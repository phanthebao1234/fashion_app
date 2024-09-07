import 'package:fashion_app/src/products/models/products_models.dart';
import 'package:flutter/material.dart';

class FetchProducts {
  final List<Products> products;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchProducts({
    required this.products,
    required this.isLoading,
    required this.error,
    required this.refetch, 
  });
}
