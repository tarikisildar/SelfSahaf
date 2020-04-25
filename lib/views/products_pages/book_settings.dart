import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:selfsahaf/controller/user_controller.dart';
import 'package:selfsahaf/models/book.dart';
import 'package:selfsahaf/views/registration/input_field.dart';

class BookSettingsPage extends StatefulWidget {
  final Book selectedBook;
  BookSettingsPage({@required this.selectedBook});
  @override
  _BookSettingsPage createState() => new _BookSettingsPage();
}

class _BookSettingsPage extends State<BookSettingsPage> {
  String _name,_surname,_email,_phoneNumber;
  final _sellerController=TextEditingController();
  bool _checkSeller=false;
  AuthService userService= GetIt.I<AuthService>();
  TextEditingController _bookNameController;
  @override
  void initState() { 
    this._name=userService.getUser().name;
    this._surname=userService.getUser().surname;
    this._email=userService.getUser().email;
    this._phoneNumber=userService.getUser().phoneNumber;
    _bookNameController= new TextEditingController(text: widget.selectedBook.name);
    
  }

  String bookNameValidation(String bookName) {
    bool booknameValid;
    if (bookName == "" || bookName == " ")
      return "Invalid Book Name";
    else
      return null;
  }
  String priceValidation(String price){
    if(price.length == 0 || !price.contains(RegExp(r'[A-Za-z]'))) return "Invalid Price";
    else return null;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {},
        child: Icon(
          Icons.save,
          color: Theme.of(context).primaryColor,
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: InputField(
                      controller: _bookNameController,
                      validation: null,
                    ),
                    ),
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
                    child: Icon(Icons.party_mode, color:Colors.white, size: 30,),
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
                    child: Center( child: Text(_email,style:TextStyle(color: Theme.of(context).primaryColor ,fontSize: 25 ) , )),
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
          ),
        )
      ) ,
    );
  }
}
