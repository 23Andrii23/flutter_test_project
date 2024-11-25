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
        title: const Text('Home Screen', style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Obx(
        () => controller.isImageLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        'Image Comparison',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  controller.imageOnePath,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  controller.getFileName(
                                    controller.imageInfoOne?.name ?? '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  controller.imageTwoPath,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  controller.getFileName(
                                    controller.imageInfoTwo?.name ?? '',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
              controller.getFileName(controller.imageInfoOne?.name ?? ''),
            ),
            CustomTableCell(
              controller.getFileName(controller.imageInfoTwo?.name ?? ''),
            ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Width:'),
            CustomTableCell(
              '${controller.imageInfoOne?.width}px',
              isBiggerThenAnother: controller.isBiggerThenAnother(
                controller.imageInfoOne?.width,
                controller.imageInfoTwo?.width,
              ),
            ),
            CustomTableCell(
              '${controller.imageInfoTwo?.width}px',
              isBiggerThenAnother: controller.isBiggerThenAnother(
                controller.imageInfoTwo?.width,
                controller.imageInfoOne?.width,
              ),
            ),
            // ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Height:'),
            CustomTableCell(
              '${controller.imageInfoOne?.height}px',
              isBiggerThenAnother: controller.isBiggerThenAnother(
                controller.imageInfoOne?.height,
                controller.imageInfoTwo?.height,
              ),
            ),
            CustomTableCell(
              '${controller.imageInfoTwo?.height}px',
              isBiggerThenAnother: controller.isBiggerThenAnother(
                controller.imageInfoTwo?.height,
                controller.imageInfoOne?.height,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Size:'),
            CustomTableCell(
              controller.imageInfoOne?.size ?? '',
              isBiggerThenAnother: controller.isBiggerSize(
                controller.imageInfoOne?.size,
                controller.imageInfoTwo?.size,
              ),
            ),
            CustomTableCell(
              controller.imageInfoTwo?.size ?? '',
              isBiggerThenAnother: controller.isBiggerSize(
                controller.imageInfoTwo?.size,
                controller.imageInfoOne?.size,
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Format:'),
            CustomTableCell(controller.imageInfoOne?.format ?? ''),
            CustomTableCell(controller.imageInfoTwo?.format ?? ''),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Latitude:'),
            CustomTableCell(
              controller.imageInfoOne?.latitude ?? '',
            ),
            CustomTableCell(
              controller.imageInfoTwo?.latitude ?? '',
            ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Longitude:'),
            CustomTableCell(
              controller.imageInfoOne?.longitude ?? '-',
            ),
            CustomTableCell(
              controller.imageInfoTwo?.longitude ?? '-',
            ),
          ],
        ),
        TableRow(
          children: [
            const CustomTableCell('Color:'),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 25,
                  color: controller.imageInfoOne?.color,
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  height: 25,
                  color: controller.imageInfoTwo?.color,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
