import 'package:cached_network_image_golden_test/main.dart';
import 'package:file/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/mockito.dart';

void main() {
  // You can use a service locator like GetIt instead.
  cacheManager = MockCacheManager();
  testWidgets(
    'should match with the golden file',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        const widget = MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        );
        await tester.pumpWidgetBuilder(widget);
        final elements = tester.elementList(find.byType(Image));
        for (var element in elements) {
          final image = element.widget as Image;
          await precacheImage(image.image, element);
        }
        await tester.pumpAndSettle();
      });

      await expectLater(
        find.byType(HomePage),
        matchesGoldenFile('goldens/home_page.png'),
      );
    },
  );

  testGoldens(
    'should match with the golden file (golden_toolkit)',
    (WidgetTester tester) async {
      await tester.runAsync(() async {
        const widget = MaterialApp(
          home: HomePage(),
          debugShowCheckedModeBanner: false,
        );
        await tester.pumpWidgetBuilder(widget);
        final elements = tester.elementList(find.byType(Image));
        for (var element in elements) {
          final image = element.widget as Image;
          await precacheImage(image.image, element);
        }
        await tester.pumpAndSettle();
      });

      await screenMatchesGolden(tester, 'home_page');
    },
  );
}

@visibleForTesting
class MockCacheManager extends Mock implements BaseCacheManager {
  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool? withProgress,
  }) async* {
    File file = const LocalFileSystem().file('test/test.jpg');
    yield FileInfo(
      file,
      FileSource.Online, // Simulate a cache hit
      DateTime(2050), // Very long validity
      url, // Source url
    );
  }
}
