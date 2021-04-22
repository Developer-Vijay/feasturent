import 'wishlist_helper.dart';
import 'wishlist_data_class.dart';

var dataCheck;
var dataCheck1;
var dataWishList;

class WishListService {
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
      int gst) {
    WishListDBhelper.insert('wishListDat', {
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
    });
  }

  Future<List<WishListClass>> fetchUsers() async {
    final usersList = await WishListDBhelper.getData('wishListDat');
    return usersList
        .map((item) => WishListClass(
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
            gst: item['gst']))
        .toList();
  }

  Future data(id) async {
    final userdata = await WishListDBhelper.querydata(id);
    dataCheck = userdata;
    return dataCheck;
  }

  void deleteUser(int id) {
    WishListDBhelper.deleteData('wishListDat', id);
  }
}
