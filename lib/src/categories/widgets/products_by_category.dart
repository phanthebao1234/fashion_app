import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/widgets/empty_screen_widget.dart';

import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';

import 'package:fashion_app/common/widgets/shimmers/list_shimmer.dart';
import 'package:fashion_app/src/categories/controllers/category_notifier.dart';

import 'package:fashion_app/src/categories/hooks/fetch_product_by_category.dart';

import 'package:fashion_app/src/products/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProductsByCategory extends HookWidget {
  const ProductsByCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    final resutls =
        fetchProductByCategories(context.read<CategoryNotifier>().id);
    final products = resutls.products;
    final isLoading = resutls.isLoading;
    final error = resutls.error;

    if (isLoading) {
      return const Scaffold(
        body: ListShimmer(),
      );
    }
    return products.isEmpty
        ? EmptyScreenWidget()
        : Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.h),
            child: StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                ...List.generate(
                  products.length,
                  (i) {
                    final double mainAxisCellCount = (i % 2 == 0 ? 2.27 : 2.5);
                    final product = products[i];

                    return StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: mainAxisCellCount,
                      child: StaggeredTileWidget(
                        onTap: () {
                          if (accessToken == null) {
                            loginBottomSheet(context);
                          } else {
                            // handle wishlist function
                            print(product);
                          }
                        },
                        product: product,
                        i: i,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
  }
}
