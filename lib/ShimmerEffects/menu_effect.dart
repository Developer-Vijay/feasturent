import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


// ignore: must_be_immutable
class MenuEffect extends StatelessWidget {
bool _enabled=true;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Shimmer.fromColors(
           baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled: _enabled,
          child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                Stack(
                  children: [
                    Container(
                      height: size.height * 0.5,
                      child: Container(
                        margin: EdgeInsets.only(bottom: size.height * 0.094),
                        child: Stack(
                          children: [
                            // Swiper(
                            //   itemCount: imageList.length,
                            //   itemBuilder: (context, index) => CachedNetworkImage(
                            //     imageUrl: imageList[index],
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            // Align(
                            //   alignment: Alignment.topLeft,
                            //   child:
                            // // Container(color: Colors.grey,)
                            // ),
                        
                          ],
                        ),
                      ),
                    ),
                    // Main Container which Overlaps
                    Align(
                      alignment: Alignment.center,
                      heightFactor: size.height * 0.0025,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.2, right: 0.2),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          height: size.height * 0.7,
                          width: size.width * 0.999,
                          child: Column(children: [
                            Container(
                                child: Row(
                              children: [
                                // Location
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 34, top: 20),
                                //   child: Icon(
                                //     Icons.location_on,
                                //     color: Colors.grey,
                                //     size: 20,
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 12, top: 21),
                                //   child: Text(
                                //     "Mc Donalds",
                                //     style: TextStyle(fontSize: 14),
                                //   ),
                                // ),
                                Spacer(),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(right: 24, top: 24),
                                  child: 
                                  Container(height: 12,color: Colors.white,)
                                ),
                              ],
                            )),

                            SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    //color: Colors.red,

                                    height: 20,
                                   
                                  ),
                                ),
                                Spacer(),
                              Container(height: 30,
                              color: Colors.white,
                              )
                              ]),
                            ),

                            // Price
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.only(right: 30.0),
                                  child:
                                  Container(height: 40,),
                                ),
                              ],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, top: 30, right: 20),
                              child: Container(
                               height: 40,
                              ),
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              margin: EdgeInsets.only(
                                  left: size.width * 0.11,
                                  right: size.width * 0.11),
                              height: 60,
                              width: 60, 
                              
                            )
                          ]),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
        ),
      ),
    );
  }
}