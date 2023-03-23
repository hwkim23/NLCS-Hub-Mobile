import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';

class PDFMenu extends StatefulWidget {
  final File file;

  const PDFMenu({
    Key? key,
    required this.file,
  }) : super(key: key);

  @override
  _PDFMenuState createState() => _PDFMenuState();
}

class _PDFMenuState extends State<PDFMenu> {
  late PDFViewController controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        title: Text(name, style: const TextStyle(color: Colors.black),),
        actions: pages >= 2
        ? [
        Center(child: Text(text, style: const TextStyle(color: Colors.black))),
        IconButton(
          icon: const Icon(Icons.chevron_left, size: 32, color: Colors.black),
          onPressed: () {
            final page = indexPage == 0 ? pages : indexPage - 1;
            controller.setPage(page);
          },
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right, size: 32, color: Colors.black),
          onPressed: () {
            final page = indexPage == pages - 1 ? 0 : indexPage + 1;
            controller.setPage(page);
          },
        ),
        ]
        : null,
      ),
      body: SafeArea(
        child: PDFView(
          filePath: widget.file.path,
          // autoSpacing: false,
          // swipeHorizontal: true,
          // pageSnap: false,
          // pageFling: false,
          onRender: (pages) => setState(() => this.pages = pages!),
          onViewCreated: (controller) =>
              setState(() => this.controller = controller),
          onPageChanged: (indexPage, _) =>
              setState(() => this.indexPage = indexPage!),
        ),
      ),
    );
  }
}