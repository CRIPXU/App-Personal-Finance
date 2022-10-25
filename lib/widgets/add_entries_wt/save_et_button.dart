import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/expenses_provider.dart';

class SaveETButton extends StatelessWidget {
  final CombinedModel cModel;

  const SaveETButton({Key? key, required this.cModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
        onTap: () {
          if (cModel.amount != 0.00) {
            exProvider.addNewEntries(cModel);
            Fluttertoast.showToast(
                msg: 'Ingreso agregado 👍', backgroundColor: Colors.green,gravity: ToastGravity.SNACKBAR);
            uiProvider.bnbIndex = 0;
            Navigator.pop(context);
          } else if (cModel.amount == 0.0) {
            Fluttertoast.showToast(
                msg: 'No olvides agregar un ingreso 🙃',
                backgroundColor: Colors.red,gravity: ToastGravity.TOP);
          }
        },
        child: SizedBox(
          height: 70.0,
          width: 150.0,
          child: Constants.customButton(Colors.green, Colors.white, 'GUARDAR'),
        ));
  }
}
