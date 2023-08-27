import 'package:flutter/material.dart';

extension ContextExtentions on BuildContext {
  void showProgressDialog() {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) {
          return const Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        }
    );
  }

  void hideDialog() {
    Navigator.of(this, rootNavigator: true).pop();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

}