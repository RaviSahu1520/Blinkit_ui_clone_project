import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class OfferCarousel extends StatelessWidget {
  const OfferCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    final banners = [
      "assets/vegetables.png",
      "assets/fruits.png",
    ];

    return CarouselSlider(
      items: banners.map((url) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              url,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: 140,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.9,
      ),
    );
  }
}
