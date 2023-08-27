import 'package:cornorshop/Widgets/My_Widgets/my_exit_dialog.dart';

import '../../../Providers/auth_provider.dart';
import '../../../Providers/style_provider.dart';
import '../../../Screens/Bnb_Screens/profile_page.dart';
import '../../../enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../Bnb_Screens/cart_page.dart';
import '../Bnb_Screens/category_page.dart';
import '../Bnb_Screens/fav_page.dart';
import '../Bnb_Screens/home_page.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Consumer2<StyleProvider, AuthProvider>(
      builder: (context, style, auth, child) {
        return WillPopScope(
          onWillPop: () async{
            showDialog(context: context, builder: (context) => myExitDialog(context));
            return false;
          },
          child: Scaffold(
            body: [
              ///List from pages with index to move from page to other selected one.
              const HomePage(),
              const CategoryPage(),
              const ShoppingCartPage(),
              const FavoritePage(),
              const ProfilePage(),
            ][style.index],
            bottomNavigationBar: auth.user?.userType == UserType.superAdmin.name || auth.user?.userType == UserType.admin.name
                ? const SizedBox.shrink()
                : SizedBox(
                    // height: 60.h,
                    child: BottomNavigationBar(
                      currentIndex: style.index,
                      onTap: (int index) => setState(() => style.index = index),
                      showSelectedLabels: true,
                      backgroundColor: whiteColor,
                      iconSize: 28.h,
                      selectedItemColor: greenColor,
                      unselectedItemColor: Colors.grey.shade400,
                      selectedLabelStyle: TextStyle(
                        fontSize: 8.0.sp,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: 8.0.sp,
                      ),
                      type: BottomNavigationBarType.fixed,

                      /// to show all icons cause we have > 4 icons
                      items: [
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.home),
                          label: AppLocalizations.of(context)!.homeBar,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.category),
                          label: AppLocalizations.of(context)!.categoryBar,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.shopping_cart),
                          label: AppLocalizations.of(context)!.cartBar,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.favorite),
                          label: AppLocalizations.of(context)!.favBar,
                        ),
                        BottomNavigationBarItem(
                          icon: const Icon(Icons.person),
                          label: AppLocalizations.of(context)!.profileBar,
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
