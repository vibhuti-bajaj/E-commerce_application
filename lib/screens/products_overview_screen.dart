import 'package:flutter/material.dart';
import 'package:shop_managment_app/screens/cart_screen.dart';
import 'package:shop_managment_app/widgets/app_drawer.dart';
import 'package:shop_managment_app/widgets/badge.dart';
import 'package:shop_managment_app/widgets/product_item.dart';
import '../providers/cart.dart';
import '../providers/product.dart';
import '../providers/products.dart';
import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';

enum FilterOptions{
Favorites,
  All
}

class ProductOverviewScreen extends StatefulWidget {

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showOnlyFavorites=false;
  var _isInit=true;
  var _isLoading=false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit){
      setState(() {
        _isLoading=true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) =>
          setState(() {
            _isLoading=false;

          })
      );
    }
    _isInit=false;
    super.didChangeDependencies();
  }
  @override
  void initState() {
    // TODO: implement initState
    // Provider.of<Products>(context).fetchAndSetProducts();
    super.initState();
  }
   // final List<Product> loadedProducts =
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My shop'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue){
              setState(() {
                if (selectedValue==FilterOptions.Favorites){
                  _showOnlyFavorites=true;
                }else{
                  _showOnlyFavorites=false;
                }
              });

    },
            icon: Icon(Icons.more_vert),
              itemBuilder: (_)=>[
                PopupMenuItem(child: Text("Only Favorites"),value: FilterOptions.Favorites),
                PopupMenuItem(child: Text("Show All"),value: FilterOptions.All,)

              ]),
          Consumer<Cart>(builder: (_,cart,ch)=>Badge(

            value:cart.itemCount.toString(), child : ch,color: Colors.blue ,
    ),
              child: IconButton(
            icon: Icon(Icons.shopping_cart), onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
              },
           ),
             ),

        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

