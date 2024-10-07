import 'package:fashion_app/src/orders/models/order_model.dart';
import 'package:flutter/material.dart';

class FetchOrders {
  final List<OrdersModel> order;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchOrders({
    required this.order,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
