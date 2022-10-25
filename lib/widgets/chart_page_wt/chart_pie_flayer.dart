import 'package:charts_flutter/flutter.dart' as charts;
import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartPieFlayer extends StatefulWidget {
  const ChartPieFlayer({Key? key}) : super(key: key);

  @override
  State<ChartPieFlayer> createState() => _ChartPieFlayerState();
}

class _ChartPieFlayerState extends State<ChartPieFlayer> {
  int _index = 0;
  bool _animate = true;

  @override
  Widget build(BuildContext context) {

    var gList = context.watch<ExpensesProvider>().grouptemsList;
    double totalOther = 0;

    if (_index >= gList.length) {
      _index = 0;
    }
    if (gList.length >= 6) {
      totalOther =
          gList.sublist(5).map((e) => e.amount).fold(0.0, (a, b) => a + b);
      gList = gList.sublist(0, 5).toList();
      gList.add(CombinedModel(
        category: 'Otros',
        amount: totalOther,
        icon: 'otros',
        color: '#20634b'
      ));
    }

    var item = gList[_index];
    List<charts.Series<CombinedModel, String>> _series(int index) {
      return [
        charts.Series<CombinedModel, String>(
            id: 'PieChart',
            domainFn: (v, i) => v.category,
            measureFn: (v, i) => v.amount,
            keyFn: (v, i) => v.icon,
            colorFn: (v, i) {
              var onTap = i == index;
              if (onTap == false) {
                return charts.ColorUtil.fromDartColor(v.color.toColor());
              } else {
                return charts.ColorUtil.fromDartColor(v.color.toColor()).darker;
              }
            },
            data: gList),
      ];
    }

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        charts.PieChart<String>(
          _series(_index),
          animate: _animate,
          animationDuration: const Duration(milliseconds: 1000),
          defaultInteractions: true,
          defaultRenderer: charts.ArcRendererConfig(
            arcWidth: 30,
            strokeWidthPx: 0.0,
            //arcRatio: 0.3,
          ),
          selectionModels: [
            charts.SelectionModelConfig(
                type: charts.SelectionModelType.info,
                changedListener: (charts.SelectionModel model) {
                  if (model.hasDatumSelection) {
                    setState(() {
                      _animate = false;
                      _index = model.selectedDatum[0].index!;
                    });
                  }
                }),
          ],
        ),
        SizedBox(
          width: 58,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Icon(
                  item.icon.toIcon(),
                  color: item.color.toColor(),
                ),
              ),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    item.category,
                  )),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  getAmountFormat(item.amount),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
