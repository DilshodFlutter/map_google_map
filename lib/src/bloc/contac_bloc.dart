import 'package:map_google_map/src/database/database_helper.dart';
import 'package:map_google_map/src/model/contac_model.dart';
import 'package:rxdart/subjects.dart';

class ContacBloc {
  DatabaseHelper databaseHelper = DatabaseHelper();

  final _fetchData = PublishSubject<List<ContacModel>>();

  Stream<List<ContacModel>> get getContacData => _fetchData.stream;

  allContac() async {
    List<ContacModel> data = await databaseHelper.getData();
    _fetchData.sink.add(data);
  }

  Future<int> saveData(ContacModel item) async {
    int id = await databaseHelper.saveData(item);
    allContac();
    return id;
  }

  Future<int> deleteData(int data) async {
    int id = await databaseHelper.deleteData(data);
    allContac();
    return id;
  }

  Future<int> updateData(ContacModel products) async {
    int id = await databaseHelper.updateData(products);
    allContac();
    return id;
  }
}
final contacBloc = ContacBloc();
