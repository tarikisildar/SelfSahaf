import 'package:flutter/material.dart';
import 'package:selfsahaf/views/page_classes/main_page/home_page_carousel.dart';

class BookProfile extends StatefulWidget {
  @override
  _BookProfileState createState() => _BookProfileState();
}

class _BookProfileState extends State<BookProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        leading: InkWell(
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Container(
            height: 50, child: Image.asset("images/logo_white/logo_white.png")),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {})
        ],
      ),
      body: Center(
        child: Container(
          color: Color(0xffe65100),
          child: Column(
            children: <Widget>[
              HomePageCarousel(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 20,
                      child: Container(
                        width: double.maxFinite,
                        height: 45,
                        child: Center(
                            child: Text(
                          "Yavuz ne ile Yasar Ne ile Yasamaz",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    ),
                    Expanded(flex: 2, child: SizedBox()),
                    Expanded(
                      flex: 6,
                      child: Container(
                        width: double.maxFinite,
                        height: 45,
                        child: Center(
                            child: Text(
                          "120 TL",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 3.0,
                color: Colors.white,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  "Yazar Adi: ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text("Yavuz Guler",style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: double.maxFinite,
                          height: 45,
                          child: Center(
                              child: Text(
                            "Yayinevi Adi",
                            style: TextStyle(color: Color(0xffe65100)),
                          )),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          width: double.maxFinite,
                          height: 120,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: SingleChildScrollView(
                                        child: Text(
                                      """İSTİKLÂL MARŞI
  -Kahraman OrdumuzaKorkma, sönmez bu şafaklarda yüzen al sancak;
  Sönmeden yurdumun üstünde tüten en son ocak.
  O benim milletimin yıldızıdır, parlayacak;
  O benimdir, o benim milletimindir ancak.
  Çatma, kurban olayım çehreni ey nazlı hilâl!
  Kahraman ırkıma bir gül… ne bu şiddet bu celâl?
  Sana olmaz dökülen kanlarımız sonra helâl,
  Hakkıdır, Hakk’a tapan, milletimin istiklâl.
  Ben ezelden beridir hür yaşadım, hür yaşarım.
  Hangi çılgın bana zincir vuracakmış? Şaşarım!
  Kükremiş sel gibiyim; bendimi çiğner, aşarım;
  Yırtarım dağları, enginlere sığmam, taşarım.
  Garb’ın âfâkını sarmışsa çelik zırhlı duvar;
  Benim iman dolu göğsüm gibi serhaddim var.
  Ulusun, korkma! Nasıl böyle bir îmânı boğar,
  "Medeniyet!" dediğin tek dişi kalmış canavar?
  Arkadaş! Yurduma alçakları uğratma sakın;
  Siper et gövdeni, dursun bu hayâsızca akın.
  Doğacaktır sana va’dettiği günler Hakk’ın…
  Kim bilir, belki yarın… belki yarından da yakın.
  Bastığın yerleri "toprak!" diyerek geçme, tanı!
  Düşün altındaki binlerce kefensiz yatanı.
  Sen şehîd oğlusun, incitme, yazıktır atanı;
  Verme, dünyâları alsan da, bu cennet vatanı.
  Kim bu cennet vatanın uğruna olmaz ki fedâ?
  Şühedâ fışkıracak, toprağı sıksan şühedâ!
  Cânı, cânânı, bütün varımı alsın da Hudâ,
  Etmesin tek vatanımdan beni dünyâda cüdâ.
  Ruhumun senden, İlâhî, şudur ancak emeli:
  Değmesin ma’bedimin göğsüne nâ-mahrem eli!
  Bu ezanlar-ki şehâdetleri dînin temeliEbedî yurdumun üstünde benim inlemeli
  O zaman vecd ile bin secde eder –varsa- taşım;
  Her cerîhamdan, İlâhî, boşanıp kanlı yaşım,
  Fışkırır rûh-i mücerred gibi yerden na’şım;
  O zaman yükselerek Arş’a değer, belki başım.
  Dalgalan sen de şafaklar gibi ey şanlı hilâl;
  Olsun artık dökülen kanlarımın hepsi helâl.
  Ebediyen sana yok, ırkıma yok izmihlâl:
  Hakkıdır, hür yaşamış bayrağımın hürriyet;
  Hakkıdır, Hakk’a tapan milletimin istiklâl!
  MEHMET AKİF ERSOY""",
                                      style:
                                          TextStyle(color: Color(0xffe65100)),
                                    )),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
