import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class ProductsDetailsScreen extends StatelessWidget {
  static const routeName = 'product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findbyId(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    loadedProduct.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Divider(
              indent: 45,
              endIndent: 45,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Text(
                '₹${loadedProduct.price}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.grey),
              ),
            ),
            Divider(
              indent: 45,
              endIndent: 45,
              color: Colors.black,
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                loadedProduct.description,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
