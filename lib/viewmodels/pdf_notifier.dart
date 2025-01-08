import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../services/pdf_service.dart';
import '../services/pdf_service1.dart';

class PdfNotifier extends StateNotifier<AsyncValue<void>> {
  PdfNotifier() : super(const AsyncValue.data(null));

  Future<void> generateAndOpenPdf({
    required bool showMail,
    required bool showWeb,
    required bool showInvoice,
    required bool showTerm,
    required int selectedIndex,

  }) async {
    state = const AsyncValue.loading();

    try {
      var pdfData;
      if(selectedIndex ==0){
        pdfData = await PdfService.generatePdf(
          showMail: showMail,
          showWeb: showWeb,
          showInvoice: showInvoice,
          showTerm: showTerm,
        );
      }
      else{
        pdfData = await PdfService1.generatePdf(
          showMail: showMail,
          showWeb: showWeb,
          showInvoice: showInvoice,
          showTerm: showTerm,
        );
      }


      print('PDF data length: ${pdfData.length}');

      if (pdfData.isEmpty) {
        throw 'PDF data is empty';
      }

      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}${Platform.pathSeparator}invoice.pdf';
      final file = File(filePath);
      await file.writeAsBytes(pdfData);

      await Process.run('explorer.exe', [filePath]);

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      print('Error generating or opening PDF: $error');
      state = AsyncValue.error(error, stackTrace);
    }
  }

}
