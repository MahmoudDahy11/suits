import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/secret/secret.dart';
import 'package:suits/core/utils/home_assets.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CustomImageProfile extends StatefulWidget {
  final String? networkImageUrl;

  const CustomImageProfile({super.key, this.networkImageUrl});

  @override
  State<CustomImageProfile> createState() => _CustomImageProfileState();
}

class _CustomImageProfileState extends State<CustomImageProfile> {
  final ValueNotifier<String?> imageUrl;
  final ValueNotifier<bool> isUploading = ValueNotifier<bool>(false);

  final cloudinary = CloudinaryPublic(cloudName, uploadPreset, cache: false);

  _CustomImageProfileState() : imageUrl = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    imageUrl.value = widget.networkImageUrl;
  }

  @override
  void didUpdateWidget(CustomImageProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.networkImageUrl != oldWidget.networkImageUrl) {
      imageUrl.value = widget.networkImageUrl;
    }
  }

  @override
  void dispose() {
    imageUrl.dispose();
    isUploading.dispose();
    super.dispose();
  }

  Future<void> _uploadIamge() async {
    final ImagePicker picker = ImagePicker();
    final imagePicker = await picker.pickImage(source: ImageSource.gallery);
    if (imagePicker == null) return;

    isUploading.value = true;
    try {
      final CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          imagePicker.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      final downloadUrl = response.secureUrl;
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'profileImageUrl': downloadUrl,
      }, SetOptions(merge: true));

      imageUrl.value = downloadUrl;
    } catch (e) {
      log("Error uploading image: $e");
    }
    isUploading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder<String?>(
          valueListenable: imageUrl,
          builder: (context, currentUrl, _) {
            return CircleAvatar(
              radius: 80,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: currentUrl != null
                  ? NetworkImage(currentUrl)
                  : const AssetImage(HomeAssets.homeHomeS2) as ImageProvider,
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: isUploading,
          builder: (context, uploading, _) {
            return Positioned(
              bottom: -10,
              right: -5,
              child: IconButton(
                onPressed: uploading ? null : _uploadIamge,
                icon: const Icon(
                  Icons.edit_road_sharp,
                  color: Color(primaryColor),
                  size: 40,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
