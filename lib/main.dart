import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PreferencesSurveyForm(),
    );
  }
}

class PreferencesSurveyForm extends StatefulWidget {
  @override
  _PreferencesSurveyFormState createState() => _PreferencesSurveyFormState();
}

class _PreferencesSurveyFormState extends State<PreferencesSurveyForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _foodController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String color = _colorController.text;
      String food = _foodController.text;

      print("Color Favorito: $color");
      print("Comida Favorita: $food");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Encuesta enviada con éxito')),
      );

      _colorController.clear();
      _foodController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Encuesta de Preferencias'))),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTextField(
                  label: 'Color Favorito:',
                  controller: _colorController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su color favorito' : null,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Comida Favorita:',
                  controller: _foodController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su comida favorita' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Enviar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 400,
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
