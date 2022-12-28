import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/product_model.dart';

class FetchProductList {
  var data = [];
  List<ProductsModel> results = [];
  String urlList = 'https://fakestoreapi.com/products';

  Future<List<ProductsModel>> productList({String? query}) async {
    var url = Uri.parse(urlList);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        data = json.decode(response.body);
        results = data.map((e) => ProductsModel.fromJson(e)).toList();
        if (query!= null){
          results = results.where((element) => element.title!.toLowerCase().contains((query.toLowerCase()))).toList();
        }
      } else {
        print("fetch error");
      }
    } on Exception catch (e) {
      print('error: $e');
    }
    return results;
  }
}