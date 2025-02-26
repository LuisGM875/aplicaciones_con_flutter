import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HotelReservationForm(),
    );
  }
}

class HotelReservationForm extends StatefulWidget {
  @override
  _HotelReservationFormState createState() => _HotelReservationFormState();
}

class _HotelReservationFormState extends State<HotelReservationForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _checkinController = TextEditingController();
  final TextEditingController _checkoutController = TextEditingController();
  final TextEditingController _personsController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      String checkin = _checkinController.text;
      String checkout = _checkoutController.text;
      String persons = _personsController.text;

      print("Fecha de Entrada: $checkin");
      print("Fecha de Salida: $checkout");
      print("Número de Personas: $persons");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reserva enviada con éxito')),
      );

      _checkinController.clear();
      _checkoutController.clear();
      _personsController.clear();
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Reserva de Habitación'))),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildDateField(
                  label: 'Fecha de Entrada:',
                  controller: _checkinController,
                ),
                SizedBox(height: 10),
                _buildDateField(
                  label: 'Fecha de Salida:',
                  controller: _checkoutController,
                ),
                SizedBox(height: 10),
                _buildTextField(
                  label: 'Número de Personas:',
                  controller: _personsController,
                  inputType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Text('Reservar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required TextEditingController controller,
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
          width: 300,
          child: TextFormField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(context, controller),
              ),
            ),
            validator: (value) =>
                value!.isEmpty ? 'Este campo es obligatorio' : null,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType inputType = TextInputType.text,
    List<TextInputFormatter>? inputFormatters,
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
          width: 300,
          child: TextFormField(
            controller: controller,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(border: OutlineInputBorder()),
            validator: (value) =>
                value!.isEmpty ? 'Este campo es obligatorio' : null,
          ),
        ),
      ],
    );
  }
}