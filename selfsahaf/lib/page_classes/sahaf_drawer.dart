import 'package:flutter/material.dart';


// Bu widget aynı scaffold gibi kullanabilirsin drawer ve appBar aliyor ama zorunlu degil
// Tek zorunlu parametresi body mantiken scaffoldlerin hepsinin bodysi oldugu icin. Ornek kullanim:
// ScaffoldWithBackground(body: Center(child: TextField(),),);
class SahafDrawer extends StatelessWidget {
  final Widget body;
  Widget leadingIcon;
  final Text title;
  final bool isDrawerOn;


   SahafDrawer(
      {@required this.body,
      this.leadingIcon,
      this.title,
      @required this.isDrawerOn})
      : assert(body != null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: !isDrawerOn
          ? null
          : Drawer(
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(47, 19, 8, 1),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 255,
                      child: DrawerHeader(
                        padding: EdgeInsets.only(top:10,bottom:0),
                        margin: EdgeInsets.only(left: 8, top: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[

                            Container(
                                child: Image.asset('images/logo_white/logo_white.png'),
                                height: 150,
                                width: 150),
                                
                            Padding(
                              padding: const EdgeInsets.only(left:13.0),
                              child: Text('İsim Soyisim',
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .copyWith(fontSize: 24)),
                            ),
                            SizedBox(
                              height: 13,
                            ),
                            Container(
                              height: 30,
                              child: Container(
                                child: GestureDetector(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left:13.0),
                                    child: Text('Ayarlar',
                                        style: Theme.of(context)
                                            .textTheme
                                            .body2
                                            .copyWith(fontSize: 18)),
                                  ),
                                  onTap: () {}
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromRGBO(47, 19, 8, 1),
        ),
        elevation: 0.0,
        centerTitle: true,
        leading: leadingIcon,
        title: title,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: body,
      ),
    );
  }

  Widget _createDrawerItem(
      {@required IconData icon,
      @required String text,
      @required GestureTapCallback onTap,
      @required BuildContext context}) {
    //assert(icon != null && text != null && onTap != null && context != null);
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          Padding(
            child: Text(text,
                style:
                    Theme.of(context).textTheme.body2.copyWith(fontSize: 16.0)),
            padding: EdgeInsets.only(left: 8.0),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
