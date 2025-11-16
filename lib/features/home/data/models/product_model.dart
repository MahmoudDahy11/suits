import '../../domain/entity/product_entity.dart';

class ProductModel {
  final String id;
  final String slug;
  final String? description;
  final Urls urls;
  final String userName;
  final int likes;

  ProductModel({
    required this.id,
    required this.slug,
    this.description,
    required this.urls,
    required this.userName,
    required this.likes,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      slug: slug,
      description: description,
      urls: urls,
      userName: userName,
      likes: likes,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      slug: entity.slug,
      description: entity.description,
      urls: entity.urls,
      userName: entity.userName,
      likes: entity.likes,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json['id'],
    slug: json['slug'],
    description: json['alt_description'] ?? json['description'],
    urls: Urls.fromJson(json['urls']),
    userName: json['user']['name'],
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

class Urls {
  final String raw;
  final String full;
  final String regular;
  final String small;
  final String thumb;
  final String smallS3;

  Urls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
    raw: json['raw'],
    full: json['full'],
    regular: json['regular'],
    small: json['small'],
    thumb: json['thumb'],
    smallS3: json['small_s3'],
  );

  Map<String, dynamic> toJson() => {
    'raw': raw,
    'full': full,
    'regular': regular,
    'small': small,
    'thumb': thumb,
    'small_s3': smallS3,
  };
}
