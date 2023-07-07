import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Widgets/my_text_field.dart';
import '../../Widgets/menu_items.dart';
import '../Bnb_Screens/cart_page.dart';
import '../Bnb_Screens/category_page.dart';
import '../Bnb_Screens/fav_page.dart';
import '../Bnb_Screens/home_page.dart';
import '../Bnb_Screens/profile_page.dart';
import '../../Const/colors.dart';
import '../../Helper/navigator_helper.dart';
import '../Menu_Items/app_settings_screen.dart';
import '../Menu_Items/message_screen.dart';
import '../Menu_Items/notifications_screen.dart';
import '../Menu_Items/app_information_screen.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with NavigatorHelper{
  late TextEditingController searchController;
  int selectedIndex = 0;

  @override
  void initState() {
    searchController =TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
   searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: babyBlue,
        toolbarHeight:124.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd:Radius.circular(20.r),
              bottomStart: Radius.circular(20.r)),
        ),
        leading: InkWell(
          onTap: (){
            ///Bottom Sheet
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.only(topStart: Radius.circular(20.r) , topEnd: Radius.circular(20.r))),
              builder: (context) {
              return Padding(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 26.w , vertical:80.h ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: Column(
                    children: [
                      ///Notification
                      MenuItems(text: AppLocalizations.of(context)!.notification,onTap: (){
                        jump(context, to: const NotificationScreen());
                      },),
                      SizedBox(height:10.h,),
                      Divider(color: grayColor, height: 0.3.h,),
                      SizedBox(height:18.h,),
                      ///Message
                      MenuItems(text: AppLocalizations.of(context)!.msg,onTap: (){
                        jump(context, to: const MessageScreen());
                      },),
                      SizedBox(height:10.h,),
                      Divider(color: grayColor, height: 0.3.h,),
                      SizedBox(height:18.h,),
                      ///App Settings
                      MenuItems(text: AppLocalizations.of(context)!.appSettings,onTap: (){
                        jump(context, to: AppSettingScreen());
                      },),
                      SizedBox(height:10.h,),
                      Divider(color: grayColor, height: 0.3.h,),
                      SizedBox(height:18.h,),
                      ///App Information
                      MenuItems(text: AppLocalizations.of(context)!.appInfo,onTap: (){
                        jump(context, to: const AppInformation(),);},),
                      SizedBox(height:10.h,),
                      Divider(color: grayColor, height: 0.3.h,),
                      SizedBox(height:18.h,),
                    ],
                  ),
                ),
              );
            },);
          } ,///call_back
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 15.w ,top: 15.h,),
            child: Icon(Icons.menu_rounded,
            color: darkBlue,
            size: 44.34.h,
            ),
          ),
        ),
        leadingWidth: 70.w, /// default =56.
        title:Padding(
          padding: EdgeInsetsDirectional.only(end:15.w,top: 15.h,),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // if (selectedIndex == 0)
              //   Image.asset('assets/images/shopLogo.png',width: 115.w,height: 27.h,),
              //   SizedBox(height: 3.h,),
              MyTextField(controller: searchController,
              hintText: AppLocalizations.of(context)!.searchBar,
                prefixIcon: IconButton(
                  icon:const  Icon(Icons.search,),
                  color: grayColor,
                  iconSize: 25.35.h,
                  onPressed: () {},
                ),),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: [
        ///List from pages with index to move from page to other selected one.
       const HomePage(),
       const CategoryPage(),
       const ShoppingCartPage(),
       const FavoritePage(),
       const ProfilePage(),
      ][selectedIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadiusDirectional.only(
          topStart: Radius.circular(20.0.r),
          topEnd: Radius.circular(20.0.r),
        ),
        child: SizedBox(
          height: 66.h,
          child: BottomNavigationBar(
            currentIndex: selectedIndex, /// the index for the page that where iam now.
            onTap: (int index)=>setState(() =>selectedIndex = index),
            ///call_back, that return the index value that i pressed on it ==> (){}.
            ///setState() its important method ==> used to move between pages and make refresh for the page.
            showSelectedLabels: true, /// to show the text(label) under the icon default value: true.
            backgroundColor: babyBlue,
            elevation: 0.0, /// to remove border
            iconSize: 28.h,
            selectedItemColor: darkBlue,
            unselectedItemColor: darkBlue,
            selectedLabelStyle:TextStyle(
              fontSize: 8.0.sp,
            ),
            unselectedLabelStyle:TextStyle(
              fontSize: 8.0.sp,
            ),
            type: BottomNavigationBarType.fixed, /// to show all icons cause we have > 4 icons
            items:  [
              BottomNavigationBarItem(
                icon: selectedIndex == 0 ? const Icon(Icons.home): const Icon(Icons.home_outlined),
                label: AppLocalizations.of(context)!.homeBar ,
              ),
              BottomNavigationBarItem(
                  icon: selectedIndex ==1 ?const Icon(Icons.category) : const Icon(Icons.category_outlined),
                  label: AppLocalizations.of(context)!.categoryBar,),
              BottomNavigationBarItem(
                  icon:selectedIndex == 2 ?const Icon(Icons.shopping_cart): const Icon(Icons.shopping_cart_outlined),
                  label: AppLocalizations.of(context)!.cartBar,),
              BottomNavigationBarItem(
                  icon:selectedIndex == 3 ? const Icon(Icons.favorite): const Icon(Icons.favorite_border_outlined),
                  label: AppLocalizations.of(context)!.favBar,),
              BottomNavigationBarItem(
                  icon:selectedIndex == 4 ? const Icon(Icons.person): const Icon(Icons.person_outline_outlined),
                  label: AppLocalizations.of(context)!.profileBar,),
            ],
          ),
        ),
      ),
    );
  }
}


