import 'package:flutter/material.dart';
import '../models/product_model.dart';

class ProductItem extends StatelessWidget {
  final ProductModel model;
  const ProductItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // 🔽 Image at the top
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              model.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "+${model.count} more",
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            model.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ],
      ),
    );
  }
}
