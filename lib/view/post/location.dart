import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kpostal/kpostal.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:potl/service/home_service.dart';
import 'package:potl/util/POTL_icons.dart';
import 'package:potl/util/confing.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../common/vote.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  late GoogleMapController _controller;

  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(35.646451642435444, 127.72239547222853), zoom: 7.0);

  // 지도 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];
  String postCode = '-';
  String roadAddress = '-';
  String jibunAddress = '-';
  String locationName = "";
  double latitude = 0.0;
  double longitude = 0.0;

  addMarker(LatLng cordinate) async {
    int id = Random().nextInt(100);
    markers.clear();
    markers.add(
      Marker(
        position: cordinate,
        markerId: MarkerId(
          id.toString(),
        ),
      ),
    );
  }

  Future<dynamic> getLocationName(double lat, double lng) async {
    String kakaoApiKey = "c78b90559472b76a3744cf561aae8b48";
    var kakaoGeoUrl = Uri.parse(
        'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=$lng&y=$lat&input_coord=WGS84');
    var kakaoGeo = await http
        .get(kakaoGeoUrl, headers: {"Authorization": "KakaoAK $kakaoApiKey"});

    String addr = kakaoGeo.body;
    var addrData = jsonDecode(addr)["documents"][0];
    String location = addrData["address"]["address_name"];
    return location;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context, {
              "latitude": this.latitude,
              "longtitude": this.longitude,
              "locationName": this.locationName,
            }),
            icon: Icon(
              Icons.arrow_back_ios,
              color: potlGrey,
            ),
          ),
          toolbarHeight: MediaQuery.of(context).size.height * 0.1,
          title: Container(
            margin: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height * 0.01, 0, 0),
            child: Text(
              "위치 선택",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          elevation: 1,
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            GoogleMap(
              initialCameraPosition: _initialPosition,
              mapType: MapType.normal,
              onMapCreated: (controller) {
                setState(() {
                  _controller = controller;
                });
              },
              markers: markers.toSet(),
              onTap: (cordinate) async {
                await getLocationName(cordinate.latitude, cordinate.longitude)
                    .then((locationName) {
                  setState(() {
                    this.latitude = cordinate.latitude;
                    this.longitude = cordinate.longitude;
                    this.locationName = locationName;
                    addMarker(cordinate);
                  });
                });
              },
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(190, 255, 255, 255),
                  // borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                // margin: EdgeInsets.only(
                //     top: MediaQuery.of(context).size.height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      POTLIcons.location_small,
                      color: potlBlack,
                    ),
                    Text(" "),
                    Text(
                      this.locationName == ""
                          ? " 인생샷 장소를 선택해보세요 "
                          : this.locationName,
                      style: TextStyle(color: potlBlack),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FloatingActionButton.extended(
              backgroundColor: Color.fromARGB(190, 255, 255, 255),
              onPressed: () => Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (_) => KpostalView(
                    useLocalServer: true,
                    localPort: 1024,
                    callback: (Kpostal result) {
                      setState(
                        () {
                          this.postCode = result.postCode;
                          this.roadAddress = result.address;
                          this.jibunAddress = result.jibunAddress;
                          this.latitude = result.latitude!;
                          this.longitude = result.longitude!;
                        },
                      );
                    },
                  ),
                ),
              )
                  .then(
                (value) {
                  getLocationName(this.latitude, this.longitude).then(
                    (locationName) {
                      setState(
                        () {
                          this.locationName = locationName;
                          addMarker(LatLng(this.latitude, this.longitude));
                        },
                      );
                    },
                  );
                },
              ),
              label: Text('위치 검색', style: TextStyle(color: potlPurple)),
              icon: Icon(
                Icons.search,
                color: potlPurple,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
