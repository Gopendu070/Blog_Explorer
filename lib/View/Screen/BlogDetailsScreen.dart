import 'dart:async';

import 'package:blog_explorer/Controller/FavoriteBlogController.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class BlogDetailsScreen extends StatefulWidget {
  String id;
  String img_url;
  String title;
  BlogDetailsScreen(
      {super.key,
      required this.id,
      required this.img_url,
      required this.title});

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var H = Get.height;
    var W = Get.width;
    FavoriteBlogController favoriteBlogController =
        Get.put(FavoriteBlogController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        Container(),
        Container(
          height: H * 0.35,
          width: W,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: CachedNetworkImageProvider(widget.img_url),
                  fit: BoxFit.cover)),
        ),
        Positioned(
            right: 8,
            top: H * 0.24,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                color: Color.fromARGB(59, 123, 122, 122),
              ),
              child: IconButton(
                  onPressed: () {
                    if (favoriteBlogController.favBlogList
                        .contains(widget.id)) {
                      favoriteBlogController.removeFromFav(widget.id);
                    } else {
                      favoriteBlogController.addToFav(widget.id);
                    }
                  },
                  icon: Obx(() => Icon(Icons.favorite_border,
                      color:
                          favoriteBlogController.favBlogList.contains(widget.id)
                              ? Colors.redAccent
                              : null))),
            )),
        IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
        Positioned(
          bottom: 0,
          child: Container(
            height: H * 0.68,
            width: W,
            padding: EdgeInsets.all(14),
            //------------Title
            child: Text(widget.title),
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 85, 84, 84),
                  Color.fromARGB(255, 33, 39, 43)
                ]),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14),
                    topRight: Radius.circular(14))),
          ),
        )
      ]),
    );
  }
}
