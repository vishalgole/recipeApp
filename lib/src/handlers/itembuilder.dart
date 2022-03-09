import 'package:flutter/material.dart';

import '../model/item.dart';

class ItemBuilder extends StatelessWidget {
  const ItemBuilder({
    Key? key,
    required List<Item> items,
    required this.index,
  })  : _items = items,
        super(key: key);

  final List<Item> _items;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      height: 150,
      color: _items[index].color,
      child: Center(
          child: Text(
        _items[index].title,
        style: const TextStyle(fontSize: 25),
      )),
    );
  }
}
