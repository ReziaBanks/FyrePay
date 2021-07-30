import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class NewTabPage extends StatefulWidget {
  const NewTabPage({Key? key}) : super(key: key);

  @override
  _NewTabPageState createState() => _NewTabPageState();
}

class _NewTabPageState extends State<NewTabPage> {
  ZoomDrawerController _zoomDrawerController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomDrawer(
        controller: _zoomDrawerController,
        style: DrawerStyle.DefaultStyle,
        menuScreen: MenuScreen(
          DataSea.mainMenu,
          callback: (index){},
          current: 0,
        ),
        mainScreen: MainScreen(),
        borderRadius: 24.0,
        showShadow: true,
        angle: 0,
        backgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width*.65,
        openCurve: Curves.fastOutSlowIn,
        closeCurve: Curves.bounceIn,
      ),
    );
  }
}

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DrawerState>(
      valueListenable: ZoomDrawer.of(context)!.stateNotifier!,
      builder: (context, state, child) {
        return AbsorbPointer(
          absorbing: state != DrawerState.closed,
          child: child,
        );
      },
      child: GestureDetector(
        child: PageStructure(),
        onPanUpdate: (details) {
          if (details.delta.dx < 6 || details.delta.dx < -6) {
            ZoomDrawer.of(context)!.toggle();
          }
        },
      ),
    );
  }
}

class PageStructure extends StatelessWidget {
  final String? title;
  final Widget? child;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;

  const PageStructure({
    Key? key,
    this.title,
    this.child,
    this.actions,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).accentColor;
    final angle = 0;
    // final _currentPage = context.select<MenuProvider, int>((provider) => provider.currentPage);
    final container = Container(
      alignment: Alignment.center,
      color: Colors.white,
      child:
      Text('A Page'),
    );
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Hello World'
        ),
        leading: Transform.rotate(
          angle: 180,
          child: IconButton(
            icon: Icon(
              Icons.menu,
            ),
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
          ),
        ),
        actions: actions,
      ),
      // bottomNavBar: PlatformNavBar(
      //   material: (_, __) => MaterialNavBarData(
      //     selectedLabelStyle: TextStyle(color: color),
      //   ),
      //   currentIndex: _currentPage,
      //   itemChanged: (index) => Provider.of<MenuProvider>(context, listen: false).updateCurrentPage(index),
      //   items: HomeScreen.mainMenu
      //       .map(
      //         (item) => BottomNavigationBarItem(
      //       label: item.title,
      //       icon: Icon(
      //         item.icon,
      //         color: color,
      //       ),
      //     ),
      //   )
      //       .toList(),
      // ),
      body: kIsWeb
          ? container
          : Platform.isAndroid
          ? container
          : SafeArea(
        child: container,
      ),
    );
  }
}

class DataSea{
  static List<MenuItem> mainMenu = [
    MenuItem("payment", Icons.payment, 0),
    MenuItem("promos", Icons.card_giftcard, 1),
    MenuItem("notifications", Icons.notifications, 2),
    MenuItem("help", Icons.help, 3),
    MenuItem("about_us", Icons.info_outline, 4),
  ];
}

class MenuItem {
  final String title;
  final IconData icon;
  final int index;

  const MenuItem(this.title, this.icon, this.index);
}

class MenuScreen extends StatefulWidget {
  final List<MenuItem> mainMenu;
  final Function(int)? callback;
  final int? current;

  MenuScreen(
      this.mainMenu, {
        Key? key,
        this.callback,
        this.current,
      });

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final widthBox = SizedBox(
    width: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    final TextStyle androidStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white);
    final TextStyle iosStyle = const TextStyle(color: Colors.white);
    final style = kIsWeb
        ? androidStyle
        : Platform.isAndroid
        ? androidStyle
        : iosStyle;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).primaryColor,
              Colors.indigo,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0, left: 24.0, right: 24.0),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 36.0, left: 24.0, right: 24.0),
                child: Text(
                  "name",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              // Selector<MenuProvider, int>(
              //   selector: (_, provider) => provider.currentPage,
              //   builder: (_, index, __) => Column(
              //     mainAxisSize: MainAxisSize.min,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       ...widget.mainMenu
              //           .map((item) => MenuItemWidget(
              //         key: Key(item.index.toString()),
              //         item: item,
              //         callback: widget.callback,
              //         widthBox: widthBox,
              //         style: style,
              //         selected: index == item.index,
              //       ))
              //           .toList()
              //     ],
              //   ),
              // ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ...widget.mainMenu
                      .map((item) => MenuItemWidget(
                    key: Key(item.index.toString()),
                    item: item,
                    callback: widget.callback,
                    widthBox: widthBox,
                    style: style,
                    selected: false,
                  ))
                      .toList()
                ],
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                child: OutlinedButton(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ("logout"),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => print("Pressed !"),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final MenuItem? item;
  final Widget? widthBox;
  final TextStyle? style;
  final Function? callback;
  final bool? selected;

  final white = Colors.white;

  const MenuItemWidget({
    Key? key,
    this.item,
    this.widthBox,
    this.style,
    this.callback,
    this.selected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => callback!(item!.index),
      style: TextButton.styleFrom(
        primary: selected! ? Color(0x44000000) : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            item!.icon,
            color: white,
            size: 24,
          ),
          widthBox!,
          Expanded(
            child: Text(
              item!.title,
              style: style,
            ),
          )
        ],
      ),
    );
  }
}