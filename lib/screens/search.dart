import 'package:firebase_signin/model/product_model.dart';
import 'package:flutter/material.dart';
import '../api_service.dart';
import '../reusable_widgets/produact_card.dart';
import '../reusable_widgets/reusable_widget.dart';


class SearchUser extends SearchDelegate {
  final FetchProductList _productList = FetchProductList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<ProductsModel>>(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text(" Something went wrong"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return ProductCard(
                title: snapshot.data![index].title!,
                description: snapshot.data![index].description!,
                price: snapshot.data![index].price!,
                thumbnailUrl: snapshot.data![index].image!,
                rating: snapshot.data![index].rating?.rate,
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      future: _productList.productList(query: query),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: logoWidget("assets/images/search.png")),
        const SizedBox(height: 10),
        const Text('Search Here ', style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
      ],
    );
  }
}