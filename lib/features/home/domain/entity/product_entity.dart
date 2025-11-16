import '../../data/models/product_model.dart';

class ProductEntity {
  final String id;
  final String slug;
  final String? description;
  final Urls urls;
  final String userName;
  final int likes;

  ProductEntity({
    required this.id,
    required this.slug,
    this.description,
    required this.urls,
    required this.userName,
    required this.likes,
  });


  ProductModel toModel() {
    return ProductModel(
      id: id,
      slug: slug,
      description: description,
      urls: urls,
      userName: userName,
      likes: likes,
    );
  }

  factory ProductEntity.fromModel(ProductModel model) {
    return ProductEntity(
      id: model.id,
      slug: model.slug,
      description: model.description,
      urls: model.urls,
      userName: model.userName,
      likes: model.likes,
    );
  }

  factory ProductEntity.fromJson(Map<String, dynamic> json) => ProductEntity(
    id: json['id'],
    slug: json['slug'],
    description: json['description'],
    urls: Urls.fromJson(json['urls']),
    userName: json['user_name'],
    likes: json['likes'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'slug': slug,
    'description': description,
    'urls': urls.toJson(),
    'user_name': userName,
    'likes': likes,
  };
}
