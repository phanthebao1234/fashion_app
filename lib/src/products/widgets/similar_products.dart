import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/products/widgets/staggered_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SimilarProducts extends StatelessWidget {
  const SimilarProducts({super.key});

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    return Padding(
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
