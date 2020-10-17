import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  TextEditingController _searchController = new TextEditingController();
  Function search;

  SearchWidget(this.search, String text) {
    _searchController.text = text;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(15),
      width: size.width,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Buscar",
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              if (_searchController.value.text != null &&
                  _searchController.value.text.isNotEmpty) {
                search(valor: _searchController.value.text);
              } else {
                search();
              }
            },
          ),
        ],
      ),
    );
  }
}
