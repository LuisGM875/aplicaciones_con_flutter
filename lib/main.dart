import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentForm(),
    );
  }
}

class PaymentForm extends StatefulWidget {
  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      setState(() {
        _expiryDateController.text = DateFormat("MM/yyyy").format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String cardNumber = _cardNumberController.text;
      String expiryDate = _expiryDateController.text;
      String cvv = _cvvController.text;

      print("Número de Tarjeta: $cardNumber");
      print("Fecha de Expiración: $expiryDate");
      print("CVV: $cvv");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pago procesado con éxito')),
      );

      _cardNumberController.clear();
      _expiryDateController.clear();
      _cvvController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Pagar con Tarjeta'))),
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
                  label: 'Número de Tarjeta:',
                  controller: _cardNumberController,
                  inputType: TextInputType.number,
                  maxLength: 12,
                  validator: (value) {
                    if (value!.isEmpty) return 'Ingrese el número de tarjeta';
                    if (value.length != 12) return 'Debe tener 12 dígitos';
                    return null;
                  },
                ),
                SizedBox(height: 10),
                _buildDatePicker(),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'CVV:',
                  controller: _cvvController,
                  inputType: TextInputType.number,
                  maxLength: 3,
                  isPassword: true,
                  validator: (value) {
                    if (value!.isEmpty) return 'Ingrese el CVV';
                    if (value.length != 3) return 'Debe tener 3 dígitos';
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Pagar'),
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
    int maxLength = 255,
    bool isPassword = false,
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
            maxLength: maxLength,
            obscureText: isPassword,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              counterText: "",
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Fecha de Expiración:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5),
        SizedBox(
          width: 400,
          child: TextFormField(
            controller: _expiryDateController,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.calendar_today),
            ),
            onTap: () => _selectDate(context),
            validator: (value) =>
                value!.isEmpty ? 'Seleccione la fecha de expiración' : null,
          ),
        ),
      ],
    );
  }
}
