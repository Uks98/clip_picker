import 'package:flutter/material.dart';


class CopyRight extends StatelessWidget {
  const CopyRight({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300,
        child: Column(
         children: [
           SizedBox(
             height: 20,
           ),
           ListTile(
             onTap: (){},
             title: Text("Icon",style: TextStyle(fontSize: 20),),
             subtitle: Container(
                 margin: EdgeInsets.only(top: 10),
                 child: Text("https://www.flaticon.com/free-icons/plant title=plant iconsPlant icons created by Freepik - Flaticon",style: TextStyle(fontSize: 20),))
           )
         ],
        ),
      ),
    );
  }
}
