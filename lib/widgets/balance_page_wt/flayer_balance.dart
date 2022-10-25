import 'package:exp_app/providers/expenses_provider.dart';
import 'package:exp_app/utils/math_operations.dart';
import 'package:exp_app/widgets/balance_page_wt/chart_bart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FlayerBalance extends StatelessWidget {
  const FlayerBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;
    double totalExp = 0;
    double totalEt = 0;
    double total = 0;

    totalExp = getSumaGastos(etList);//ingresos
    totalEt = getSumaIngresos(eList);//gastos
    total = getSumaGastos(etList)-getSumaIngresos(eList);
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Ingresos',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                trailing: Text(
                  getAmountFormat(totalExp),
                  style: const TextStyle(color: Colors.green),
                ),
              ),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Gastos',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                trailing: Text(
                  getAmountFormat(totalEt),
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              const Divider(indent: 15, endIndent: 15, thickness: 2.0),
              ListTile(
                dense: true,
                visualDensity: const VisualDensity(vertical: -4),
                title: const Text('Total',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                trailing: Text(
                  getAmountFormat(total),
                  style: TextStyle(
                      color: (total<0)? Colors.red : Colors.green,
                ),
              ),
              )],
          ),
        ),
        const Expanded(
          flex: 2,
          child: SizedBox(
            height: 200.0,
            child: ChartBart(),
          ),
        )
      ],
    );
  }
}
