import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_image.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_webtoon_view.dart';
import 'package:shonenx/features/reader/presentation/widgets/reader_page_view.dart';
import 'package:shonenx/features/reader/providers/reader_prefs_provider.dart';
import 'package:shonenx/source_engine/models/chapter_page.dart';

void main() {
  final path = File('test/fixtures/reader-page.png').absolute.path;
  Future<void> decoded(WidgetTester tester) async {
    for (var i = 0; i < 15; i++) {
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(milliseconds: 30)),
      );
      await tester.pump();
    }
  }

  testWidgets(
    'local Webtoon images render with nonzero height and retain page on parent rebuild',
    (tester) async {
      var current = 0;
      late StateSetter rebuild;
      final key = GlobalKey<ReaderWebtoonViewState>();
      final pages = List.generate(16, (i) => ChapterPage(url: path));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                rebuild = setState;
                return ReaderWebtoonView(
                  key: key,
                  pages: pages,
                  initialPage: current,
                  scaleType: ReaderScaleType.fitWidth,
                  textColor: Colors.white,
                  onPageChanged: (page) => setState(() => current = page),
                );
              },
            ),
          ),
        ),
      );
      await decoded(tester);
      expect(tester.takeException(), isNull);
      final images = tester
          .widgetList<RawImage>(find.byType(RawImage))
          .where((i) => i.image != null);
      expect(images, isNotEmpty);
      expect(
        tester.getSize(find.byType(ReaderImage).first).height,
        greaterThan(300),
      );
      expect(
        current,
        lessThan(2),
        reason: 'Loading zero-height images must not jump to the last page',
      );
      key.currentState!.jumpToPage(8);
      rebuild(() => current = 8);
      await decoded(tester);
      expect(current, 8);
      await tester.drag(find.byType(ReaderWebtoonView), const Offset(0, -1600));
      await decoded(tester);
      expect(current, greaterThanOrEqualTo(8));
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets(
    'last saved Webtoon page renders and paginated RTL decodes offline',
    (tester) async {
      final pages = List.generate(16, (i) => ChapterPage(url: path));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReaderWebtoonView(
              pages: pages,
              initialPage: 15,
              scaleType: ReaderScaleType.fitWidth,
              textColor: Colors.white,
              onPageChanged: (_) {},
            ),
          ),
        ),
      );
      await decoded(tester);
      expect(
        tester
            .widgetList<RawImage>(find.byType(RawImage))
            .any((i) => i.image != null),
        isTrue,
      );
      final controller = PageController(initialPage: 3);
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReaderPageView(
              pages: pages,
              controller: controller,
              direction: ReaderDirection.rtl,
              scaleType: ReaderScaleType.fitWidth,
              textColor: Colors.white,
              onPageChanged: (_) {},
            ),
          ),
        ),
      );
      await decoded(tester);
      expect(controller.page, 3);
      expect(
        tester
            .widgetList<RawImage>(find.byType(RawImage))
            .any((i) => i.image != null),
        isTrue,
      );
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox());
      controller.dispose();
    },
  );
  testWidgets(
    'damaged downloaded image displays retry instead of a blank reader',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReaderImage(
              url: '/missing-shonenz-page.image',
              index: 2,
              scaleType: ReaderScaleType.fitWidth,
              textColor: Colors.white,
              continuous: true,
            ),
          ),
        ),
      );
      await decoded(tester);
      expect(find.text('Could not load page 3'), findsOneWidget);
      expect(find.text('Retry page'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}
