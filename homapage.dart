import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intel/components/CardGridNav.dart';
import 'package:intel/components/webview.dart';
import 'package:intel/dao/home_dao.dart';
import 'package:intel/model/common_model.dart';
import 'package:intel/model/home_model.dart';
import 'package:intel/components/grid_nav.dart';
import 'package:intel/model/grid_nav_model.dart';
import 'package:intel/components/sub_nav.dart';
import 'package:intel/components/sales_box.dart';
import 'package:intel/model/sales_box_model.dart';
import 'package:intel/components/loading_widget.dart';
import 'package:intel/components/search_bar.dart';
import 'package:intel/pages/search_page.dart';
import 'package:intel/pages/speak_page.dart';
import 'dart:convert';
import 'dart:async';

const APPBAR_SCROLL_OFFSET = 100;


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  double appBarOpacity = 0;

  String resultString = "";

  List<CommonModel> gridNavList;
  List<CommonModel> subNavList;
  SalesBoxModel salesBoxModel;
  GridNavModel girdModeList;
  List<CommonModel> bannerList;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  // implement wantKeepAlive true 
  bool get wantKeepAlive => true;

  Future<Null> _handleRefresh() async {
  
    
    try {
      HomeModel model = await HomeDao.fetch();
      setState(() {
        gridNavList = model.localNavList;
        girdModeList = model.gridNav;
        subNavList = model.subNavList;
        salesBoxModel = model.salesBox;
        bannerList = model.bannerList;
        isLoading = false;
        print(json.encode(model.localNavList));
      });
    } catch (e) {
      print(e.toString());
      setState(() {
        isLoading = false;
      });
    }
    return null;
  }

  
  _scroll(offest) {
    double alpha = offest / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarOpacity = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        //appbar
        body: LoadingWidget(
          isLoading: isLoading,
          child: Stack(
            children: <Widget>[
              //view 
              
              MediaQuery.removePadding(
                removeTop: true, // padding
                context: context,
                child: RefreshIndicator(
                    child: NotificationListener(
                      // list view
                      onNotification: (scrollNotification) {

                        if (scrollNotification is ScrollUpdateNotification &&
                            scrollNotification.depth == 0) {
                          
                          _scroll(scrollNotification.metrics.pixels);
                        }
                      },
                      child: _buildListView,
                    ),
                    onRefresh: _handleRefresh),
              ),
              //bar
              _buildTopBar(appBarOpacity),
            ],
          ),
        ));
  }

  ///bar
  Widget _buildTopBar(appBarOpacity) {
    return Column(
      children: <Widget>[
        Container(
          
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0x66000000), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )),
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            height: 80,
            decoration: BoxDecoration(
              color:
                  Color.fromARGB((appBarOpacity * 255).toInt(), 255, 255, 255),
            ),
            child: SearchBar(
              searchType:
                  appBarOpacity > 0.2 ? SearchType.homeLight : SearchType.home,
              inputBoxClick: _jumpToSearch,
              speakClick: _jumpToSpeak,
              defultText: 'jump',
              leftButtonClick: () {},
              rightButtonClick: () {},
            ),
          ),
        ),

        ///
        Container(
          height: appBarOpacity > 0.2 ? 0.5 : 0,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)],
          ),
        )
      ],
    );
  }

  _jumpToSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(
              hint: 'Internet celebrity check-in locations, attractions, hotels, food',
            ),
      ),
    );
  }

   _jumpToSpeak() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SpeakPage()));
  }

  
  ListView get _buildListView {
    return ListView(
      children: <Widget>[
        _buildBanner,
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: GridNav(gridNavList: gridNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: CardGridNav(
            gridNavModel: girdModeList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SubNav(
            subNavList: subNavList,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 4),
          child: SalesBox(
            salesBoxModel: salesBoxModel,
          ),
        ),
      ],
    );
  }

  /// banner
  Widget get _buildBanner {
    return Container(
      height: 160.0,
      child: Swiper(
        itemCount: bannerList == null ? 0 : bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebView(
                            url: model.url,
                            title: model.title,
                            statusBarColor: model.statusBarColor,
                            hideAppBar: model.hideAppBar,
                          )));
            },
            child: Image.network(bannerList[index].icon,
                fit: BoxFit.fill), ,
          );
        },
        pagination: SwiperPagination(), 
      ),
    );
  }
}
