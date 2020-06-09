import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:Selfsahaf/controller/user_controller.dart';
import 'package:Selfsahaf/models/address.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/address_widget.dart';
import 'package:Selfsahaf/views/customer_view/profile_pages/addAddress.dart';

class AdressesPage extends StatefulWidget {
  // ExamplePage({ Key key }) : super(key: key);
  @override
  _AdressesPage createState() => new _AdressesPage();
}

    
class _AdressesPage extends State<AdressesPage> {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  AuthService userService = GetIt.I<AuthService>();
  List<Address> _addresses=new List();
  @override
  void initState() { 
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
    _getAddresses();
  }
  _getAddresses() async {
    userService.getUserAddresses().then((value) {
      setState(() {
        this._addresses = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement build
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text("Address informations"),
                    content: AddAddress( addType: 0,),
                  )).then((value){
                    _getAddresses();
                  }),
          backgroundColor: Colors.white,
          child: Icon(Icons.add),
        ),
        body: (_addresses == null||_addresses.length==0)
            ? Center(
                child: Text("No address",style: TextStyle(color:Colors.white, fontSize: 25 ),),
              )
            :RefreshIndicator(
            onRefresh: () => _getAddresses(),
            key: _refreshIndicatorKey,
            child: ListView.builder(
              
                itemBuilder: (BuildContext context, index) {
                  return AddressWidget(
                    addressID: _addresses[index].addressID,
                    addressLine: _addresses[index].addressLine,
                    addressName: _addresses[index].addressName,
                    city: _addresses[index].city,
                    country: _addresses[index].country,
                    postalCode: _addresses[index].postalCode,
                  );
                },
                itemCount: _addresses.length,
              )));
  }
}
