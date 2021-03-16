import 'package:feasturent_costomer_app/screens/Dineout/DIneoutTabs/DineoutReserveTable/dineout_date_select.dart';
import 'package:feasturent_costomer_app/screens/Dineout/dineoutlist.dart';
import 'package:flutter/material.dart';

class PortfolioGallerySubPage extends StatelessWidget {
  const PortfolioGallerySubPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _textstyle=TextStyle(color: Colors.black);
    Size size = MediaQuery.of(context).size;
    return Container(
        child: ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 8, right: 30, top: 20, bottom: 20),
          child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 2, spreadRadius: 3, color: Colors.blue[50])
                  ],
                  borderRadius: BorderRadius.circular(8)),
              child: Padding(
                padding: const EdgeInsets.all(8),
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
                      style: TextStyle(fontSize: 12,color: Colors.black
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Row(
                      children: [
                        Text(
                          " ₹ 1,000 for 2 . Rajasthani",
                          style: TextStyle(fontSize: 12,color: Colors.black),
                        ),
                        SizedBox(width: 12,),
                        Text("Call - 9818069709",style: TextStyle(color: Colors.black),)
                      ],
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
                          width: 20,
                        ),
                        Text(
                          "Opens at 07:00 PM",
                          style: TextStyle(fontSize: 12,color: Colors.green,fontWeight: FontWeight.bold),
                        ),
                        
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Pay 10% of Total Bill using PromoCash",
                      style: TextStyle(fontSize: 12,color: Colors.black),
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
                  onTap: () {
                    if (dineoutlist[index].number == 3) {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) => Container(
                              height: size.height * 0.6,
                              child: DineoutDateSelection()));
                    } else {
                      print(dineoutlist[index].number);
                    }
                  },
                  leading: Container(child: dineoutlist[index].icon),
                  enabled: true,
                  title: Text(dineoutlist[index].title),
                  subtitle: Text(dineoutlist[index].subtitle),
                ),
              ),
            );
          },
        )),
      ],
    ));
  }
}
