import 'package:feasturent_costomer_app/components/menuRelatedScreens/foodlistclass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  @override
  void dispose() {
    super.dispose();
    setSession();
  }

  @override
  void initState() {
    super.initState();
    createstorage();
  }

  createstorage() async {
    final SharedPreferences locationShared =
        await SharedPreferences.getInstance();
    locationShared.setString('tempLocation', "Fetching location...");
    final SharedPreferences cart = await SharedPreferences.getInstance();
    cart.setInt('TotalGst', 0);
    cart.setInt('TotalPrice', 0);
    cart.setInt('VendorId', 0);
    cart.setInt('TotalCount', 0);
    cart.setStringList('addedtocart', itemAdded);
    cart.setStringList('addontocart', addOnAdded);
    cart.setStringList('recommendDineout', []);
    cart.setStringList('idDineout', []);
  }

  setSession() async {
    //On boarding viewed
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isOnboadingSeen', true);
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF70B7ED), // Indicator color
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final kTitleStyle = GoogleFonts.merriweather(
        color: Colors.black,
        fontSize: size.height * 0.038,
        height: size.height * 0.002,
        fontWeight: FontWeight.w500);

    final kSubtitleStyle = TextStyle(
      color: Colors.black,
      fontSize: size.height * 0.0288,
      height: size.height * 0.002,
    );
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.1, 0.4, 0.7, 0.9],
                colors: [
                  Color(0xFFF8F9FE),
                  Color(0xFFF8F9FE),
                  Color(0xFFF8F9FE),
                  Color(0xFF3498E5),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.of(context).pushReplacementNamed('/homePage'),
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: Color(0xFF3498E5),
                        fontSize: size.height * 0.03,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: size.height * 0.775,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/boading1.png',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width:
                                    MediaQuery.of(context).size.height * 0.35,
                              ),
                            ),
                            SizedBox(height: size.height * 0.08),
                            Center(
                              child: Text(
                                'Enjoy yummuy food ',
                                style: kTitleStyle,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Center(
                              child: Text(
                                'Order all you want from ',
                                style: kSubtitleStyle,
                              ),
                            ),
                            Center(
                              child: Text(
                                'your favourite stores.',
                                style: kSubtitleStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/boading2.png',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width:
                                    MediaQuery.of(context).size.height * 0.35,
                              ),
                            ),
                            SizedBox(height: size.height * 0.08),
                            Center(
                              child: Text(
                                'Delivery On Time',
                                style: kTitleStyle,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Center(
                              child: Text(
                                'Receive Your order in less than ',
                                style: kSubtitleStyle,
                              ),
                            ),
                            Center(
                              child: Text(
                                '1 hour or pick a specific',
                                style: kSubtitleStyle,
                              ),
                            ),
                            Center(
                              child: Text(
                                ' delivery time',
                                style: kSubtitleStyle,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/boading3.png',
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.35,
                                width:
                                    MediaQuery.of(context).size.height * 0.35,
                              ),
                            ),
                            SizedBox(height: size.height * 0.08),
                            Center(
                              child: Text(
                                "Top #1 Fastest Delivery ",
                                style: kTitleStyle,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            Center(
                              child: Text(
                                'Order food and get delivery in the',
                                style: kSubtitleStyle,
                              ),
                            ),
                            Center(
                              child: Text(
                                'Ofastest time Anytime ',
                                style: kSubtitleStyle,
                              ),
                            ),
                            Center(
                              child: Text("Anywhere", style: kSubtitleStyle),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _buildPageIndicator(),
                ),
                _currentPage != _numPages - 1
                    ? Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  'Next',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: size.height * 0.032,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: size.height * 0.034,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Text(''),
              ],
            ),
          ),
        ),
        bottomSheet: _currentPage == _numPages - 1
            ? Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: double.infinity,
                color: Colors.white,
                child: GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushReplacementNamed('/homePage'),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        'Get started',
                        style: TextStyle(
                          color: Color(0xFF5e72e4),
                          fontSize: size.height * 0.032,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            : Text(''),
      ),
    );
  }
}
