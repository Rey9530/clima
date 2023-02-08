// import 'package:clima_app/components/background_component.dart';

import 'package:animate_do/animate_do.dart';
import 'package:clima_app/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ClimateDetailPage extends StatelessWidget {
  const ClimateDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 410,
            color: colorPiel,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 60,
            ),
            width: double.infinity,
            child: const BodyDetailComponent(),
          )
        ],
      ),
    );
  }
}

class BodyDetailComponent extends StatelessWidget {
  const BodyDetailComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const TextComponent(
            text: '12 de Febrero',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          const TextComponent(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            text: 'San Salvador',
          ),
          const SizedBox(height: 10),
          Material(
            color: Colors.transparent,
            elevation: 50,
            child: Image.asset(
              "assets/png/cloud-sun.png",
              height: 150,
            ),
          ),
          const TextComponent(
            fontSize: 68,
            fontWeight: FontWeight.bold,
            text: '-6°',
            textAlign: TextAlign.center,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              TextComponent(
                width: 95,
                text: 'Mostly sunny',
              ),
              TextComponent(
                width: 12,
                text: ' | ',
              ),
              TextComponent(
                width: 65,
                text: 'H:-1 L:-6',
              ),
              TextComponent(
                width: 12,
                text: '|',
              ),
              TextComponent(
                width: 95,
                text: 'FEELS LIKE -9',
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            height: 115.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                ItemRowDayComponent(
                  fecha: 'Ahora',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-6°',
                  isBool: true,
                ),
                ItemRowDayComponent(
                  fecha: '08',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-6°',
                ),
                ItemRowDayComponent(
                  fecha: '09',
                  img: 'assets/png/sun.png',
                  temperatura: '-5°',
                ),
                ItemRowDayComponent(
                  fecha: '10',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-4°',
                ),
                ItemRowDayComponent(
                  fecha: '11',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-4°',
                ),
                ItemRowDayComponent(
                  fecha: '12',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-4°',
                ),
                ItemRowDayComponent(
                  fecha: '14',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-4°',
                ),
                ItemRowDayComponent(
                  fecha: '15',
                  img: 'assets/png/cloud-sun.png',
                  temperatura: '-4°',
                ),
              ],
            ),
          ),
          const CharAdnResportComponent(),
          const SizedBox(height: 20),
          const CountsComponents(),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

class CountsComponents extends StatelessWidget {
  const CountsComponents({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: const [
          CardSkillsComponent(
            color: Color(0XFF0000FF),
            icono: Icons.ac_unit,
            text: '10%',
            subText: 'Snow',
          ),
          CardSkillsComponent(
            color: Color(0XFF5DC1B9),
            icono: Icons.water_drop,
            text: '62%',
            subText: 'Humidity',
          ),
          CardSkillsComponent(
            color: Color(0XFFA03DBD),
            icono: Icons.air,
            text: '5 m/s',
            subText: 'Wind',
          ),
        ],
      ),
    );
  }
}

