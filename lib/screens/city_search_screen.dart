import 'package:flutter/material.dart';

class CitySearchScreen extends StatelessWidget {
  const CitySearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter a city'),
      ),
      body: Form(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                  labelText: 'Enter a city', hintText: 'Example: Chicago'),
            )),
            IconButton(
                onPressed: () {
                  Navigator.pop(context, _searchController.text);
                },
                icon: Icon(Icons.search))
          ],
        ),
      )),
    );
  }
}
