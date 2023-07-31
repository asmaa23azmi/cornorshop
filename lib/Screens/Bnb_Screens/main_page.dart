import 'package:cornorshop/Screens/Auth/create_new_acount.dart';
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
        //const CreateNewAccount(),
      ][selectedIndex],
      floatingActionButton: FloatingActionButton(
          backgroundColor: darkBlue,
          onPressed: () {
            setState(() {
              selectedIndex = 0;
            });
          },
          child: Icon(
            Icons.home,
            size: 28.h,
            color: whiteColor,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
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
                          color: selectedIndex == 1
                              ? greenColor
                              : Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.categoryBar,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: selectedIndex == 1
                                ? greenColor
                                : Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
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
                          color: selectedIndex == 2
                              ? greenColor
                              : Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.cartBar,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: selectedIndex == 2
                                ? greenColor
                                : Colors.grey.shade400,
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
                          Icons.favorite,
                          size: 28.h,
                          color: selectedIndex == 3
                              ? greenColor
                              : Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.favBar,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: selectedIndex == 3
                                ? greenColor
                                : Colors.grey.shade400,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 4.w),
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
                          Icons.person,
                          size: 28.h,
                          color: selectedIndex == 4
                              ? greenColor
                              : Colors.grey.shade400,
                        ),
                        Text(
                          AppLocalizations.of(context)!.profileBar,
                          style: TextStyle(
                            fontSize: 8.sp,
                            color: selectedIndex == 4
                                ? greenColor
                                : Colors.grey.shade400,
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
    );
  }
}
