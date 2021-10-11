import 'package:flutter/material.dart';

class Category {
  final String id;
  final Color color;

  const Category({
    required this.id,
    this.color = Colors.orange,
  });
}
