import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

Future<void> savePdf(pw.Document pdf) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/invoice.pdf';
    final file = File(filePath);

    await file.writeAsBytes(await pdf.save());
    debugPrint('PDF saved to: $filePath');
  } catch (e) {
    debugPrint('Error saving PDF: $e');
  }
}