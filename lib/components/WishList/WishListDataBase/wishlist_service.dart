import 'wishlist_helper.dart';
import 'wishlist_data_class.dart';

var dataCheck;
var dataCheck1;
var dataWishList;

class WishListService {
  void saveUser(
    int isDineout,
    int isResturent,
    String average,
    String imagepath,
    String name,
    int idDR,
    String rating,
    String address,
    String cusines,
  ) {
    WishListDBhelper.insert('wishListDat', {
      'isDineout': isDineout,
      'isResturent': isResturent,
      'average': average,
      'imagepath': imagepath,
      'name': name,
      'idDR': idDR,
      'rating': rating,
      'address': address,
      'cusines': cusines,
    });
  }

  Future<List<WishListClass>> fetchUsers() async {
    final usersList = await WishListDBhelper.getData('wishListDat');
    return usersList
        .map((item) => WishListClass(
              id: item['id'],
              isDineout: item['isDineout'],
              isResturent: item['isResturent'],
              average: item['average'],
              imagepath: item['imagepath'],
              name: item['name'],
              idDR: item['idDR'],
              rating: item['rating'],
              address: item['address'],
              cusines: item['cusines'],
            ))
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
