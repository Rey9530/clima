import 'package:clima_app/components/background_component.dart';
import 'package:clima_app/pages/climate_detail_page.dart';
import 'package:flutter/material.dart';

class AddPlacesPage extends StatelessWidget {
  const AddPlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundComponent(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            TextBuscadorComponent(),
            ItemResultPlacesComponent(),
            ItemResultPlacesComponent(),
            ItemResultPlacesComponent(),
            ItemResultPlacesComponent(),
            Expanded(child: SizedBox()),
            // SizedBox(
            //   width: double.infinity,
            //   child: Text(
            //     "Digite el nombre de una ciudad en el buscador",
            //     style: TextStyle(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w700,
            //       color: Colors.white,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // Expanded(child: SizedBox()),
          ],
        ),
      ),
    );
  }
}

class ItemResultPlacesComponent extends StatelessWidget {
  const ItemResultPlacesComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ClimateDetailPage(),
          ),
        ),
        child: Row(
          children: [
            Container(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("San tamaria ostuma"),
                Text(
                  "San Salvador",
                  style: TextStyle(fontSize: 12),
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

class TextBuscadorComponent extends StatelessWidget {
  const TextBuscadorComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: const TextField(
            decoration: InputDecoration(
              suffixIcon: Icon(Icons.search),
              border: InputBorder.none,
              // labelText: 'Buscar lugares',
              hintText: 'Ejemplo: San Salvador',
              fillColor: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
