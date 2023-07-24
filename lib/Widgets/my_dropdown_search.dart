import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Const/colors.dart';


class MyDropdownSearch extends StatefulWidget {
  final List<String> items;
  final Function(String? value)? onChange;


 const MyDropdownSearch({
    super.key,
    required this.items,
    required this.onChange,
  });

  @override
  State<MyDropdownSearch> createState() => _MyDropdownSearchState();
}

class _MyDropdownSearchState extends State<MyDropdownSearch> {
  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps:  PopupProps.modalBottomSheet(
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
      items: widget.items,
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
      onChanged:  widget.onChange,
    );
  }
}

