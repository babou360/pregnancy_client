import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:pregnancy_tracking_app/models/sales.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/custom/appBar.dart';

class Dimensions extends StatefulWidget {
  User currentUser;
  Dimensions(this.currentUser);
  @override
  _DimensionsState createState() => _DimensionsState();
}

class _DimensionsState extends State<Dimensions> {
  @override
  Widget build(BuildContext context) {
  List<charts.Series<Sales, num>> _seriesBarData;
  final _formKey = GlobalKey<FormState>();
    TextEditingController monthController = TextEditingController();
    TextEditingController weightController = TextEditingController();
    String month;
    String weight;
    User currentUser;
    bool isLoading = false;
    List<String> weeks = ['1','2','3','4','5','6','7','8','9'];
     String _week;
  List<Sales> mydata;
  int _selectedIndex;
   _onDaySelected(int index) {
    setState(() {
      _selectedIndex = index;
      ;
    });
  }


  _generateData(mydata) {
    // ignore: deprecated_member_use
    _seriesBarData = List<charts.Series<Sales, num>>();
    _seriesBarData.add(
      charts.Series(
        domainFn: (Sales sales, _) => int.parse(sales.month),
        measureFn: (Sales sales, _) => int.parse(sales.weight),
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        fillColorFn: (_, __) => charts.MaterialPalette.green.shadeDefault.lighter,
        // domainFn: (Sales sales, _) => sales.month.toString(),
        // measureFn: (Sales sales, _) => int.parse(sales.weight),
        id: 'Sales',
        data: mydata,
        labelAccessorFn: (Sales row, _) => "${row.month}",
      ),
    );
  }
  
    Future  _submit() async{
   final FormState form = _formKey.currentState;
   if(!_formKey.currentState.validate()){
     Scaffold.of(context).showSnackBar(
         SnackBar(content: Text("Please fill out all the fields"),
         duration: new Duration(seconds: 2),
         behavior: SnackBarBehavior.floating,
         elevation: 3.0,
         backgroundColor: Colors.green,)
       );
     }else{
       if(month.isNotEmpty && weight.isNotEmpty ){
        form.save();
        setState(() {
        isLoading=true;
        });
        Firestore
        .instance
        .collection('weight')
        .document(this.widget.currentUser.mobileNumber)
        .collection('current')
        .add({
          'month': month,
          'weight': weight
        });
        setState(() {
          isLoading =false;
          monthController.clear();
          weightController.clear();
        });  
        Navigator.pop(context);
     }
   }
  }

   uzito(){
     return FutureBuilder(
       future:Firestore.instance.collection('weight').document(this.widget.currentUser.mobileNumber).collection('current').orderBy('month',descending: false).getDocuments(),
       builder: (context,snapshot){
        //  print('Data Length: ${snapshot.data.documents.length}');
         if(snapshot.hasData){
           return GridView.count(
          shrinkWrap: true,
          crossAxisCount: 1,
          mainAxisSpacing: 0,
          scrollDirection: Axis.horizontal,
          children: List.generate(snapshot.data.documents.length,(index){
            return SingleChildScrollView(
              child: Container(
                // height: 20,
                width: 50,
                // margin: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                              border: Border.all(color: Colors.green,)
                        ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.white30,)
                        // ),
                        child: Column(
                          children: [
                            Row(
                        children: [
                          Container(
                            width: 60,
                            child: Text(' Mwezi:',
                            style: TextStyle(fontFamily: 'Noto',fontSize: 12,fontWeight: FontWeight.w700))),
                          Text(snapshot.data.documents[index]['month'].toString(),
                          style: TextStyle(fontFamily: 'Noto',fontSize: 15,color: Colors.green)),
                        ]),
                        Divider(color: Colors.green,),
                        Row(
                        children: [
                          Container(
                            width: 50,
                            child: Text(' Kilo:',
                            style: TextStyle(fontFamily: 'Roboto',fontSize: 12,fontWeight: FontWeight.w700))),
                          Text(snapshot.data.documents[index]['weight'].toString(),
                          style: TextStyle(fontFamily: 'Roboto',fontSize: 15,color: Colors.green))
                        ]),
                        VerticalDivider(color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  )
                ),
              ),
            );
          }));
         }else{
           return SizedBox.shrink();
         }
       }
     );
  }
  addWeight(){
    showDialog(
      context: context,
        builder: (BuildContext context) => AlertDialog(
        title: Center(
          child: const Text('UZITO',
          style: TextStyle(fontWeight: FontWeight.w400,color: Colors.green,fontFamily: 'Noto',fontSize:20 )),
        ),
        content: Material(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   height: 30,
                  //   child: buildWeekRow()),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                          maxLines: 1,
                          cursorColor: Colors.green,
                          style: TextStyle(
                              color: Colors.green,
                              fontFamily: 'CustomIcons',
                              fontWeight: FontWeight.w500,
                              decorationColor: Colors.white),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tafadhali jaza mwezi';
                            }else if(value.length> 1){
                              return 'Maxmum 1';
                            } else {
                              return null;
                            }
                          },
                          controller: monthController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green[400])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green[400],
                            )),
                            // labelText: "Month",
                            hintText: "Mwezi mfano 1 au 2",
                            fillColor: Color(0xFFFFC107),
                            focusColor: Color(0xFFFFC107),
                            hoverColor: Color(0xFFFFC107),
                          ),
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          onChanged: (input) => month = input),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: TextFormField(
                          maxLines: 1,
                          cursorColor: Colors.green,
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'CustomIcons',
                              decorationColor: Colors.white),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Tafadhali jaza uzito';
                            } else {
                              return null;
                            }
                          },
                          controller: weightController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green[400])),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green[400],
                            )),
                            // labelText: "Weight",
                            hintText: "Uzito kwa Kg",
                            fillColor: Color(0xFFFFC107),
                            focusColor: Color(0xFFFFC107),
                            hoverColor: Color(0xFFFFC107),
                          ),
                          obscureText: false,
                          keyboardType: TextInputType.number,
                          onChanged: (input) => weight = input),
                    ),
                  ),
                  GestureDetector(
                    onTap: _submit,
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      color: Colors.green[400],
                      child: isLoading? CircularProgressIndicator() : Text('Save',
                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white,fontFamily: 'Noto')),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Theme.of(context).primaryColor,
            child: const Text('Cancel',
            style: TextStyle(fontWeight: FontWeight.w600,color: Colors.green,fontFamily: 'Noto')),
          ),
        ],
      ),
            );
  }
  Widget _buildChart(BuildContext context, List<Sales> saledata) {
    mydata = saledata;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                height: 100,
                // decoration: BoxDecoration(
                //   border: Border.all(color: Colors.white)
                // ),
                child: uzito()
              ),
              Expanded(
                child: charts.LineChart(_seriesBarData,
                    animate: true,
                    animationDuration: Duration(seconds:5),
                    domainAxis: new charts.AxisSpec<num>(
                      renderSpec: new charts.SmallTickRendererSpec(

                      labelStyle: new charts.TextStyleSpec(
                      fontSize: 18, // size in Pts.
                      color: charts.MaterialPalette.black
                      ),

                      axisLineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.black),
                  // Change the line colors to match text color.
                      lineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.black)
                      )
                    ),
                    primaryMeasureAxis: new charts.NumericAxisSpec(
                    renderSpec: new charts.GridlineRendererSpec(
                      // Tick and Label styling here.
                    labelStyle: new charts.TextStyleSpec(
                      fontSize: 18, // size in Pts.
                      color: charts.MaterialPalette.black),

                    // Change the line colors to match text color.
                    lineStyle: new charts.LineStyleSpec(
                        color: charts.MaterialPalette.black)
                    )),
                     behaviors: [
                      // new charts.DatumLegend(
                      //   desiredMaxRows: 3,
                      //   entryTextStyle: charts.TextStyleSpec(
                      //       color: charts.MaterialPalette.green.shadeDefault,
                      //       fontFamily: 'Noto',
                      //       fontSize: 10),
                      // )
                    ],
                  ),
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore
        .instance
        .collection('weight')
        .document(this.widget.currentUser.mobileNumber)
        .collection('current')
        .orderBy('month',descending: false)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text('Java Uzito kuona Chati',
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.grey[800],fontFamily: 'Noto')),
          );
        }else if(snapshot.data.documents.length< 1) {
          return Center(
            child: Text('Java Uzito kuona Chati',
            style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17,color: Colors.grey[800],fontFamily: 'Noto')),
          );
        } else {
          List<Sales> sales = snapshot.data.documents
              .map((documentSnapshot) => Sales.fromMap(documentSnapshot.data))
              .toList();
          return _buildChart(context, sales);
        }
      },
    );
  }


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:  CustomAppBar(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: addWeight,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Ongeza Uzito',style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.green[400]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                ),
                Text('UZITO',
                style: TextStyle(fontWeight: FontWeight.w400,color: Colors.green[400],fontSize: 20,fontFamily: 'CustomIcons')),
                GestureDetector(
                  onTap: (){
                    showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text('Futa Data',
                      style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[800],fontFamily: 'Noto',fontSize: 20)),
                      content: Text('Una Uhakika?',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.green[400],fontFamily: 'Noto')),
                      actions: [
                        FlatButton(
                          onPressed:()=> Navigator.pop(context),
                          child: Text('Hapana',style: TextStyle(fontWeight: FontWeight.w500,color: Colors.grey[800],fontFamily: 'Noto'))),
                          FlatButton(
                          onPressed:(){
                            Firestore
                            .instance
                            .collection('weight')
                            .document(this.widget.currentUser.mobileNumber)
                            .collection('current')
                            .getDocuments().then((snapshot) {
                              List<DocumentSnapshot> allDocs = snapshot.documents;
                              for (DocumentSnapshot ds in allDocs){
                                ds.reference.delete()
                                .then((value){
                                  Navigator.pop(context);
                                });
                              }
                            });
                          },
                          child: Text('Ndio',style: TextStyle(fontWeight: FontWeight.w500,color:Colors.grey[800],fontFamily: 'Noto')))
                      ],
                    ));
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Futa Data',style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                        color: Colors.green[400]
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                  ),
                )
              ],
            ),
          )),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:  _buildBody(context),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: addWeight,
          child: Icon(Icons.add),
          backgroundColor: Colors.green[400],
        ),
      ),
    );
  }
}
