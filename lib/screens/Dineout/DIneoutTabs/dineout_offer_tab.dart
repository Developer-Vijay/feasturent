import 'package:flutter/material.dart';

class DineoutOfferTabPage extends StatefulWidget {
  final data;
  const DineoutOfferTabPage({this.data});
  @override
  _DineoutOfferTabPageState createState() => _DineoutOfferTabPageState();
}

class _DineoutOfferTabPageState extends State<DineoutOfferTabPage> {
  var data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return data['user']['OffersAndCoupons'].isNotEmpty
        ? Container(
            child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: Colors.blue[50],
                            spreadRadius: 2,
                          )
                        ],
                        borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.bar_chart_sharp,
                                color: Colors.red[300],
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                "Trending",
                                style: TextStyle(
                                    color: Colors.red[300], fontSize: 12),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                  child: data['user']['OffersAndCoupons'][index]
                                              ['coupon'] !=
                                          null
                                      ? Text(
                                          "${data['user']['OffersAndCoupons'][index]['coupon']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : Text("Data")),
                              Spacer(),
                              CircleAvatar(
                                backgroundColor: Colors.grey[200],
                                child: Icon(
                                  Icons.note,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              Container(
                                  child: data['user']['OffersAndCoupons'][index]
                                              ['couponQuantity'] !=
                                          null
                                      ? Text(
                                          '${data['user']['OffersAndCoupons'][index]['couponQuantity']} GUEST',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        )
                                      : Text("No. of Person")),
                              Spacer(),
                              Text(
                                "from",
                                style: TextStyle(
                                    color: Colors.blueGrey, fontSize: 12),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Container(
                                  child: data['user']['OffersAndCoupons'][index]
                                              ['couponDiscount'] !=
                                          null
                                      ? Text(
                                          "₹ ${data['user']['OffersAndCoupons'][index]['couponDiscount']}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        )
                                      : Text("coupon discount")),
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Container(
                                  child: data['user']['OffersAndCoupons'][index]
                                              ['couponValidity'] !=
                                          null
                                      ? Text(
                                          ' The offer is valid till - ${data['user']['OffersAndCoupons'][index]['couponValidity']}',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text("No offer Avalioable")),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 3,
                            width: size.width * 0.7,
                            color: Colors.red[300],
                            child: Text("1"),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            "Avaliable All Days",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.amber[100],
                                borderRadius: BorderRadius.circular(5)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Only Applicable when Paying using Dineout Pay",
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Container(
                            height: 6,
                            width: size.width * 0.9,
                            color: Colors.blue,
                            child: Text("1"),
                          ),
                        ],
                      ),
                    )),
              );
            },
          )
          )
        : Center(child: Text("No offer Yet"));
  }
}
