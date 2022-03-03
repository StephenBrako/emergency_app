import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ghana/SizeConfig.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ghana/contactpage/books_api2.dart';
import 'package:ghana/contactpage/book.dart';


class HomePage extends StatefulWidget {
 // final Map<String, List> newsData;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final Set<Factory> gestureRecognizers = [Factory(() => EagerGestureRecognizer())].toSet();
  //Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController _controller;
  UniqueKey _key = UniqueKey();

  List<Book> books = [];
  String query = '';
  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;
  Map<String, List> _newsData = Map<String, List>();
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    init();
    _scrollController = ScrollController();
    _tabController = TabController(length: 10, vsync: this);
    _tabController.addListener(_smoothScrollToTop);
    setState(() {
  //    _newsData = Map.from(widget.newsData);
    });
  }

  _smoothScrollToTop() {
    _scrollController.animateTo(
      0,
      duration: Duration(microseconds: 300),
      curve: Curves.ease,
    );
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }
  Timer debouncer;


  @override
  void dispose() {
    debouncer?.cancel();
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    //_controller = new Completer<WebViewController>();

    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (context, value) {
        return [


          SliverAppBar(
            title: Text(
              "Browse Shops",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black87,
                fontFamily: "Times",
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            )
            ,
            actions: [

              IconButton(
                  icon: Icon(
                    Icons.notifications_active_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                   // _controller.goBack();
                  })
            ],
            floating: true,
            expandedHeight: 72,
            //toolbarHeight: 35,
            pinned: true,
            bottom:  TabBar(
                  labelPadding: EdgeInsets.only(right: 15),
                  indicatorSize: TabBarIndicatorSize.label,
                  controller: _tabController,
                  isScrollable: true,
                  indicator: UnderlineTabIndicator(),
                  labelColor: Colors.black,
                  labelStyle: TextStyle(
                      fontFamily: "Avenir",
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  unselectedLabelColor: Colors.black45,
                  unselectedLabelStyle: TextStyle(
                      fontFamily: "Avenir",
                      fontSize: 20,
                      fontWeight: FontWeight.normal),
                onTap: (index) {


                },

                  tabs: List.generate(books.length,
                          (index) => Text(books[index].name))),

          ),
        ];
      },

      body: TabBarView(physics:ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          controller: _tabController,
          children:List.generate(
            books.length,
                (index) {


              return tabbar(value: books[index].site);
            },
          )),


    );
  }

  void debounce(
      VoidCallback callback, {
        Duration duration = const Duration(milliseconds: 1000),
      }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }
  Future init() async {
    final books = await BooksApi.getBooks(query);

    setState(() => this.books = books);
  }

}
class tabbar extends StatefulWidget {
  final Map<String, List> newsData;
  final String value;
  const tabbar({Key key, this.newsData,this.value}) : super(key: key);
  @override
  _tabbarState createState() => _tabbarState();
}

class _tabbarState extends State<tabbar>  with AutomaticKeepAliveClientMixin {
  WebViewController _controller;
  final Set<Factory> gestureRecognizers = [Factory(() => EagerGestureRecognizer())].toSet();
  UniqueKey _key = UniqueKey();
  UniqueKey _key1 = UniqueKey();
  UniqueKey _key2 = UniqueKey();
  UniqueKey _key3 = UniqueKey();
  UniqueKey _key4 = UniqueKey();
  UniqueKey _key5 = UniqueKey();
  WebViewController _controller1;
  WebViewController _controller2;
  WebViewController _controller3;
  WebViewController _controller4;
  WebViewController _controller5;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var site = widget.value;
    return Scaffold(
      body:
      WebView(
        key: _key,
        initialUrl: site,
        javascriptMode: JavascriptMode.unrestricted,
        gestureRecognizers: gestureRecognizers,
        onWebViewCreated: (WebViewController webViewController) {
          _controller = webViewController;
        },

      ),

      floatingActionButton:  Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          FloatingActionButton(

              backgroundColor: Colors.black.withOpacity(0.8),
              child: Icon(Icons.arrow_back_ios,color: Colors.white,size: 30,),
              onPressed: () {
                _controller.goBack();
              }),
          SizedBox(width: SizeConfig.safeBlockHorizontal*1,),
          FloatingActionButton(
              backgroundColor: Colors.black.withOpacity(0.8),
              child: Icon(Icons.arrow_forward_ios,color: Colors.white,size: 30,),
              onPressed: () {
                _controller.goForward();
              }),

        ],
      ),

    ) ;
  }
  @override
  bool get wantKeepAlive => true;
}

