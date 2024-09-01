import 'package:fashion_app/common/utils/kcolors.dart';
import 'package:fashion_app/common/widgets/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProfileTileWidget extends StatelessWidget {
  const ProfileTileWidget(
      {super.key, required this.title, this.onTap, required this.leading});

  final String title;
  final void Function()? onTap;
  final IconData leading;

  @override
  Widget build(BuildContext context) {
    // ListTile trong Flutter là một widget dùng để hiển thị thông tin trong danh sách (ListView).
    // Nó bao gồm một đến ba dòng văn bản và có thể có biểu tượng hoặc widget khác đi kèm, chẳng hạn như checkbox.
    // ListTile giúp đơn giản hóa việc tạo danh sách bằng cách xử lý các thành phần giao diện mà không cần phải tạo các Rows,
    // Columns và Containers một cách thủ công.
    return ListTile(
      visualDensity: VisualDensity.compact,
      onTap: onTap,
      leading: Icon(leading),
      title: Text(
        title,
        style: appStyle(14, Kolors.kDark, FontWeight.w600),
      ),
      trailing: const Icon(
        AntDesign.right,
        size: 16,
        color: Kolors.kDark,
      ),
    );
  }
}
