class WishListClass {
  int id;
  int itemPrice;
  int itemCount;
  int vendorId;
  int menuItemId;
  String imagePath;
  String itemName;
  String itemStatus;
  int itemtype;
  int isSelected;
  String vendorName;
  int gst;

  WishListClass(
      {this.id,
      this.itemtype,
      this.imagePath,
      this.itemCount,
      this.itemName,
      this.itemPrice,
      this.menuItemId,
      this.vendorId,
      this.itemStatus,
      this.isSelected,
      this.vendorName,
      this.gst});
}
