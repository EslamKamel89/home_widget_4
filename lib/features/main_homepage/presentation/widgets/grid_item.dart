import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GridItem extends StatelessWidget {
  const GridItem({
    super.key,
    required this.title,
    this.image,
    this.onTap,
  });
  final String title;
  final String? image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        // color: Colors.red,
        // height: 100,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 1),
                child: Image.asset(
                  image!,
                  fit: BoxFit.fill,
                  height: 60.h,
                ),
              ),
            Text(
              '$title\n',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
