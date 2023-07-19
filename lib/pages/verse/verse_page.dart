import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '/domain/domain.dart';
import '/core/core.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';

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
    final RenderRepaintBoundary boundary =
        _globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;

    final ui.Image image = await boundary.toImage(pixelRatio: 2.0);

    final ByteData? byteData =
        await image.toByteData(format: ui.ImageByteFormat.png);

    final Uint8List pngBytes = byteData!.buffer.asUint8List();

    return pngBytes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.verse.title,
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
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
      body: Center(
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
                          const Icon(
                            Icons.format_quote,
                            color: Colors.white,
                            size: 35,
                          ),
                          Text(
                            widget.verse.content,
                            style: const TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 30),
                          Text(
                            widget.verse.title,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Image.asset(
                      Assets.extendedDarkLogo,
                      height: 28,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
