import 'dart:math' as math;

import 'package:flutter_web/material.dart';
import 'package:flutter_web/widgets.dart';

import 'session.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController menuController;
  Animation<Offset> menuPosition;

  @override
  void initState() {
    super.initState();
    menuController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    menuPosition = Tween<Offset>(begin: Offset(1.0, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: menuController, curve: Curves.easeIn));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  floating: true,
                  pinned: true,
                  flexibleSpace: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(width: 12.0),
                      Image.asset("img/ineat-logo-full.png"),
                      Spacer(),
                      FlatButton(
                        child: Icon(
                          Icons.menu,
                          size: 40,
                          color: Colors.white,
                        ),
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          menuController.forward();
                        },
                      )
                    ],
                  ),
                  expandedHeight: 90,
                ),
                SliverOverlapAbsorber(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  child: SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Image.asset(
                          "img/flap-french-tech.png",
                        ),
                      ),
                      minHeight: 150,
                      maxHeight: 150,
                    ),
                  ),
                ),
              ];
            },
            body: Stack(
              children: <Widget>[
                SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Header(),
                      QuiSommesNous(),
                      AgenceHybride(),
                      NosMetiers(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SlideTransition(
            child: Menu(
              onCloseTap: () {
                menuController.reverse();
              },
            ),
            position: menuPosition,
          ),
        ],
      ),
    );
  }
}

class Menu extends StatelessWidget {
  final VoidCallback onCloseTap;

  const Menu({Key key, this.onCloseTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: false,
      child: Stack(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor.withAlpha(220),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MenuButton(text: "Groupe"),
                    MenuButton(text: "Nos Métiers"),
                    MenuButton(text: "Nos Formations"),
                    MenuButton(text: "Recrutement"),
                    MenuButton(text: "Nos Références"),
                    MenuButton(text: "Blog"),
                    MenuButton(text: "Contact"),
                  ],
                ),
                Image.asset(
                  "img/poulpy.png",
                  fit: BoxFit.cover,
                  width: 250,
                ),
              ],
            ),
          ),
          Positioned(
            child: FlatButton(
              child: Icon(
                Icons.close,
                size: 40,
                color: Colors.white,
              ),
              highlightColor: Colors.transparent,
              onPressed: this.onCloseTap,
            ),
            width: 100,
            height: 100,
            top: 0,
            right: 0,
          )
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String text;

  const MenuButton({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        this.text,
        style: TextStyle(fontSize: 23.0),
      ),
      onPressed: () {},
      textColor: Colors.white,
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fontSize = 35.0;
    return Material(
      textStyle: TextStyle(
          color: Colors.white, fontSize: fontSize, fontWeight: FontWeight.bold),
      child: Container(
        height: MediaQuery.of(context).size.height - 80,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "img/background-jobs.jpeg",
              fit: BoxFit.cover,
            ),
            Container(
              alignment: Alignment.center,
              color: Theme.of(context).primaryColor.withAlpha(100),
              child: FittedBox(
                alignment: Alignment.center,
                child: MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.3),
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text("INEAT"),
                            Text("NEW TECHNOLOGY"),
                            Text("NEW LEADERS"),
                            Text(
                              "#STARTUP #ETI #PME #GRANDCOMPTE",
                              style: TextStyle(
                                  color: Colors.black, fontSize: fontSize / 2),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Image.asset(
                          "img/poulpy.png",
                          fit: BoxFit.cover,
                          width: 250,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuiSommesNous extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Session(
      primary: false,
      child: GridSession(
        firstChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "QUI SOMMES-NOUS ?",
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Depuis plus de 10 ans nous sommes engagés sur le terrain de jeu de l’Innovation, au service des nouvelles expériences. Nous accompagnons les grands comptes, ETI, PME et Start up dans la conception et la mise en œuvre de solutions digitales. \n\nNotre marque de fabrique : concevoir et animer durablement une Expérience Client(s) Unique grâce à l’association du savoir-faire technologique, aux stratégies métier, marketing et SI.",
            ),
          ],
        ),
        secondChild: Image.asset(
          "img/qui-sommes-nous.png",
          fit: BoxFit.scaleDown,
        ),
        isVerticalReversed: false,
      ),
    );
  }
}

class AgenceHybride extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Session(
      primary: false,
      child: GridSession(
        firstChild: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "AGENCE HYBRIDE",
              textAlign: TextAlign.end,
              style: Theme.of(context)
                  .textTheme
                  .display2
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Véritable carrefour des savoirs numériques, INEAT répond à tous vos projets digitaux. Nous alignons des stratégies, pour co-créer, co-animer et co-designer votre réussite et innover en continu votre experience ou celle de vos clients.",
              textAlign: TextAlign.end,
            ),
          ],
        ),
        secondChild: Image.asset(
          "img/qui-sommes-nous.png",
          fit: BoxFit.scaleDown,
        ),
        isVerticalReversed: false,
      ),
    );
  }
}

class NosMetiers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Session(
      primary: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 150),
        child: GridSession(
          firstChild: Image.asset(
            "img/nos-metiers.png",
            fit: BoxFit.scaleDown,
          ),
          secondChild: Column(
            children: <Widget>[
              Text(
                "Découvrez",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "NOS MÉTIERS",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .display2
                    .copyWith(color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "INEAT répond à tout un panel de services pour mener à bien votre projet. Que vous souhaitiez créer ou redesigner votre site web vitrine ou e-commerce, développer une application mobile, un CRM, ou encore mettre en place une stratégie client ou marketing, … Nous adaptons nos savoir-faire, pour faire de votre projet UNE RÉUSSITE",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          isVerticalReversed: false,
        ),
      ),
    );
  }
}
