
import 'package:expense_manager/models/category.dart';
import 'package:flutter/material.dart';

class CategoryIconBox extends StatelessWidget{
  final Category category;

  const CategoryIconBox({super.key,required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: category.backgroundColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12)
      ),
      child: Center(child: Icon(category.icon,color: category.backgroundColor,),),
    );
  }

}