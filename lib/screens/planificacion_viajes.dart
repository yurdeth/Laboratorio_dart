import 'dart:developer';
import 'package:flutter/material.dart';

class PlanificacionViajes extends StatefulWidget {
  const PlanificacionViajes({super.key});

  @override
  State<PlanificacionViajes> createState() => _PlanificacionViajesState();
}

class _PlanificacionViajesState extends State<PlanificacionViajes> {
  final _formKey = GlobalKey<FormState>();

  bool _firstIsSelected = false;
  bool _secondIsSelected = false;
  bool _thirdIsSelected = false;
  bool _fourthIsSelected = false;
  String? _selectedSize;
  String? _selectedMeal;

  TextEditingController? _controller;
  String? duracionViaje = "7";
  String? result = "Sin seleccionar";

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text("Planificador de viajes"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(

                  controller: _controller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El campo no puede ser nulo ni vacío";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      labelText: "Ingresa la duración del viaje",
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Actividades a realizar:',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                      title: const Text("Excursiones"),
                      value: _firstIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _firstIsSelected = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Visitas a Museos"),
                      value: _secondIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _secondIsSelected = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text(
                        "Deportes",
                      ),
                      value: _thirdIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _thirdIsSelected = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Compras"),
                      value: _fourthIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _fourthIsSelected = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tipo de alojamiento:',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile<String>(
                      title: const Text('Hotel'),
                      value: 'Hotel',
                      groupValue: _selectedSize,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSize = value;
                          log('Hotel selected');
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Hostal'),
                      value: 'Hostal',
                      groupValue: _selectedSize,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSize = value;
                          log('Hostal selected');
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Apartamento'),
                      value: 'Apartamento',
                      groupValue: _selectedSize,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSize = value;
                          log('Apartamento selected');
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Destino:',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: _selectedMeal,
                      hint: const Text('Selecciona el destino'),
                      items: <String>['París', 'Nueva York', 'Tokio']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedMeal = newValue;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      log('Selected activities:');
                      if (_firstIsSelected) log('- Excursiones');
                      if (_secondIsSelected) log('- Visitas a Museos');
                      if (_thirdIsSelected) log('- Deportes');
                      if (_fourthIsSelected) log('- Compras');
                      log('Accommodation type: $_selectedSize');
                      log('Destination: $_selectedMeal');
                      duracionViaje = _controller?.text;
                      result = calculateCost(
                          duracionViaje,
                          _selectedSize,
                          _selectedMeal,
                          _firstIsSelected,
                          _secondIsSelected,
                          _thirdIsSelected,
                          _fourthIsSelected);
                      log(result!);
                    });
                  },
                  child: const Text("Calcular"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(result!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String calculateCost(
    String? duracion,
    String? selectedSize,
    String? selectedMeal,
    bool? excursionesSelected,
    bool? museosSelected,
    bool? deportesSelected,
    bool? comprasSelected) {
  double sizeMultiplier = 0;
  double costMultiplier = 0;

  int duracionViaje = int.tryParse(duracion!) ?? 7;

  if (excursionesSelected == true) costMultiplier += 200;
  if (museosSelected == true) costMultiplier += 150;
  if (deportesSelected == true) costMultiplier += 50;
  if (comprasSelected == true) costMultiplier += 100;

  switch (selectedSize) {
    case 'Hotel':
      sizeMultiplier = 100;
      break;
    case 'Hostal':
      sizeMultiplier = 150;
      break;
    case 'Apartamento':
      sizeMultiplier = 200;
      break;
    default:
      sizeMultiplier = 100;
  }

  return 'El costo total de tu viaje a $selectedMeal será de: '
      'USD \$${sizeMultiplier * costMultiplier * duracionViaje}';
}
