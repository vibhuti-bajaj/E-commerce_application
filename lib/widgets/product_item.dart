import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_managment_app/providers/auth.dart';
import 'package:shop_managment_app/screens/product_detail_screen.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  //
  // ProductItem(this.id, this.title, this.imageUrl, {Key? key}) : super(key: key);
  //
  // final String imageUrl;

  // const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product=Provider.of<Product>(context,listen: false);
    final cart=Provider.of<Cart>(context);
    final authData=Provider.of<Auth>(context,listen: false);
    return
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child:
        GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductDetailScreen.routeName,arguments:product.id);
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () {
                cart.addItem(product.id!,product.title, product.price);
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Item added to cart'),
                    duration: Duration(seconds: 2),
                      action: SnackBarAction(label: 'UNDO',onPressed: (){
                        cart.removeSingleItem(product.id!);

                      },),
                    ));
              },
              color: Theme.of(context).colorScheme.secondary,
            ),
            leading:Consumer<Product>(
              builder: (context,product,_)=> IconButton(
              icon: Icon(
                  product.isFavorite?
                  Icons.favorite : Icons.favorite_border),
              onPressed: () {
                product.toggleFavoriteStatus(authData.token!,authData.userId!);
              },
              color: Theme.of(context).colorScheme.secondary,
              ),),

             title: Text(product.title,
          textAlign: TextAlign.center),
        ),
      ),
    );
  }
}
