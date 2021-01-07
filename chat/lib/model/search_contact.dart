import '../model/user_info.dart';
import 'package:flutter/material.dart';
import '../widgets/contact_list.dart';

class SearchContact extends SearchDelegate {
  final List<UsrList> userList;
  final Function(
          BuildContext context, String userId, String name, String imageUrl)
      chatPage;

  SearchContact({this.userList, this.chatPage});

  @override
  ThemeData appBarTheme(BuildContext context) {
    // TODO: implement appBarTheme
    return ThemeData(
      primaryColor: Colors.lightGreen,
      hintColor: Colors.white54,
    );
  }


  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear,color: Colors.white,),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back,color: Colors.white,),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ContactList(
      usersInfo: query.isEmpty
          ? userList
          : userList
              .where((element) =>
                  element.name.toUpperCase().startsWith(query.toUpperCase()))
              .toList(),
      chatPage: chatPage,
    );
  }
}
