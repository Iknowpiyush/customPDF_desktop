import 'dart:typed_data';
import 'package:anosh_assignment/constants/font_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../constants/dimensions.dart';

class PdfService1 {
  static Future<Uint8List> generatePdf(
      {showMail, showWeb, showInvoice, showTerm}) async {
    final pdf = pw.Document(
        version: PdfVersion.pdf_1_5,
        compress: true,
        pageMode: PdfPageMode.none);

    final headerStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.grey800,
      fontSize: FontSizes.xsmall,
    );

    final titleStyle = pw.TextStyle(
      fontSize: FontSizes.medium,
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.blue800,
    );

    final sectionTitleStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.blue800,
      fontSize: FontSizes.small,
    );

    final itemHeaderStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.white,
      fontSize: 8,
    );

    final itemCellStyle = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      color: PdfColors.black,
      fontSize: 8,
    );

    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(12),
        build: (pw.Context context) {
          return pw.Stack(children: [
            showWeb ?
            pw.Positioned(
                left: Dimensions.width * 2,
                top: Dimensions.height * 4,
                child: pw.Transform(
                  transform: Matrix4.rotationZ(45),
                  child: pw.Text("PIYUSH \n JINDAL",
                      style: pw.TextStyle(
                          color: PdfColor.fromHex("DCDCDCFF"),
                          font: pw.Font.timesBoldItalic(),
                          fontSize: FontSizes.watermark)),
                )
            ) :
            pw.SizedBox(),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Header Section
                _buildHeader(titleStyle, headerStyle,
                    showEmail: showMail, showValue: showInvoice),

                pw.SizedBox(height: 10),
                _buildDivider(),
                pw.SizedBox(height: 10),

                // Bill To & Ship To Section
                _buildBillToShipTo(sectionTitleStyle, headerStyle,showValue: showInvoice ),

                pw.SizedBox(height: 20),

                // Item Details Header
                _buildItemDetailsHeader(),

                pw.SizedBox(height: 10),

                // Item Details Table
                _buildItemTable(itemHeaderStyle, itemCellStyle),

                pw.SizedBox(height: Dimensions.height * 3),

                // Totals Section
                _buildTotalSection(),

                pw.SizedBox(height: 10),
                _buildDivider(),
                pw.SizedBox(height: 10),

                // Terms & Conditions
                showTerm ? _buildTermsAndConditions() : pw.SizedBox(),

                pw.SizedBox(height: 20),

                // Authorized Signature
                _buildSignature(),
              ],
            ),

          ]);
        },
      ),
    );

    return pdf.save();
  }

  static pw.Widget _buildHeader(
      pw.TextStyle titleStyle, pw.TextStyle headerStyle,
      {showEmail, showValue}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("COMPANY NAME", style: titleStyle),
            pw.Text("123 BUSINESS STREET, CITY, STATE - 12345",
                style: headerStyle),
            pw.Text("CONTACT: 2525454545", style: headerStyle),
            showEmail
                ? pw.Text("contact@company.com", style: headerStyle)
                : pw.SizedBox(),
          ],
        ),
      ],
    );
  }

  static pw.Widget _buildDivider() {
    return pw.Container(color: PdfColors.blue800, height: 1);
  }

  static pw.Widget _buildBillToShipTo(
      pw.TextStyle sectionTitleStyle, pw.TextStyle headerStyle,{showValue}) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("BILL TO:", style: sectionTitleStyle),
            pw.SizedBox(height: Dimensions.height * 0.25),
            pw.Text("PARTY NAME: ABC CORPORATION PVT LTD", style: headerStyle),
            pw.Text("ADDRESS: 123 BUSINESS STREET, CITY, STATE - 12345",
                style: headerStyle),
            pw.Text("GST: 27XXXXP0103Z", style: headerStyle),
          ],
        ),
        showValue
            ? pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Text("INVOICE", style: sectionTitleStyle),
            pw.Text("INVOICE NO: 123", style: headerStyle),
            pw.Text("20-Nov-2024", style: headerStyle),
          ],
        )
            : pw.SizedBox(),
      ],
    );
  }

  static pw.Widget _buildItemDetailsHeader() {
    return pw.Center(
      child: pw.Text(
        "ITEM DETAILS",
        style: pw.TextStyle(
          fontSize: FontSizes.large,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _buildItemTable(
      pw.TextStyle itemHeaderStyle, pw.TextStyle itemCellStyle) {
    return pw.TableHelper.fromTextArray(
      headers: [
        'SR NO.',
        'DESCRIPTION',
        'QTY',
        'PRICE',
        'GST',
        'AMOUNT',
      ],
      oddRowDecoration: pw.BoxDecoration(
        color: PdfColor.fromHex("cfd7edFF"),
      ),
      data: List.generate(
        5,
            (index) => [
          '${index + 1}',
          'ABCDEFGHIJKLMN',
          '99',
          '9999999.99',
          '99999.9999',
          '99999999.99',
        ],
      ),
      headerHeight: 10,
      headerStyle: itemHeaderStyle,
      headerDecoration: pw.BoxDecoration(
        color: PdfColor.fromHex("2d3646FF"),
      ),
      cellStyle: itemCellStyle,
      cellAlignment: pw.Alignment.center,
      border: const pw.TableBorder(
        bottom: pw.BorderSide(width: 0),
        left: pw.BorderSide(width: 0),
        right: pw.BorderSide(width: 0),
        top: pw.BorderSide(width: 0),
      ),
    );
  }

  static pw.Widget _buildTotalSection() {
    return pw.Align(
      alignment: pw.Alignment.centerRight,
      child: pw.Text(
        "TOTAL:     999999999.99",
        style: pw.TextStyle(
          fontSize: 12,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  static pw.Widget _buildTermsAndConditions() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          "Terms & Conditions:",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.indigo600,
            fontSize: FontSizes.small,
          ),
        ),
        pw.Text(
          "Payment is due within 30 days",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey,
            fontSize: FontSizes.xxsmall,
          ),
        ),
        pw.Text(
          "Please include invoice number on payment",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey,
            fontSize: FontSizes.xxsmall,
          ),
        ),
        pw.Text(
          "All prices are in USD",
          style: pw.TextStyle(
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.grey,
            fontSize: FontSizes.xxsmall,
          ),
        ),
      ],
    );
  }

  static pw.Widget _buildSignature() {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.end,
      children: [
        pw.Column(
          children: [
            pw.Container(height: 1, width: 120, color: PdfColors.black),
            pw.SizedBox(height: 5),
            pw.Text(
              "Authorized Signatory",
              style: pw.TextStyle(
                fontSize: FontSizes.xsmall,
                color: PdfColors.indigo600,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
