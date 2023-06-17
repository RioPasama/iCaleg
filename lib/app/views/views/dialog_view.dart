import 'package:flutter/material.dart';

AlertDialog dialogView(
    {required String title,
    required String content,
    required Function() onTapOke,
    Function()? onTapBack}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      Visibility(
        visible: onTapBack != null,
        child: TextButton(
          onPressed: onTapBack,
          child: const Text('Kembali'),
        ),
      ),
      TextButton(
        onPressed: onTapOke,
        child: const Text('Oke'),
      ),
    ],
  );
}
