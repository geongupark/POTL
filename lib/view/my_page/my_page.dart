import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:potl/service/my_page_service.dart';
import 'package:potl/util/confing.dart';
import 'package:provider/provider.dart';
import '../../service/auth_service.dart';
import '../../util/POTL_icons.dart';
import '../common/vote.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);
  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _editEnable = false;
  User? _user;
  File? _image;
  String _url = "";

  @override
  Widget build(BuildContext context) {
    _user = context.read<AuthService>().currentUser();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    TextEditingController nickNameController = TextEditingController();

    return Consumer<MyPageService>(
      builder: (context, myPageService, child) {
        return Container(
          color: Colors.white,
          child: Column(
            children: [
              FutureBuilder<QuerySnapshot>(
                future: myPageService.readMyInfo(_user?.uid.toString() ?? ""),
                builder: (context, snapshot) {
                  final docs = snapshot.data?.docs ?? []; // 문서들 가져오기

                  String? profileImage;
                  String? nickName;
                  String? userDocId;
                  if (docs.isEmpty) {
                    nickName = "";
                    profileImage = potlDefaultProfileImage;
                    userDocId = "";
                  } else {
                    docs.forEach((element) {
                      nickName = element.get("nick_name");
                      profileImage = element.get("profile_image");
                      userDocId = element.id;
                    });
                  }
                  nickNameController.text = nickName!;

                  return Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.height * 0.025,
                                0,
                                MediaQuery.of(context).size.height * 0.025,
                                0,
                              ),
                              width: MediaQuery.of(context).size.height * 0.13,
                              height: MediaQuery.of(context).size.height * 0.13,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: _editEnable && _image != null
                                      ? FileImage(_image!) as ImageProvider
                                      : NetworkImage(profileImage!),
                                ),
                              ),
                            ),
                            _editEnable
                                ? Positioned(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.03,
                                    left:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: CircleAvatar(
                                      radius:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      backgroundColor:
                                          Color.fromARGB(150, 196, 49, 216),
                                      child: IconButton(
                                        onPressed: () {
                                          _getProfileImageFromLocal(
                                              source: ImageSource.gallery);
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: potlWhite,
                                        ),
                                      ),
                                    ),
                                  )
                                : Text(""),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: _editEnable
                                ? MediaQuery.of(context).size.height * 0.015
                                : MediaQuery.of(context).size.height * 0.053,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _editEnable
                                  ? Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: TextField(
                                        controller: nickNameController,
                                      ),
                                    )
                                  : Text(
                                      nickName!,
                                      style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.029,
                                      ),
                                    ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    primary: potlBlack,
                                    backgroundColor:
                                        _editEnable ? potlPurple : potlWhite,
                                  ),
                                  onPressed: () {
                                    if (_editEnable == true) {
                                      myPageService.updateNickNameUserDoc(
                                          userDocId!, nickNameController.text);
                                      if (_image != null) {
                                        _uploadProfileImageToStorage()
                                            .then((value) {
                                          myPageService
                                              .updateProfileImageUserDoc(
                                                  userDocId!, _url);
                                        });
                                      }
                                    } else {}
                                    setState(() {
                                      _editEnable = !_editEnable;
                                    });
                                  },
                                  child: _editEnable
                                      ? Text(
                                          '프로필 편집 완료',
                                          style: TextStyle(color: potlWhite),
                                        )
                                      : Text('프로필 편집'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Container(
                color: potlLightGrey,
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future:
                      myPageService.readMyPosts(_user?.uid.toString() ?? ""),
                  builder: (context, snapshot) {
                    final docs = snapshot.data?.docs ?? []; // 문서들 가져오기
                    if (docs.isEmpty) {
                      return Center(child: Text("내 포스트를 작성해주세요 ㅜ"));
                    }
                    docs.sort(((a, b) => b
                        .get("time")
                        .toDate()
                        .compareTo(a.get("time").toDate())));
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 5 / 5,
                      ),
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        final doc = docs[index];
                        String imageUrl = doc.get("image_url");
                        int voteCnt = doc.get("voting");
                        String postId = doc.id;
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            margin: EdgeInsets.only(
                              left: index % 2 == 0 ? 8 : 0,
                              right: index % 2 == 1 ? 8 : 0,
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8),
                              ),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => VotePage(
                                      postId: postId,
                                    ),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
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
                                  Positioned(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.15),
                                      color: Color.fromARGB(60, 100, 100, 100),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: MediaQuery.of(context).size.height *
                                        0.02,
                                    right: MediaQuery.of(context).size.width *
                                        0.02,
                                    child: Column(
                                      children: [
                                        Text(
                                          voteCnt.toString(),
                                          style: TextStyle(
                                            color: potlWhite,
                                          ),
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.01,
                                        ),
                                        Icon(
                                          POTLIcons.vote_enable,
                                          color: potlWhite,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _getProfileImageFromLocal({required ImageSource source}) async {
    final file =
        await ImagePicker().pickImage(source: source, imageQuality: 10);

    if (file != null) {
      setState(() {
        print(file.path);
        _image = File(file.path);
      });
    } else {
      return;
    }
  }

  Future<void> _uploadProfileImageToStorage() async {
    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    final ref = FirebaseStorage.instance
        .ref()
        .child("profile")
        .child(_user!.uid.toString() + 'jpg');
    await ref.putFile(_image!);
    await ref.getDownloadURL().then((url) {
      _url = url;
    });
  }
}
