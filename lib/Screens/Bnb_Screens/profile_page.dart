import 'package:cornorshop/Screens/Vendor_Screens/vendor_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Const/texts.dart';
import '../../Helper/navigator_helper.dart';
import '../../Const/colors.dart';
import '../../Models/fb/product_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with NavigatorHelper {
  List<ProductModel> product = [
    ProductModel(
      id: '1',
      name: 'كيكة الكريمة',
      price: 25.0,
      img: ['cake'],
      categoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),
    ProductModel(
      id: '2',
      name: 'مسخن رول _ عدد 1 ',
      price: 2.0,
      img: ['food'],
      categoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),
    ProductModel(
      id: '3',
      name: 'قميص شتوي ',
      price: 70.0,
      img: ['shirt'],
      categoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),
    ProductModel(
      id: '2',
      name: 'مسخن رول _ عدد 1 ',
      price: 2.0,
      img: ['food'],
      categoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),
    ProductModel(
      id: '3',
      name: 'قميص شتوي ',
      price: 70.0,
      img: ['shirt'],
      categoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),
    ProductModel(
      id: '2',
      name: 'مسخن رول _ عدد 1 ',
      price: 2.0,
      img: ['food'],
      categoryType: 'طعام وحلويات منزلية',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),
    ProductModel(
      id: '3',
      name: 'قميص شتوي ',
      price: 70.0,
      img: ['shirt'],
      categoryType: 'ملابس',
      vendorName: 'اسم المتجر',
      quantity: 1,
    ),

  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0.4,
        backgroundColor: whiteColor,
        //toolbarHeight: 100.h,
        title: Text(
          AppLocalizations.of(context)!.userPage,
          style: textAppBarStyle,
        ),
      ),
      body:const VendorProfilePage(),

    );
  }
}


