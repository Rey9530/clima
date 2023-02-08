import 'package:clima_app/components/background_component.dart';
import 'package:clima_app/pages/add_places_page.dart';
import 'package:clima_app/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              ToolBarWidget(),
              ListadoCiudadesWidget(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add,
          size: 42,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlacesPage()),
          );
        },
      ),
    );
  }
}

class ListadoCiudadesWidget extends StatelessWidget {
  const ListadoCiudadesWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ItemCityWidget(
          ciudad: "New York",
          grados: "7",
          img: "assets/png/sun.png",
          status: "Sunny",
          gradient: orangeArray,
        ),
        ItemCityWidget(
          ciudad: "Munbai",
          grados: "25",
          img: "assets/png/cloud-sun.png",
          status: "Hazy Sunshine",
          gradient: greenArray,
        ),
        ItemCityWidget(
          ciudad: "Sydney",
          grados: "12",
          img: "assets/png/rain.png",
          status: "Raining",
          gradient: moradoArray,
        ),
        ItemCityWidget(
          ciudad: "Sydney",
          grados: "12",
          img: "assets/png/rain.png",
          status: "Raining",
          gradient: azulArray,
        ),
      ],
    );
  }
}

class ItemCityWidget extends StatelessWidget {
  const ItemCityWidget({
    Key? key,
    required this.ciudad,
    required this.status,
    required this.grados,
    required this.img,
    required this.gradient,
  }) : super(key: key);

  final String ciudad;
  final String status;
  final String grados;
  final String img;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradient,
          stops: const [0.0, 1.0],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          const SizedBox(width: 20),
          Image.asset(
            img,
            height: 40,
            // width: ,
          ),
          const SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ciudad,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                status,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          Text(
            "$grados°",
            style: const TextStyle(
              fontSize: 38,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}

class ToolBarWidget extends StatelessWidget {
  const ToolBarWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Administrador de Ciudades",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
