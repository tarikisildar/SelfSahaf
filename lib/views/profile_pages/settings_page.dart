import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _SettingsPage createState() => new _SettingsPage();
}

class _SettingsPage extends State<SettingsPage> {
  String _name="Yavuz",_surname="Güler",_email="asd",_phoneNumber="2314546654";
  final _sellerController=TextEditingController();
  bool _checkSeller=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Image.asset("images/logo_white/logo_white.png"),
     
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                  alignment: Alignment.center,
                    
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  width: 250,
                  color: Colors.white,
                  child: Center( child: Text("$_name $_surname",style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
                 )),
               Expanded(
                 flex: 1,
                 child: InkWell(
                  child: Icon(Icons.edit, color:Colors.white, size: 50,),
                  onTap: (){
                    print("sa");
                  },
                ))
                
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                  alignment: Alignment.center,
                   
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: 250,
                  color: Colors.white,
                  child: Center( child: Text("Change Photo",style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
                 )),
               Expanded(
                 flex: 1,
                 child: InkWell(
                  child: Icon(Icons.party_mode, color:Colors.white, size: 50,),
                  onTap: (){
                    print("sa");
                  },
                ))
                
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                  alignment: Alignment.center,
                    
          
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: 250,
                  color: Colors.white,
                  child: Center( child: Text("Change Email",style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
                 )),
               Expanded(
                 flex: 1,
                 child: InkWell(
                  child: Icon(Icons.edit, color:Colors.white, size: 50,),
                  onTap: (){
                    print("sa");
                  },
                ))
                
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                  alignment: Alignment.center,
                    
                  
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: 250,
                  color: Colors.white,
                  child: Center( child: Text("Change Password",style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
                 )),
               Expanded(
                 flex: 1,
                 child: InkWell(
                  child: Icon(Icons.edit, color:Colors.white, size: 50,),
                  onTap: (){
                    print("sa");
                  },
                ))
                
              ],
            ),Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                  alignment: Alignment.center,
                    
                  
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: 250,
                  color: Colors.white,
                  child: Center( child: Text("Seller",style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
                 )),
               Expanded(
                 flex: 1,
                 child: InkWell(
                  child: Icon(Icons.add_circle, color:Colors.white, size: 50,),
                  onTap: (){
                    return showDialog(context: context, builder: (context){
                      return AlertDialog(
                        title: Text("Seller's address"),
                        content: TextFormField( 
                          controller:  _sellerController,
                          decoration: InputDecoration(
                            labelText: 'Enter your address'
                          ),

                        ),
                        actions: <Widget>[
                          InkWell(child: Icon( Icons.done, color: Colors.red,size: 50 ) ,
                          onTap: (){
                            if(_sellerController.text==''){
                              print("nah sana");
                            _checkSeller=false;
                             
                            }
                            else{
                              _checkSeller=true;
                              Navigator.of(context).pop();
                              }
                            
                          }                       
                          ,)
                         
                        ],
                      );
                    });
                  },
                ))
                
              ],
            ),Row(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                  alignment: Alignment.center,
                    
                  
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                  width: 250,
                  color: Colors.white,
                  child: Center( child: Text("$_phoneNumber",style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
                 )),
               Expanded(
                 flex: 1,
                 child: InkWell(
                  child: Icon(Icons.edit, color:Colors.white, size: 50,),
                  onTap: (){
                    print("sa");
                  },
                ))
                
              ],
            )
          ],
        )
      ) ,
    );
  }
}
