import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_managment_app/providers/cart.dart';
class CartItem extends StatelessWidget {

  final String id;
  final String productId;
  final String title;
  final int quantity;
  final double price;
  CartItem(this.productId , this.id,this.title,this.quantity,this.price, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
            color: Colors.white,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4
        ),
      ),
      direction: DismissDirection.endToStart,
     confirmDismiss: (direction){
        return showDialog(
            context: context,
            builder: (context)=>
              AlertDialog(
                title: Text('Are you sure'),
                content: Text('Do you want to remove item from the cart'),
                actions: <Widget>[
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop(false);
                  }, child: Text("NO")),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop(true);
                  }, child: Text("YES"))
                ],
              )
            );
     },
      onDismissed: (direction){
        Provider.of<Cart>(context,listen: false).removeItem(id);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child:Padding(
                padding: const EdgeInsets.all(10.0),
                child: FittedBox(
                child: Text('\$$price'),
                ),
              )
            ),
            title: Text(title),
            subtitle:Text(
              'Total: \$${(price*quantity)}',
            ) ,
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
