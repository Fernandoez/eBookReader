import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class ReadPage extends StatefulWidget {
  const ReadPage({Key? key}) : super(key: key);

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  String? selectedFilePath;

  Future<void> _openFileExplorer() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        String filePath = result.files.single.path!;
        setState(() {
          selectedFilePath = filePath;
        });
      } else {
        // O usuário cancelou a seleção de arquivos
      }
    } catch (e) {
      print("Erro ao abrir o explorador de arquivos: $e");
    }

    if(selectedFilePath != null){
      readFile(selectedFilePath!);
    }
    else{
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Erro ao abrir:\n$selectedFilePath',
          style: TextStyle(fontSize: 16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _openFileExplorer,
            child: const Text('Selecionar Arquivo'),
          ),
        ],
      ),
    );
  }

  void readFile(String selectedFilePath){
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );
    VocsyEpub.open(selectedFilePath);
  }

}