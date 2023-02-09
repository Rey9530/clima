// ignore: non_constant_identifier_names
// ignore_for_file: non_constant_identifier_names, duplicate_ignore

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

show_snackbar({title, messaje, ContentType? type, context}) {
  var snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: title,
      message: messaje,
      contentType: type ?? ContentType.warning,
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
