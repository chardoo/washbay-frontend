// ignore_for_file: must_be_immutable

import 'package:bayfrontend/model/userService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:bayfrontend/contollers/login_controller.dart';

import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// ignore: use_key_in_widget_constructors
class ReportScreen extends StatelessWidget {
  final pdf = pw.Document();

  writeOnPdf() {
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (pw.Context context) {
        return <pw.Widget>[
          pw.Header(
              level: 0,
              child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: <pw.Widget>[
                    pw.Text('Geeksforgeeks', textScaleFactor: 2),
                  ])),
          pw.Header(level: 1, text: 'What is Lorem Ipsum?'),

          // Write All the paragraph in one line.
          // For clear understanding
          // here there are line breaks.
          pw.Paragraph(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus '),
          pw.Paragraph(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus'),
          pw.Header(level: 1, text: 'This is Header'),
          pw.Paragraph(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Nunc mi ipsum faucibus'),
          pw.Paragraph(
              text:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'),
          pw.Padding(padding: const pw.EdgeInsets.all(10)),
          pw.Table.fromTextArray(context: context, data: const <List<String>>[
            <String>['Year', 'Sample'],
            <String>['SN0', 'GFG1'],
            <String>['SN1', 'GFG2'],
            <String>['SN2', 'GFG3'],
            <String>['SN3', 'GFG4'],
          ]),
        ];
      },
    ));
  }

  Future savePdf() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentDirectory.path;
    File file = File("$documentPath/example.pdf");
   // file.writeAsBytesSync(pdf.save());
  }

  // final _formKey = GlobalKey<FormState>();
  static const colorizeTextStyle =
      TextStyle(fontSize: 25.0, fontFamily: 'SF', color: Colors.redAccent);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF800020),
      appBar: _getAppBar(),
      body: loginBody(context),
    );
  }

  Widget loginBody(context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 14, 15),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  color: Colors.blueGrey,
                  child: Text(
                    'Preview PDF',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  onPressed: () async {
                    writeOnPdf();
                    await savePdf();

                    Directory documentDirectory =
                        await getApplicationDocumentsDirectory();

                    String documentPath = documentDirectory.path;

                    String fullPath = "$documentPath/example.pdf";
                    print(fullPath);

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => PdfPreviewScreen(
                    //               path: fullPath,
                    //             )));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.jpg",
              fit: BoxFit.contain,
            ),
          ],
        ));
  }
}
