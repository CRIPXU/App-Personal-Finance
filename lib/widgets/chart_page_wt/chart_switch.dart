import 'package:exp_app/providers/ui_provider.dart';
import 'package:exp_app/widgets/chart_page_wt/chart_line.dart';
import 'package:exp_app/widgets/chart_page_wt/chart_scatterplot.dart';
import 'package:exp_app/widgets/chart_page_wt/charts_pie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartSwitch extends StatelessWidget {
  const ChartSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentChart = context.watch<UIProvider>().selectedChart;

    switch(currentChart){
      case 'Gráfico Lineal' : return const ChartLine();
      case 'Gráfico Pie' : return const ChartPie();
      case 'Gráfico de Dispersión' : return const ChartScatterPlot();
      default: return const ChartLine();
    }
  }
}
