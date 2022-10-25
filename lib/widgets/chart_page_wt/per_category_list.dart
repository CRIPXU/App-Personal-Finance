import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PerCategoryList extends StatelessWidget {
  const PerCategoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final gList = context.watch<ExpensesProvider>().grouptemsList;

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, i) {
        var item = gList[i];
        return ListTile(
          leading: Icon(
            item.icon.toIcon(),
            color: item.color.toColor(),
            size: 35.0,
          ),
          title: Text(item.category),
          trailing: Text(
            getAmountFormat(item.amount),
          ),
        );
      }, childCount: gList.length),
    );
  }
}
