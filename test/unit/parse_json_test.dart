import 'package:dcd_flut_restaurant/data/model/restaurant.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Parse List of Restaurant Response', () {
    var json = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    test('Should be able to parse List of Restaurant from json', () {
      // Act
      var result = RestaurantResponse.fromJson(json);

      // Assert
      expect(result.error, false);
      expect(result.message, 'success');
      expect(result.count, 20);
      expect(result.restaurants?.length, 2);
    });

    test('Should be able to parse List of Restaurant to json', () {
      // Act
      var result = RestaurantResponse.fromJson(json).toJson();

      // Assert
      expect(result['error'], false);
      expect(result['message'], 'success');
      expect(result['count'], 20);
      expect(result['restaurants']?.length, 2);
    });
  });

  group('Parse Detail of Restaurant Response', () {
    var json = {
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    };

    test('Should be able to parse Detail of Restaurant from json', () {
      // Act
      var result = RestaurantDetailResponse.fromJson(json);

      // Assert
      expect(result.error, false);
      expect(result.message, 'success');
      expect(result.restaurant?.id, 'rqdv5juczeskfw1e867');
      expect(result.restaurant?.name, 'Melting Pot');
      expect(result.restaurant?.description, 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...');
      expect(result.restaurant?.city, 'Medan');
      expect(result.restaurant?.address, 'Jln. Pandeglang no 19');
      expect(result.restaurant?.pictureId, '14');
      expect(result.restaurant?.categories?.length, 2);
      expect(result.restaurant?.categories![0].name, 'Italia');
      expect(result.restaurant?.menus?.foods?.length, 2);
      expect(result.restaurant?.menus?.foods![0].name, 'Paket rosemary');
      expect(result.restaurant?.menus?.drinks?.length, 2);
      expect(result.restaurant?.menus?.drinks![0].name, 'Es krim');
      expect(result.restaurant?.rating, 4.2);
      expect(result.restaurant?.customerReviews?.length, 1);
      expect(result.restaurant?.customerReviews![0].name, 'Ahmad');
      expect(result.restaurant?.customerReviews![0].review, 'Tidak rekomendasi untuk pelajar!');
      expect(result.restaurant?.customerReviews![0].date, '13 November 2019');
    });

    test('Should be able to parse Detail of Restaurant to json', () {
      // Act
      var result = RestaurantDetailResponse.fromJson(json).toJson();

      // Assert
      expect(result, json);
      expect(result['error'], false);
      expect(result['message'], 'success');
      expect(result['restaurant']['id'], 'rqdv5juczeskfw1e867');
      expect(result['restaurant']['name'], 'Melting Pot');
      expect(result['restaurant']['description'], 'Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...');
      expect(result['restaurant']['city'], 'Medan');
      expect(result['restaurant']['address'], 'Jln. Pandeglang no 19');
      expect(result['restaurant']['pictureId'], '14');
      expect(result['restaurant']['categories'][0]['name'], 'Italia');
      expect(result['restaurant']['menus']['foods'][0]['name'], 'Paket rosemary');
      expect(result['restaurant']['menus']['drinks'][0]['name'], 'Es krim');
      expect(result['restaurant']['rating'], 4.2);
      expect(result['restaurant']['customerReviews'][0]['name'], 'Ahmad');
      expect(result['restaurant']['customerReviews'][0]['review'], 'Tidak rekomendasi untuk pelajar!');
      expect(result['restaurant']['customerReviews'][0]['date'], '13 November 2019');
    });
  });
}
