import 'package:cached_network_image/cached_network_image.dart';
import 'package:fashion_app/common/services/storage.dart';
import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/utils/kstrings.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:fashion_app/common/widgets/back_button.dart';
import 'package:fashion_app/common/widgets/error_modal.dart';
import 'package:fashion_app/common/widgets/login_bottom_sheet.dart';
import 'package:fashion_app/common/widgets/reusable_text.dart';
import 'package:fashion_app/const/constants.dart';
import 'package:fashion_app/src/cart/controllers/cart_notifier.dart';
import 'package:fashion_app/src/cart/models/create_cart_model.dart';
import 'package:fashion_app/src/products/controllers/colors_sizes_notifier.dart';
import 'package:fashion_app/src/products/controllers/product_notifier.dart';
import 'package:fashion_app/src/products/widgets/expandable_text.dart';
import 'package:fashion_app/src/products/widgets/color_selection_widget.dart';
import 'package:fashion_app/src/products/widgets/product_bottom_bar.dart';
import 'package:fashion_app/src/products/widgets/product_sizes_widget.dart';
import 'package:fashion_app/src/products/widgets/similar_products.dart';
import 'package:fashion_app/src/wishlist/controllers/wishlist_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    String? accessToken = Storage().getString('accessToken');
    // Consumer trong Flutter là một widget cho phép lấy giá trị từ provider mà không cần một BuildContext là một người kế thừa của provider đó.
    // Consumer thường được sử dụng trong quản lý trạng thái, giúp tái tạo lại giao diện khi có sự thay đổi trong mô hình,
    // thông qua việc gọi hàm notifyListeners() từ ChangeNotifierProvider.
    return Consumer<ProductNotifier>(
      builder: (context, productNotifier, child) {
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 320.h, // chiều cao tối đa
                collapsedHeight: 65.h, // chiều cao tối thiểu khi thu gọn
                floating: false,
                pinned:
                    true, // SliverAppBar trong CustomScrollView có thể được cấu hình để "pinned", tức là nó sẽ giữ nguyên ở vị trí trên cùng khi cuộn.
                leading: AppBackButton(),
                actions: [
                  Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Consumer<WishlistNotifier>(
                          builder: (context, wishlistNotifier, child) {
                        return GestureDetector(
                          onTap: () {
                            if (accessToken == null) {
                              loginBottomSheet(context);
                            } else {
                              wishlistNotifier.addRemoveWishList(
                                  productNotifier.product!.id, () {});
                            }
                          },
                          child: CircleAvatar(
                            backgroundColor: Kolors.kSecondaryLight,
                            child: Icon(
                              AntDesign.heart,
                              color: wishlistNotifier.wishlist
                                      .contains(productNotifier.product!.id)
                                  ? Kolors.kRed
                                  : Kolors.kGray,
                              size: 18,
                            ),
                          ),
                        );
                      })),
                ],
                //  bạn có thể chỉ định một widget flexibleSpace cung cấp không gian linh hoạt ở phía sau thanh công cụ và các widget khác.
                // Điều này cho phép tiêu đề và các yếu tố khác thay đổi kích thước khi cuộn.
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: SizedBox(
                    height: 415.h,
                    child: ImageSlideshow(
                      indicatorColor: Kolors.kPrimaryLight,
                      autoPlayInterval: 13000, // seconds
                      height: 415.h,
                      isLoop: productNotifier.product!.imageUrls.length > 1
                          ? true
                          : false,
                      children: List.generate(
                          productNotifier.product!.imageUrls.length, (i) {
                        return CachedNetworkImage(
                          // CachedNetworkImage là một thư viện Flutter dùng để tải và lưu trữ hình ảnh từ mạng.
                          // Nó hỗ trợ việc sử dụng hình ảnh với các widget placeholder và error,
                          // và có thể được sử dụng trực tiếp hoặc thông qua ImageProvider.
                          placeholder: placeholder,
                          errorWidget: errorWidget,
                          imageUrl: productNotifier.product!.imageUrls[i],
                          fadeInDuration: Duration(milliseconds: 2500),
                          fit: BoxFit.cover,
                        );
                      }),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ReusableText(
                        text:
                            productNotifier.product!.clothesType.toUpperCase(),
                        style: appStyle(13, Kolors.kGray, FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Icon(
                            AntDesign.star,
                            color: Kolors.kGold,
                            size: 14,
                          ),
                          SizedBox(
                            width: 5.h,
                          ),
                          ReusableText(
                            text: productNotifier.product!.ratings
                                .toStringAsFixed(1),
                            style: appStyle(
                              13,
                              Kolors.kGray,
                              FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ReusableText(
                    text: productNotifier.product!.title,
                    style: appStyle(16, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(8.h),
                  child: ExpandableText(
                      text: productNotifier.product!.description),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Divider(
                    thickness: .5.h,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Select Size",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ProductSizesWidget(),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Select Colors",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ColorSelectionWidget(),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ReusableText(
                    text: "Similar Products",
                    style: appStyle(14, Kolors.kDark, FontWeight.w600),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 10.h,
                ),
              ),
              const SliverToBoxAdapter(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: SimilarProducts(),
              )),
            ],
          ),
          bottomNavigationBar: ProductBottomBar(
            price: productNotifier.product!.price.toStringAsFixed(2),
            onPressed: () {
              if (accessToken == null) {
                loginBottomSheet(context);
              } else {
                if (context.read<ColorsSizesNotifier>().colors == '' ||
                    context.read<ColorsSizesNotifier>().sizes == '') {
                  showErrorPopup(context, AppText.kCartErrorText,
                      'Error Adding to cart', true);
                } else {
                  CreateCartModel data = CreateCartModel(
                    product: context.read<ProductNotifier>().product!.id,
                    quantity: 1,
                    size: context.read<ColorsSizesNotifier>().sizes,
                    color: context.read<ColorsSizesNotifier>().colors,
                  );

                  String cartData = createCartModelToJson(data);
                  context.read<CartNotifier>().addToCart(cartData, context);
                }
              }
            },
          ),
        );
      },
    );
  }
}
