import 'package:flutter/material.dart';

import '../../util/POTL_icons.dart';
import '../common/vote.dart';

class SliderTemplate extends StatefulWidget {
  const SliderTemplate({
    Key? key,
    required this.postId,
    required this.imageUrl,
    required this.locationName,
  }) : super(key: key);
  final String postId;
  final String imageUrl;
  final String locationName;
  @override
  State<SliderTemplate> createState() => _SliderTemplateState();
}

class _SliderTemplateState extends State<SliderTemplate> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => VotePage(
            postId: widget.postId,
          ),
        ),
      ),
      child: Container(
        child: Container(
          margin: EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 10), // all(2.0),
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
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                  widget.imageUrl,
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
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Row(
                      children: [
                        Icon(
                          color: Colors.white,
                          POTLIcons.potl_location,
                        ),
                        Text(
                          ' ${widget.locationName}',
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
  }
}
