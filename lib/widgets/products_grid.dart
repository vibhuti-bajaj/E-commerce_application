import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_managment_app/providers/products.dart';
import 'package:shop_managment_app/widgets/product_item.dart';

import '../providers/product.dart';
class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid(this.showFavs);




  @override
  Widget build(BuildContext context) {
    final ProductsData=Provider.of<Products>(context);

    final products=showFavs?ProductsData.favoriteItems:ProductsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:2,
          childAspectRatio: 3/2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,

        ),
        itemBuilder: (context,index)=>
        ChangeNotifierProvider.value(
            value : products[index] ,
            child:
            ProductItem(
                // products[index].id,
                // products[index].title,
                // products[index].imageUrl
     ),


        )
    );
  }
}
