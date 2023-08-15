import 'package:cornorshop/Providers/style_provider.dart';
import 'package:cornorshop/Screens/Bnb_Screens/profile_page.dart';
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
    return Consumer<StyleProvider>(
      builder: (context, style, child) {
        return Scaffold(
          body: [
            ///List from pages with index to move from page to other selected one.
            const HomePage(),
            const CategoryPage(),
            const ShoppingCartPage(),
            const FavoritePage(),
            const ProfilePage(),
          ][style.index],
          bottomNavigationBar: SizedBox(
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
                  icon: const Icon( Icons.favorite),
                  label: AppLocalizations.of(context)!.favBar,
                ),
                BottomNavigationBarItem(
                  icon: const Icon( Icons.person),
                  label: AppLocalizations.of(context)!.profileBar,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
