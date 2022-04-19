import 'package:flutter/material.dart';
import 'package:shop_managment_app/providers/auth.dart';
import 'package:shop_managment_app/providers/cart.dart';
import 'package:shop_managment_app/providers/orders.dart';
import 'package:shop_managment_app/screens/auth_screen.dart';
import 'package:shop_managment_app/screens/cart_screen.dart';
import 'package:shop_managment_app/screens/edit_product_screen.dart';
import 'package:shop_managment_app/screens/orders_screen.dart';
import 'package:shop_managment_app/screens/product_detail_screen.dart';
import 'package:shop_managment_app/screens/products_overview_screen.dart';
import 'package:shop_managment_app/providers/products.dart';
import 'package:provider/provider.dart';
import 'package:shop_managment_app/screens/user_product_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers:
    [
      ChangeNotifierProvider.value(value: Auth()),
      ChangeNotifierProxyProvider<Auth,Products>(

       update: (ctx,auth,previousProducts)=>
           Products(auth.token!,previousProducts==null ?[]:previousProducts.items,auth.userId!),
           create : (_)=>Products(null,[],null),
    ),
      ChangeNotifierProxyProvider<Auth,Orders>(

        update: (ctx,auth,previousOrders)=>
            Orders(auth.token!,previousOrders==null ?[]:previousOrders.orders),
        create : (_)=>Orders(null,[]),
      ),


    ChangeNotifierProvider(
    create:(context)=>Cart(),
    ),
    ],
      child: Consumer<Auth>(
        builder: (ctx,auth,_)=>
       MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
            fontFamily: 'Lato' ,
            colorScheme:
            ColorScheme.fromSwatch(
                primarySwatch: Colors.purple)
                .copyWith(secondary: Colors.blue.shade200),



        ),
        home:auth.isAuth?ProductOverviewScreen():  AuthScreen(),
        routes: {
          ProductDetailScreen.routeName:(context)=>ProductDetailScreen(),
          CartScreen.routeName:(context)=>CartScreen(),
          OrderScreen.routeName:(context)=>OrderScreen(),
          UserProductsScreen.routeName:(context)=>UserProductsScreen(),
          EditProductScreen.routeName:(context)=>EditProductScreen(),
        },
      ),
    ));
  }
}
