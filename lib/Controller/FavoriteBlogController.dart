import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteBlogController extends GetxController {
  RxList<String> favBlogList = [""].obs;

  @override
  void onInit() {
    super.onInit();
    // Load the favorites from shared preferences when the controller is initialized.
    loadFavorites();
  }

  void getSharedPref() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    favBlogList.value = sp.getStringList("FavoriteList")!;
  }

  //-----Add to the Favorite List
  void addToFav(String BlogID) {
    favBlogList.add(BlogID);
    print("FavList length:  ${favBlogList.length}");
  }

  //-----Add to the Favorite List
  void removeFromFav(String BlogID) {
    favBlogList.remove(BlogID);
    print("FavList length:  ${favBlogList.length}");
  }

  // Load favorites from shared preferences
  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favBlogList.value =
        prefs.getStringList('favorites') ?? []; //Loads favBlogList
  }

  // Save favorites to shared preferences
  void saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', favBlogList.toList());
  }
}
