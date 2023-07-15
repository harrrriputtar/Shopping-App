import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';

import '../providers/cart.dart';
import '../Screens/products_detail_screen.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    print('refreshed');
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductsDetailsScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context, value, _) => IconButton(
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
                color: product.isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                product.isToggleFavorite(
                    product.id!, authData.token!, authData.userId!);
              },
            ),
          ),
          title: Text(product.title, textAlign: TextAlign.center),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product.id, product.price, product.title);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item added to cart!'),
                  duration: Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
        ),
      ),
    );
  }
}
