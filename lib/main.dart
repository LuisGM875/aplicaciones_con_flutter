import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'dart:typed_data';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FileUploadForm(),
    );
  }
}

class FileUploadForm extends StatefulWidget {
  @override
  _FileUploadFormState createState() => _FileUploadFormState();
}

class _FileUploadFormState extends State<FileUploadForm> {
  File? _selectedFile;
  Uint8List? _selectedFileBytes;
  String? _fileName;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        if (kIsWeb) {
          _selectedFileBytes = result.files.first.bytes;
          _fileName = result.files.first.name;
        } else {
          _selectedFile = File(result.files.single.path!);
          _fileName = result.files.single.name;
        }
      });
    }
  }

  void _uploadFile() {
    if (_selectedFile == null && _selectedFileBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, seleccione un archivo')),
      );
      return;
    }

    if (kIsWeb) {
      print("Archivo seleccionado: $_fileName");
    } else {
      print("Archivo seleccionado: ${_selectedFile!.path}");
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Archivo subido con éxito')),
    );

    setState(() {
      _selectedFile = null;
      _selectedFileBytes = null;
      _fileName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Subida de Archivos'))),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Seleccione un archivo:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickFile,
                child: Text('Abrir Explorador'),
              ),
              SizedBox(height: 10),
              _fileName != null
                  ? Text('Archivo: $_fileName')
                  : Text('Ningún archivo seleccionado'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Subir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}