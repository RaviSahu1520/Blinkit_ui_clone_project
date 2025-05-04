import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import '../models/product_model.dart';

class HomeController extends GetxController {
  RxString userLocation = "Fetching location...".obs;

  RxList<Map<String, dynamic>> categories = [
    {"label": "All", "icon": Icons.category},
    {"label": "Summer", "icon": Icons.wb_sunny},
    {"label": "Electronics", "icon": Icons.devices},
    {"label": "Beauty", "icon": Icons.brush},
    {"label": "Kids", "icon": Icons.child_friendly},
    {"label": "Gifting", "icon": Icons.card_giftcard},
    {"label": "Premium", "icon": Icons.star},
  ].obs;

  RxList<ProductModel> bestSellers = [
    ProductModel(name: "Dairy, Bread & Eggs", count: 32, image: "assets/milk.jpeg"),
    ProductModel(name: "Vegetables & Fruits", count: 160, image: "assets/vegetable_fruits.jpeg"),
    ProductModel(name: "Oil, Ghee & Masala", count: 174, image: "assets/gheee.jpeg"),
    ProductModel(name: "Chips & Namkeen", count: 351, image: "assets/chips.jpeg"),
    ProductModel(name: "Atta, Rice & Dal", count: 33, image: "assets/attaaa.jpeg"),
    ProductModel(name: "Drinks & Juices", count: 124, image: "assets/juicve.jpeg"),
  ].obs;

  RxList<String> productImagePaths = [
    "assets/bisbuits.jpeg",
    "assets/bottles.jpeg",
    "assets/chicken.jpeg",
    "assets/dryfruits.jpeg",
    "assets/mixi.jpeg",
  ].obs;

  RxInt currentNavIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    getLocation();
  }

  Future<void> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      userLocation.value = "Location services are disabled.";
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        userLocation.value = "Location permission denied.";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      userLocation.value = "Location permission permanently denied.";
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      userLocation.value = "${place.street}, ${place.locality}";
    } else {
      userLocation.value = "Location not found.";
    }
  }
}
