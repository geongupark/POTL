import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:potl/service/home_service.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:provider/provider.dart';
import '../../util/confing.dart';
import '../common/vote.dart';

class HomeSeeAllPage extends StatefulWidget {
  const HomeSeeAllPage({
    Key? key,
    required this.selectedRange,
  }) : super(key: key);
  final int selectedRange;
  @override
  State<HomeSeeAllPage> createState() => _HomeSeeAllPageState();
}

class _HomeSeeAllPageState extends State<HomeSeeAllPage> {
  int _selectedRange = 0;
  bool initCall = true;

  @override
  Widget build(BuildContext context) {
    initCall = false;
    if (initCall == true) {
      _selectedRange = widget.selectedRange;
    }

    return Consumer<HomeService>(
      builder: (context, homeService, chihld) {
        return Scaffold(
          backgroundColor: potlWhite,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(
                Icons.arrow_back_ios,
                color: potlGrey,
              ),
            ),
            title: Text(
              "Best shot",
              style: TextStyle(color: potlBlack),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
          ),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedRange = 0;
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
                SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FutureBuilder<QuerySnapshot>(
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
                        return GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 104 / 90,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10),
                          itemCount: targetDocs.length,
                          itemBuilder: (BuildContext ctx, index) {
                            var doc = targetDocs[index];
                            String imageUrl = doc.get("image_url");
                            String postId = doc.id;
                            int vote = doc.get("voting");
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
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                      bottomLeft: Radius.circular(8),
                                      bottomRight: Radius.circular(8),
                                    ),
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.fill,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
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
    }
    return targetDocs;
  }
}
