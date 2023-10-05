class Blog {
  String id;
  String image_url;
  String title;
  Blog({required this.id, required this.image_url, required this.title});
  //
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      title: json['title'],
      image_url: json['img_url'],
      id: json['id'],
    );
  }
}
