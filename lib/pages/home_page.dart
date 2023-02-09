// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously
import 'dart:math' as math;
import 'package:clima_app/components/background_component.dart';
import 'package:clima_app/models/ciudades_model.dart';
import 'package:clima_app/pages/add_places_page.dart';
import 'package:clima_app/pages/climate_detail_page.dart';
import 'package:clima_app/providers/basedatos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../providers/shearch_places_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShearchPlacesProvider>(context);
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
          provider.listaCiudades = [];
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddPlacesPage()),
          );
        },
      ),
    );
  }
}

class ListadoCiudadesWidget extends StatefulWidget {
  const ListadoCiudadesWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<ListadoCiudadesWidget> createState() => _ListadoCiudadesWidgetState();
}

class _ListadoCiudadesWidgetState extends State<ListadoCiudadesWidget> {
  @override
  Widget build(BuildContext context) {
    final db = Provider.of<DataBaseProvider>(context);
    List<Widget> items = [];
    db.listadoCiudades.map((e) {
      Color color = Color((math.Random().nextDouble() * 0xFFFFFF).toInt());
      Color color1 = color.withOpacity(0.3);
      Color color2 = color.withOpacity(1.0);
      items.add(
        Dismissible(
          key: Key(e["id"]),
          background: Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(15)),
            padding: const EdgeInsets.only(right: 20),
            alignment: Alignment.centerRight,
            child: const Text(
              "Eliminar",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          onDismissed: (direction) async {
            final resp = await db.eliminarFavorito(e["id"]);
            // Then show a snackbar.
            if (resp) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(e["name"] + ' Eliminado'),
                ),
              );
            }
          },
          child: ItemCityWidget(
            ciudad: e["name"],
            grados: e["countryCode"],
            img: e["countryCode"],
            status: e["admin1"],
            gradient: [color1, color2],
            item: e,
          ),
        ),
      );
    }).toList();
    if (items.isEmpty) {
      items.add(const SizedBox(height: 50));
      items.add(
        const TextComponent(
          text: 'Listado de favoritos vacio',
          fontSize: 40,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      );
      items.add(const SizedBox(height: 10));

      items.add(
        const TextComponent(
          text: 'De clic en el boton de la parte inferior derecha para agregar',
          fontWeight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Column(children: items);
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
    this.item,
  }) : super(key: key);

  final String ciudad;
  final dynamic item;
  final String status;
  final String grados;
  final String img;
  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String url =
        "https://assets.open-meteo.com/images/country-flags/${(img != null) ? "${img.toLowerCase()}.svg" : "sv.svg"}";
    return GestureDetector(
      onTap: () {
        Ciudad ciudad = Ciudad(
          id: item["id"] != null ? int.parse(item["id"]) : null,
          name: item["name"],
          latitude:
              item["latitude"] != null ? double.parse(item["latitude"]) : null,
          longitude: item["longitude"] != null
              ? double.parse(item["longitude"])
              : null,
          elevation: item["elevation"] != null
              ? double.parse(item["elevation"])
              : null,
          featureCode: item["featureCode"],
          countryCode: item["countryCode"],
          admin1Id:
              item["admin1Id"] != null ? int.parse(item["admin1Id"]) : null,
          timezone: item["timezone"],
          population:
              item["population"] != null ? int.parse(item["population"]) : null,
          countryId:
              item["countryId"] != null ? int.parse(item["countryId"]) : null,
          country: item["country"],
          admin1: item["admin1"],
          admin2Id:
              item["admin2Id"] != null ? int.parse(item["admin2Id"]) : null,
          admin3Id:
              item["admin3Id"] != null ? int.parse(item["admin3Id"]) : null,
          admin2: item["admin2"],
          admin3: item["admin3"],
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClimateDetailPage(ciudad: ciudad),
          ),
        );
      },
      child: Container(
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
            SvgPicture.network(
              url,
              height: 40,
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
                SizedBox(
                  width: size.width * 0.55,
                  child: Text(
                    status,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Text(
              grados,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
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
