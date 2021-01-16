import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  final String cName;
  final String cProfile;
  final String cEmail;
  const AppDrawer({Key key, this.cName, this.cProfile, this.cEmail})
      : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  
  @override
  Widget build(BuildContext context) {
    return 
       Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(padding: EdgeInsets.only(bottom: 5,top: 3),
                decoration: BoxDecoration(
                  
                  color: Color(0xFF3498E5),
                ),
                child: Container(
                  margin: EdgeInsets.only(),
                 

                  child: Column(
                    children: [
                      SizedBox(height: 0,),
                      Container(
                       
                        padding: EdgeInsets.all(0),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Color(0xffF8F9FE),
                          child: CircleAvatar(
                            radius: 48,
                            backgroundImage: widget.cProfile != null
                                ? NetworkImage(widget.cProfile)
                                : NetworkImage(
                                    'https://cdn4.iconfinder.com/data/icons/avatars-xmas-giveaway/128/batman_hero_avatar_comics-512.png'),
                          ),
                        ),
                      ),
                       SizedBox(
                         height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom:2),
                        child: Column(
                          children: [
                            Text(
                              widget.cName,
                              style: TextStyle(fontSize: 0, color: Colors.white),
                            ),
                            Text(widget.cEmail != null ? widget.cEmail : '',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.white)),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
                SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              dense: true,
              selected: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Orders'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Wishlist'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('History'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Wallet'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              color: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Help & Support'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              dense: true,
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      );
    
  }
}
