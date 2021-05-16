import 'package:flutter/material.dart';
import 'package:pregnancy_tracking_app/Screens/tips/subTopicList.dart';
import 'package:pregnancy_tracking_app/app/sizeConfig.dart';
import 'package:pregnancy_tracking_app/models/content.dart';
import 'package:pregnancy_tracking_app/models/user.dart';
import 'package:pregnancy_tracking_app/widget/CustomBannerText.dart';
import 'package:pregnancy_tracking_app/widget/CustomIconButton.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopicView extends StatefulWidget {
  User1 currentUser = User1();
  Content mainTopic = Content();
  TopicView(this.mainTopic, this.currentUser);

  @override
  _TopicViewState createState() => _TopicViewState();
}

class _TopicViewState extends State<TopicView> {
  double blockHeight = SizeConfig.safeBlockVertical;
  double blockWidth = SizeConfig.safeBlockHorizontal;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: blockHeight * 2,
                    horizontal: blockWidth * 4,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CustomIconButton(
                              icon: Icons.arrow_back,
                              callback: () {
                                Navigator.pop(context);
                              })
                        ],
                      ),
                      Container(
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
                          backgroundImage:
                              (this.widget.currentUser.profileImageURL == null)
                                  ? AssetImage("images/defaultProfile.png")
                                  : NetworkImage(
                                      this.widget.currentUser.profileImageURL,
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    // color: Colors.black26,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(6),
                          child: CustomBannerText(
                            fontFamily: '',
                            title: this.widget.mainTopic.title,
                            size: blockWidth * 5,
                            weight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 6),
                          child: CustomBannerText(
                              fontFamily: '',
                              title: this.widget.mainTopic.subtitle,
                              size: blockWidth * 2.5,
                              weight: FontWeight.w400,
                              color: Colors.grey[500],
                            ),
                        ),
                        SizedBox(height: blockHeight * 2),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                             constraints: BoxConstraints(
                                minHeight: 350,
                                maxHeight: 500,
                              ),
                            width: MediaQuery.of(context).size.width,
                            child: CachedNetworkImage(
                                imageUrl: this.widget.mainTopic.imageURL,fit: BoxFit.fill,
                                placeholder: (context, url) => Image.asset('images/place4.png',fit: BoxFit.cover),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                             ),
                           ),
                        ),
                        SizedBox(height: blockHeight * 2),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: blockWidth * 3,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: CustomBannerText(
                              title: this.widget.mainTopic.description,
                              size: blockWidth * 3.5,
                              fontFamily: '',
                              weight: FontWeight.w400,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SizedBox(height: blockHeight * 1),
                // Divider(
                //   thickness: 1.0,
                //   color: Colors.green[200],
                //   indent: blockWidth * 3,
                //   endIndent: blockWidth * 3,
                // ),
                SizedBox(height: blockHeight * 1),
                Column(
                  children: <Widget>[
                    SubTopicList(this.widget.mainTopic.id),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
