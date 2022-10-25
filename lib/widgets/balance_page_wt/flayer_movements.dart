import 'package:exp_app/global_wt/percent_indicator.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class FlayerMoviments extends StatelessWidget {
  const FlayerMoviments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double _totalExp = 0;
    double _totalEt = 0;

    _totalExp = getSumaGastos(etList);
    _totalEt = getSumaIngresos(eList);
    return SizedBox(
      height: 180,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: PercentCircular(
                percent: _totalEt / _totalExp,
                radius: 75,
                color: (Colors.red),
                arcType: ArcType.FULL),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(
              height: 190.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gastos Realizados',
                    style: TextStyle(fontSize: 13.0, letterSpacing: 1.3),
                  ),
                  Text(
                    getAmountFormat(_totalEt),
                    style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.3),
                  ),
                  Text(
                    'Absorbe un ${(_totalEt / _totalExp * 100).toStringAsFixed(2)}% de tus ingresos',
                    style: const TextStyle(fontSize: 13.0, letterSpacing: 1.3),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
