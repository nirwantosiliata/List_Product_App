import 'dart:convert';

// Class representing the response structure from the API
class BaseProductResponse {
  final List<Product>? products; // List of products
  final int? total; // Total number of products
  final int? skip; // Number of products skipped
  final int? limit; // Limit on the number of products

  BaseProductResponse({
    this.products,
    this.total,
    this.skip,
    this.limit,
  });

  // Factory method to create an instance of BaseProductResponse from raw JSON
  factory BaseProductResponse.fromRawJson(String str) =>
      BaseProductResponse.fromJson(json.decode(str));

  // Convert the object to raw JSON string
  String toRawJson() => json.encode(toJson());

  // Factory method to create an instance of BaseProductResponse from JSON
  factory BaseProductResponse.fromJson(Map<String, dynamic> json) =>
      BaseProductResponse(
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
        total: json["total"],
        skip: json["skip"],
        limit: json["limit"],
      );

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
        "total": total,
        "skip": skip,
        "limit": limit,
      };
}

// Class representing a product
class Product {
  final int? id; // Product ID
  final String? title; // Product title
  final String? description; // Product description
  final int? price; // Product price
  final double? discountPercentage; // Discount percentage on the product
  final double? rating; // Product rating
  final int? stock; // Product stock quantity
  final String? brand; // Product brand
  final String? category; // Product category
  final String? thumbnail; // Product thumbnail image URL
  final List<String>? images; // List of product images

  Product({
    this.id,
    this.title,
    this.description,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.brand,
    this.category,
    this.thumbnail,
    this.images,
  });

  // Factory method to create an instance of Product from raw JSON
  factory Product.fromRawJson(String str) => Product.fromJson(json.decode(str));

  // Convert the object to raw JSON string
  String toRawJson() => json.encode(toJson());

  // Factory method to create an instance of Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        price: json["price"],
        discountPercentage: json["discountPercentage"]?.toDouble(),
        rating: json["rating"]?.toDouble(),
        stock: json["stock"],
        brand: json["brand"],
        category: json["category"],
        thumbnail: json["thumbnail"],
        images: json["images"] == null
            ? []
            : List<String>.from(json["images"]!.map((x) => x)),
      );

  // Convert the object to JSON
  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "discountPercentage": discountPercentage,
        "rating": rating,
        "stock": stock,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
      };
}
