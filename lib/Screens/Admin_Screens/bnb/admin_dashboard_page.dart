import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../Providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../Const/colors.dart';
import '../../../Const/texts.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<int> getUserCount() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    return snapshot.docs.length;
  }

  Future<int> getCategoryCount() async {
    QuerySnapshot snapshot = await _firestore.collection('categories').get();
    return snapshot.docs.length;
  }

  Future<int> getProductCount() async {
    QuerySnapshot snapshot = await _firestore.collection('products').get();
    return snapshot.docs.length;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.4,
            backgroundColor: whiteColor,
            title: Text(
              AppLocalizations.of(context)!.adminDashboard,
              style: textAppBarStyle,
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsetsDirectional.symmetric(
                  horizontal: 14.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ///Profile Img
                      Container(
                        width: 80.w,
                        height: 80.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade200,
                        ),
                        child: Icon(
                          Icons.person,
                          size: 60.h,
                          color: Colors.grey.shade300,
                        ),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///Admin name
                          Text(auth.user?.name ?? '', style: textStyle),

                          ///Admin Email
                          Text(
                            auth.user?.email ?? '',
                            style: TextStyle(
                                fontFamily: 'TitilliumWeb',
                                color: blackObacityColor,
                                fontSize: 13.sp),
                          ),

                          ///Admin Type
                          Text(
                            auth.user?.userType ?? '',
                            style: TextStyle(
                                fontFamily: 'TitilliumWeb',
                                color: blackObacityColor,
                                fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 8.w, vertical: 15.h),
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.r),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                    color: Colors.grey.shade300)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.person,
                                    color: Colors.grey,
                                    size: 22.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                      AppLocalizations.of(context)!.users,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey)),
                                ],
                              ),
                              FutureBuilder<int>(
                                future: getUserCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return SizedBox(
                                        height: 20.h,
                                        width: 20.h,
                                        child:  CircularProgressIndicator(strokeWidth: .8.w));
                                  } else if (snapshot.hasError) {
                                    return const Text('Error loading user count.');
                                  } else {
                                    int userCount = snapshot.data ?? 0;
                                    return Text('$userCount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp,
                                            color: greenColor));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 8.w, vertical: 15.h),
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.r),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                    color: Colors.grey.shade300)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.category_rounded,
                                    color: Colors.grey,
                                    size: 22.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .categories,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey)),
                                ],
                              ),
                              FutureBuilder<int>(
                                future: getCategoryCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                        height: 20.h,
                                        width: 20.h,
                                        child:  CircularProgressIndicator(strokeWidth: .8.w));
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Error loading category count.');
                                  } else {
                                    int categoryCount = snapshot.data ?? 0;
                                    return Text('$categoryCount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp,
                                            color: greenColor));
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ]),
                  SizedBox(height: 50.h),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 8.w, vertical: 15.h),
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.r),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                    color: Colors.grey.shade300)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/target.png',
                                      height: 22.h,
                                      width: 22.h,
                                      color: Colors.grey),
                                  SizedBox(width: 6.w),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .products,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey)),
                                ],
                              ),
                              FutureBuilder<int>(
                                future: getProductCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return SizedBox(
                                        height: 20.h,
                                        width: 20.h,
                                        child:  CircularProgressIndicator(strokeWidth: .8.w));
                                  } else if (snapshot.hasError) {
                                    return const Text(
                                        'Error loading product count.');
                                  } else {
                                    int productCount = snapshot.data ?? 0;
                                    return Text('$productCount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp,
                                            color: greenColor));
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsetsDirectional.symmetric(
                              horizontal: 8.w, vertical: 15.h),
                          width: 120.w,
                          height: 120.w,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.r),
                              color: whiteColor,
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 6,
                                    offset: const Offset(0, 3),
                                    color: Colors.grey.shade300)
                              ]),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.shopping_cart_rounded,
                                    color: Colors.grey,
                                    size: 22.h,
                                  ),
                                  SizedBox(width: 6.w),
                                  Text(
                                      AppLocalizations.of(context)!
                                          .orders,
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: Colors.grey)),
                                ],
                              ),
                              FutureBuilder<int>(
                                future: getCategoryCount(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return SizedBox(
                                        height: 20.h,
                                        width: 20.h,
                                        child:  CircularProgressIndicator(strokeWidth: .8.w));
                                  } else if (snapshot.hasError) {
                                    return const Text('Error loading order count.');
                                  } else {
                                    int categoryCount = snapshot.data ?? 0;
                                    return Text('$categoryCount',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 40.sp,
                                            color: greenColor));
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      ]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
