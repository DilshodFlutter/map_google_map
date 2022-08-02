import 'package:flutter/material.dart';
import 'package:map_google_map/src/database/database_helper.dart';
import 'package:map_google_map/src/model/contac_model.dart';

class ContacScreen extends StatefulWidget {
  const ContacScreen({Key? key}) : super(key: key);

  @override
  State<ContacScreen> createState() => _ContacScreenState();
}

class _ContacScreenState extends State<ContacScreen> {
  TextEditingController controller = TextEditingController();

  List<ContacModel> data = [];
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      Text(data[index].name),
                      Text(data[index].number),
                      GestureDetector(
                        onTap: () async {
                         // data[index].number = "97868676776";
                          await databaseHelper.updateData(data[index]);
                          _getData();
                        },
                        child: const Text("edit"),
                      ),
                      GestureDetector(
                        onTap: () async {
                          await databaseHelper.deleteData(data[index].id);
                          _getData();
                        },
                        child: Text("delete"),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await databaseHelper.saveData(
            ContacModel(
              number: '+998943293406',
              name: controller.text,
            ),
          );
          controller.text = "";
          _getData();
        },
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _getData() async {
    data = await databaseHelper.getData();
    setState(() {});
  }
}
