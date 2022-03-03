import 'dart:convert';
import 'package:ghana/contactpage/book.dart';
import 'package:http/http.dart' as http;

class BooksApi {
  static Future<List<Book>> getBooks(String query) async {
    final url = Uri.parse(
        'https://firebasestorage.googleapis.com/v0/b/ghana-66a63.appspot.com/o/shops.json?alt=media');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List books = json.decode(response.body);
      return books.map((json) => Book.fromJson(json)).where((book) {
        final nameLower = book.name.toLowerCase();
        final searchLower = query.toLowerCase();
        return nameLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
