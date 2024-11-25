import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test_project/screens/main_screen/main_screen.dart';
import 'package:flutter_test_project/screens/main_screen/main_screen_controller.dart';
import 'package:get/get.dart';

void main() {
  late MainScreenController controller;

  setUp(() {
    controller = MainScreenController();
    Get.put(controller);
  });

  tearDown(Get.reset);

  testWidgets('Check if page loading', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const HomeScreen(),
        initialBinding: BindingsBuilder(() {
          Get.put(controller);
        }),
      ),
    );

    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('check if show images and table', (WidgetTester tester) async {
    await tester.pumpWidget(
      GetMaterialApp(
        home: const HomeScreen(),
        initialBinding: BindingsBuilder(() {
          Get.put(controller);
        }),
      ),
    );

    // await tester.pump();
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    controller.isImageLoading = false;
    await tester.pump();

    expect(find.byType(Image), findsNWidgets(2));
    expect(find.byType(Table), findsOneWidget);
  });
}
