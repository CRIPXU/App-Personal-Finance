import 'package:exp_app/models/entries_model.dart';
import 'package:exp_app/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({Key? key}) : super(key: key);



  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  @override
  Widget build(BuildContext context) {
    final etList = context.watch<ExpensesProvider>().etList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Desglose de Ingesos💰'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ListTile(
                  title: Text(etList[index].entries.toString()),
                );
              },
              childCount: etList.length,
            ),
          ),
        ],
      ),
    );
  }
}
