import 'package:flutter/material.dart';
import 'package:pagina_boton/page/services/firebase_serivice.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

//CREATE
class _AddDataState extends State<AddData> {

  TextEditingController nameController = TextEditingController(text: "");
  TextEditingController matchReceptorController = TextEditingController(text: "");
  TextEditingController matchSelectorController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Segunda Página'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingresa un nombre',
              ),
            ),
            TextField(
              controller: matchReceptorController,
              decoration: const InputDecoration(
                hintText: 'matchReceptor',
              ),
            ),
            TextField(
              controller: matchSelectorController,
              decoration: const InputDecoration(
                hintText: 'ImatchSelector',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
              addUser(nameController.text, matchReceptorController.text, matchSelectorController.text ).then((_) {
                Navigator.pop(context);
              });
            }, child: const Text('Guardar'))
          ],
        ),
      ),
    );
  }
}

// EDIT
class EditData extends StatefulWidget {
  const EditData({super.key});

  @override
  State<EditData> createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController nameController = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['name'] ?? 'Unknown';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Actualizar datos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingresa un nombre para modificar',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await updateUser(arguments['uid'], nameController.text).then((_) {
                  Navigator.pop(context);
                });
              }, 
              child: const Text('Actualizar')
            )
          ],
        ),
      ),
    );
  }
}
