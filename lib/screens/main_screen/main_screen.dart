import 'package:flutter/material.dart';
import 'package:flutter_test_project/screens/main_screen/main_screen_controller.dart';
import 'package:flutter_test_project/widgets/custom_table_cell.dart';
import 'package:get/get.dart';

/// The home screen widget.
class HomeScreen extends GetView<MainScreenController> {
  /// Creates a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Obx(
        () => controller.isImageLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: controller.image1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: controller.image2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: _buildTable(),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildTable() {
    return Table(
      border: TableBorder.all(),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: [
        const TableRow(
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: SizedBox.shrink(),
            ),
            CustomTableCell('Image 1:'),
            CustomTableCell('Image 2:'),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Name:'),
            CustomTableCell(
              controller.getFileName(controller.imageInfo1?.debugLabel ?? ''),
            ),
            CustomTableCell(
              controller.getFileName(controller.imageInfo2?.debugLabel ?? ''),
            ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Width:'),
            CustomTableCell('${controller.imageInfo1?.image.width}px'),
            CustomTableCell('${controller.imageInfo2?.image.width}px'),
            // ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Height:'),
            CustomTableCell('${controller.imageInfo1?.image.height}px'),
            CustomTableCell('${controller.imageInfo2?.image.height}px'),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Size:'),
            CustomTableCell(controller.imageSize(controller.imageInfo1)),
            CustomTableCell(controller.imageSize(controller.imageInfo2)),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Format:'),
            CustomTableCell(
              controller.imageInfo1?.debugLabel?.split('.').last ?? '',
            ),
            CustomTableCell(
              controller.imageInfo2?.debugLabel?.split('.').last ?? '',
            ),
          ],
        ),
      ],
    );
  }
}
