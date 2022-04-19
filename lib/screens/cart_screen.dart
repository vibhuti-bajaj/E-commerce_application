// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:shop_managment_app/providers/orders.dart';
//
// import '../providers/cart.dart' show Cart;
// import '../widgets/cart_item.dart';
// class CartScreen extends StatelessWidget {
//   const CartScreen({Key? key}) : super(key: key);
//   static const routeName='/cart';
//
//   @override
//   Widget build(BuildContext context) {
//     final cart=Provider.of<Cart>(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Your Cart"),
//       ),
//       body: Column(
//         children: <Widget>[
//           Card(
//             margin: EdgeInsets.all(15),
//             child: Padding(
//               padding: EdgeInsets.all(8),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text('Total',style: TextStyle(fontSize: 20),),
//
//                   Chip(label: Text('\$ ${cart.totalAmount.toStringAsFixed(2) }',style: TextStyle(color: Theme.of(context).primaryTextTheme.headline6?.color),),
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                   ),
//                   OrderButton(cart: cart)
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
//           Expanded(child: ListView.builder(
//     itemBuilder:(context, index) => CartItem(
//         cart.items.values.toList()[index].id,
//          cart.items.keys.toList()[index],
//         cart.items.values.toList()[index].title,
//         cart.items.values.toList()[index].quantity,
//         cart.items.values.toList()[index].price) ,
//     itemCount: cart.items.length,))
//
//         ],
//       ),
//
//     );
//   }
// }
//
// class OrderButton extends StatefulWidget {
//   const OrderButton({
//     Key? key,
//     required this.cart,
//   }) : super(key: key);
//
//   final Cart cart;
//
//   @override
//   State<OrderButton> createState() => _OrderButtonState();
// }
//
// class _OrderButtonState extends State<OrderButton> {
//   var isLoading=false;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: ()=>( widget.cart.totalAmount<=0 || isLoading==true) ?null:
//             () async
//         {
//           setState(() {
//             isLoading=true;
//           });
//          await Provider.of<Orders>(context,listen: false).addOrder
//             (
//               widget.cart.items.values.toList(),
//               widget.cart.totalAmount,
//           );
//           setState(() {
//             isLoading=false;
//           });
//           widget.cart.clear();
//         },
//         child:isLoading ? CircularProgressIndicator() : Text('order now'),
//
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.headline6!.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].quantity,
                cart.items.values.toList()[i].price,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: _isLoading ? CircularProgressIndicator() : Text('ORDER NOW'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<Orders>(context, listen: false).addOrder(
          widget.cart.items.values.toList(),
          widget.cart.totalAmount,
        );
        setState(() {
          _isLoading = false;
        });
        widget.cart.clear();
      },
      textColor: Theme.of(context).primaryColor,
    );
  }
}