class CardSkillsComponent extends StatelessWidget {
  const CardSkillsComponent({
    Key? key,
    required this.icono,
    required this.text,
    required this.subText,
    required this.color,
  }) : super(key: key);
  final IconData icono;
  final String text;
  final String subText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 110,
      decoration: BoxDecoration(
        color: color.withOpacity(0.4),
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.6),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Icon(
              icono,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          TextComponent(
            fontWeight: FontWeight.bold,
            text: text,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 5),
          TextComponent(
            // fontWeight: FontWeight.bold,
            text: subText,
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}

class CharAdnResportComponent extends StatefulWidget {
  const CharAdnResportComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<CharAdnResportComponent> createState() =>
      _CharAdnResportComponentState();
}

class _CharAdnResportComponentState extends State<CharAdnResportComponent> {
  bool isChart = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            const TextComponent(
              fontWeight: FontWeight.bold,
              width: 95,
              text: 'Esta Semana',
            ),
            const Expanded(child: SizedBox(width: 10)),
            ElevatedButtomComponent(
              selected: isChart,
              icon: Icons.insights,
              onPress: () {
                setState(() {
                  isChart = true;
                });
              },
            ),
            const SizedBox(width: 10),
            ElevatedButtomComponent(
              selected: !isChart,
              icon: Icons.list_alt,
              onPress: () {
                setState(() {
                  isChart = false;
                });
              },
            ),
          ],
        ),
        isChart
            ? FadeInLeft(
                animate: isChart,
                child: const ChartLineBarComponent(),
              )
            : FadeInRight(
                animate: !isChart,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      width: double.infinity,
                      height: 120.0,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          ItemReportComponent(
                            fecha: 'Jan 16',
                            dia: 'Mon',
                            img: 'assets/png/cloud-sun.png',
                            isBool: true,
                            temperatura: '-6',
                          ),
                          ItemReportComponent(
                            fecha: '16',
                            dia: 'Tue',
                            img: 'assets/png/cloud-sun.png',
                            isBool: false,
                            temperatura: '-4',
                          ),
                          ItemReportComponent(
                            fecha: '17',
                            dia: 'Wed',
                            img: 'assets/png/cloud-sun.png',
                            isBool: false,
                            temperatura: '-3',
                          ),
                          ItemReportComponent(
                            fecha: '18',
                            dia: 'Thu',
                            img: 'assets/png/cloud-sun.png',
                            isBool: false,
                            temperatura: '2',
                          ),
                          ItemReportComponent(
                            fecha: '19',
                            dia: 'Fri',
                            img: 'assets/png/cloud-sun.png',
                            isBool: false,
                            temperatura: '3',
                          ),
                          ItemReportComponent(
                            fecha: '20',
                            dia: 'Sat',
                            img: 'assets/png/cloud-sun.png',
                            isBool: false,
                            temperatura: '-3',
                          ),
                          ItemReportComponent(
                            fecha: '21',
                            dia: 'Sun',
                            img: 'assets/png/cloud-sun.png',
                            isBool: false,
                            temperatura: '-7',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}

class ItemReportComponent extends StatelessWidget {
  const ItemReportComponent({
    Key? key,
    required this.isBool,
    required this.fecha,
    required this.img,
    required this.temperatura,
    required this.dia,
  }) : super(key: key);
  final bool isBool;
  final String fecha;
  final String dia;
  final String img;
  final String temperatura;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 53,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 5),
            TextComponent(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              text: fecha,
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
            const SizedBox(height: 5),
            TextComponent(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              text: temperatura,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(
                img,
              ),
            ),
            TextComponent(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              text: dia,
              textAlign: TextAlign.center,
              fontSize: 16,
            ),
          ],
        ));
  }
}

class ElevatedButtomComponent extends StatelessWidget {
  const ElevatedButtomComponent({
    Key? key,
    required this.icon,
    required this.onPress,
    required this.selected,
  }) : super(key: key);
  final IconData icon;
  final bool selected;
  final VoidCallback onPress;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(10),
        child: TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.all(0),
            ),
          ),
          onPressed: onPress,
          child: Icon(
            icon,
            color: selected ? null : Colors.black.withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}

class ChartLineBarComponent extends StatelessWidget {
  const ChartLineBarComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 180,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: [
                const FlSpot(1, -6),
                const FlSpot(2, -4),
                const FlSpot(3, -3),
                const FlSpot(4, 2),
                const FlSpot(5, 3),
                const FlSpot(6, -3),
                const FlSpot(7, -7),
              ],
              color: Colors.blue,
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            // horizontalInterval: 5,
          ),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              axisNameWidget: const SizedBox(),
              drawBehindEverything: false,
            ),
            rightTitles: AxisTitles(
              axisNameWidget: const SizedBox(),
            ),
            bottomTitles: AxisTitles(sideTitles: _bottomTitles),
          ),
          borderData: FlBorderData(
            show: true,
            border: const Border(
              bottom: BorderSide(
                width: 0.5,
                color: Colors.grey,
              ),
            ),
          ),
          minX: 0,
          maxX: 8,
          minY: -10,
          maxY: 10,
        ),
        swapAnimationDuration: const Duration(
          milliseconds: 150,
        ), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }

  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          String text = '';
          switch (value.toInt()) {
            case 1:
              text = 'L';
              break;
            case 2:
              text = 'M';
              break;
            case 3:
              text = 'M';
              break;
            case 4:
              text = 'J';
              break;
            case 5:
              text = 'V';
              break;
            case 6:
              text = 'S';
              break;
            case 7:
              text = 'D';
              break;
          }

          return Text(text);
        },
      );
}

class ItemRowDayComponent extends StatelessWidget {
  const ItemRowDayComponent({
    Key? key,
    required this.fecha,
    required this.img,
    required this.temperatura,
    this.isBool = false,
  }) : super(key: key);
  final String fecha;
  final String img;
  final String temperatura;
  final bool isBool;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextComponent(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              text: fecha,
              textAlign: TextAlign.center,
              fontSize: 18,
            ),
            const SizedBox(height: 5),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Image.asset(
                img,
              ),
            ),
            const SizedBox(height: 5),
            TextComponent(
              fontWeight: isBool ? FontWeight.bold : FontWeight.normal,
              text: temperatura,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class TextComponent extends StatelessWidget {
  const TextComponent({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.width,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.left,
  });
  final String text;
  final double fontSize;
  final double? width;
  final FontWeight fontWeight;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
