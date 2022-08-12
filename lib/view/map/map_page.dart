import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:potl/service/home_service.dart';
import 'package:provider/provider.dart';

import '../common/vote.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // 애플리케이션에서 지도를 이동하기 위한 컨트롤러
  late GoogleMapController _controller;

  // 이 값은 지도가 시작될 때 첫 번째 위치입니다.
  final CameraPosition _initialPosition = CameraPosition(
      target: LatLng(35.846451642435444, 127.72239547222853), zoom: 6.9);

  // 지도 표시할 장소에 대한 마커 목록
  final List<Marker> markers = [];

  addMarker(cordinate, postId) {
    int id = Random().nextInt(100);
    markers.add(
      Marker(
        position: cordinate,
        markerId: MarkerId(id.toString()),
        onTap: () => Navigator.of(context)
            .push(
          MaterialPageRoute(
            builder: (context) => VotePage(
              postId: postId,
            ),
          ),
        )
            .then((value) {
          setState(() {
            _controller.animateCamera(CameraUpdate.newLatLng(
                LatLng(35.646451642435444, 127.72239547222853)));
          });
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeService = context.read<HomeService>();
    // future builde
    // homeService.readAllPostBySorting().then((QuerySnapshot qs) {
    //   qs.docs.forEach((element) {
    //     GeoPoint geo_point = element.get("geo_point");
    //     String postId = element.id;
    //     print(geo_point);
    //     LatLng latLng = new LatLng(geo_point.latitude, geo_point.longitude);
    //     addMarker(latLng, postId);
    //   });
    // });
    return FutureBuilder<QuerySnapshot>(
        future: homeService.readAllPostBySorting(),
        builder: (context, snapshot) {
          snapshot.data?.docs.forEach((element) {
            GeoPoint geo_point = element.get("geo_point");
            String postId = element.id;
            print(geo_point);
            LatLng latLng = new LatLng(geo_point.latitude, geo_point.longitude);
            addMarker(latLng, postId);
          });
          if (!snapshot.hasData) {
            return Container(
              alignment: Alignment(0.0, 0.0),
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return Scaffold(
              body: GoogleMap(
                initialCameraPosition: _initialPosition,

                mapType: MapType.normal,
                onMapCreated: (controller) {
                  setState(() {
                    _controller = controller;
                  });
                },
                markers: markers.toSet(),
                myLocationButtonEnabled: false,
                // 클릭한 위치가 중앙에 표시
                onTap: (cordinate) {
                  print("cordinate!!!!!!!!");
                  print(markers);
                },
              ),
            );
          }
        });
  }
}
