import 'package:flutter/material.dart';
import 'package:pagina_boton/page/services/firebase_serivice.dart';

//stles + tab 
class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

//ventana emergente
  // void _showDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         // title: const Text('Ventana Emergente'),
  //         content: const Text('Informacion de la reunion 1'),
  //         actions: <Widget>[
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop(); 
  //             },
  //             child: const Text('Cerrar'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuarios'),
      ),

      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUser(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        onDismissed: (direction) async {
                          await deleteUser(snapshot.data?[index]['uid']);
                        },
                        confirmDismiss: (direction) async {
                          bool result = false;
                          result = await showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("¿Seguro que desea eliminar a ${snapshot.data?[index]['name']}?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, false);
                                    },
                                    child: const Text("Cancelar"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      return Navigator.pop(context, true);
                                    },
                                    child: const Text("Aceptar"),
                                  ),
                                ],
                              );
                            },
                          );
                          return result;
                        },
                        background: Container(
                          color: Colors.red,
                          child: const Icon(Icons.delete),
                        ),
                        direction: DismissDirection.endToStart,
                        key: Key(snapshot.data?[index]['uid']),
                        child: ListTile(
                          title: Text(snapshot.data?[index]['name'] ?? 'Unknown'),
                          onTap: () async {
                            await Navigator.pushNamed(
                              context,
                              '/edit',
                              arguments: {
                                "name": snapshot.data?[index]['name'] ?? 'Unknown',
                                "uid": snapshot.data?[index]['uid'],
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              try {
                await deleteDuplicateMatches();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Documentos duplicados eliminados')),
                );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al eliminar documentos: $e')),
                );
              }
            },
            child: const Text('Eliminar matches Duplicados'),
          ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}




