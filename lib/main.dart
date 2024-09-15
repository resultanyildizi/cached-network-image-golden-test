import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

late BaseCacheManager cacheManager;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  cacheManager = DefaultCacheManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'MyApp',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const image =
      'https://cdn.leonardo.ai/users/2e0d1e44-6cf8-453e-ae5b-cf2e51e2b0da/generations/d2190ecb-a047-4369-b719-f899f971f4ce/variations/alchemyrefiner_alchemymagic_3_d2190ecb-a047-4369-b719-f899f971f4ce_0.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 40,
          itemBuilder: (context, index) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: image,
                cacheManager: cacheManager,
                fit: BoxFit.cover,
                memCacheHeight: 800,
                height: 400,
              ),
            );
          },
        ),
      ),
    );
  }
}
