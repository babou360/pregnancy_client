import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/imageSlider/sliderControl.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/Screens/home/homeScreen.dart';
import 'package:pregnancy_tracking_app/widget/CustomButton.dart';

class SliderPage extends StatefulWidget {
  User loginUser;
  SliderPage(this.loginUser);
  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  int _currentPage = 0;
  PageController _controller = PageController();

  List<Widget> _slidePages = [
    SliderControl(
        description:
            "Every week during pregnancy, We provide you with important information",
        imagePath: "images/slider1.jpg"),
    SliderControl(
        description: "We plan a healthy diet for you during pregnancy",
        imagePath: "images/slider2.jpg"),
    SliderControl(
        description:
            "We monitor the progress of you and you`r baby during pregnancy",
        imagePath: "images/slider3.jpg")
  ];

  onClickSkip() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(this.widget.loginUser.mobileNumber),
      ),
    );
  }

  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: _slidePages.length,
              onPageChanged: _onChanged,
              itemBuilder: (context, int index) {
                return _slidePages[index];
              },
            ),
            Positioned(
              top: blockHeight * 4,
              right: blockWidth * 7.5,
              child: CustomButton(
                title: "Skip",
                width: blockWidth * 20,
                height: blockHeight * 5,
                bgColor: Colors.green[50],
                textColor: Colors.black87,
                fontSize: blockHeight * 2,
                callback: onClickSkip,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: blockWidth * 5),
                      child: InkWell(
                        onTap: () {
                          (_currentPage == 0)
                              ? Navigator.pop(context)
                              : _controller.previousPage(
                                  duration: Duration(milliseconds: 800),
                                  curve: Curves.easeInOutQuint,
                                );
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: blockWidth * 10,
                          width: blockWidth * 10,
                          alignment: Alignment.bottomRight,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            size: blockWidth * 10,
                            color: Colors.teal[500],
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(
                        _slidePages.length,
                        (int index) {
                          return AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: blockHeight * 1,
                            width: (index == _currentPage)
                                ? blockWidth * 7.5
                                : blockWidth * 2.5,
                            margin: EdgeInsets.symmetric(
                              horizontal: blockWidth * 1,
                              vertical: blockHeight * 4,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: (index == _currentPage)
                                  ? Colors.green[300]
                                  : Colors.green[300].withOpacity(0.5),
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: blockWidth * 5),
                      child: InkWell(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 300),
                          height: blockWidth * 10,
                          alignment: Alignment.center,
                          width: (_currentPage == _slidePages.length - 1)
                              ? blockWidth * 20
                              : blockWidth * 10,
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: (_currentPage == _slidePages.length - 1)
                              ? Text(
                                  "Start",
                                  style: TextStyle(
                                    fontSize: blockHeight * 2,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              : Icon(
                                  Icons.chevron_right,
                                  size: blockWidth * 10,
                                  color: Colors.teal[500],
                                ),
                        ),
                        onTap: () {
                          if (_currentPage == _slidePages.length - 1) {
                            Navigator.pop(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    this.widget.loginUser.mobileNumber),
                              ),
                            );
                          } else {
                            _controller.nextPage(
                              duration: Duration(milliseconds: 800),
                              curve: Curves.easeInOutQuint,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
