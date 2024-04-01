import 'package:e_commerce_app_with_firebase/constants/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class QuantityItem extends StatelessWidget {
  const QuantityItem({super.key});

  @override
  Widget build(BuildContext context) {
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
                      onTap: () {},
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
