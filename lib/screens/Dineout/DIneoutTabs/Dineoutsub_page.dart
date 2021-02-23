import 'package:feasturent_costomer_app/screens/Dineout/dineoutlist.dart';
import 'package:flutter/material.dart';

class PortfolioGallerySubPage extends StatelessWidget {
  const PortfolioGallerySubPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 8, right: 30, top: 10, bottom: 20),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 3, color: Colors.blue[50])
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Raisng Bar",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Netaji Subhash Place , North Delhi",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      " ₹ 1,000 for 2 . Rajasthani",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          "Now Closed",
                          style:
                              TextStyle(color: Colors.red[700], fontSize: 12),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Opens at 07:00 PM",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Pay 10% of Total Bill using PromoCash",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              )),
        ),
        Container(
            child: ListView.builder(
          itemCount: dineoutlist.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2,
                          spreadRadius: 2,
                          color: Colors.blue[50])
                    ],
                    borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                  leading: Container(child: dineoutlist[index].icon),
                  title: Text(dineoutlist[index].title),
                  subtitle: Text(dineoutlist[index].subtitle),
                ),
              ),
            );
          },
        )
        ),
        
      ],
    ));
  }
}
