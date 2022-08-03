import 'package:flutter/material.dart';
import 'package:map_google_map/src/bloc/contac_bloc.dart';
import 'package:map_google_map/src/model/contac_model.dart';

class ContacScreen extends StatefulWidget {
  const ContacScreen({Key? key}) : super(key: key);

  @override
  State<ContacScreen> createState() => _ContacScreenState();
}

class _ContacScreenState extends State<ContacScreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();

  @override
  void initState() {
    contacBloc.allContac();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<List<ContacModel>>(
        stream: contacBloc.getContacData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ContacModel> data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(24),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          data[index].name,
                          maxLines: 3,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        SizedBox(
                          height: 20,
                          width: 85,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.phone_iphone,
                                size: 20,
                              ),
                              Text(
                                data[index].number,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 6.0),
                        GestureDetector(
                          onTap: () async {
                            showBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 200,
                                  color: Colors.amber,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            data[index].number = "asasa";
                                            contacBloc.updateData(data[index]);
                                          },
                                          child: const Text("edit"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("Back"),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                              padding: const EdgeInsets.all(4.0),
                              width: 48,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.blue),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 18,
                              )),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        GestureDetector(
                          onTap: () async {
                            contacBloc.deleteData(data[index].id);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(4.0),
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.red),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return Container(
                height: 450,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25.0),
                    topLeft: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () => null,
                      child: SizedBox(
                        height: 60,
                        //  padding: EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width - 80,
                        child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.black45)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () => null,
                      child: SizedBox(
                        height: 60,
                        //  padding: EdgeInsets.all(15.0),
                        width: MediaQuery.of(context).size.width - 80,
                        child: TextField(
                          controller: controller2,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Number",
                              hintStyle: TextStyle(color: Colors.black45)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Align(
                      alignment: const FractionalOffset(0.94, 0.1),
                      child: ElevatedButton(
                        onPressed: () async {
                          contacBloc.saveData(ContacModel(
                            name: controller.text,
                            number: controller2.text,
                          ));
                          controller.text = "";
                          controller2.text = "";
                          Navigator.pop(this.context);
                        },
                        child: const SizedBox(
                          height: 40.0,
                          width: 40.0,
                          child: Center(
                            child: Icon(
                              Icons.done,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            backgroundColor: Colors.transparent,
          );
        },
        child: const Center(
          child: Icon(Icons.person_add_alt_1),
        ),
      ),
    );
  }
}
