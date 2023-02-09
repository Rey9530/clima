// import 'package:clima_app/components/background_component.dart';

import 'package:animate_do/animate_do.dart';
import 'package:clima_app/models/ciudades_model.dart';
import 'package:clima_app/models/clima_model.dart';
import 'package:clima_app/providers/shearch_places_provider.dart';
import 'package:clima_app/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClimateDetailPage extends StatelessWidget {
  const ClimateDetailPage({super.key, required this.ciudad});
  final Ciudad ciudad;
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShearchPlacesProvider>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
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
                ),
                width: double.infinity,
                child: FutureBuilder(
                  future: provider.getDataClimate(ciudad),
                  builder: (BuildContext context,
                      AsyncSnapshot<RespClima?> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data != null) {
                      return BodyDetailComponent(
                        clima: snapshot.data!,
                        ciudad: ciudad,
                      );
                    } else {
                      return const Center(
                        child: TextComponent(
                          text: 'Sin Datos',
                          fontSize: 44,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}

class BodyDetailComponent extends StatelessWidget {
  BodyDetailComponent({
    Key? key,
    required this.clima,
    required this.ciudad,
  }) : super(key: key);
  final RespClima clima;
  final Ciudad ciudad;

  final List<String> meses = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre",
  ];
  @override
  Widget build(BuildContext context) {
    List<String> fechaHoraArray = clima.currentWeather.time.split("T");
    List<String> fechArray = fechaHoraArray[0].split("-");

    String mes = meses[int.parse(fechArray[1])];
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextComponent(
            text: '${fechArray[2]} de $mes',
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          TextComponent(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            text: ciudad.admin1 ?? ciudad.name ?? "",
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
          TextComponent(
            fontSize: 68,
            fontWeight: FontWeight.bold,
            text: '${clima.currentWeather.temperature}°',
            textAlign: TextAlign.center,
          ),
          TextComponent(
            text: 'Zona Horaria: ${clima.timezone}',
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: double.infinity,
            height: 120.0,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: clima.daily.time.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, int index) {
                DateTime fechaArray = clima.daily.time[index];
                String minimo =
                    clima.daily.apparentTemperatureMin[index].toString();
                String maximo =
                    clima.daily.apparentTemperatureMax[index].toString();
                String unidadMedida = clima.dailyUnits.apparentTemperatureMin;
                return ItemRowDayComponent(
                  fecha: index == 0 ? "Ahora" : fechaArray.day.toString(),
                  img: 'assets/png/cloud-sun.png',
                  temperatura:
                      'Min $minimo $unidadMedida\nMax $maximo $unidadMedida',
                  isBool: index == 0,
                );
              },
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
    final provider = Provider.of<ShearchPlacesProvider>(context, listen: false);
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          CardSkillsComponent(
            color: const Color(0XFF0000FF),
            icono: Icons.air,
            text:
                "${provider.respClima!.currentWeather.windspeed} ${provider.respClima!.dailyUnits.windspeed10MMax}",
            subText: 'Velocidad',
          ),
          CardSkillsComponent(
            color: const Color(0XFF5DC1B9),
            icono: Icons.location_searching,
            text: "${provider.respClima!.currentWeather.winddirection}°",
            subText: 'Direccion',
          ),
          CardSkillsComponent(
            color: const Color(0XFFA03DBD),
            icono: Icons.water,
            text: '${provider.respClima!.elevation}',
            subText: 'Elevación',
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
      width: 95,
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
            text: subText,
            textAlign: TextAlign.left,
            fontSize: 10,
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
    final provider = Provider.of<ShearchPlacesProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            const SizedBox(width: 10),
            const TextComponent(
              fontWeight: FontWeight.bold,
              width: 145,
              text: 'Aproximación semanal',
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: provider.respClima?.daily.time.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            DateTime fechaArray =
                                provider.respClima?.daily.time[index] ??
                                    DateTime.now();
                            String minimo = provider
                                    .respClima?.daily.temperature2MMin[index]
                                    .toString() ??
                                "";
                            String maximo = provider
                                    .respClima?.daily.temperature2MMax[index]
                                    .toString() ??
                                "";
                            String unidadMedida = provider
                                    .respClima?.dailyUnits.temperature2MMin ??
                                "";

                            return ItemReportComponent(
                              fecha: index == 0
                                  ? "Ahora"
                                  : fechaArray.day.toString(),
                              dia: provider.listaDias[fechaArray.weekday],
                              img: 'assets/png/cloud-sun.png',
                              isBool: true,
                              temperatura:
                                  'Min $minimo $unidadMedida\nMax $maximo $unidadMedida',
                            );
                          },
                        )
                        // ListView(
                        //   scrollDirection: Axis.horizontal,
                        //   children: const [
                        //     ItemReportComponent(
                        //       fecha: 'Jan 16',
                        //       dia: 'Mon',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: true,
                        //       temperatura: '-6',
                        //     ),
                        //     ItemReportComponent(
                        //       fecha: '16',
                        //       dia: 'Tue',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: false,
                        //       temperatura: '-4',
                        //     ),
                        //     ItemReportComponent(
                        //       fecha: '17',
                        //       dia: 'Wed',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: false,
                        //       temperatura: '-3',
                        //     ),
                        //     ItemReportComponent(
                        //       fecha: '18',
                        //       dia: 'Thu',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: false,
                        //       temperatura: '2',
                        //     ),
                        //     ItemReportComponent(
                        //       fecha: '19',
                        //       dia: 'Fri',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: false,
                        //       temperatura: '3',
                        //     ),
                        //     ItemReportComponent(
                        //       fecha: '20',
                        //       dia: 'Sat',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: false,
                        //       temperatura: '-3',
                        //     ),
                        //     ItemReportComponent(
                        //       fecha: '21',
                        //       dia: 'Sun',
                        //       img: 'assets/png/cloud-sun.png',
                        //       isBool: false,
                        //       temperatura: '-7',
                        //     ),
                        //   ],
                        // ),
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
        width: 60,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 5),
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
              fontSize: 10,
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
    final provider = Provider.of<ShearchPlacesProvider>(context, listen: false);

    List<double> listOrdMin =
        provider.respClima?.daily.apparentTemperatureMin ?? [];
    List<double> listOrdMax =
        provider.respClima?.daily.apparentTemperatureMax ?? [];
    listOrdMin.sort();
    listOrdMax.sort();
    List<FlSpot> spots = [];
    for (var i = 0; i < (provider.respClima!.daily.time.length); i++) {
      double min = provider.respClima!.daily.apparentTemperatureMin[i];
      double max = provider.respClima!.daily.apparentTemperatureMax[i];
      double calculo = ((max - min) / 2) + min;
      spots.add(FlSpot((i + 1), calculo));
    }

    return SizedBox(
      width: double.infinity,
      height: 180,
      child: LineChart(
        LineChartData(
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              color: Colors.blue,
            ),
          ],
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
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
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int dia = value.toInt() - 1;
                  if (dia >= 0 && dia < 7) {
                    DateTime fechaArray =
                        provider.respClima?.daily.time[dia] ?? DateTime.now();
                    return Text(provider.listaDias[fechaArray.weekday]);
                  } else {
                    return const Text("");
                  }
                },
              ),
            ),
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
          minY: listOrdMin[0],
          maxY: listOrdMax[listOrdMax.length - 1],
        ),
        swapAnimationDuration: const Duration(
          milliseconds: 150,
        ), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }
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
      width: 70,
      height: 110,
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
              fontSize: 10,
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
