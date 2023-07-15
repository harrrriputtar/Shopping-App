import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';

import 'providers/orders.dart';

import 'providers/products.dart';

import 'providers/cart.dart';

import './Screens/auth_screen.dart';

import './Screens/editing_product_screen.dart';

import './Screens/user_products_screen.dart';

import './Screens/cart_screen.dart';

import './Screens/orders_screen.dart';

import './Screens/products_detail_screen.dart';

import './Screens/profucts_overview_screen.dart';

import './Widgets/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Auth()),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (context, auth, previousProducts) => Products(
              authToken: auth.token,
              userId: auth.userId,
              items: previousProducts?.items == null
                  ? []
                  : previousProducts?.items),
          create: (context) => Products(),
        ),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProxyProvider<Auth, Orders>(
            update: (context, auth, previousOrders) => Orders(
                authToken: auth.token,
                userId: auth.userId,
                orders: previousOrders?.orders == null
                    ? []
                    : previousOrders?.orders),
            create: (context) => Orders())
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Lato ',
          ),
          home: auth.isAuth
              ? ProductsOverviewScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapshot) =>
                      authResultSnapshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : AuthScreen()),
          routes: {
            ProductsDetailsScreen.routeName: (ctx) => ProductsDetailsScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditingProductScreen.routeName: (ctx) => EditingProductScreen(),
          },
        ),
      ),
    );
  }
}
