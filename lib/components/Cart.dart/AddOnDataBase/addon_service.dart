import 'addon_dataClass.dart';
import 'addon_helper.dart';

var data3New;
var data4;
var sqlIdData1;

class AddOnService {
  void saveUser(
    int addonPrice,
    int addonCount,
    int vendorId,
    int addonId,
    String addonName,
    String addonvendorName,
    int addongst,
  ) {
    DBHelper.insert('addOnData', {
      'addonPrice': addonPrice,
      'addonCount': addonCount,
      'vendorId': vendorId,
      'addonId': addonId,
      'addonName': addonName,
      'addonvendorName': addonvendorName,
      'addongst': addongst,
    });
  }

  Future<List<AddOnData>> fetchUsers() async {
    final usersList = await DBHelper.getData('addOnData');
    return usersList
        .map((item) => AddOnData(
              id: item['id'],
              addonCount: item['addonCount'],
              addonId: item['addonId'],
              vendorId: item['vendorId'],
              addonName: item['addonName'],
              addonPrice: item['addonPrice'],
              addongst: item['addongst'],
              addonvendorName: item['addonvendorName'],
            ))
        .toList();
  }

  Future incrementItemCounter(id, count) async {
    print("ob");
    var d = count++;
    print(d);
    int updateduser = await DBHelper.incrementCounter(id, count++);

    count = updateduser;
    print("Data udateing");
    print(count);
    print("data updated");
    return updateduser;
  }

  Future decrementItemCounter(id, count) async {
    print("ob");
    var d = count--;
    print(d);
    int updateduser = await DBHelper.decrementCounter(id, count--);

    count = updateduser;
    print("Data udateing");
    print(count);
    print("data updated");
    return updateduser;
  }

  Future data(id) async {
    final userdata = await DBHelper.querydata(id);
    data3New = userdata;
    return data3New;
  }

  Future sqliteIDquery(id) async {
    final userdata = await DBHelper.sqlIDquerydata(id);
    sqlIdData1 = userdata;
    return sqlIdData1;
  }

  void deleteUser(int id) {
    DBHelper.deleteData('addOnData', id);
  }

  void updateUser(
    int id,
    int addonPrice,
    int addonCount,
    int vendorId,
    int addonId,
    String addonName,
    String addonvendorName,
    int addongst,
  ) {
    DBHelper.updateData('addOnData', id, {
      'addonPrice': addonPrice,
      'addonCount': addonCount,
      'vendorId': vendorId,
      'addonId': addonId,
      'addonName': addonName,
      'addonvendorName': addonvendorName,
      'addongst': addongst,
    });
  }
}
