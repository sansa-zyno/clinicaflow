import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartCard extends StatelessWidget {
  final String text;
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final double? degree;
  final double paddingvalue;

  const PieChartCard({
    super.key,
    required this.text,
    required this.dataMap,
    required this.colorList,
    required this.degree,
    required this.paddingvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0xffA342EF),
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
          BoxShadow(
            color: Color(0xffA342EF),
            blurRadius: 2,
            spreadRadius: 0,
            offset: Offset(
              0,
              2,
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 9.0, top: 15),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(right: paddingvalue),
            child: PieChart(
              dataMap: dataMap,
              chartType: ChartType.disc,
              baseChartColor: Colors.transparent,
              colorList: colorList,
              chartRadius: 130,
              initialAngleInDegree: degree,
              chartValuesOptions: const ChartValuesOptions(
                showChartValueBackground: false,
                showChartValues: true,
                showChartValuesInPercentage: true,
                showChartValuesOutside: false,
                decimalPlaces: 0,
              ),
              legendOptions: LegendOptions(
                legendShape: BoxShape.rectangle,
                legendTextStyle: TextStyle(
                    fontSize: 11,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                    fontWeight: FontWeight.w600),
              ),
              chartLegendSpacing: 18,
            ),
          ),
        ],
      ),
    );
  }
}
