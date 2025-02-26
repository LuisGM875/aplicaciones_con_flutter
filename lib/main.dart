import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CommentForm(),
    );
  }
}

class CommentForm extends StatefulWidget {
  @override
  _CommentFormState createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String comment = _commentController.text;

      print("Nombre: $name");
      print("Email: $email");
      print("Comentario: $comment");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Comentario enviado con éxito')),
      );

      _nameController.clear();
      _emailController.clear();
      _commentController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Deja un Comentario'))),
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
                  validator: (value) => value!.isEmpty ? 'Ingrese su nombre' : null,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Email:',
                  controller: _emailController,
                  inputType: TextInputType.emailAddress,
                  validator: (value) => value!.isEmpty ? 'Ingrese su email' : null,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Comentario:',
                  controller: _commentController,
                  maxLines: 4,
                  validator: (value) => value!.isEmpty ? 'Ingrese su comentario' : null,
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
    int maxLines = 1,
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
            maxLines: maxLines,
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
