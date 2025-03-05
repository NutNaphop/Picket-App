import 'package:flutter/material.dart';

class Logo extends StatefulWidget {
  double width  ; 
  double height ; 

  Logo({
    required this.width , 
    required this.height 
  });

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return                     Stack(
                      alignment: Alignment.center, // จัดให้ทุกอย่างอยู่ตรงกลาง
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height:widget.height,
                            width: widget.width,
                            decoration: BoxDecoration(
                              color: Color(0xFFF281C1),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.favorite,
                          size: 60,
                          color: Colors.white,
                        ),
                      ],
                    ) ; 
  }
}