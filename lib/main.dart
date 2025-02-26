import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'dart:ui' as ui;

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ContactForm(),
    );
  }
}

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      print("Nombre: $name");
      print("Email: $email");
      print("Contraseña: $password");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Formulario enviado con éxito')),
      );

      _nameController.clear();
      _emailController.clear();
      _passwordController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Formulario de Registro'))),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                Center(
                  child: _buildTextField(
                    label: 'Nombre:',
                    controller: _nameController,
                    validator: (value) => value!.isEmpty ? 'Nombre' : null,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: _buildTextField(
                    label: 'Email:',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? 'Email' : null,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: _buildTextField(
                    label: 'Contraseña:',
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Contraseña' : null,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Enviar'),
                  ),
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
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    int maxLines = 1,
    required String? Function(String?) validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 400,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: validator,
          ),
        ),
      ],
    );
  }
}