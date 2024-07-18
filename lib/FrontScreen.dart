import 'dart:async';
import 'package:kos/ChooseScreen.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';


class Frontscreen extends StatefulWidget {
  const Frontscreen({Key? key}) : super(key: key);

  @override
  _FrontscreenState createState() => _FrontscreenState();
}

class _FrontscreenState extends State<Frontscreen> {
  final PageController _pageController = PageController();
  late Timer _timer;
 late int nextPage=0;
  final List<String> _images = [
    'assets/image1.jpg',
    'assets/image2.jpg',
    'assets/image3.jpg',

  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 6), (Timer timer) {
      if (nextPage >= _images.length) {
        nextPage = 0;
      }
      _pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      nextPage++;
    });
  }


  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();
    return Scaffold(
      body: Column(
        children: [
          // Image slider occupying 70% of the screen height
          Expanded(
            flex: 7,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _images.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  _images[index],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Center(child: Text('Image not found'));
                  },
                );
              },
            ),
          ),
          // Row with two containers occupying 30% of the screen height
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Color.fromARGB(255, 255, 216, 0),
                    margin: EdgeInsets.only(top: 20,left: 20,right: 20),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        // Get the current screen width and height
                        final screenWidth = constraints.maxWidth;
                        final screenHeight = constraints.maxHeight;

                        // Calculate responsive font sizes and image height
                        final fontSize1 = screenWidth * 0.075;
                        final fontSize2 = screenWidth * 0.055;
                        final imageHeight = screenHeight * 0.5;
                        final spacing = screenHeight * 0.02;

                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Scan or tab for',
                              style: TextStyle(
                                fontSize: fontSize1,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: spacing * 0.1),
                            Text(
                              'Details & more',
                              style: TextStyle(
                                fontSize: fontSize2,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: spacing * 0.2),
                            Image.asset(
                              'assets/qr.png',
                              height: imageHeight,
                            ),
                            SizedBox(height: spacing * 0.1),
                            Icon(
                              Icons.keyboard_arrow_down_sharp,
                              color: Colors.black,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),


                Expanded(
                  child: Container(

                    margin: EdgeInsets.only(right: 20,left: 20,top: 20),
                    child: Center(
                        child: Column(
                          children: [
                            Expanded(
                              flex: 5,
                              child: InkWell(
                                onTap: () {
                                  // Handle the button tap
                                  Vibration.vibrate(duration: 100, amplitude: 128);
                               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Choosescreen(),));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Start Order',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'to get deliciousness',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 8,),
                            Expanded(
                              flex: 3,
                              child: InkWell(
                                onTap: () {
                                  // Handle the button tap
                                  print('Button tapped!');
                                  // Add your desired action here
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.image_not_supported, color: Colors.black54),
                                        SizedBox(width: 8), // Adjust spacing as needed
                                        Text(
                                          'Accessibility',
                                          style: TextStyle(fontSize: 16, color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 8,),
                            Expanded(
                          flex: 3,
                              child: Text('2,000 calories a day is used for general nutrition advice,but calorie needs vary.Additional nutrition information available upon request.2,000 calories a day is used for general nutrition advice,but calorie needs can vary.Additional nutrition information avaible upon request.Additional nutrition information',style: TextStyle(fontSize: 9,color: Colors.black54),)
                            ),
                            SizedBox(height: 4,)
                          ],
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
