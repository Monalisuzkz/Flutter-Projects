import 'package:activity_4_flutter/model/userdata.dart';
import 'package:activity_4_flutter/views/friendlist.dart';
import 'package:activity_4_flutter/views/infoheader.dart';
import 'package:activity_4_flutter/views/mainheader.dart';
import 'package:activity_4_flutter/views/postlist.dart';
import 'package:flutter/material.dart';

class SocialMedia extends StatefulWidget {
  const SocialMedia({super.key});

  @override
  State<SocialMedia> createState() => _SocialMediaState();
}

class _SocialMediaState extends State<SocialMedia> {

  Userdata userdata = Userdata();

  var followTxtStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold( 
      appBar: AppBar(
      leading: IconButton(onPressed: (){
        Navigator.pop(context);
      }, icon:  Icon(Icons.arrow_back),
      ),
    ),
    body: ListView(
      shrinkWrap: true,
      children: [
        MainHeader(userdata: userdata),
        Infoheader(userdata: userdata),
        Friendlist(userdata: userdata),
        const SizedBox(height: 20),
        Padding(padding: 
        const EdgeInsets.only(left: 8.0),
        child: Row(children: [Text('Posts', style: followTxtStyle,)]),
        ),
        const SizedBox(height: 20),
        Postlist(userdata: userdata),
      ],
    ),
    );
  }
}