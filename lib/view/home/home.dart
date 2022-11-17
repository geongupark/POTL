import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:potl/view/home/home_see_all.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';
import '../../service/home_service.dart';
import '../../util/POTL_icons.dart';
import '../../util/confing.dart';
import '../common/vote.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // for carousel slider
  final List<String> imgList = [];

  // for carouselslider
  int _currentSlide = 0;
  final CarouselController _controller = CarouselController();

  // week, month, year
  int _selectedRange = 0;
  bool isToZero = true;
  @override
  Widget build(BuildContext context) {
    final authService = context.read<AuthService>();

    return Consumer<HomeService>(
      builder: (context, homeService, chihld) {
        return Container(
          color: Colors.white,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: [
                    Text(
                      "Best shot",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRange = 0;
                          isToZero = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "주간",
                          style: TextStyle(
                            fontWeight:
                                _selectedRange == 0 ? FontWeight.bold : null,
                            color: _selectedRange == 0 ? potlPurple : null,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRange = 1;
                          isToZero = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "월간",
                          style: TextStyle(
                            fontWeight:
                                _selectedRange == 1 ? FontWeight.bold : null,
                            color: _selectedRange == 1 ? potlPurple : null,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedRange = 2;
                          isToZero = true;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Text(
                          "연간",
                          style: TextStyle(
                            fontWeight:
                                _selectedRange == 2 ? FontWeight.bold : null,
                            color: _selectedRange == 2 ? potlPurple : null,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              FutureBuilder<QuerySnapshot>(
                future: homeService.readAllPostBySorting(),
                builder: (context, snapshot) {
                  final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
                  final targetDocs = getTargetDocs(docs);
                  if (targetDocs.isEmpty) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: Center(
                        child: Text("사진을 올려주세요 ㅜㅜ"),
                      ),
                    );
                  }
                  imgList.clear();
                  for (var i = 0; i < targetDocs.length; i++) {
                    imgList.add(targetDocs[i].id);
                  }
                  return Column(
                    children: [
                      CarouselSlider.builder(
                        itemCount: targetDocs.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          final doc = targetDocs[itemIndex];
                          String imageUrl = doc.get("image_url");
                          String locationName = doc.get("location_name");
                          String postId = doc.id;
                          if (isToZero == true) {
                            _controller.animateToPage(0);
                            isToZero = false;
                          }
                          return GestureDetector(
                            onTap: () => Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) => VotePage(
                                  postId: postId,
                                ),
                              ),
                            )
                                .then((value) {
                              setState(() {});
                            }),
                            child: Container(
                              child: Container(
                                margin: EdgeInsets.fromLTRB(
                                    2.0, 2.0, 2.0, 10), // all(2.0),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 8.0, // soften the shadow
                                      spreadRadius: 1.0, //extend the shadow
                                      offset: Offset(
                                        0.0, // Move to right 10  horizontally
                                        1.5, // Move to bottom 10 Vertically
                                      ),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      Image.network(
                                        imageUrl,
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                      Positioned(
                                        bottom: 0.0,
                                        left: 0.0,
                                        right: 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color.fromARGB(200, 0, 0, 0),
                                                Color.fromARGB(0, 0, 0, 0)
                                              ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter,
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 20.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                color: Colors.white,
                                                POTLIcons.potl_location,
                                              ),
                                              Text(
                                                ' ${locationName.split(" ")[0] + " " + locationName.split(" ")[1]}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        carouselController: _controller,
                        options: CarouselOptions(
                            disableCenter: true,
                            autoPlay: false,
                            enlargeCenterPage: true,
                            aspectRatio: 15 / 14,
                            onPageChanged: (index, reason) {
                              setState(() {
                                _currentSlide = index;
                              });
                            }),
                      ),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: imgList.asMap().entries.map((entry) {
                              return GestureDetector(
                                onTap: () =>
                                    _controller.animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.fromLTRB(3, 15, 3, 10),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : potlPurple)
                                          .withOpacity(
                                              _currentSlide == entry.key
                                                  ? 0.9
                                                  : 0.3)),
                                ),
                              );
                            }).toList(),
                          ),
                          Positioned(
                            right: 10,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => HomeSeeAllPage(
                                      selectedRange: _selectedRange),
                                ),
                              )
                                  .then((value) {
                                setState(() {});
                              }),
                              child: Container(
                                margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                child: Row(
                                  children: [
                                    Text("See all "),
                                    Icon(POTLIcons.potl_arrow_right),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  List<QueryDocumentSnapshot<Object?>> getTargetDocs(
      List<QueryDocumentSnapshot<Object?>> docs) {
    List<QueryDocumentSnapshot<Object?>> targetDocs = [];
    DateTime today = DateTime.now();
    DateTime startDay;
    DateTime endDay;
    if (_selectedRange == 0) {
      startDay = today.subtract(Duration(days: today.weekday - 1));
      endDay = today.subtract(Duration(days: today.weekday - 7));
    } else if (_selectedRange == 1) {
      startDay = DateTime(today.year, today.month, 1);
      endDay = DateTime(today.year, today.month + 1, 0);
    } else if (_selectedRange == 2) {
      startDay = DateTime(today.year, 1, 1);
      endDay = DateTime(today.year + 1, 0, 0);
    } else {
      return [];
    }
    for (int i = 0; i < docs.length; i++) {
      DateTime postTime = docs[i].get("time").toDate();
      if (startDay.isBefore(postTime) && endDay.isAfter(postTime)) {
        targetDocs.add(docs[i]);
      }
      if (targetDocs.length >= 5) {
        break;
      }
    }
    return targetDocs;
  }
}
