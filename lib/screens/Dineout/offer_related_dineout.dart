import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class OfferRelatedDineout extends StatelessWidget {
  var data;
  OfferRelatedDineout({this.data});
  @override
  Widget build(BuildContext context) {
    Size sized = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Offer Dineouts"),
      ),
      body: data.isEmpty
          ? Center(
              child:
                  Text("No any dineout available on this offer currently..."),
            )
          : GridView.count(
              crossAxisCount: 2,
              children: List.generate(data.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Container(
                    color: Colors.white,
                    height: sized.height * 0.195,
                    width: sized.height * 0.22,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (DineoutDetailPage(
                                    dineID: data[index]['vendorId']))));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Stack(
                            children: [
                              data[index]['VendorInfo']['user']['profile'] !=
                                      null
                                  ? CachedNetworkImage(
                                      imageUrl: S3_BASE_PATH +
                                          data[index]['VendorInfo']['user']
                                              ['profile'],
                                      height: sized.height * 0.35,
                                      width: sized.height * 0.35,
                                      imageBuilder: (context, imageProvider) =>
                                          Container(
                                        height: sized.height * 0.35,
                                        width: sized.height * 0.35,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      placeholder: (context, url) =>
                                          Image.asset(
                                        "assets/images/defaultdineout.jpg",
                                        fit: BoxFit.cover,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    )
                                  : Container(
                                      height: sized.height * 0.35,
                                      width: sized.height * 0.35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                  "assets/images/defaultdineout.jpg"))),
                                    ),
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: sized.height * 0.07,
                                  width: sized.width * 1,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(10),
                                        bottomRight: Radius.circular(10)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: sized.height * 0.063,
                                          color: Colors.black.withOpacity(0.4),
                                          padding:
                                              EdgeInsets.only(left: 5, top: 10),
                                          alignment: Alignment.topLeft,
                                          child: RichText(
                                            text: TextSpan(
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                                children: [
                                                  TextSpan(
                                                      text: capitalize(
                                                          "${data[index]['VendorInfo']['name']}\n"),
                                                      style: TextStyle(
                                                          fontSize:
                                                              sized.height *
                                                                  0.022,
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  // TextSpan(
                                                  //     text:
                                                  //         " ${data[index]['VendorInfo']['Address']['city']}",
                                                  //     style: TextStyle(
                                                  //         fontSize:
                                                  //             sized.height * 0.018,
                                                  //         fontWeight:
                                                  //             FontWeight.w600)),
                                                ]),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
