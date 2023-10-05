import 'package:blog_explorer/Controller/BlogServices.dart';
import 'package:blog_explorer/Controller/FavoriteBlogController.dart';
import 'package:blog_explorer/View/Widget/BlogWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavItemScreen extends StatefulWidget {
  List<String> currentFavList = [];

  FavItemScreen({super.key, required this.currentFavList});

  @override
  State<FavItemScreen> createState() => _FavItemScreenState();
}

class _FavItemScreenState extends State<FavItemScreen> {
  late var blogList;
  late var favBlogListOnly;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    setState(() {
      isLoading = true;
    });
    FavoriteBlogController favoriteBlogController =
        Get.put(FavoriteBlogController());
    blogList = await BlogServices.fetchBlogs();
    for (int i = 0; i < blogList.length; i++) {
      if (favoriteBlogController.favBlogList.contains(blogList[i]["id"])) {
        favBlogListOnly.add(blogList[i]);
      }
    }
    print("Fetched successfully.");

    print(blogList[0]);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Blogs")),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: favBlogListOnly.length,
              itemBuilder: (context, index) {
                return BlogWidget(
                  id: favBlogListOnly[index]["id"],
                  img_url: favBlogListOnly[index]["image_url"],
                  title: favBlogListOnly[index]["title"],
                );
              },
            ),
    );
  }
}
