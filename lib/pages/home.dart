import 'package:flutter/material.dart';
import 'package:band_names/models/band.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Heroes del Silencio', votes: 3),
    Band(id: '3', name: 'Bon Jovi', votes: 2),
    Band(id: '4', name: 'Héroes de la grieta', votes: 4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandTile(bands[index]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 1,
        onPressed: addNewBand,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.delete, color: Colors.white),
              SizedBox(width: 8),
              Text('Delete Band', style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
      onDismissed: (direction) {
        // Remove the band from the list
        setState(() {
          bands.remove(band);
        });
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(band.name.substring(0, 2)),
        ),
        title: Text(band.name),
        trailing: Text('${band.votes}', style: const TextStyle(fontSize: 20)),
        onTap: () {
          print(band.name);
        },
      ),
    );
  }

  addNewBand() {
    final TextEditingController textController = TextEditingController();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('New band name:'),
            content: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Band name',
              ),
            ),
            actions: [
              MaterialButton(
                elevation: 5,
                textColor: Colors.blue,
                onPressed: () => addBandToList(textController.text),
                child: const Text('Add'),
              )
            ],
          );

          // Band newBand = Band(id: '5', name: 'Nirvana', votes: 5);
          // setState(() {
          //   bands = [...bands, newBand];
          // });
        });
  }

  void addBandToList(String name) {
    print(name);
    if (name.length > 1) {
      // Add the band to the list
      setState(() {
        bands = [
          ...bands,
          Band(id: DateTime.now().toString(), name: name, votes: 0)
        ];
      });
      Navigator.pop(context); // Close the dialog
    }
    // Add your logic here to add the band to the list
  }
}
