import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '/imports.dart';

class VersePage extends StatefulWidget {
  final Verse verse;

  const VersePage({
    super.key,
    required this.verse,
  });

  @override
  State<VersePage> createState() => _VersePageState();
}

class _VersePageState extends State<VersePage> {
  final GlobalKey _globalKey = GlobalKey();

  Future<Uint8List> captureWidget() async {
    final RenderRepaintBoundary boundary = _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 2.0);

    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Theme.of(context).colorScheme.background,
        title: Text(
          widget.verse.title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          SaveVerse(
            title: widget.verse.title,
            content: widget.verse.content,
          ),
          IconButton(
            onPressed: () async {
              var result = await captureWidget();

              Share.shareXFiles([
                XFile.fromData(
                  result,
                  name: 'image test',
                  mimeType: 'image/png',
                )
              ]);
            },
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              RepaintBoundary(
                key: _globalKey,
                child: Stack(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.width - 30,
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 60, 30, 30),
                      color: Colors.black,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                            ),
                            const Icon(
                              Icons.format_quote_outlined,
                              color: Colors.white,
                              size: 35,
                            ),
                            Text(
                              widget.verse.content,
                              style: const TextStyle(
                                fontSize: 19,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              widget.verse.title,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 22,
                      right: 22,
                      child: Image.asset(
                        Assets.extendedDarkLogo,
                        height: 38,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
