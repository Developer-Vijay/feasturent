import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DineoutEffect extends StatefulWidget {

  @override
  _DineoutEffectState createState() => _DineoutEffectState();
}

class _DineoutEffectState extends State<DineoutEffect> {
 bool _enabled=false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(

          child: Column(
            children: [
              Shimmer.fromColors(

                  baseColor: Colors.grey[300],
                  highlightColor: Colors.grey[100],
                  enabled: _enabled,
                child: Column(children: [
                  Container(color: Colors.white,
                  height: 300,

                  ),
                  SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(color: Colors.white,
                    height: 100,

                    ),
                ),
                SizedBox(height: 20,),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(color: Colors.white,
                    height: 100,

                    ),
                ),
                ],),
              ),
            ],
          ),
          
        ),
      ),
    );
  }
}