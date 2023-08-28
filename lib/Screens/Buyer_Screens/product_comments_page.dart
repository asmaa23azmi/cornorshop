import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cornorshop/Fierbase/controllers/comment_fb_controller.dart';
import 'package:cornorshop/Models/fb/comment_model.dart';
import 'package:cornorshop/Models/fb/product_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../Helper/image_helper.dart';
import '../../Helper/snack_bar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Const/colors.dart';
import '../../Const/texts.dart';
import '../../Providers/auth_provider.dart';
import '../../Widgets/My_Widgets/my_text_field.dart';

class ProductCommentPage extends StatefulWidget {
  final ProductModel? product;

   const ProductCommentPage({
    required this.product,
    super.key});

  @override
  State<ProductCommentPage> createState() => _ProductCommentPageState();
}

class _ProductCommentPageState extends State<ProductCommentPage> with SnackBarHelper, ImgHelper{
  AuthProvider get _auth => Provider.of<AuthProvider>(context, listen: false);

  late TextEditingController commentController;

@override
  void initState() {
  commentController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0.4,
          backgroundColor: whiteColor,
          // toolbarHeight: 70.h,
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: darkBlue,
              size: 22.h,
            ),
          ),
          centerTitle: true,
          title: Text(
            AppLocalizations.of(context)!.productComments,
            style: textAppBarStyle,
          )
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsDirectional.symmetric(
              horizontal: 14.w, vertical: 10.h),
          child: Column(
            children: [
              /// all comment
             Expanded(
               child: StreamBuilder(
                 stream: CommentFbController().readComments(widget.product!.id!),
                 builder: (context, snapshot) {
                 if(snapshot.connectionState == ConnectionState.waiting){
                   return Padding(
                     padding: EdgeInsets.symmetric(vertical: 240.h),
                     child: const Center(child: CircularProgressIndicator()),
                   );
                 }else if(snapshot.hasData && snapshot.data!.docs.isNotEmpty){
                   List<CommentModel> comments =  snapshot.data!.docs.map((e) => e.data()).toList();
                   return  ListView.separated(
                     shrinkWrap: true,
                     itemCount: comments.length,
                     itemBuilder: (context, index) {
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Row(
                             children: [
                               Container(
                                 height: 30.h,
                                 width: 30.h,
                                 clipBehavior: Clip.antiAlias,
                                 decoration: BoxDecoration(
                                     shape: BoxShape.circle,
                                     color: Colors.grey.shade200
                                 ),
                                 child: appCacheImg('${comments[index].user?.profileImg?.link}',
                                     Icon(
                                       Icons.person,
                                       size: 18.h,
                                       color: Colors.grey.shade300,
                                     )),
                               ),
                               SizedBox(width: 8.w),
                               Text('${comments[index].user?.name}',
                                 style: TextStyle(
                                     fontSize: 12.sp,
                                     color: darkBlue,
                                     fontWeight: FontWeight.bold
                                 ),),
                               SizedBox(width: 6.w),
                               Text('${comments[index].timestamp?.toDate()}',
                                 style: TextStyle(
                                   fontSize: 10.sp,
                                   color: blackObacityColor,
                                 ),),
                             ],
                           ),
                           SizedBox(height: 12.h),
                           Padding(
                             padding: EdgeInsetsDirectional.only(start: 14.w),
                             child: Text('${comments[index].text}',
                               style: TextStyle(
                                   fontSize: 12.sp
                               ),),
                           )
                         ],
                       );
                     },
                     separatorBuilder: (context, index) => SizedBox(height: 10.h),
                   );
                 }else {
                   return Padding(
                     padding: EdgeInsets.symmetric(vertical: 240.h),
                     child: Center(
                       child: Text(
                         AppLocalizations.of(context)!.theresNoCommentsYet,
                         style: TextStyle(
                             fontSize: 14.0.sp,
                             fontWeight: FontWeight.normal,
                             color: blackObacityColor),
                         textAlign: TextAlign.center,
                       ),
                     ),
                   );
                 }
               },),
             ),
              ///add comment
              Row(
                children: [
                  Expanded(
                      child: MyTextField(
                          controller: commentController,
                          hintText: AppLocalizations.of(context)!.addComment,
                          textFieldBorderColor: greyColor)),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () async => _performAddComment() ,
                    child: Container(
                      width: 36.h,
                      height: 36.h,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: greenColor
                      ),
                      child: Icon(Icons.send_rounded, color: Colors.white,size: 18.h),
                    ),
                  )
                ],)
            ],
          ),
        ),
      ),
    );
  }

  ///functions

  Future<void> _performAddComment() async{
    ///before create account
    if (_checkData()) {

      !_auth.loggedIn
          ? showMySnackBar(context,
          text: AppLocalizations.of(context)!.pleaseLoginToAddComment, error: true)
          : await _addComment();
    }
  }

  Future<void> _addComment() async{
  var status = await CommentFbController().addComment(CommentModel(
       id: const Uuid().v4(),
       text: commentController.text,
       user: _auth.user,
       product: widget.product,
       timestamp: Timestamp.now()));

  if(status){
    commentController.clear();
  }
  }

  bool _checkData() {
    ///to check text field
    if (commentController.text.isEmpty) {
      showMySnackBar(context,
          text: AppLocalizations.of(context)!.addBlankComment, error: true);
      return false;
    }
    return true;
  }
}
