import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:potl/service/vote_service.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:potl/util/confing.dart';
import 'package:provider/provider.dart';

import '../../service/auth_service.dart';

class VotePage extends StatefulWidget {
  const VotePage({
    Key? key,
    required this.postId,
  }) : super(key: key);
  final String postId;
  @override
  State<VotePage> createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthService>().currentUser();
    return Consumer<VoteService>(builder: (context, voteService, child) {
      return Scaffold(
        body: SafeArea(
          child: FutureBuilder<DocumentSnapshot>(
              future: voteService.readTargetPost(widget.postId),
              builder: (context, snapshot) {
                final postDoc = snapshot.data;
                List<dynamic> votingUsers = postDoc?.get("voting_users") ?? [];
                List<dynamic> warningUsers =
                    postDoc?.get("warning_users") ?? [];
                final isVote = votingUsers.contains(user?.uid);
                final isWarn = warningUsers.contains(user?.uid);
                final authorId = postDoc?.get("uid");

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: <Widget>[
                        Image.network(
                          postDoc?.get("image_url") ??
                              "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1024px-No_image_available.svg.png",
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(Icons.arrow_back_ios),
                                color: Colors.white,
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  dividerTheme: DividerThemeData(
                                    color: Colors.black,
                                  ),
                                  iconTheme: IconThemeData(color: potlGrey),
                                ),
                                child: PopupMenuButton<int>(
                                  color: potlWhite,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0))),
                                  onSelected: (item) {
                                    if (item == 0) {
                                      if (authorId == user?.uid) {
                                        var warning_posts = [];
                                        firestore
                                            .collection("user")
                                            .where("uid", isEqualTo: user?.uid)
                                            .get()
                                            .then((QuerySnapshot qs) {
                                          qs.docs.forEach((element) {
                                            warning_posts =
                                                element.get("warning_posts");
                                          });
                                        });
                                        var voting_posts = [];
                                        firestore
                                            .collection("user")
                                            .where("uid", isEqualTo: user?.uid)
                                            .get()
                                            .then((QuerySnapshot qs) {
                                          qs.docs.forEach((element) {
                                            voting_posts =
                                                element.get("voting_posts");
                                          });
                                        });
                                        warning_posts.removeWhere((element) =>
                                            element == widget.postId);
                                        voteService.updateWarningPosts(
                                            warning_posts, user?.uid ?? "");
                                        voting_posts.removeWhere((element) =>
                                            element == widget.postId);
                                        voteService.updateVotingPosts(
                                            voting_posts, user?.uid ?? "");
                                        voteService.deletePost(widget.postId);
                                        _deleteImageFromFireStorage(
                                            postDoc?.get("image_url"));
                                        Navigator.of(context).pop();
                                      } else {
                                        var warning_posts = [];
                                        firestore
                                            .collection("user")
                                            .where("uid", isEqualTo: user?.uid)
                                            .get()
                                            .then((QuerySnapshot qs) {
                                          qs.docs.forEach((element) {
                                            warning_posts =
                                                element.get("warning_posts");
                                          });
                                          if (isWarn) {
                                            voteService.updateWarning(
                                                postDoc?.get("warning") - 1,
                                                widget.postId);
                                            warning_posts.removeWhere(
                                                (element) =>
                                                    element == widget.postId);
                                            voteService.updateWarningPosts(
                                                warning_posts, user?.uid ?? "");
                                            warningUsers.removeWhere(
                                                (element) =>
                                                    element == user?.uid);
                                            voteService.updateWarningUsers(
                                                warningUsers, widget.postId);
                                          } else {
                                            voteService.updateWarning(
                                                postDoc?.get("voting") + 1,
                                                widget.postId);
                                            warning_posts.add(widget.postId);
                                            voteService.updateWarningPosts(
                                                warning_posts, user?.uid ?? "");
                                            warningUsers.add(user?.uid);
                                            voteService.updateWarningUsers(
                                                warningUsers, widget.postId);
                                          }
                                        });
                                      }
                                    }
                                  },
                                  itemBuilder: (context) => [
                                    authorId == user?.uid
                                        ? PopupMenuItem(
                                            value: 0,
                                            child: Center(
                                              child: Text('삭제'),
                                            ),
                                          )
                                        : PopupMenuItem(
                                            value: 0,
                                            child: Center(
                                              child: isWarn
                                                  ? Text('신고취소')
                                                  : Text('신고하기'),
                                            ),
                                          ),
                                    // PopupMenuDivider(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.017,
                          left: MediaQuery.of(context).size.width * 0.04,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.place, color: Colors.white),
                              ),
                              Text(
                                postDoc?.get("location_name") ?? "여긴어디?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height * 0.017,
                          left: MediaQuery.of(context).size.width * 0.88,
                          child: Column(
                            children: [
                              Text(
                                postDoc?.get("voting").toString() ?? "0",
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {
                                  var voting_posts = [];
                                  firestore
                                      .collection("user")
                                      .where("uid", isEqualTo: user?.uid)
                                      .get()
                                      .then((QuerySnapshot qs) {
                                    qs.docs.forEach((element) {
                                      voting_posts =
                                          element.get("voting_posts");
                                    });
                                    if (isVote) {
                                      voteService.updateVoting(
                                          postDoc?.get("voting") - 1,
                                          widget.postId);
                                      voting_posts.removeWhere((element) =>
                                          element == widget.postId);
                                      voteService.updateVotingPosts(
                                          voting_posts, user?.uid ?? "");
                                      votingUsers.removeWhere(
                                          (element) => element == user?.uid);
                                      voteService.updateVotingUsers(
                                          votingUsers, widget.postId);
                                    } else {
                                      voteService.updateVoting(
                                          postDoc?.get("voting") + 1,
                                          widget.postId);
                                      voting_posts.add(widget.postId);
                                      voteService.updateVotingPosts(
                                          voting_posts, user?.uid ?? "");
                                      votingUsers.add(user?.uid);
                                      voteService.updateVotingUsers(
                                          votingUsers, widget.postId);
                                    }
                                  });
                                },
                                icon: isVote
                                    ? Icon(
                                        Icons.star,
                                        color: potlWhite,
                                      )
                                    : Icon(
                                        Icons.star_border_outlined,
                                        color: potlWhite,
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    FutureBuilder<QuerySnapshot>(
                        future: voteService.readUserInfo(postDoc?.id ?? ""),
                        builder: (context, snapshot) {
                          final docs = snapshot.data?.docs ?? [];
                          String nickName = "";
                          String profileImage = potlDefaultProfileImage;
                          docs.forEach((element) {
                            nickName = element.get("nick_name");
                            profileImage = element.get("profile_image");
                          });
                          return Container(
                            height: MediaQuery.of(context).size.height * 0.07,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundImage: NetworkImage(profileImage),
                                    radius: 15,
                                    backgroundColor: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                    ),
                                  ),
                                ),
                                Text(nickName),
                              ],
                            ),
                          );
                        }),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.005,
                      color: potlLightGrey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("인생샷 명소 주소"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.04,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: Colors.black,
                                side: BorderSide(color: Colors.black),
                              ),
                              onPressed: () {},
                              child: Text("길찾기"),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.03,
                        MediaQuery.of(context).size.height * 0,
                        MediaQuery.of(context).size.width * 0.03,
                        MediaQuery.of(context).size.height * 0.01,
                      ),
                      child: Image.network(
                        "https://greenblog.co.kr/wp-content/uploads/2020/03/%ED%81%AC%EA%B8%B0%EB%B3%80%ED%99%98_%EC%9A%B0%EB%A6%AC%EB%82%98%EB%9D%BC-%EC%A7%80%EB%8F%84.jpg",
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              }),
        ),
      );
    });
  }

  Future<void> _deleteImageFromFireStorage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
    } catch (e) {
      print("Error deleting db from cloud: $e");
    }
  }
}
