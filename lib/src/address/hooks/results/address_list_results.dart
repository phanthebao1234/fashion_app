import 'package:fashion_app/src/address/models/address_model.dart';
import 'package:flutter/material.dart';

class FetchAddress {
  final List<AddressModel> address;
  final bool isLoading;
  final String? error;
  final VoidCallback refetch;

  FetchAddress({
    required this.address,
    required this.isLoading,
    required this.error,
    required this.refetch,
  });
}
