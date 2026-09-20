import 'package:flutter/material.dart';

class CarImageSlider extends StatefulWidget {
  final List<String>? imageUrls;

  const CarImageSlider({super.key, required this.imageUrls});

  @override
  State<CarImageSlider> createState() => _CarImageSliderState();
}

class _CarImageSliderState extends State<CarImageSlider> {
  int _currentIndex = 0; // Tracks which image is currently showing

  @override
  Widget build(BuildContext context) {
    final urls = widget.imageUrls ?? [];
    if (urls.isEmpty) {
      return Container(
        height: 250,
        width: double.infinity,
        color: Colors.grey[200],
        child: const Center(child: Icon(Icons.directions_car, size: 50, color: Colors.grey)),
      );
    }

    return Container(
      height: 250, // Adjust height to match your Figma design (e.g., 250-300)
      width: double.infinity,
      color: Colors.grey[200], // Placeholder background color
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // 1. The Image Slider
          PageView.builder(
            itemCount: urls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Image.network(
                urls[index],
                fit: BoxFit.cover, // Ensures image fills the box without distortion
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(child: CircularProgressIndicator());
                },
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.error); // Show if URL is bad
                },
              );
            },
          ),

          // 2. The Dots (Pagination Indicators)
          if (urls.length > 1) // Only show dots if > 1 image
            Positioned(
              bottom: 15, // Distance from bottom
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  urls.length,
                  (index) => _buildDot(index),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper method to build a single dot
  Widget _buildDot(int index) {
    bool isActive = _currentIndex == index;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4), // Space between dots
      height: 8,
      width: isActive ? 20 : 8, // Active dot is wider (like a pill), inactive is circle
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}