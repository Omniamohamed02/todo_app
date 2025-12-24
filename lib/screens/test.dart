import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         Column(
          children: [
            Container(
              color: Colors.blue,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height*0.3,
              child: Column(
                children: [
                  Text("data"),
                  Text("data"),
                ],
              ) ,
            )
          ],
         ),
         Positioned(
          top: 120,
          left: 0,
          right: 0,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height*0.3,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context,index){
                         return Text("data");
                      }
                    ),
                ),
                SizedBox(
                  height: 30,),
                  Text("data"),
                  Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height*0.3,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context,index){
                         return Text("data");
                      }
                    ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
                  onPressed: (){}, child: Text("data"))
              ],
            ),
          ))
        ],
      ),
    );
  }
}