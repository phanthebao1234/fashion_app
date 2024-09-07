import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/src/categories/controllers/category_notifier.dart';
import 'package:fashion_app/src/categories/widgets/products_by_category.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: const AppBackButton(),
        title: ReusableText(
          text: context.read<CategoryNotifier>().category,
          style: appStyle(
            16,
            Kolors.kPrimary,
            FontWeight.normal,
          ),
        ),
      ),
      body: const ProductsByCategory(),
    );
  }
}
