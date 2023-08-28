import 'package:flutter/material.dart';

extension ContextExtentions on BuildContext {
  void showProgressDialog() {
    showDialog(
        context: this,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Container(
              height: 80,
              width: 80,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
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