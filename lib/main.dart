import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EventRegistrationForm(),
    );
  }
}

class EventRegistrationForm extends StatefulWidget {
  @override
  _EventRegistrationFormState createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _attendance;

  void _submitForm() {
    if (_formKey.currentState!.validate() && _attendance != null) {
      String name = _nameController.text;
      String email = _emailController.text;

      print("Nombre: $name");
      print("Email: $email");
      print("Asistirá: $_attendance");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Inscripción enviada con éxito')),
      );

      _nameController.clear();
      _emailController.clear();
      setState(() {
        _attendance = null;
      });
    } else if (_attendance == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, seleccione su asistencia')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Inscripción a un Evento'))),
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
                  label: 'Nombre:',
                  controller: _nameController,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su nombre' : null,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Email:',
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  validator: (value) =>
                      value!.isEmpty ? 'Ingrese su email' : null,
                ),
                SizedBox(height: 10),
                _buildRadioButtons(),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Inscribirse'),
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

  Widget _buildRadioButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '¿Asistirá al evento?',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Sí',
                  groupValue: _attendance,
                  onChanged: (value) {
                    setState(() {
                      _attendance = value;
                    });
                  },
                ),
                Text('Sí'),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'No',
                  groupValue: _attendance,
                  onChanged: (value) {
                    setState(() {
                      _attendance = value;
                    });
                  },
                ),
                Text('No'),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
