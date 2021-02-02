import 'package:flutter/material.dart';

class Adreesbook extends StatefulWidget {
  @override
  _AdreesbookState createState() => _AdreesbookState();
}

class _AdreesbookState extends State<Adreesbook> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<String> _data = [
    "Gali no- 13 , Nathu Colony , Nathu Pura Delhi-84 Burari Delhi-84"
  ];
  List<String> item = List();
  String temp;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child:
              ListView(
                children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            IconButton(
                  icon: Icon(Icons.arrow_back_sharp),
                  onPressed: () {},
            ),
            SizedBox(
                  height: 12,
            ),
            Container(
                    margin: EdgeInsets.only(left: 20), child: Text("My Addresses")),
            SizedBox(
                  height: 10,
            ),
            FlatButton(
                  onPressed: () {
                    setState(() {
                      item.add(temp);
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 5, right: 5),
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        SizedBox(
                          width: 4,
                        ),
                        Text("Add Addresses"),
                      ],
                    ),
                  ),
            ),
            Divider(
                  thickness: 1.1,
            ),

            TextField(
                  onChanged: (text) {
                    temp = text;
                  },
                  maxLength: 30,
            ),

           // item.map((element)=>Text(element)).toList(growable: true);
            
                  
                  
                  
            
            //             Expanded(
            //               child: AnimatedList(
            //                   key: _listKey,
            //                   initialItemCount: _data.length,
            //                   itemBuilder: (context, index, animation) =>
            //                       _buildItem(context, _data[index], animation)),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   );
            // }

            // Widget _buildItem(
            //     BuildContext context, String item, Animation<double> animation) {
            //   TextStyle textStyle = TextStyle(fontSize: 20);

            //   return Padding(
            //     padding: EdgeInsets.all(8),
            //     child: SizeTransition(
            //       sizeFactor: animation,
            //       axis: Axis.vertical,
            //       child: SizedBox(
            //           height: 50,
            //           child: Card(
            //             child: Center(
            //               child: Text(
            //                 item,
            //                 style: textStyle,
            //               ),
            //             ),
            //           )),
            //     ),
            //   );
            // }

            // void _addAnItem() {
            //   _data.insert(0, "Address");
            //   _listKey.currentState.insertItem(0);
          ]),
                ],
              ),
        ),
        
      ),
    );
  }
}
