import 'package:e_commerce_app_with_firebase/constants/widgets/cart_empty.dart';
import 'package:e_commerce_app_with_firebase/screens/profile/orderwidget.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});
  final bool isempty = false;

  @override
  Widget build(BuildContext context) {
    return  
    isempty?
         const Scaffold(
            body: CartEmpty(
            image: 'assets/images/order.png',
            title: 'Whoops',
            subTitle: 'Your order is empty',
            details:
                "No orders has been placed yet",
            textButton: 'Shop now',
          )):Scaffold(body:  ListView.separated(
                itemCount: 15,
                itemBuilder: (ctx, index) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                    child: OrdersWidgetFree(),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),);
        
  }
}
