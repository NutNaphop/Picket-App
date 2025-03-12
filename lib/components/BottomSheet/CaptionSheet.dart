import 'package:flutter/material.dart';

class CaptionSheet extends StatefulWidget {
  const CaptionSheet({super.key});

  @override
  State<CaptionSheet> createState() => _CaptionSheetState();
}

class _CaptionSheetState extends State<CaptionSheet> {
  final _formKey = GlobalKey<FormState>();
  final captionController = TextEditingController();

  void showCaptionConfirmBottomSheet(BuildContext context) {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Container(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Write your caption", style: TextStyle(fontSize: 20)),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: captionController,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          decoration: InputDecoration(
                            hintText: "Enter caption...",
                            hintStyle: TextStyle(color: Colors.white70),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showCaptionConfirmBottomSheet(context);
        },
        icon: Icon(Icons.draw, size: 40, color: Colors.white));
  }
}
