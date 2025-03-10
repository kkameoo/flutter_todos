import 'package:flutter/material.dart';

class WriteForm extends StatelessWidget {
  const WriteForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("할 일 추가"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Placeholder(),
    );
  }
}
