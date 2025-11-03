import 'package:flutter/material.dart';
import 'package:suits/core/constant/app_constant.dart';
import 'package:suits/core/utils/app_text_style.dart';

class CardItem extends StatefulWidget {
  const CardItem({super.key, required this.image, required this.onTap});
  final String image;
  final VoidCallback onTap;
  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  bool isCheck = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(widget.image, fit: BoxFit.cover),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade100.withValues(alpha: .7),
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          isCheck = !isCheck;
                        });
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: isCheck
                            ? const Color(primaryColor)
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8.0),

          const Row(
            children: [
              Flexible(
                child: Text(
                  'classic blazar',
                  style: AppTextStyles.style16BoldBlack3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Spacer(),
              Icon(Icons.star, color: Colors.amber, size: 18),
              Text('4.9', style: AppTextStyles.style12RegularGrey),
            ],
          ),
          const SizedBox(height: 4.0),
          const Text(r'$83.97', style: AppTextStyles.style14RegularGrey),
        ],
      ),
    );
  }
}
