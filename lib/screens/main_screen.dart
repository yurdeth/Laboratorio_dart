import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:guia_ejercicios/screens/planificacion_viajes.dart';

import 'contador_calorias.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bienvenido"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        titleTextStyle:
        const TextStyle(fontFamily: "Times New Roman", fontSize: 18),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Primer botón
            Padding(
              padding: const EdgeInsets.all(15.0), // Espacio alrededor del botón
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const ContadorCalorias()));
                        });
                      },
                      child: const Text("Contar calorias"),
                  ),
                ],
              ),
            ),
            // Segundo botón
            Padding(
              padding: const EdgeInsets.all(15.0), // Espacio alrededor del botón
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const PlanificacionViajes()));
                        });
                      },
                      child: const Text("Planificar un viaje"),
                  ),
                ],
              ),
            ),
            // Tercer botón
          ],
        ),
      ),
    );
  }
}
