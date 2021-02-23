import 'package:flutter/material.dart';

class DineoutOfferTabPage extends StatefulWidget {
  @override
  _DineoutOfferTabPageState createState() => _DineoutOfferTabPageState();
}

class _DineoutOfferTabPageState extends State<DineoutOfferTabPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 2,
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
                          style:
                              TextStyle(color: Colors.red[300], fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "50% Off Total Bill",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700),
                        ),
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
                        Text(
                          "1 Guest(s)",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Text(
                          "from",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "₹ 35",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text("25 left for 26th Feb"),
                        Spacer(),
                        MaterialButton(
                            onPressed: () {},
                            minWidth: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text("BUY NOW",style: TextStyle(fontSize: 12),),
                            color: Colors.white)
                      ],
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
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5,),
                    Container(
                      decoration: BoxDecoration( color: Colors.amber[100],
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
    ));
  }
}
