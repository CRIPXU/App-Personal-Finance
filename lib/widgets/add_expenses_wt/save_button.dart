import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/expenses_provider.dart';

class SaveButton extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;

  const SaveButton({Key? key, required this.cModel, required this.hasData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          if (cModel.amount != 0.00 && cModel.link != null) {
            (hasData)
                ? exProvider.addNewExpense(cModel)
                : exProvider.addNewExpense(cModel);
            Fluttertoast.showToast(
                msg: (hasData)?'Gasto editado':'Gasto agregado 👍', backgroundColor: Colors.green,gravity: ToastGravity.SNACKBAR);
            uiProvider.bnbIndex = 0;
            Navigator.pop(context);
          } else if (cModel.amount == 0.0) {
            Fluttertoast.showToast(
                msg: 'No olvides agregar un gasto🙃',
                backgroundColor: Colors.red,gravity: ToastGravity.TOP);
          } else {
            Fluttertoast.showToast(
                msg: 'No olvides seleccionar una categoría🛑',
                backgroundColor: Colors.red,gravity: ToastGravity.CENTER);
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 150.0,
          child: Constants.customButton(Colors.green, Colors.white, (hasData)? 'EDITAR':'GUARDAR'),
        ));
  }
}
