import 'package:cornorshop/Fierbase/controllers/categories_fb_controller.dart';
import 'package:cornorshop/Models/fb/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import 'my_text_field.dart';

typedef MyDropdownCallBack = Function(dynamic _);

class MyDropdownSearch extends StatefulWidget {
 //final List<dynamic>? list;
 //final dynamic selectedItem;
 final MyDropdownCallBack? callBack;
  /// List<dynamic> list;
  /// dynamic selectedItem
  /// MyDropdownCallBack callback

  const MyDropdownSearch({
    super.key,
    this.callBack,

  });

  @override
  State<MyDropdownSearch> createState() => _MyDropdownSearchState();
}

class _MyDropdownSearchState extends State<MyDropdownSearch> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: CategoriesFbController().readCategory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox();
        } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
          List<CategoryModel> items =
              snapshot.data!.docs.map((e) => e.data()).toList();
          return DropdownSearch<String>(
            popupProps: PopupProps.modalBottomSheet(
              modalBottomSheetProps: ModalBottomSheetProps(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20.r),
                    topEnd: Radius.circular(20.r),
                  ),
                ),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.45,
                ),
              ),
              showSelectedItems: true,
            ),
            items: items.map((e) => e.title ?? '').toList(),
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                constraints: BoxConstraints(maxHeight: 44.h),
                contentPadding:
                    EdgeInsetsDirectional.symmetric(horizontal: 10.w),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14.0.r),
                  borderSide: BorderSide(
                    color: blackObacityColor,
                  ),
                ),
                hintText: AppLocalizations.of(context)!.chooseOne,
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal,
                  color: blackObacityColor,
                ),
              ),
            ),
            onChanged: widget.callBack,
          );
        } else {
          return MyTextField(
            controller: _controller,
            hintText: AppLocalizations.of(context)!.chooseOne,
            textFieldBorderColor: blackObacityColor,
            isEnabled: false,
          );
        }
      },
    );
  }
}
