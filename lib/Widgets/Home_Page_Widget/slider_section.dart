import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Const/colors.dart';

class SliderSection extends StatefulWidget {
  const SliderSection({super.key});

  @override
  State<SliderSection> createState() => _SliderSectionState();
}

class _SliderSectionState extends State<SliderSection>{
  int selectedIndex = 0;
  List<String> items = ['img1', 'img2'];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 150.h,
              child: PageView.builder(
                onPageChanged: (value) =>
                    setState(() => selectedIndex = value),
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                    EdgeInsetsDirectional.symmetric(horizontal: 14.w),
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius:
                        BorderRadiusDirectional.circular(14.r)),
                    child: Image.asset(
                      'assets/images/${items[index]}.png',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),
            ),
            PositionedDirectional(
              bottom: 10.h,
              start: 0,
              end: 0,
              child: Container(
                alignment: Alignment.center,
                height: 10.h,
                child: ListView.separated(
                  padding: EdgeInsetsDirectional.zero,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    bool selected = selectedIndex == index;
                    return Container(
                      height: 10.h,
                      width: 10.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected
                            ? blackObacityColor
                            : Colors.transparent,
                        border: Border.all(
                            color: selected
                                ? Colors.transparent
                                : blackObacityColor),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) =>
                      SizedBox(width: 4.w),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 15.h),

      ],
    );
  }
}
