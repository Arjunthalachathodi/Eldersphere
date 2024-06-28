import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  final String? errorMessage;
  const ErrorPage({super.key, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Error Page"),
      ),
    );
  }
}
