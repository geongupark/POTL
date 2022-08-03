import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:potl/util/confing.dart';
import 'package:potl/view/post/location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../service/post_service.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  String? _locationName;
  File? _image;
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _user;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  String _url = "";

  @override
  void initState() {
    super.initState();
    _prepareService();
  }

  void _prepareService() async {
    _user = await FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    final postService = context.read<PostService>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      primary: potlGrey,
                      side: BorderSide(
                        color: potlGrey,
                      ),
                      backgroundColor: potlWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LocationPage(),
                      ),
                    ),
                    label: Text('위치 추가'),
                    icon: Icon(POTLIcons.location_small),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            _image != null
                ? Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.001,
                          0,
                          MediaQuery.of(context).size.width * 0.001,
                          0,
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.1,
                        left: MediaQuery.of(context).size.width * 0.32,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: OutlinedButton.icon(
                            style: OutlinedButton.styleFrom(
                              primary: potlBlack,
                              side: BorderSide(color: potlGrey),
                              backgroundColor:
                                  Color.fromARGB(170, 196, 49, 216),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(31.0),
                              ),
                            ),
                            onPressed: () {
                              _getPostImageFromLocal(
                                  source: ImageSource.gallery);
                            },
                            label: Text(
                              '사진 바꾸기',
                              style: TextStyle(
                                color: potlWhite,
                              ),
                            ),
                            icon: Icon(
                              Icons.add,
                              color: potlWhite,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.5,
                        color: potlLightGrey,
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        top: MediaQuery.of(context).size.height * 0.13,
                        bottom: 0,
                        child: Column(
                          children: [
                            Icon(
                              POTLIcons.camera,
                              color: potlGrey,
                              size: MediaQuery.of(context).size.width * 0.089,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            Text(
                              "인물 사진을 올려주세요 :)",
                              style: TextStyle(
                                color: potlGrey,
                              ),
                            ),
                            Text(
                              "풍경, 음식, 동물 등 사람이 포함되지 않을 경우",
                              style: TextStyle(
                                color: potlGrey,
                              ),
                            ),
                            Text(
                              "삭제 조치됨을 알려드립니다.",
                              style: TextStyle(
                                color: potlGrey,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  primary: potlBlack,
                                  side: BorderSide(color: potlBlack),
                                  backgroundColor: potlWhite,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(31.0),
                                  ),
                                ),
                                onPressed: () {
                                  _getPostImageFromLocal(
                                      source: ImageSource.gallery);
                                },
                                label: Text('사진 추가하기'),
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.035,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.065,
              // alignment: Alignment.center,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: _image == null ? potlGrey : potlWhite,
                  side: BorderSide(
                    color: potlWhite,
                  ),
                  backgroundColor: _image == null ? potlLightGrey : potlPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: _image == null
                    ? null
                    : () {
                        setState(() {
                          _uploadPostImageToStorage().then((value) {
                            postService.create(
                                _user!.uid, _url, GeoPoint(2, 2), "test");
                          });
                          _image = null;
                        });
                      },
                child: Text('등록하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getPostImageFromLocal({required ImageSource source}) async {
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

  Future<void> _uploadPostImageToStorage() async {
    // 프로필 사진을 업로드할 경로와 파일명을 정의. 사용자의 uid를 이용하여 파일명의 중복 가능성 제거
    final ref = FirebaseStorage.instance
        .ref()
        .child("post")
        .child(DateTime.now().toString() + _user!.uid.toString() + 'jpg');
    await ref.putFile(_image!);
    await ref.getDownloadURL().then((url) {
      _url = url;
    });
  }
}
