import 'dart:async';

String paymentMode = "Online Mode";
String addAddress = " ";
String userNameWithNumber = "Select Delivery Address";
int addressID;
Timer circluatimer, placeTimer1;
double placeValue = 0.0;
double placePrecent = 0.0;
double circluarValue = 0.0;
double circularPrecent = 0.0;
double latitude;
double longitude;
int addresstype;
List<int> idCheck = [];
List<String> itemAdded = [];
List<String> addOnAdded = [];

var takeUser;
var emailid;
var photo;
var userName;
var location = "Fetching location...";
int loginstatus = 0;

class MenuData {
  int id;
  int qty;
  int variantId;
  MenuData(this.id, this.qty, this.variantId);

  Map toJson() => {
        'id': id,
        'qty': qty,
        'variantId': variantId,
      };
}

class AddOnDataclass {
  int id;
  int qty;
  AddOnDataclass(this.id, this.qty);

  Map toJson() => {
        'id': id,
        'qty': qty,
      };
}

String tempAddOns;
