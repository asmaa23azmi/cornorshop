import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Bnb_Screens/cart_page.dart';
import '../Bnb_Screens/category_page.dart';
import '../Bnb_Screens/fav_page.dart';
import '../Bnb_Screens/home_page.dart';
import '../Bnb_Screens/profile_page.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with NavigatorHelper {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        ///List from pages with index to move from page to other selected one.
        const HomePage(),
        const CategoryPage(),
        const ShoppingCartPage(),
        const FavoritePage(),
        const ProfilePage(),
      ][selectedIndex],
      floatingActionButton: FloatingActionButton(
        backgroundColor: babyBlue,
        onPressed: () {
          setState(() {
            selectedIndex = 0;
          });
        },
        child: Icon(
          Icons.home,

          size: 28.h,
          color:  selectedIndex == 0 ? darkBlue: whiteColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape:const CircularNotchedRectangle(),
        notchMargin: 10.w,
        child: SizedBox(
          height: 66.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                  minWidth: 50.w,
                  onPressed: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                         Icons.category,
                        size: 28.h,
                        color:  selectedIndex == 1 ? darkBlue: Colors.grey.shade400,
                      ),
                      Text(
                        AppLocalizations.of(context)!.categoryBar,
                        style: TextStyle(
                            fontSize: 8.sp,
                          color:  selectedIndex == 1 ? darkBlue: Colors.grey.shade400,
                        ),
                      )
                    ],
                  ),
                ),
                  SizedBox(width: 4.w,),
                  MaterialButton(
                    minWidth: 50.w,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                           Icons.shopping_cart,
                          size: 28.h,
                          color: selectedIndex == 2 ? darkBlue: Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.cartBar,
                          style: TextStyle(
                              fontSize: 8.sp,
                            color:  selectedIndex == 2 ? darkBlue: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MaterialButton(
                    minWidth: 50.w,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                           Icons.favorite ,
                          size: 28.h,
                          color:  selectedIndex == 3 ? darkBlue: Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.favBar,
                          style: TextStyle(
                              fontSize: 8.sp,
                            color:  selectedIndex == 3 ? darkBlue: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w,),
                  MaterialButton(
                    minWidth: 50.w,
                    onPressed: () {
                      setState(() {
                        selectedIndex = 4;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.person ,
                          size: 28.h,
                          color:  selectedIndex == 4 ? darkBlue: Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.profileBar,
                          style: TextStyle(
                              fontSize: 8.sp,
                            color:  selectedIndex == 4 ? darkBlue: Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
      // bottomNavigationBar: ClipRRect(
      //   borderRadius: BorderRadiusDirectional.only(
      //     topStart: Radius.circular(20.0.r),
      //     topEnd: Radius.circular(20.0.r),
      //   ),
      //   child: SizedBox(
      //     height: 66.h,
      //     child: BottomNavigationBar(
      //       currentIndex: selectedIndex,
      //
      //       /// the index for the page that where iam now.
      //       onTap: (int index) => setState(() => selectedIndex = index),
      //
      //       ///call_back, that return the index value that i pressed on it ==> (){}.
      //       ///setState() its important method ==> used to move between pages and make refresh for the page.
      //       showSelectedLabels: true,
      //
      //       /// to show the text(label) under the icon default value: true.
      //       backgroundColor: whiteColor,
      //       elevation: 1,
      //
      //       /// to remove border
      //       iconSize: 28.h,
      //       selectedItemColor: darkBlue,
      //       unselectedItemColor: darkBlue,
      //       selectedLabelStyle: TextStyle(
      //         fontSize: 8.0.sp,
      //       ),
      //       unselectedLabelStyle: TextStyle(
      //         fontSize: 8.0.sp,
      //       ),
      //       type: BottomNavigationBarType.fixed,
      //
      //       /// to show all icons cause we have > 4 icons
      //       items: [
      //         BottomNavigationBarItem(
      //           icon: selectedIndex == 0
      //               ? const Icon(Icons.home)
      //               : const Icon(Icons.home_outlined),
      //           label: AppLocalizations.of(context)!.homeBar,
      //         ),
      //         BottomNavigationBarItem(
      //           icon: selectedIndex == 1
      //               ? const Icon(Icons.category)
      //               : const Icon(Icons.category_outlined),
      //           label: AppLocalizations.of(context)!.categoryBar,
      //         ),
      //         BottomNavigationBarItem(
      //           icon: selectedIndex == 2
      //               ? const Icon(Icons.shopping_cart)
      //               : const Icon(Icons.shopping_cart_outlined),
      //           label: AppLocalizations.of(context)!.cartBar,
      //         ),
      //         BottomNavigationBarItem(
      //           icon: selectedIndex == 3
      //               ? const Icon(Icons.favorite)
      //               : const Icon(Icons.favorite_border_outlined),
      //           label: AppLocalizations.of(context)!.favBar,
      //         ),
      //         BottomNavigationBarItem(
      //           icon: selectedIndex == 4
      //               ? const Icon(Icons.person)
      //               : const Icon(Icons.person_outline_outlined),
      //           label: AppLocalizations.of(context)!.profileBar,
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
