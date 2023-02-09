// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:clima_app/components/background_component.dart';
import 'package:clima_app/models/ciudades_model.dart';
import 'package:clima_app/pages/climate_detail_page.dart';
import 'package:clima_app/providers/shearch_places_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class AddPlacesPage extends StatelessWidget {
  const AddPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShearchPlacesProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BackgroundComponent(
        child: SizedBox(
          width: double.infinity,
          height: size.height * 0.9,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const TextBuscadorComponent(),
                provider.loading
                    ? const CircularProgressIndicator()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: provider.listaCiudades.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemResultPlacesComponent(
                            ciudad: provider.listaCiudades[index],
                          );
                        },
                      ),
                (provider.listaCiudades.isEmpty && !(provider.loading))
                    ? const SizedBox(
                        width: double.infinity,
                        child: Text(
                          "Digite el nombre de una ciudad valida en el buscador",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemResultPlacesComponent extends StatelessWidget {
  const ItemResultPlacesComponent({
    Key? key,
    required this.ciudad,
  }) : super(key: key);
  final Ciudad ciudad;
  @override
  Widget build(BuildContext context) {
    String url =
        "https://assets.open-meteo.com/images/country-flags/${(ciudad.countryCode != null) ? "${ciudad.countryCode?.toLowerCase()}.svg" : "sv.svg"}";
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(
              3.0,
              3.0,
            ),
            blurRadius: 1.0,
            spreadRadius: 1.0,
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 10),
      height: 50,
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClimateDetailPage(ciudad: ciudad),
            ),
          );
        },
        child: Row(
          children: [
            Container(width: 20),
            SvgPicture.network(
              url,
              width: 30,
            ),
            Container(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(ciudad.name ?? ""),
                Text(
                  ciudad.admin1 ?? "",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Expanded(child: Container()),
            const Icon(Icons.arrow_forward_ios),
            Container(width: 20),
          ],
        ),
      ),
    );
  }
}

class TextBuscadorComponent extends StatefulWidget {
  const TextBuscadorComponent({
    Key? key,
  }) : super(key: key);

  @override
  State<TextBuscadorComponent> createState() => _TextBuscadorComponentState();
}

class _TextBuscadorComponentState extends State<TextBuscadorComponent> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ShearchPlacesProvider>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 5),
          width: double.infinity,
          child: const Text(
            "Digite una ciudad",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.only(
            left: 20,
            top: 5,
            right: 5,
            bottom: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
              // labelText: 'Buscar lugares',
              hintText: 'Ejemplo: San Salvador',
              fillColor: Colors.green,
            ),
            onChanged: (String query) async {
              if (_debounce?.isActive ?? false) _debounce!.cancel();
              _debounce = Timer(
                const Duration(milliseconds: 500),
                () async {
                  await provider.obtenerCiudades(query);
                  FocusScope.of(context).unfocus();
                },
              );
              // print("fin");
            },
          ),
        ),
      ],
    );
  }
}
