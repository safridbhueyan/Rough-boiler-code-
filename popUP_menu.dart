import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Future<String?> customPopupMenu({
  required BuildContext context,
  required GlobalKey key,
  required Set<String> list,
  required List<String> iconListPath,
}) async {
  final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  final Size size = renderBox.size;

  final result = await showMenu<String>(
    context: context,
    color: Colors.white,
    elevation: 20,
    shadowColor: Colors.grey.withValues(alpha: 0.2),
    constraints: BoxConstraints(minWidth: 150, maxHeight: 250),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    position: RelativeRect.fromLTRB(
      190,
      offset.dy + size.height,
      20,
      offset.dy,
    ),
    items: () {
      List<PopupMenuEntry<String>> menuItems = [];
      final areasList = list.toList();

      for (int i = 0; i < areasList.length; i++) {
        menuItems.add(
          PopupMenuItem(
            value: areasList[i],
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(iconListPath[i]),
                Text(
                  areasList[i],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );

        if (i < areasList.length - 1) {
          menuItems.add(const PopupMenuDivider(color: Color(0xff000000)));
        }
      }
      return menuItems;
    }(),
  );

  return result;
}



//=====++++=+=++==+=++==++=+===+++++==+++++++++=========================================




import 'package:boilercode/custom_final_popUp.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey key = GlobalKey();

    return Scaffold(
      appBar: AppBar(title: Text("Custom Popup Menu Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              key: key,
              onPressed: () async {
                Set<String> menuItems = {'Item 1', 'Item 2', 'Item 3'};
                List<String> iconPaths = [
                  'assets/icon1.svg',
                  'assets/icon2.svg',
                  'assets/icon3.svg',
                ];

                String? selectedItem = await customPopupMenu(
                  context: context,
                  key: key,
                  list: menuItems,
                  iconListPath: iconPaths,
                );

                if (selectedItem != null) {
                  debugPrint('Selected: $selectedItem');
                }
              },
              child: Text("Show Popup Menu"),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: HomePage()));
}
//+++====================+++++++++++++++++++++++++++==================+++++++++++++++++++++++++++++++++++
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<String?> customPopupMenu({
  required BuildContext context,
  required GlobalKey key,
  required List<String> list, // Changed from Set<String> to List<String>
  required List<String> iconListPath,
}) async {
  final RenderBox renderBox =
      key.currentContext!.findRenderObject() as RenderBox;
  final Offset offset = renderBox.localToGlobal(Offset.zero);

  final Size size = renderBox.size;

  final result = await showMenu<String>(
    context: context,
    color: Colors.white,
    elevation: 20,
    shadowColor: Colors.grey.withValues(alpha: 0.2),
    constraints: BoxConstraints(minWidth: 150, maxHeight: 250),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    position: RelativeRect.fromLTRB(
      190,
      offset.dy + size.height,
      20,
      offset.dy,
    ),
    items: () {
      List<PopupMenuEntry<String>> menuItems = [];

      for (int i = 0; i < list.length; i++) {
        menuItems.add(
          PopupMenuItem(
            value: list[i], // Directly accessing the list
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(iconListPath[i]), // Using the icon list
                Text(
                  list[i], // Directly accessing the list
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        );

        // Add a divider between menu items
        if (i < list.length - 1) {
          menuItems.add(const PopupMenuDivider(color: Color(0xff000000)));
        }
      }
      return menuItems;
    }(),
  );

  return result;
}

