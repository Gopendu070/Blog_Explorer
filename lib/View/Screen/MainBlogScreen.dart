import 'package:blog_explorer/Controller/BlogServices.dart';
import 'package:blog_explorer/Controller/FavoriteBlogController.dart';
import 'package:blog_explorer/View/Screen/FavItemsScreen.dart';
import 'package:blog_explorer/View/Widget/BlogWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainBlogScreen extends StatefulWidget {
  MainBlogScreen({Key? key});

  @override
  State<MainBlogScreen> createState() => _MainBlogScreenState();
}

class _MainBlogScreenState extends State<MainBlogScreen> {
  late var blogList;
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

    blogList = await BlogServices.fetchBlogs();
    print("Fetched successfully.");

    print(blogList[0]);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("List Build");
    return Scaffold(
      // extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 115, 217, 188),
        onPressed: () {
          FavoriteBlogController favoriteBlogController =
              Get.put(FavoriteBlogController());
          Get.to(FavItemScreen(
            currentFavList: favoriteBlogController.favBlogList,
          ));
        },
        child: Icon(
          Icons.favorite,
          size: 32,
          color: Colors.redAccent,
        ),
      ),
      appBar: AppBar(
        elevation: 13,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset("lib/assets/logo.png", height: 25)),
        ),
        backgroundColor: Color.fromARGB(119, 0, 0, 0),
        title: Text("Blog Explorer"),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                addAutomaticKeepAlives: true,
                itemCount: blogList.length,
                itemBuilder: (context, index) {
                  return BlogWidget(
                    id: blogList[index]["id"],
                    img_url: blogList[index]["image_url"],
                    title: blogList[index]["title"],
                  );
                },
              ),
      ),
    );
  }
}
