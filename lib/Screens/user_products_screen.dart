import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../Screens/editing_product_screen.dart';

import '../Widgets/user_product_item.dart';

import '../Widgets/app_drawer.dart';

import '../providers/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditingProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => _refreshProducts(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Consumer<Products>(
                        builder: (ctx, productData, _) => ListView.builder(
                          itemCount: productData.items.length,
                          itemBuilder: (_, index) => Column(
                            children: [
                              UserProductItem(
                                  id: productData.items[index].id,
                                  title: productData.items[index].title,
                                  imageUrl: productData.items[index].imageUrl),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
