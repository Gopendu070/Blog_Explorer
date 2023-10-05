import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Model/Blog.dart';

class BlogServices {
  //fetching data
  static fetchBlogs() async {
    String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        // print('Response data: ${response.body}');
        final data = json.decode(response.body);
        final blogList = data['blogs'];
        // print(blogList);
        print("Blogs Count: ${blogList.length}");
        return blogList;
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }
  }
}
