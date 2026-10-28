
import 'package:expense_manager/models/category.dart';
import 'package:flutter/material.dart';

class CategoryIconBox extends StatelessWidget{
  final Category category;
  final double width;
  final double height;
  final double? iconSize;

  const CategoryIconBox({super.key,required this.category,this.width=50,this.height=50,this.iconSize});

  @override
  Widget build(BuildContext context) {
    iconSize??IconTheme.of(context).size;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: category.backgroundColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: Icon(category.icon,color: category.backgroundColor,size: iconSize,),),
    );
  }

}