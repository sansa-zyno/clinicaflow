// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class BarChartCard extends StatelessWidget {
//   final String text;
//   final Map<String, double> dataMap;
//   final List<Color> colorList;
//   final double paddingvalue;
//
//   BarChartCard({
//     super.key,
//     required this.text,
//     required this.dataMap,
//     required this.colorList,
//     required this.paddingvalue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       decoration: BoxDecoration(
//         color: Color(0xffFFFFFF),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xffA342EF),
//             blurRadius: 0,
//             spreadRadius: 0,
//             offset: Offset(0, 0),
//           ),
//           BoxShadow(
//             color: Color(0xffA342EF),
//             blurRadius: 2,
//             spreadRadius: 0,
//             offset: Offset(
//               0,
//               2,
//             ),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 9.0, top: 15),
//             child: Text(
//               text,
//               style: GoogleFonts.montserrat(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: paddingvalue),
//             child: Container(
//               height: 200, // Adjust the height as needed
//               child: BarChart(
//                 BarChartData(
//                   barGroups: _createBarGroups(),
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: true),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (double value, TitleMeta meta) {
//                           return SideTitleWidget(
//                             axisSide: meta.axisSide,
//                             child: Text(
//                               dataMap.keys.elementAt(value.toInt()),
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<BarChartGroupData> _createBarGroups() {
//     List<BarChartGroupData> barGroups = [];
//     int index = 0;
//     dataMap.forEach((key, value) {
//       barGroups.add(
//         BarChartGroupData(
//           x: index,
//           barRods: [
//             BarChartRodData(
//               toY: value,
//               //colors: [colorList[index % colorList.length]],
//               width: 16,
//             ),
//           ],
//         ),
//       );
//       index++;
//     });
//     return barGroups;
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:fl_chart/fl_chart.dart';
//
// class BarChartCard extends StatelessWidget {
//   final String text;
//   final Map<String, double> dataMap;
//   final List<Color> colorList;
//   final double paddingvalue;
//
//   BarChartCard({
//     super.key,
//     required this.text,
//     required this.dataMap,
//     required this.colorList,
//     required this.paddingvalue,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.9,
//       decoration: BoxDecoration(
//         color: Color(0xffFFFFFF),
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Color(0xffA342EF),
//             blurRadius: 0,
//             spreadRadius: 0,
//             offset: Offset(0, 0),
//           ),
//           BoxShadow(
//             color: Color(0xffA342EF),
//             blurRadius: 2,
//             spreadRadius: 0,
//             offset: Offset(
//               0,
//               2,
//             ),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 9.0, top: 15),
//             child: Text(
//               text,
//               style: GoogleFonts.montserrat(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: EdgeInsets.only(right: paddingvalue),
//             child: Container(
//               height: 200, // Adjust the height as needed
//               child: BarChart(
//                 BarChartData(
//                   barGroups: _createBarGroups(),
//                   borderData: FlBorderData(show: false),
//                   titlesData: FlTitlesData(
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(showTitles: true),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: (double value, TitleMeta meta) {
//                           return SideTitleWidget(
//                             axisSide: meta.axisSide,
//                             child: Text(
//                               dataMap.keys.elementAt(value.toInt()),
//                               style: TextStyle(
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<BarChartGroupData> _createBarGroups() {
//     List<BarChartGroupData> barGroups = [];
//     int index = 0;
//     dataMap.forEach((key, value) {
//       barGroups.add(
//         BarChartGroupData(
//           x: index,
//           barRods: [
//             BarChartRodData(
//               toY: value,
//               //colors: [colorList[index % colorList.length]],
//               width: 16,
//             ),
//           ],
//         ),
//       );
//       index++;
//     });
//     return barGroups;
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartCard extends StatelessWidget {
  final String text;
  final Map<String, double> dataMap;
  final List<Color> colorList;
  final double paddingvalue;

  const BarChartCard({
    super.key,
    required this.text,
    required this.dataMap,
    required this.colorList,
    required this.paddingvalue,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          const BoxShadow(
            color: Color(0xffA342EF),
            blurRadius: 0,
            spreadRadius: 0,
            offset: Offset(0, 0),
          ),
          const BoxShadow(
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
            child: Container(
              height: 210,
              child: BarChart(
                BarChartData(
                  barGroups: _createBarGroups(),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          int index = value.toInt();
                          if (index >= dataMap.keys.length) return Container();
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              dataMap.keys.elementAt(index),
                              style: const TextStyle(
                                fontSize: 7,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<BarChartGroupData> _createBarGroups() {
    List<BarChartGroupData> barGroups = [];
    int index = 0;
    dataMap.forEach((key, value) {
      barGroups.add(
        BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: value,
              color: colorList[index % colorList.length],
              width: 16,
            ),
          ],
        ),
      );
      index++;
    });
    return barGroups;
  }
}