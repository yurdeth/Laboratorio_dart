import 'dart:developer';
import 'package:flutter/material.dart';

class ContadorCalorias extends StatefulWidget {
  const ContadorCalorias({super.key});

  @override
  State<ContadorCalorias> createState() => _ContadorCaloriasState();
}

class _ContadorCaloriasState extends State<ContadorCalorias> {
  final _formKey = GlobalKey<FormState>();

  bool _firstIsSelected = false;
  bool _secondIsSelected = false;
  bool _thirdIsSelected = false;
  bool _fourthIsSelected = false;
  String? _selectedSize;
  String? _selectedMeal;

  TextEditingController? _controller;
  String? nombre = "Invitado";
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
        title: const Text("Contador de calorías"),
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
                      labelText: "Ingresa tu nombre",
                      contentPadding: EdgeInsets.all(10)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Selecciona los alimentos:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    CheckboxListTile(
                      title: const Text("Carne"),
                      value: _firstIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _firstIsSelected = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Arroz"),
                      value: _secondIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _secondIsSelected = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Ensalada"),
                      value: _thirdIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _thirdIsSelected = value ?? false;
                        });
                      },
                    ),
                    CheckboxListTile(
                      title: const Text("Pan"),
                      value: _fourthIsSelected,
                      onChanged: (bool? value) {
                        setState(() {
                          _fourthIsSelected = value ?? false;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tamaño de la porción:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    RadioListTile<String>(
                      title: const Text('Pequeña'),
                      value: 'Pequeña',
                      groupValue: _selectedSize,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSize = value;
                          log('Porción Pequeña selected');
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Mediana'),
                      value: 'Mediana',
                      groupValue: _selectedSize,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSize = value;
                          log('Porción Mediana selected');
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Grande'),
                      value: 'Grande',
                      groupValue: _selectedSize,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedSize = value;
                          log('Porción Grande selected');
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Tipo de comida:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    DropdownButton<String>(
                      value: _selectedMeal,
                      hint: const Text('Selecciona el tipo de comida'),
                      items: <String>['Desayuno', 'Almuerzo', 'Cena']
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
                      log('Selected foods:');
                      if (_firstIsSelected) log('- Carne');
                      if (_secondIsSelected) log('- Arroz');
                      if (_thirdIsSelected) log('- Ensalada');
                      if (_fourthIsSelected) log('- Pan');
                      log('Portion size: $_selectedSize');
                      log('Meal type: $_selectedMeal');
                      nombre = _controller?.text;
                      log(result = calculateCalories(
                          nombre,
                          _selectedSize,
                          _selectedMeal,
                          _firstIsSelected,
                          _secondIsSelected,
                          _thirdIsSelected,
                          _fourthIsSelected
                      ));
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

String calculateCalories(String? nombre, String? selectedSize, String? selectedMeal,
    bool? carneSelected, bool? riceSelected, bool? ensaladaSelected, bool? breadSelected){
  double sizeMultiplier = 0;
  double calMultiplier = 0;

  if (carneSelected == true) calMultiplier += 200;
  if (riceSelected == true) calMultiplier += 150;
  if (ensaladaSelected == true) calMultiplier += 50;
  if (breadSelected == true) calMultiplier += 100;

  switch(selectedSize){
    case 'Pequeña': {
      sizeMultiplier = 1.0;
    }
    case 'Mediana': {
      sizeMultiplier = 1.5;
    }
    case 'Grande': {
      sizeMultiplier = 2.0;
    }
  }

  return 'Hola, $nombre. '
      'El total de calorías que consumes durante tu '
      '$selectedMeal es: ${sizeMultiplier * calMultiplier} cal';

}
