import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Const/colors.dart';
import '../Const/texts.dart';
import 'my_text_field.dart';

///To Build CallBack Fun
typedef SelectedCountryCallBak = Function({required CountryModel country});

class MyPhoneTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final Color textFieldColor;
  final CountryModel country;
  final SelectedCountryCallBak selectedCountryCallBak;
  const MyPhoneTextField({
    required this.controller,
    required this.hintText,
    this.textFieldColor = whiteColor,
    required this.country,
    required this.selectedCountryCallBak,
    super.key});

  @override
  State<MyPhoneTextField> createState() => _MyPhoneTextFieldState();
}

class _MyPhoneTextFieldState extends State<MyPhoneTextField> {
  late TextEditingController searchController;
  List<CountryModel> searchedCountries =[];
  List<CountryModel> get _listToShow =>
      searchController.text.isEmpty ? appCountries : searchedCountries ;
  late CountryModel selectedCountry = widget.country;

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
    return SizedBox(
      height: 44.0,
      width: double.infinity,
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        controller: widget.controller, // to control text field
        cursorColor: grayColor,
        // autofocus: true,
        onChanged: (String value){
          //to return the value that i write it in text field
        },
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          prefixIconConstraints: const BoxConstraints(),
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(start: 10.w),
            child: InkWell(
              onTap: ()=> _showCountries,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 26.h,
                    width: 26.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset('assets/flags/${selectedCountry.code.toLowerCase()}.png',
                    fit: BoxFit.cover, package: 'intl_phone_field',),
                    ),
                  SizedBox(width: 5.w,),
                  Text('+${selectedCountry.dialCode}'),
                  SizedBox(width: 5.w,),
                  const Icon(Icons.arrow_drop_down_rounded),
                ],
              ),
            ),
          ),
          fillColor: widget.textFieldColor, /// text field background color
          filled: true,
          hintText: widget.hintText,
          hintStyle: hintTextButtonStyle,
          contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 10.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide:  BorderSide(
              color: widget.textFieldColor,),),
          disabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide: BorderSide(
              color: widget.textFieldColor,),) ,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide:  BorderSide(
              color: widget.textFieldColor,),),
          errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(14.0.r),
            borderSide:  BorderSide(
              color: widget.textFieldColor,),),
        ),
      ),
    );
  }
  void update(StateSetter newState) => newState((){});
  void get _showCountries{
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusDirectional.only(topEnd: Radius.circular(20.r),
          topStart: Radius.circular(20.r),),
      ),
      builder:  (context) {
        return StatefulBuilder(builder: (context, newSetState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height - 150,
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w , vertical: 26.h),
              child: Column(
                children: [
                  MyTextField(controller: searchController, hintText: AppLocalizations.of(context)!.selectCountry,
                      textFieldColor: Colors.transparent, textFieldBorderColor:Colors.grey,
                      onChange: (searchValue) {
                        setState(() {
                          searchedCountries.clear();
                          for (var item in appCountries){
                            if(item.name.toLowerCase().contains(searchValue.toLowerCase())){
                              searchedCountries.add(item);}
                          }
                        });
                        update(newSetState);
                      }),
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsetsDirectional.symmetric( vertical: 20.h),
                      itemCount: _listToShow.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            setState(() {
                              selectedCountry = _listToShow[index];
                            });
                            update(newSetState);
                            widget.selectedCountryCallBak(country: selectedCountry);
                            Navigator.pop(context);
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                height: 25.h,
                                width: 40.w,
                                child: Image.asset('assets/flags/${_listToShow[index].code.toLowerCase()}.png',
                                  fit: BoxFit.cover,
                                  package: 'intl_phone_field',),
                              ),
                              SizedBox(width: 15.w,),
                              Expanded(child: Text('+${_listToShow[index].dialCode}   ${_listToShow[index].name}')),
                            ],
                          ),
                        );
                      }, separatorBuilder: (context, index) => SizedBox(height: 15.h,) ,
                    ),
                  ),
                ],
              ),
            ),
          );
        },);
      },);
  }
}
