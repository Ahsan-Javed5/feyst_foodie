import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

import 'package:chef/screens/custom_form/fields/check_list/widgets/check_list_item.dart';

class InnerCheckListItemScreen extends StatelessWidget {
  InnerCheckListItemScreen({
    required this.items,
    required this.title,
    Key? key,
  }) : super(key: key);

  final List<CheckListItem> items;
  final String title;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Html(
            data: title,
            style: {'body': Style(color: Colors.white)},
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.check_sharp),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [...items],
            ),
          ),
        ),
      ),
    );
  }
}
