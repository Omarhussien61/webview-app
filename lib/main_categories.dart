import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:wiyakm/Categories.dart';
import 'package:wiyakm/service/api.dart';

class MainCategoriesPage extends StatefulWidget {
  @override
  _MainCategoriesPageState createState() => _MainCategoriesPageState();
}

class _MainCategoriesPageState extends State<MainCategoriesPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  ScrollController controller = new ScrollController();
  String indexMain = '0';
  int checkboxType = 0;
  Categories? categories;
  @override
  void initState() {
    API(context).get('mobile/categories').then((value) {
      setState(() {
        categories = Categories.fromJson(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var localizationDelegate = LocalizedApp.of(context).delegate;
    //var lang = localizationDelegate.currentLocale.languageCode;
    // final connection = Provider.of<ConnectivityStatus>(context);

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(),
      body: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: categories == null
              ? Container(
                  color: Colors.white,
                  child: Center(child: Image.asset("assets/splash.gif")))
              : categories?.childrenData?.isEmpty == null
                  ? Container(
                      color: Colors.white,
                      child: Center(child: Image.asset("assets/splash.gif")))
                  : Container(
                      height: MediaQuery.of(context).size.height / 1.25,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                            vertical: BorderSide(color: Color(0x11000000))),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                  vertical:
                                      BorderSide(color: Color(0x11000000))),
                            ),
                            child: SingleChildScrollView(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.5,
                                // height: ScreenUtil.getHeight(context) / 1.25,
                                child: Container(
                                  child: ListView.builder(
                                    primary: false,
                                    shrinkWrap: true,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 2),
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: categories?.childrenData?.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool selected = checkboxType == index;

                                      return item(
                                          categories?.childrenData![index],
                                          index,
                                          selected);
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: getList(categories?.childrenData),
                            ),
                          ),
                        ],
                      ),
                    ),
          // ScrollableListTabView(
          //   tabs: categories?.childrenData?.map((e) {
          //   return ScrollableListTab(
          //       tab: ListTab(
          //           label: Text(
          //             "${e.name}",
          //             textAlign: TextAlign.center,
          //             style: TextStyle(fontWeight: FontWeight.w700),
          //           ),activeBackgroundColor: Colors.deepOrangeAccent),
          //       body: (e.childrenData!.isEmpty && (e.image == null || e.image!.isEmpty))
          //           ? null
          //           : ListView(
          //         shrinkWrap: true,
          //         physics: NeverScrollableScrollPhysics(),
          //         children: [
          //           // Banners
          //           //Container(margin: EdgeInsets.symmetric(horizontal: 4), child: Banners(e.image ?? '', isAsset: false)),
          //           // Space
          //           Padding(padding: EdgeInsets.all(5)),
          //
          //           if (e.childrenData!.isEmpty)
          //             SizedBox(
          //               height: MediaQuery.of(context).size.height / 2,
          //             ),
          //
          //           ListView(
          //             physics: NeverScrollableScrollPhysics(),
          //             shrinkWrap: true,
          //             children: e!.childrenData!.map((element) => Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 // Header Text
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Padding(
          //                       padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15, bottom: 5),
          //                       child: Text(
          //                         "${element.name}",
          //                         style: TextStyle(
          //                           fontSize: 12,
          //                           fontWeight: FontWeight.w700,
          //                           color: const Color(0xff333333),
          //                         ),
          //                       ),
          //                     ),
          //                     Padding(
          //                         padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 15, bottom: 5),
          //                         child: GestureDetector(
          //                           onTap: () {
          //                    //         locator<HomeViewModel>().spiderFunction(context, element.id, element.level.toString(), element.parentId.toString());
          //                           },
          //                           child: Wrap(
          //                             crossAxisAlignment: WrapCrossAlignment.center,
          //                             children: [
          //                               Padding(
          //                                 padding: const EdgeInsets.only(top: 3),
          //                                 child: Text("اكثر"),
          //                               ),
          //                               Icon(
          //                                 Icons.arrow_forward_ios_rounded,
          //                                 size: 13,
          //                               ),
          //                             ],
          //                           ),
          //                         )),
          //                   ],
          //                 ),
          //                 Container(
          //                   margin: EdgeInsets.symmetric(horizontal: 4),
          //                   child: element.childrenData!.isEmpty
          //                       ? Row(
          //                     children: [Text(" . . . . ")],
          //                   )
          //                       : GridView.builder(
          //                     physics: NeverScrollableScrollPhysics(),
          //                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //                         crossAxisCount: 3,
          //                         childAspectRatio: 0.75,
          //                         crossAxisSpacing: 4.0,
          //                         mainAxisSpacing: 4.0),
          //                     itemBuilder: (context, i) {
          //                       final data = element.childrenData![i + 1];
          //                       // if(i == 0) return Text('d');
          //                       return Visibility(
          //                         // visible: i != 0 ,
          //                         child: GestureDetector(
          //                           onTap: () {
          //                           //  locator<HomeViewModel>().spiderFunction(context, data.id, data.level.toString(), data.parentId.toString());
          //                             Navigator.pop(context,);
          //                           },
          //                           child: Container(
          //                             child: GridTile(
          //                               child: Card(
          //                                 child: Column(
          //                                   children: [
          //                                     Image.network(
          //                                       data.image ?? '',
          //                                       fit: BoxFit.contain,
          //                                       height: 45,
          //                                       color: Colors.black26,
          //                                       errorBuilder: (context, error, stackTrace) => Image.asset(
          //                                         'assets/images/placeholder.png',color: Colors.white10,
          //                                         fit: BoxFit.cover,
          //                                       ),
          //                                     ),
          //                                     SizedBox(
          //                                       height: 10,
          //                                     ),
          //                                     Container(
          //                                       height: 20,
          //                                       width: MediaQuery.of(context).size.width / 4,
          //                                       child: Text(
          //                                         "${data.name}",
          //                                         maxLines: 2,
          //                                         // maxFontSize: 12,
          //                                        // minFontSize: 6,
          //                                         overflow: TextOverflow.ellipsis,
          //                                         style: TextStyle(
          //                                           fontSize: 10,
          //                                           // color: const Color(0xff333333),
          //                                         ),
          //                                         textAlign: TextAlign.center,
          //                                       ),
          //                                     )
          //                                   ],
          //                                 ),
          //                                 elevation: 0,
          //                                 color: Colors.transparent,
          //                                 margin: EdgeInsets.only(bottom: 20),
          //                               ),
          //                             ),
          //                           ),
          //                         ),
          //                       );
          //                     },
          //                     itemCount: element.childrenData!.length - 1,
          //                     shrinkWrap: true,
          //                   ),
          //                 ),
          //               ],
          //             ))
          //                 .toList(),
          //           )
          //         ],
          //       ));
          // }).toList(),
          // ),
        ),
      ),
    );
  }

  getList(List<Categories>? Categories) {
    return Categories == null
        ? Container()
        : Categories[checkboxType].childrenData == null
            ? Container()
            : Categories[checkboxType].childrenData!.isEmpty
                ? Center(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('لا يوجد اقسام فرعيه '),
                ),)
                : Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: Categories[checkboxType].childrenData?.length,
                      itemBuilder: (BuildContext context, int index) {
                        bool selected = checkboxType == index;
                        return Column(
                          children: [
                            itemcat(Categories[checkboxType].childrenData![index],
                                index, false),
                          ],
                        );
                      },
                    ),
                  );
  }

  item(Categories? categories_item, int index, bool selected) {
    return InkWell(
      onTap: () {
        categories_item!.childrenData!.isEmpty?
        Navigator.pop(context,categories_item?.url): setState(() {
          checkboxType = index;
        });
      },
      child: Container(
        height: 60,
        decoration: BoxDecoration(
            color: !selected ? Colors.white : Color(0x11000000),
            border: Border.symmetric(
                horizontal: BorderSide(
                    color: selected ? Colors.black12 : Color(0x11000000)))),
        child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: 5, color: !selected ? Colors.white : Colors.orange),
            SizedBox(
              width: 2,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 4.2,

              child: Text(
                "${categories_item?.name}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context,categories_item?.url);

                },
                icon: Icon(Icons.remove_red_eye_outlined,color: Color(0xffc8c8c8),))

          ],
        ),
      ),
    );
  }
  itemcat(Categories? categories_item, int index, bool selected) {
    return InkWell(
      onTap: () {
        setState(() {
          checkboxType = index;
        });
      },
      child: Column(
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
                color: !selected ? Colors.white : Color(0x11000000),
                border: Border.symmetric(
                    horizontal: BorderSide(
                        color: selected ? Colors.black12 : Color(0x11000000)))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    width: 8, color: !selected ? Colors.white : Colors.orange),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "${categories_item?.name}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context,categories_item?.url);

                    },
                    icon: Icon(Icons.remove_red_eye_outlined,color: Color(0xffc8c8c8),))
              ],
            ),
          ),
         Padding(
              padding: const EdgeInsets.all(8.0),
              child: categories_item!.childrenData!.isEmpty?Container(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('لا يوجد اقسام فرعيه ',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),): GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 2,vertical: 5),
                physics: NeverScrollableScrollPhysics(),
                itemCount: categories_item?.childrenData!
                    .length,
                itemBuilder:
                    (BuildContext context, int index) {
                  var e = categories_item?.childrenData![index];
                  return InkWell(
                    onTap: () {
                      Navigator.pop(context,e?.url);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 100,
                          decoration:  BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(15)),
                              image: DecorationImage(image: NetworkImage("${e?.image}"),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 5.0,
                                    spreadRadius: 1,
                                    offset: Offset(0.0, 2)),
                              ]),
                        ),
                        Text(
                          "${e?.name}",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 11),
                        ),
                      ],
                    ),
                  );
                },
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              )),

        ],
      ),
    );
  }
}
