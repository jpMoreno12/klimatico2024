// outra tela
import 'package:flutter/material.dart';

class MudarCidade extends StatelessWidget {
  MudarCidade({super.key});


  final _cidadeCampoControl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Mudar Cidade'),
        centerTitle: true,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: Image.asset('assets/white_snow.png',
            width: double.infinity,
            height: double.infinity, 
            fit:  BoxFit.cover,
            ),
          ),
          ListView(
            children: [
              ListTile(
                title: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Cidade', 
                  ),
                  controller: _cidadeCampoControl,
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: TextButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'cidade': _cidadeCampoControl.text
                    });
                  },
                  style: const ButtonStyle(
                    foregroundColor: WidgetStatePropertyAll(Colors.white),
                    backgroundColor: WidgetStatePropertyAll(Colors.purple)
                  ),
                  child: const Text('Mostra o Tempo'),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}
