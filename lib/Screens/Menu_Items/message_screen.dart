import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Widgets/my_text_field.dart';
class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late TextEditingController searchBarController;
  @override
  void initState() {
   searchBarController = TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    searchBarController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: babyBlue,
        toolbarHeight: 124.h,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.only(
              bottomEnd:Radius.circular(20.r),
              bottomStart: Radius.circular(20.r)),
        ),
        leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          onTap: (){Navigator.pop(context);},
            child: Icon(Icons.arrow_back_ios,
              color: darkBlue,
              size: 24.0.h,),),
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.msg, style: textAppBarStyle,),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 18.h),
          child: Column(
            children: [
              MyTextField(controller: searchBarController, hintText: AppLocalizations.of(context)!.searchBar,
              prefixIcon: IconButton(onPressed: (){}, icon:const  Icon(Icons.search),color: blackObacityColor,
                iconSize: 25.35.h,),
                textFieldColor: msgSearchColor,hintSyleColor: blackObacityColor,
            ),],
          ),
        ),
      ),
    );
  }
}
