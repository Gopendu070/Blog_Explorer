import 'package:blog_explorer/Controller/FavoriteBlogController.dart';
import 'package:blog_explorer/View/Screen/BlogDetailsScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BlogWidget extends StatefulWidget {
  String img_url;
  String title;
  String id;
  BlogWidget(
      {super.key,
      required this.id,
      required this.img_url,
      required this.title});

  @override
  State<BlogWidget> createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {
  //-----injecting dependency
  FavoriteBlogController favoriteBlog = Get.put(FavoriteBlogController());

  @override
  Widget build(BuildContext context) {
    print("BLog Build");

    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Stack(children: [
        InkWell(
          onTap: () {
            Get.to(() => BlogDetailsScreen(
                  id: widget.id,
                  img_url: widget.img_url,
                  title: widget.title,
                ));
          },
          child: Container(
            width: Get.width,
            height: Get.height * 0.33,
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(44, 122, 120, 120),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(13),
                          bottomRight: Radius.circular(13))),
                  padding: EdgeInsets.all(10),
                  width: Get.width,
                  //Blog Title
                  child: Text(
                    widget.title,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(191, 255, 255, 255),
                Color.fromARGB(255, 93, 92, 92)
              ]),
              borderRadius: BorderRadius.circular(13),
              //Blog Cover Image
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  widget.img_url,
                  scale: 0.5,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 4,
          top: 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(80),
            ),
            child: IconButton(
              onPressed: () async {
                if (favoriteBlog.favBlogList.contains(widget.id)) {
                  //Remove from favBlogList and saving to shared pref.
                  favoriteBlog.removeFromFav(widget.id);
                  favoriteBlog.saveFavorites();
                  print(favoriteBlog.favBlogList);
                } else {
                  //Add to favBlogList and saving to shared pref.
                  favoriteBlog.addToFav(widget.id);
                  favoriteBlog.saveFavorites();
                  print(favoriteBlog.favBlogList);
                }
              },
              icon: Obx(() => Icon(Icons.favorite_border,
                  color: favoriteBlog.favBlogList.contains(widget.id)
                      ? Colors.redAccent
                      : null)),
            ),
          ),
        )
      ]),
    );
  }
}
