import 'package:fashion_app/src/orders/models/order_model.dart';
import 'package:flutter/material.dart';

class FetchOrder {
  final OrdersModel? order;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchOrder({
    required this.order,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
