import 'package:flutter/material.dart';
import 'package:kos/MenuScreen.dart';

import 'FrontScreen.dart';
import 'package:vibration/vibration.dart';


class Choosescreen extends StatefulWidget {
  const Choosescreen({Key? key}) : super(key: key);

  @override
  _ChoosescreenState createState() => _ChoosescreenState();
}

class _ChoosescreenState extends State<Choosescreen> {
  bool _isEatInSelected = false;
  bool _isTakeAwaySelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Spacer(),
            // Logo at the top
            Center(
              child: Image.asset(
                'assets/logo.png', // Replace with your logo asset path
                width: 500,
              ),
            ),
            const SizedBox(height: 24.0),
            // Text
            Center(
              child: Text(
                'Where would you like to eat?',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 32.0),
            // Two containers in a row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {

                    setState(() {
                      _isEatInSelected = !_isEatInSelected;
                      _isTakeAwaySelected = false;
                    });
                    Vibration.vibrate(duration: 100, amplitude: 128);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen(),));
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isEatInSelected
                            ? [Colors.blueAccent, Colors.blue]
                            : [Colors.blueAccent, Colors.lightBlueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Eat In',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Image.asset(
                            'assets/eatin.png', // Replace with your actual asset path
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      _isTakeAwaySelected = !_isTakeAwaySelected;
                      _isEatInSelected = false;
                    });
                    Vibration.vibrate(duration: 100, amplitude: 128);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen(),));
                  },
                  borderRadius: BorderRadius.circular(4.0),
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: 200,
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: _isTakeAwaySelected
                            ? [Colors.greenAccent, Colors.green]
                            : [Colors.greenAccent, Colors.lightGreenAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Take Away',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8),
                          Image.asset(
                            'assets/takeaway.png', // Replace with your actual asset path
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Two containers in a row at the bottom
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        Vibration.vibrate(duration: 100, amplitude: 128);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Frontscreen(),));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.restart_alt, color: Colors.black54),
                              SizedBox(width: 8),
                              Text(
                                'Start Over',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    flex: 2,
                    child: InkWell(
                      onTap: () {
                        print('Accessibility tapped!');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 5.0,
                              spreadRadius: 1.0,
                              offset: Offset(2.0, 2.0),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image_not_supported, color: Colors.black54),
                              SizedBox(width: 8),
                              Text(
                                'Accessibility',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
