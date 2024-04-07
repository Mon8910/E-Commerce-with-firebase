import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:e_commerce_app_with_firebase/model/cart_model.dart';
import 'package:e_commerce_app_with_firebase/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityItem extends StatelessWidget {
  const QuantityItem({super.key, required this.cartModel,});
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    final cartProvider=Provider.of<CartProvider>(context);
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         const SizedBox(height: 10,),
          
          Container(
            height: 6,
            width: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12)
              

            ),

          ),
          const SizedBox(height: 10,),
          Flexible(
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (context, index) {
                  return Center(
                    child: InkWell(
                      onTap: () {
                        cartProvider.updateCart(cartModel.productId,index+1);
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SubtitleText(label: '${index + 1}'),
                      ),
                    ),
                  );
                }),
          ),
           const SizedBox(height: 10,),
        ],
      ),
    );
  }
}
