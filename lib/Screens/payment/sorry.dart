import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class Sorry extends StatefulWidget {
  @override
  _SorryState createState() => _SorryState();
}

class _SorryState extends State<Sorry> {

 void bottomSheet(context){
    showDialog(
      context: context,
      builder: (BuildContext bc){
          return AlertDialog(
            title: Center(
              child: Text('Namna ya Kulipa'),
            ),
            content: Text('Tuma pesa(TSH 5000) kwenda namba 0787474787(Airtel) jina Jiang Alipo au 0744644225 jina ALIPO ALIPO MWANDIMILA \n \nAngalizo \n \n1.Kiwango ni TSH 5000 \n2.Hakikisha line ya simu unayolipia imo kwenye simu yenye app hii \n3.hakikisha umewasha data(internet) \n4.Baada ya kulipa rudi tena hapa na uthibitishe malipo kwenye kitufe mbele ya ujumbe wako wa malipo ndani ya app hii \n \n5.Baada ya malipo screen ya kuthibitsha itatokea automatic'),
            actions: [
              FlatButton(
                onPressed: ()=>Navigator.pop(context),
                child: Text('ok'),
              )
            ],
          );
      }
    );
}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 350,
                child: Image.asset('images/soory.jpg',fit: BoxFit.cover,)),
              Center(
              child: Text('Samahani',
              style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontSize: 25,fontFamily: '')),
            ),
            Center(
              child: Text('Usajili Wako umesitishwa',
              style: TextStyle(fontWeight: FontWeight.w300,color: Colors.white,fontSize: 20,fontFamily: '')),
            ),
            Center(
              child: Text('Lipia Tuendelee kukuhudumia ',
              style: TextStyle(fontWeight: FontWeight.w400,color: Colors.white,fontSize: 20,fontFamily: '')),
            ),
            SizedBox(height: 25,),
            GestureDetector(
              onTap:()=> bottomSheet(context),
              child: Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Lipa',
                  style: TextStyle(fontWeight: FontWeight.w500,color: Colors.green,fontSize: 18,fontFamily: '')),
                ),
                width: MediaQuery.of(context).size.width/2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Unapata Tabu kulipia?',style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(width: 5),
                GestureDetector(
                  onTap:() => contact(),
                  child: Text('Tupigie',style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white)),
                )
              ],
            )
            ],
          ),
    );
  }

    contact(){
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
        context: context,
        builder: (ctx) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              color: Colors.green[600]
            ),
            height: MediaQuery.of(context).size.height  * 0.4,
            child: Center(
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(FontAwesomeIcons.projectDiagram,color: Colors.white),
                        Text('Contact Us',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.grey[800])),
                        IconButton(
                          icon: Icon(Icons.cancel_outlined,size: 40,color: Colors.white),
                          onPressed:()=> Navigator.pop(context)),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: _phone,
                    child: Container(
                      // color: Colors.green[800],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.phone,color: Colors.white),
                            SizedBox(width: 10,),
                            Text('Simu',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _whatsapp,
                    child: Container(
                      // color: Colors.green[900],
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.whatsapp,color: Colors.white),
                            SizedBox(width: 10,),
                            Text('Whatsapp',style: TextStyle(fontFamily: 'Noto',fontSize: 20,color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _phone() async {
  const url = 'tel:+255744644225';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
 _whatsapp() async {
  const url = 'https://wa.me/+255744644225';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
}