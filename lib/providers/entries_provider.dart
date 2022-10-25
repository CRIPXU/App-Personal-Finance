import 'dart:convert';

import 'package:exp_app/models/combined_model.dart';
import 'package:exp_app/models/entries_model.dart';
import 'package:exp_app/models/expenses_model.dart';
import 'package:exp_app/models/features_model.dart';
import 'package:exp_app/providers/db_entries.dart';
import 'package:exp_app/providers/db_features.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpensesEntries extends ChangeNotifier {
  List<FeaturesModel> fList = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];
  List<EntriesModel> etList = [];

  /*
    ---- Functions to insert ----
  */

  addNewExpense(CombinedModel cModel) async {
    var entries = EntriesModel(
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        entries: cModel.amount
        );

    final id = await DBEntries.db.addEntries(entries);
    entries.id = id;
    etList.add(entries);
    notifyListeners();
  }

/*
----addNewEntries------
 */
  addNewEntries(CombinedModel cModel) async {
    var entries = EntriesModel(
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        entries: cModel.amount);

    final id = await DBEntries.db.addEntries(entries);
    entries.id = id;
    etList.add(entries);
    notifyListeners();
  }

  /*
  ------------------addNewFeature----------------
   */

  addNewFeature(FeaturesModel newFeature) async {
    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;
    fList.add(newFeature);
    notifyListeners();
  }

  /*
    ---- Functions to read ----
  */

  getEntriesByDate(int month, int year) async {
    final response = await DBEntries.db.getEntriesByDate(month, year);
    etList = [...response];
    notifyListeners();
  }
  getExpensesByDate(int month, int year) async {
    final response = await DBEntries.db.getEntriesByDate(month, year);
    etList = [...response];
    notifyListeners();
  }

  getAllFeatures() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  /*
    ---- Functions to edit ----
  */

  updateExpense(CombinedModel cModel) async {
    var entries = EntriesModel(
        id: cModel.id,
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        entries: cModel.amount
    );
    await DBEntries.db.updateEntries(entries);
    notifyListeners();
  }

  updateFeatures(FeaturesModel features) async {
    await DBFeatures.db.updateFeatures(features);
    getAllFeatures();
  }

  /*
    ---- Functions to delete ----
  */

  deleteEntries(int id) async {
    await DBEntries.db.deleteEntries(id);
    notifyListeners();
  }

  /*
    ---- Getters to combined List ----
  */

  List<CombinedModel> get _allItemsList {
    List<CombinedModel> cModel = [];

    for (var x in etList) {
      for (var y in fList) {
        if (x.id == y.id) {
          cModel.add(CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              id: x.id,
              //link: x.link,
              //amount: x.expense,
              comment: x.comment,
              year: x.year,
              month: x.month,
              day: x.day));
        }
      }
    }
    return cList = [...cModel];
  }

  List<CombinedModel> get grouptemsList {
    List<CombinedModel> cModel = [];

    for (var x in etList) {
      for (var y in fList) {
        if (x.id == y.id) {
          double amount = etList
              .where((e) => e.id == y.id)
              .fold(0.0, (a, b) => a + b.entries);

          cModel.add(CombinedModel(
            category: y.category,
            color: y.color,
            icon: y.icon,
            amount: amount,
          ));
        }
      }
    }

    var encode = cModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    cModel = result.map((e) => CombinedModel.fromJson(e)).toList();

    return cList = [...cModel];
  }
}
