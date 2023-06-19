import 'dart:convert';

class ReviewResponse {
  bool? error;
  String? message;
  List<CustomerReview>? customerReviews;

  ReviewResponse({
    this.error,
    this.message,
    this.customerReviews,
  });

  factory ReviewResponse.fromRawJson(String str) =>
      ReviewResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReviewResponse.fromJson(Map<String, dynamic> json) {
    return ReviewResponse(
      error: json["error"],
      message: json["message"],
      customerReviews: json["customerReviews"] == null
          ? []
          : List<CustomerReview>.from(
              json["customerReviews"]!.map((x) => CustomerReview.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "error": error,
      "message": message,
      "customerReviews": customerReviews == null
          ? []
          : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
    };
  }
}

class CustomerReview {
  String? name;
  String? review;
  String? date;

  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  factory CustomerReview.fromRawJson(String str) =>
      CustomerReview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomerReview.fromJson(Map<String, dynamic> json) {
    return CustomerReview(
      name: json["name"],
      review: json["review"],
      date: json["date"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "review": review,
      "date": date,
    };
  }
}
