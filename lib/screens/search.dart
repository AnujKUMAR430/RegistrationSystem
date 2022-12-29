import 'package:firebase_signin/model/product_model.dart';
import 'package:flutter/material.dart';
import '../api_service.dart';
import '../reusable_widgets/produact_card.dart';
import '../reusable_widgets/reusable_widget.dart';


class Search extends SearchDelegate {
  final FetchProductList _productList = FetchProductList();
  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: Colors.white,
      textTheme: const TextTheme(headline6: TextStyle(color: Colors.white, fontSize: 18)),
      appBarTheme: AppBarTheme.of(context).copyWith(
        backgroundColor: Colors.blueGrey.shade300,
        iconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      ),
      inputDecorationTheme:
           const InputDecorationTheme(
            border: InputBorder.none,
          ),
    );
  }






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
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: FutureBuilder<List<ProductsModel>>(
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
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: logoWidget("assets/images/search.png")),
          const SizedBox(height: 10),
          const Text('Search Here ', style: TextStyle(fontSize: 20),textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}