import 'package:exp_app/models/entries_model.dart';
import 'package:intl/intl.dart';

import '../models/expenses_model.dart';

export 'package:exp_app/utils/math_operations.dart';

getAmountFormat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}

getSumaIngresos(List<ExpensesModel> eList) {
  double _eList;
  _eList = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return _eList;
}

getSumaGastos(List<EntriesModel> eList) {
  double _etList;

  _etList = eList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return _etList;
}

/*
--------------obtener el balance---------
 */

getBalance(List<ExpensesModel> eList, List<EntriesModel> etList) {
  double _balance;

  _balance = getSumaGastos(etList) - getSumaIngresos(eList);
  return getAmountFormat(_balance);
}
