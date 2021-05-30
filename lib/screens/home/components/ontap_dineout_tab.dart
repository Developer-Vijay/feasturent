import 'package:cached_network_image/cached_network_image.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutdetailpage.dart';
import 'package:flutter/material.dart';
import 'ontap_offer.dart';
import '../../../constants.dart';

class OnTapDineOutTab extends StatefulWidget {
  @override
  _OnTapDineOutTabState createState() => _OnTapDineOutTabState();
}

class _OnTapDineOutTabState extends State<OnTapDineOutTab> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        child: offerTapData != null
            ? offerTapData['dineout'].isNotEmpty
                ? Container(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                    ),
                    child: new GridView.count(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      children:
                          List.generate(offerTapData['dineout'].length, (i) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 7.0, left: 7, right: 7),
                          child: Container(
                              height: size.height * 0.24,
                              width: size.width * 0.4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DineoutDetailPage(
                                                dineID: offerTapData['dineout']
                                                    [i]['VendorInfo']['id'],
                                              )));
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Stack(
                                      children: [
                                        offerTapData['dineout'][i]['VendorInfo']
                                                    ['user']['profile'] !=
                                                null
                                            ? CachedNetworkImage(
                                                imageUrl:
                                                    // "https://im1.dineout.co.in/images/uploads/restaurant/sharpen/2/e/p/p20298-1484731590587f34c63a2a1.jpg?tr=tr:n-medium",

                                                    S3_BASE_PATH +
                                                        offerTapData['dineout']
                                                                    [i]
                                                                ['VendorInfo']
                                                            ['user']['profile'],
                                                fit: BoxFit.cover,
                                                height: size.height * 0.27,
                                                width: size.width * 0.46,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  "assets/images/feasturenttemp.jpeg",
                                                  height: size.height * 0.27,
                                                  width: size.width * 0.46,
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : Image.asset(
                                                "assets/images/feasturenttemp.jpeg",
                                                height: size.height * 0.27,
                                                width: size.width * 0.46,
                                                fit: BoxFit.cover,
                                              ),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Container(
                                            height: size.height * 0.0875,
                                            width: size.width * 1,
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'EAT, SAVE, REPEAT.',
                                                    style: TextStyle(
                                                        fontSize:
                                                            size.height * 0.015,
                                                        color: Colors.white),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                          capitalize(offerTapData[
                                                                      'dineout']
                                                                  [
                                                                  i]['VendorInfo']
                                                              ['name']),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.033,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  offerTapData['dineout'][i]
                                                                  ['VendorInfo']
                                                              ['avgCost'] ==
                                                          null
                                                      ? SizedBox()
                                                      : Text(
                                                          capitalize(
                                                              '₹ ${offerTapData['dineout'][i]['VendorInfo']['avgCost']} for ${offerTapData['dineout'][i]['VendorInfo']['forPeople']}'),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  size.height *
                                                                      0.015,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              )),
                        );
                      }),
                    ),
                  )
                : Center(
                    child: Text("No Dineout available"),
                  )
            : Center(
                child: Text("Loading...."),
              ));
  }
}
