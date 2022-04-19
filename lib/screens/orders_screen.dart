import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_managment_app/providers/orders.dart' show Orders;
import 'package:shop_managment_app/widgets/app_drawer.dart';
import 'package:shop_managment_app/widgets/order_item.dart';
class OrderScreen extends StatefulWidget {
  static const routeName="/orders";

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _ordersFuture;
  Future? _obtainOrdersFuture(){
  return  Provider.of<Orders>(context,listen: false).fetchAndSetOrders();

  }

  @override
  void initState() {
    // TODO: implement initState
    _ordersFuture=_obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final orderData=Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('YOUR ORDERS'),
      ),
      body:FutureBuilder(future:_ordersFuture ,
       builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.error !=null){
          return Center(child: Text("An error occured"));
        //  error handling stuff
        }
        else{
          return Consumer<Orders>(builder: (context,orderData,child)=>ListView.builder(
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) =>OrderItem(orderData.orders[index])
          ));
        }
      },


    ),

      drawer: AppDrawer(),
    ) ;
  }
}
