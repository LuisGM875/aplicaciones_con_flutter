import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductSearchForm(),
    );
  }
}

class ProductSearchForm extends StatefulWidget {
  @override
  _ProductSearchFormState createState() => _ProductSearchFormState();
}

class _ProductSearchFormState extends State<ProductSearchForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _productController = TextEditingController();
  String _selectedCategory = 'electronica'; // Valor predeterminado

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String product = _productController.text;

      print("Producto: $product");
      print("Categoría: $_selectedCategory");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Búsqueda enviada con éxito')),
      );

      _productController.clear();
      setState(() {
        _selectedCategory = 'electronica';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Búsqueda de Productos'))),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                children: [
                  Center(
                    child: _buildTextField(
                      label: 'Nombre del Producto:',
                      controller: _productController,
                      validator: (value) =>
                          value!.isEmpty ? 'Ingrese el nombre del producto' : null,
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: _buildDropdown(),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Buscar'),
                    ),
                  ),
                ],
              ),
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
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categoría:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          width: 400,
          padding: EdgeInsets.symmetric(vertical: 5),
          child: DropdownButtonFormField<String>(
            value: _selectedCategory,
            items: [
              DropdownMenuItem(value: 'electronica', child: Text('Electrónica')),
              DropdownMenuItem(value: 'ropa', child: Text('Ropa')),
              DropdownMenuItem(value: 'hogar', child: Text('Hogar')),
            ],
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            decoration: InputDecoration(border: OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}