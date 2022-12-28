class ProductsModel {
  final String? category;
  final String? description;
  final int? id;
  final String? image;
  final price;
  final String? title;
  final Rating? rating;

  ProductsModel(
      {this.category,
        this.description,
        this.id,
        this.image,
        this.price,
        this.title,
        this.rating
      });

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: json['rating']!= null ? Rating.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    data['description'] = description;
    data['id'] = id;
    data['image'] = image;
    data['price'] = price;
    data['title'] = title;
    if (rating != null) {
      data['rating'] = rating?.toJson();
    }
    return data;
  }
}



class Rating {
  final rate;
  final int? count;
  Rating({
    this.rate,
    this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['rate'] = rate;
    data['count'] = count;
    return data;
  }
}
