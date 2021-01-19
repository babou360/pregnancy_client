import 'package:flutter/material.dart';
import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:pregnancy_tracking_app/Screens/mother/mother.dart';
import 'package:pregnancy_tracking_app/Screens/unPaied/UnPaiedScree.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/services/databaseService.dart';
import 'package:pregnancy_tracking_app/Screens/today/todayScreen.dart';
import 'package:pregnancy_tracking_app/Screens/baby/babyScreen.dart';
import 'package:pregnancy_tracking_app/Screens/mother/motherScreen.dart';
import 'package:pregnancy_tracking_app/Screens/tips/topicListScreen.dart';
import 'package:pregnancy_tracking_app/Screens/profile/profileScreen.dart';
import 'package:pregnancy_tracking_app/shared/greetings.dart';
import 'package:pregnancy_tracking_app/widget/CustomLoading.dart';

class HomeScreen extends StatefulWidget {
  String userId;
  HomeScreen(this.userId);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;

  DatabaseService _databaseService = DatabaseService();
  User currentUser = User();
  Greetings greeting = Greetings();
  int _currentIndex;
  Stream userStream;

  List<Widget> _currentBody() => [
        TodayScreen(currentUser),
        BabyScreen(currentUser),
        MotherNew(currentUser),
        // MotherScreen(currentUser),
        TopicListScreen(currentUser),
        ProfileScreen(currentUser)
      ];

  @override
  void initState() {
    super.initState();
    print(this.widget.userId);
    userStream = _databaseService.getUser(this.widget.userId);
    _currentIndex = 0;
  }

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    greeting.welcomeGreetings();
    final List<Widget> currentBody = _currentBody();
    return StreamBuilder(
      stream: userStream,
      builder: (context, currentUserSnap) {
        if (currentUserSnap.hasData && currentUserSnap.data.exists) {
          this.currentUser.name = currentUserSnap.data["name"];
          this.currentUser.age = currentUserSnap.data["age"];
          this.currentUser.mobileNumber = currentUserSnap.data["phoneNumber"];
          this.currentUser.lastPeriodDate =
              currentUserSnap.data["lastPeriodDate"].toDate();
          this.currentUser.dueDate = currentUserSnap.data['dueDate'].toDate();
          this.currentUser.profileImageURL =
              currentUserSnap.data["profileImage"];
          this.currentUser.weight = currentUserSnap.data["weight"];
          this.currentUser.bloodCount = currentUserSnap.data["bloodCount"];
          this.currentUser.joinedAt = currentUserSnap.data["joinedAt"].toDate();
          this.currentUser.renewalDate =
              currentUserSnap.data["renewalDate"].toDate();

          if (this.currentUser.renewalDate.compareTo(DateTime.now()) >= 0) {
            return SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: blockWidth * 5,
                            vertical: blockWidth * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            getTitle(_currentIndex),
                            getUserProfileIcon(_currentIndex),
                          ],
                        ),
                      ),
                      currentBody[_currentIndex],
                    ],
                  ),
                ),
                bottomNavigationBar: BubbleBottomBar(
                  opacity: 0.4,
                  backgroundColor: Colors.green[300],
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(30.0)),
                  currentIndex: _currentIndex,
                  hasInk: false,
                  hasNotch: false,
                  elevation: 30,
                  iconSize: blockWidth * 6,
                  inkColor: Colors.black,
                  onTap: changePage,
                  items: <BubbleBottomBarItem>[
                    BottomBarItem("Today", Icons.today),
                    BottomBarItem("Baby", Icons.child_care),
                    BottomBarItem("Mom", Icons.pregnant_woman),
                    BottomBarItem("Tips", Icons.view_agenda),
                    BottomBarItem("Profile", Icons.person_outline),
                  ],
                ),
              ),
            );
          } else {
            return UnPaiedScreen(currentUser);
          }
        } else {
          return Scaffold(body: CustomLoading());
        }
      },
    );
  }

  Column getTitle(currentIndex) {
    String title1;
    String title2;
    switch (currentIndex) {
      case 0:
        title1 = greeting.welcomeGreetings();
        title2 = this.currentUser.name.split(" ")[0];
        break;
      case 1:
        title1 = 'Baby`s';
        title2 = 'Development';
        break;
      case 2:
        title1 = 'Mother`s';
        title2 = 'Development';
        break;
      case 3:
        title1 = 'Tips';
        title2 = 'Get more knowledge';
        break;
      case 4:
        title1 = 'Profile';
        title2 = '';
        break;
      default:
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title1,
          style: TextStyle(
            fontSize: blockWidth * 7,
            fontWeight: FontWeight.w200,
            color: Colors.teal[900],
          ),
        ),
        Text(
          title2,
          style: TextStyle(
            fontSize: blockWidth * 4,
            fontWeight: FontWeight.w400,
            color: Colors.teal[900],
          ),
        ),
      ],
    );
  }

  getUserProfileIcon(int currentIndex) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(100)),
      ),
      child: CircleAvatar(
        backgroundImage: (currentUser.profileImageURL != null)
            ? NetworkImage(currentUser.profileImageURL)
            : AssetImage("images/defaultProfile.png"),
      ),
    );
  }

  BottomBarItem(String title, IconData icon) {
    return BubbleBottomBarItem(
      backgroundColor: Colors.green[100],
      icon: Icon(
        icon,
        color: Colors.green[100],
      ),
      activeIcon: Icon(
        icon,
        color: Colors.white,
        size: blockWidth * 4,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: blockWidth * 5),
      ),
    );
  }
}
