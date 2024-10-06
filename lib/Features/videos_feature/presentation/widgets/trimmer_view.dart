import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shorts/Features/videos_feature/presentation/widgets/trimmer_view_body.dart';


class TrimmerView extends StatefulWidget {
  const TrimmerView({super.key, required this.file});

  final File file;

  @override
  State<TrimmerView> createState() => TrimmerViewState();
}

class TrimmerViewState extends State<TrimmerView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Trimmer'),
      ),
      body:  TrimmerViewBody(
        file: widget.file,
      ),
    );
  }
}


