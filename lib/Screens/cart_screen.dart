import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' as ci;
import '../providers/orders.dart';
import '../Widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = 'cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ci.Cart>(context);
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Your Cart',
      )),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Subtotal',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  width: 10,
                ),
                Chip(
                  label: Text(
                    '₹ ${cart.totalAmount}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.blue,
                )
              ],
            ),
          ),
          OrderButton(cart: cart),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemCount,
            itemBuilder: (ctx, i) {
              return CartItem(
                  id: cart.cartItems.values.toList()[i].id,
                  productId: cart.cartItems.keys.toList()[i],
                  price: cart.cartItems.values.toList()[i].price,
                  quantity: cart.cartItems.values.toList()[i].quantity,
                  title: cart.cartItems.values.toList()[i].title);
            },
          ))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    super.key,
    required this.cart,
  });

  final ci.Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: InkWell(
        onTap: (widget.cart.totalAmount <= 0 || _isLoading)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.cartItems.values.toList(),
                  widget.cart.totalAmount,
                );
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              },
        child: _isLoading
            ? const CircularProgressIndicator(
                color: Color.fromARGB(255, 247, 240, 106))
            : Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.cart.totalAmount <= 0
                        ? Colors.grey
                        : const Color.fromARGB(255, 247, 240, 106)),
                height: 50,
                width: double.infinity,
                // color: Colors.yellowAccent,
                child: const Center(
                  child: Text(
                    'Proceed to Buy',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
