import 'dart:io';
import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../modules/pengasuh/izin/view/report_izin_page.dart';

reportView(context, Izin izin, Santri santri) async {
  final pdf = pw.Document();
  final img = await networkImage('https://i.ibb.co/3TQ3jBV/darululum.png');
  pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.symmetric(horizontal: 32,vertical: 64),
      build: (pw.Context context) {
        return pw.Column(
          children: <pw.Widget>[
            pw.Header(
              child: pw.Row(
                  children: <pw.Widget> [
                    pw.Container(
                      width: 108,
                      height: 108,
                      decoration: pw.BoxDecoration(
                          image: pw.DecorationImage(
                              image: img
                          )
                      ),
                    ),

                    pw.SizedBox(width: 56),
                    pw.Text("PONDOK PESANTREN DARUL ULUM")
                  ]
              ),
            ),
            pw.SizedBox(height: 56),
            pw.Row(children: <pw.Widget>[
              pw.Text("Nama: "),
              pw.Text(santri.name!),
            ]),
            pw.SizedBox(height: 16),
            pw.Row(children: <pw.Widget>[
              pw.Text("Asrama: "),
              pw.Text(santri.dormitory!),
            ]),
            pw.SizedBox(height: 16),
            pw.Row(children: <pw.Widget>[
              pw.Text("Tujuan: "),
              pw.Text(izin.title!),
            ]),
            pw.SizedBox(height: 16),
            pw.Row(children: <pw.Widget>[
              pw.Text("Detail: "),
              pw.Text(izin.information!),
            ]),
            pw.SizedBox(height: 16),
            pw.Row(children: <pw.Widget>[
              pw.Text("Dari: "),
              pw.Text(izin.fromDate!.toIso8601String()),
            ]),
            pw.SizedBox(height: 16),
            pw.Row(children: <pw.Widget>[
              pw.Text("Sampai: "),
              pw.Text(izin.toDate!.toIso8601String()),
            ]),

            pw.SizedBox(height: 108),
            pw.Row(children: <pw.Widget>[
              pw.Text("Diiziinkan: "),
              pw.Text(izin.isPermissioned! ? "Sudah" : "Belum"),
            ]),

            pw.SizedBox(height: 32),
            pw.Row(children: <pw.Widget>[
              pw.Text("Sudah Kembali: "),
              pw.Text(izin.isPermissioned! ? "Sudah" : "Belum"),
            ]),
          ]
        );
      }));

  //save PDF
  final String dir = (await getApplicationDocumentsDirectory()).path;
  final String path = '$dir/report.pdf';
  final File file = File(path);
  await file.writeAsBytes(await pdf.save());
  Navigator.of(context).push( MaterialPageRoute(
      builder: (_) => ReportIzinPage(path: path),
    ),
  );

}

Future<pw.ImageProvider> networkImage(
    String url, {
      bool cache = true,
      PdfImageOrientation? orientation,
      double? dpi,
    }) async {
  final img = await download(url, cache: cache);
  return pw.MemoryImage(img, orientation: orientation, dpi: dpi);
}

Future<Uint8List> download(
    String url, {
      bool cache = true,
    }) async {
  late File file;
  if (cache) {
    final tmp = await getTemporaryDirectory();
    file = File('${tmp.path}/${url.hashCode}');
    if (file.existsSync()) {
      return await file.readAsBytes();
    }
  }

  print('Downloading $url');
  final client = HttpClient();
  final request = await client.getUrl(Uri.parse(url));
  final response = await request.close();
  final builder = await response.fold(
      BytesBuilder(), (BytesBuilder b, List<int> d) => b..add(d));
  final List<int> data = builder.takeBytes();

  if (cache) {
    await file.writeAsBytes(data);
  }
  return Uint8List.fromList(data);
}