import 'package:feasturent_costomer_app/components/Cart.dart/CartDataBase/dataClass.dart';
import 'helper.dart';

var data1;
var data2;
var sqlIdData;

class UserServices {
  void saveUser(
      int itemPrice,
      int itemCount,
      int vendorId,
      int menuItemId,
      String imagePath,
      String itemName,
      String itemStatus,
      int itemtype,
      int isSelected,
      String vendorName,
      int gst,
      int variantId,
      String addons,
      String rating) {
    DBHelper.insert('addToCartData', {
      'itemPrice': itemPrice,
      'itemCount': itemCount,
      'vendorId': vendorId,
      'menuItemId': menuItemId,
      'imagePath': imagePath,
      'itemName': itemName,
      'itemStatus': itemStatus,
      'itemtype': itemtype,
      'isSelected': isSelected,
      'vendorName': vendorName,
      'gst': gst,
      'variantId': variantId,
      'addons': addons,
      'rating': rating,
    });
  }

  Future<List<AddToCart>> fetchUsers() async {
    final usersList = await DBHelper.getData('addToCartData');
    print(usersList);
    return usersList
        .map((item) => AddToCart(
            id: item['id'],
            itemPrice: item['itemPrice'],
            itemCount: item['itemCount'],
            vendorId: item['vendorId'],
            menuItemId: item['menuItemId'],
            imagePath: item['imagePath'],
            itemName: item['itemName'],
            itemStatus: item['itemStatus'],
            itemtype: item['itemtype'],
            isSelected: item['isSelected'],
            vendorName: item['vendorName'],
            gst: item['gst'],
            variantId: item['variantId'],
            addons: item['addons'],
            rating: item['rating']))
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
    data1 = userdata;
    return data1;
  }

  Future sqliteIDquery(id) async {
    final userdata = await DBHelper.sqlIDquerydata(id);
    sqlIdData = userdata;
    return sqlIdData;
  }

  void deleteUser(int id) {
    DBHelper.deleteData('addToCartData', id);
  }

  void updateUser(
      int id,
      int itemPrice,
      int itemCount,
      int vendorId,
      int menuItemId,
      String imagePath,
      String itemName,
      String itemStatus,
      int itemtype,
      int isSelected,
      String vendorName,
      int gst,
      int variantId,
      String addons,
      String rating) {
    DBHelper.updateData('addToCartData', id, {
      'itemPrice': itemPrice,
      'itemCount': itemCount,
      'vendorId': vendorId,
      'menuItemId': menuItemId,
      'imagePath': imagePath,
      'itemName': itemName,
      'itemStatus': itemStatus,
      'itemtype': itemtype,
      'isSelected': isSelected,
      'vendorName': vendorName,
      'gst': gst,
      'variantId': variantId,
      'addons': addons,
      'rating': rating,
    });
  }
}
