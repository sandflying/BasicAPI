import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomePage extends StatefulWidget {
  //const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ความรู้เกียวกับอิหยังวะ"),
        ),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: FutureBuilder(
              builder: (context, AsyncSnapshot snapshot) {
                // var data = json.decode(snapshot.data
                //     .toString()); // [{คอมพิวเตอร์คืออะไร...},{},{},{}]
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return MyBox(
                        snapshot.data[index]['title'],
                        snapshot.data[index]['subtitle'],
                        snapshot.data[index]['image_url'],
                        snapshot.data[index]['detail']);
                  },
                  itemCount: snapshot.data.length,
                );
              },
              future: getData(),
              // future:
              //     DefaultAssetBundle.of(context).loadString('assets/data.json'),
            )));
  }

  Widget MyBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20), //ระยะห่างจาก ขอบทั่งหมด
      //color: Colors.blue[50],
      height: 200,
      decoration: BoxDecoration(
          //ขอบมน
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              image: NetworkImage(image_url),
              fit: BoxFit.cover, //รูปเต็มกรอบ
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.35),
                  BlendMode.darken) //เทสีพื้นหลัง
              )),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.start, //เมนของcolmun(แนวตั้ง) start center end
        crossAxisAlignment: CrossAxisAlignment
            .start, //ด้านตรงข้ามกับเมน (แนวนอน) start center end
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 18,
          ),
          TextButton(
              onPressed: () {
                print("Next Page >>>");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                            v1, v2, v3, v4))); //เชื่อมไปยัง detail.dart
              },
              child: Text("อ่านต่อ"))
        ],
      ),
    );
  }

  Future getData() async {
    //https://raw.githubusercontent.com/sandflying/BasicAPI/main/data.json
    var url = Uri.https(
        'raw.githubusercontent.com', '/sandflying/BasicAPI/main/data.json');
    var response = await http.get(url);
    var result = json.decode(response.body);
    return result;
  }
}
