import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart' as mt;
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/data_layer/models/invoice/invoice.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';

class ReceiptPdf with UiInfoMixin {
  generate(mt.BuildContext context, Invoice invoiceDetails) async {
    final Directory? directory;
    //final ByteData fontData = await rootBundle.load('assets/fonts/Outfit/static/Outfit-Regular.ttf');
    //final ttf = pw.Font.ttf(fontData.buffer.asByteData());
    try {
      final pdf = Document();
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(), /*color: PdfColor.fromInt(Colors.white.value)*/
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  color: PdfColor.fromInt(AppColors.lightGrey.value),
                ),
                SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      topRow(invoiceDetails.invoiceNumber ?? '', invoiceDetails.appointment?.appointmentDate),
                      SizedBox(height: 16),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Patient : ',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                            TextSpan(
                              text: '${invoiceDetails.patient!.firstName ?? ''} ${invoiceDetails.patient!.lastName ?? ''}',
                              style: TextStyle(color: PdfColor(0.42, 0.56, 1, 1), fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                    ])),
                SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Divider(height: 1),
                        SizedBox(height: 10),
                        Container(
                          height: 40,
                          color: const PdfColor.fromInt(0xFFF8F7FC),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Text("Treatments", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text("Qty", textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                              /* Expanded(
                                flex: 2,
                                child: Text("Tax Amt.", textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),*/
                              Expanded(
                                flex: 2,
                                child: Text("Amt.", textAlign: TextAlign.right, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14),
                        ListView.builder(
                            itemCount: (invoiceDetails.treatments ?? []).length,
                            itemBuilder: (context, index) {
                              Treatment item = invoiceDetails.treatments![index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(item.treatment ?? '', style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(item.quantity.toString(),
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                                    ),
                                    /* Expanded(
                                      flex: 2,
                                      child: Text("50.00", textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                                    ),*/
                                    Expanded(
                                      flex: 2,
                                      child: Text(item.amount.toString(),
                                          textAlign: TextAlign.right, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal)),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    )),
                SizedBox(height: 10),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Divider(height: 1),
                        SizedBox(height: 10),
                        custom("Total Amt.", "-", invoiceDetails.totalAmount.toString(), "INR", TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                        SizedBox(height: 17),
                        custom("Total Tax", "-", invoiceDetails.totalTax.toString(), "INR", TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                        SizedBox(height: 17),
                        custom("Total Cost", "-", invoiceDetails.totalCost.toString(), "INR", TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                        SizedBox(height: 17),
                        custom("Discount @${invoiceDetails.discountRate ?? '0'}%", "-", invoiceDetails.discount.toString(), "INR",
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 16), TextStyle(fontWeight: FontWeight.normal, fontSize: 16)),
                      ],
                    )),
                SizedBox(height: 7),
                Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(children: [
                      Divider(height: 1),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: custom(
                              "Grand Total",
                              "-",
                              invoiceDetails.totalCost.toString(),
                              "INR",
                              TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: const PdfColor.fromInt(0xff4646B5)),
                              TextStyle(fontWeight: FontWeight.normal, fontSize: 16, color: const PdfColor.fromInt(0xff4646B5)))),
                      Divider(height: 1),
                    ])),
                SizedBox(height: 10),
                Container(
                  height: 50,
                  color: PdfColor.fromInt(AppColors.lightGrey.value),
                ),
              ],
            ),
          )
        ],
      ));
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = await getDownloadsDirectory();
      }
      if (directory == null) {
        //CustomSnackbar.showBottom(context, "Document directory not available");
        return;
      }
      String path = directory.path;
      String myFile = '$path/healthether-receipt.pdf';
      final file = File(myFile);
      await file.writeAsBytes(await pdf.save());
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final filePath = await FlutterFileDialog.saveFile(params: params);
      if (filePath != null) {
        showSnackMessage(context, 'Your receipt is downloaded');
      } else {
        showSnackMessage(context, 'Error occurred while downloading receipt');
      }
    } catch (e) {
      log("$e");
      showSnackMessage(context, 'Error occurred');
    }
  }

  Widget custom(
    String leadingText,
    String middleText,
    String trailingText,
    String unit,
    TextStyle leadingTextStyle,
    TextStyle trailingTextStyle,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(leadingText, style: leadingTextStyle),
        ),
        Expanded(
          flex: 1,
          child: Text(middleText, textAlign: TextAlign.center, style: leadingTextStyle),
        ),
        Expanded(
          flex: 2,
          child: Text(trailingText, textAlign: TextAlign.right, style: trailingTextStyle),
        ),
        Expanded(
          flex: 1,
          child: Text(unit, textAlign: TextAlign.right, style: trailingTextStyle),
        ),
      ],
    );
  }

  Widget topRow(String invoiceNo, DateTime? appointmentDate) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Invoice: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              TextSpan(
                text: invoiceNo,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
        Text(
          appointmentDate != null ? DateFormat('d MMMM, yyyy').format(appointmentDate).toString() : "N/A",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
