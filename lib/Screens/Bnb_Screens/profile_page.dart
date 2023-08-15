import 'package:cornorshop/Screens/Admin_Screens/bnb/main_admin_page.dart';
import 'package:provider/provider.dart';
import '../../Screens/Buyer_Screens/buyer_profile_page.dart';
import '../../Screens/Auth/log_in.dart';
import '../../Screens/Vendor_Screens/vendor_profile_page.dart';
import 'package:flutter/material.dart';
import '../../Helper/navigator_helper.dart';
import '../../Providers/auth_provider.dart';
import '../../enums.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with NavigatorHelper {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, auth, child) => !auth.loggedIn
          ? const LogIn()
          : auth.user?.userType == UserType.vendor.name
              ? const VendorProfilePage()
              : auth.user?.userType == UserType.buyer.name
                  ? const BuyerProfilePage()
                  : auth.user?.userType == UserType.superAdmin.name
                      ? const MainAdminPage()
                      : const SizedBox(),
    );
  }
}
