import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../Screens/editing_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;

  UserProductItem({
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditingProductScreen.routeName, arguments: id);
                },
                icon: Icon(Icons.edit_outlined),
                color: Colors.black),
            IconButton(
                onPressed: () async {
                  try {
                    await Provider.of<Products>(context, listen: false)
                        .deleteProduct(id);
                  } catch (error) {
                    scaffold.showSnackBar(
                      SnackBar(content: Text('Deleting Failed')),
                    );
                  }
                },
                icon: Icon(Icons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
