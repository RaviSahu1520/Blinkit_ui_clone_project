import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../controllers/theme_controller.dart';
import '../widgets/banner_carousel.dart';
import '../widgets/category_list.dart';
import '../widgets/product_grid.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFD54F), Color(0xFFFFF176)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  _buildTopBar(context),
                  _buildSearchBar(),
                  _buildCategoryList(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    const OfferCarousel(),
                    _buildSectionTitle('Bestsellers'),
                    _buildBestSellerGrid(),
                    _buildSectionTitle('Grocery & Kitchen'),
                    _buildProductImages(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.currentNavIndex.value,
        onTap: (i) => controller.currentNavIndex.value = i,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: 'Order Again'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      )),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Obx(() => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Blinkit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        controller.userLocation.value,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 13,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.notifications, size: 30),
              IconButton(
                icon: Obx(() => Icon(
                  Get.find<ThemeController>().isDark.value
                      ? Icons.dark_mode
                      : Icons.light_mode,
                )),
                onPressed: () => Get.find<ThemeController>().toggleTheme(),
              ),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage("assets/me.jpg"),
              ),
            ],
          ),
        ],
      )),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search for atta, dal, coke and more",
          prefixIcon: const Icon(Icons.search),
          suffixIcon: const Icon(Icons.mic),
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 70,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: controller.categories.length,
        itemBuilder: (_, i) {
          final category = controller.categories[i];
          return CategoryItem(
            title: category["label"],
            icon: category["icon"],
          );
        },
      )),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildBestSellerGrid() {
    return Obx(() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        itemCount: controller.bestSellers.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (_, i) {
          return ProductItem(model: controller.bestSellers[i]);
        },
      ),
    ));
  }

  Widget _buildProductImages() {
    return SizedBox(
      height: 130,
      child: Obx(() => ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: controller.productImagePaths.length,
        itemBuilder: (_, i) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                controller.productImagePaths[i],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      )),
    );
  }
}
