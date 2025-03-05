import 'package:flutter/material.dart';

class WelcomeWidget extends StatefulWidget {
  const WelcomeWidget({super.key});

  @override
  State<WelcomeWidget> createState() => _WelcomeWidgetState();
}

class _WelcomeWidgetState extends State<WelcomeWidget> {

  int mainColor = 0xFFD9D9D9 ; 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: 19,
        child: Container(
          width: 184,
          height: 298,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(mainColor), width: 3)),
          child: Column(
            spacing: 10,
            children: [
              Expanded(
                child: Container(
                  width: 147,
                  height: 50,
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Color(mainColor), borderRadius: BorderRadius.circular(15)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(mainColor),
                        borderRadius: BorderRadius.circular(15)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network("https://res.cloudinary.com/dzfeowrkg/image/upload/v1741155664/S__31408133_0_gdmsum.jpg" , fit: BoxFit.cover),
                    )
                  ),
                  Container(
                    width: 70,
                    height: 70,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2 , mainAxisSpacing: 5 , crossAxisSpacing: 5),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Color(mainColor),
                              borderRadius: BorderRadius.circular(10)),
                        );
                      },
                    ),
                  )
                ],
              ) , 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 147,
                    height: 140,
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4 , mainAxisSpacing: 5 , crossAxisSpacing: 5),
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                              color: Color(mainColor),
                              borderRadius: BorderRadius.circular(10)),
                        );
                      },
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
