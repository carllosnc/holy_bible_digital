import 'package:flutter/material.dart';
import '/domain/domain.dart';
import '/core/core.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.share),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
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
          ],
        ),
      ),
    );
  }
}
