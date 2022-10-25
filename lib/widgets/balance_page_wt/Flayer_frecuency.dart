import 'package:exp_app/widgets/chart_page_wt/chart_line.dart';
 import 'package:flutter/material.dart';

class FlayerFrecuency extends StatelessWidget {
  const FlayerFrecuency({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 180.0,
          child: ChartLine(),
        ),
        GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext contex){return ChartLine();}));
          },
            child: const Text('🔍',style: TextStyle(fontSize: 15),),)
      ],
    );
  }
}

