import 'package:flutter/cupertino.dart';

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color selectedColor;
  final Color unSelectedColor;
  final double size;
  final double sizeSelected;

  const PageIndicator({
    Key key,
    this.itemCount,
    this.currentIndex,
    this.selectedColor,
    this.unSelectedColor,
    this.size = 8,
    this.sizeSelected = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: items,
    );
  }

  List<Widget> get items {
    final List<Widget> items = [];
    for (int i = 0; i < itemCount; i++) {
      final itemSize = i == currentIndex ? sizeSelected : size;
      items.add(Container(
        width: itemSize,
        height: itemSize,
        margin: EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: i == currentIndex ? selectedColor : unSelectedColor,
        ),
      ));
    }
    return items;
  }
}
