import 'package:activout_firebase_options_selector/firebase_options_selector.dart';
import 'package:flutter/material.dart';

Future<void> showFirebaseOptionsSelectorDialog(
    BuildContext context, String titleText,
    {String okText = 'OK'}) async {
  var selected = await FirebaseOptionsSelector.getCurrentSelection();

  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(titleText),
        content: SingleChildScrollView(
          child: StatefulBuilder(
            builder: (context, setState) {
              return ListBody(
                  children: FirebaseOptionsSelector.availableOptions.entries
                      .map((e) => RadioListTile<String>(
                            title: Text(e.key),
                            value: e.key,
                            groupValue: selected,
                            onChanged: (String? newValue) async {
                              if (newValue != null) {
                                await FirebaseOptionsSelector.select(newValue);
                                setState(() => selected = newValue);
                              }
                            },
                          ))
                      .toList());
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(okText),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
