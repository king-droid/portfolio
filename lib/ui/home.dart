import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/assets.dart';
import 'package:portfolio/constants/fonts.dart';
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/constants/text_styles.dart';
import 'package:portfolio/models/education.dart';
import 'package:portfolio/utils/screen/screen_utils.dart';
import 'package:portfolio/widgets/responsive_widget.dart';

// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

List imgList = new List<String>();
List<Widget> imageSliders;

_getProjectsData(BuildContext context) async
{
  String data = await DefaultAssetBundle.of(context).loadString("assets/projectsData.json");
  final jsonResult = json.decode(data);
   print(data);
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    _getProjectsData(context);

    imgList.add("app1/screen1.png");
    imgList.add("app1/screen2.png");
    imgList.add("app1/screen3.png");
    imgList.add("app1/screen4.png");
    imgList.add("app1/screen5.png");
    imgList.add("app1/screen6.png");
    imgList.add("app1/screen7.png");

    imageSliders = imgList
        .map((item) =>
        Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset("projects/" + item,
                        fit: BoxFit.fitHeight, width: 600.0),
                  ],
                )),
          ),
        ))
        .toList();

    return Material(
      color: Color(0xFFF7F8FA),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: (ScreenUtil.getInstance().setWidth(108))), //144
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(context),
          drawer: _buildDrawer(context),
          body: LayoutBuilder(builder: (context, constraints) {
            return _buildBody(context, constraints);
          }),
        ),
      ),
    );
  }

  //AppBar Methods:-------------------------------------------------------------
  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: _buildTitle(),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions:
      !ResponsiveWidget.isSmallScreen(context) ? _buildActions() : null,
    );
  }

  Widget _buildTitle() {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.portfoli,
            style: TextStyles.logo,
          ),
          TextSpan(
            text: Strings.o,
            style: TextStyles.logo.copyWith(
              color: Color(0xFF50AFC0),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      MaterialButton(
        child: Text(
          Strings.menu_about,
          style: TextStyles.menu_item.copyWith(
            color: Color(0xFF50AFC0),
          ),
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menu_projects,
          style: TextStyles.menu_item,
        ),
        onPressed: () {},
      ),
      MaterialButton(
        child: Text(
          Strings.menu_contact,
          style: TextStyles.menu_item,
        ),
        onPressed: () {},
      ),
    ];
  }

  Widget _buildDrawer(BuildContext context) {
    return ResponsiveWidget.isSmallScreen(context)
        ? Drawer(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: _buildActions(),
      ),
    )
        : null;
  }

  //Screen Methods:-------------------------------------------------------------
  Widget _buildBody(BuildContext context, BoxConstraints constraints) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: constraints.maxWidth, minHeight: constraints.maxHeight),
        child: ResponsiveWidget(
          largeScreen: _buildLargeScreen(context),
          mediumScreen: _buildMediumScreen(context),
          smallScreen: _buildSmallScreen(context),
        ),
      ),
    );
  }

  Widget _buildLargeScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 1, child: _buildContent(context)),
              _buildIllustration(),
            ],
          ),
               SizedBox(height: 16.0),
              _buildProjects(context),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildMediumScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(flex: 1, child: _buildContent(context)),
              ],
            ),
          ),
          _buildProjects(context),
          _buildFooter(context)
        ],
      ),
    );
  }

  Widget _buildSmallScreen(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(flex: 1, child: _buildContent(context)),
          SizedBox(height: 16.0),
          _buildProjects(context),
          Divider(),
          _buildCopyRightText(context),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
          _buildSocialIcons(),
          SizedBox(
              height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 0.0),
        ],
      ),
    );
  }

  // Body Methods:--------------------------------------------------------------
  Widget _buildIllustration() {
    return Image.network(
      Assets.programmer3,
      height: ScreenUtil.getInstance().setWidth(345), //480.0
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 0.0),
        _buildAboutMe(context),
        SizedBox(height: 4.0),
        _buildHeadline(context),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 12.0 : 24.0),
        _buildSummary(),
        SizedBox(height: ResponsiveWidget.isSmallScreen(context) ? 24.0 : 48.0),
        ResponsiveWidget.isSmallScreen(context)
            ? Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //_buildEducation(),
            SizedBox(height: 24.0),
            _buildSkills(context),
            /* SizedBox(height: 24.0),
                  _buildProjects(context),*/
          ],
        )
        /*: _buildSkillsAndEducation(context),*/
            : Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //_buildEducation(),
            SizedBox(height: 24.0),
            _buildSkills(context),
            /* SizedBox(height: 24.0),
                  _buildProjects(context),*/
          ],
        ),
      ],
    );
  }

  Widget _buildAboutMe(BuildContext context) {
    return RichText(
      text: TextSpan(
        // Note: Styles for TextSpans must be explicitly defined.
        // Child text spans will inherit styles from parent
        style: TextStyle(
          fontSize: 14.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
            text: Strings.about,
            style: TextStyles.heading.copyWith(
              fontFamily: Fonts.nexa_light,
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
          TextSpan(
            text: Strings.me,
            style: TextStyles.heading.copyWith(
              color: Color(0xFF50AFC0),
              fontSize: ResponsiveWidget.isSmallScreen(context) ? 36 : 45.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            ResponsiveWidget.isSmallScreen(context)
                ? Strings.headline_part1
                : Strings.headline_part1.replaceFirst(RegExp(r' f'), '\nf'),
            style: TextStyles.sub_heading,
          ),
          Text(
            ResponsiveWidget.isSmallScreen(context)
                ? Strings.headline_part2
                : Strings.headline_part2.replaceFirst(RegExp(r' f'), '\nf'),
            style: TextStyles.body,
          )
        ]);
  }

  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.only(right: 80.0),
      child: Text(
        Strings.summary,
        style: TextStyles.body,
      ),
    );
  }

  Widget _buildSkillsAndEducation(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        /*Expanded(
          flex: 1,
          child: _buildEducation(),
        ),
        SizedBox(width: 40.0),*/
        Expanded(
          flex: 1,
          child: _buildSkills(context),
        ),
      ],
    );
  }

  // Skills Methods:------------------------------------------------------------
  final skills = [
    'Java',
    'Kotlin',
    'Dart',
    'Flutter',
    'Android',
    'Bit Bucket',
    'NodeJS',
    'Git',
    'Jenkins',
    'Firebase',
    'AWS EC2 configure',
    'server setup',
    'Backend APIs',
    'Promotional Web Site',
  ];

  Widget _buildSkills(BuildContext context) {
    final List<Widget> widgets = skills
        .map((skill) =>
        Padding(
          padding: EdgeInsets.only(right: 8.0, bottom: 10, top: 5),
          child: _buildSkillChip(context, skill),
        ))
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildSkillsContainerHeading(),
        Padding(
            padding: EdgeInsets.only(top: 10), child: Wrap(children: widgets)),
//        _buildNavigationArrows(),
      ],
    );
  }

  Widget _buildSkillsContainerHeading() {
    return Text(
      Strings.skills_i_have,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildSkillChip(BuildContext context, String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyles.chip.copyWith(
          fontSize: ResponsiveWidget.isSmallScreen(context) ? 10.0 : 11.0,
        ),
      ),
    );
  }

  // Education Methods:---------------------------------------------------------
  final educationList = [
    Education(
      'May 2019',
      'Present',
      'HCL Technologies',
      'Technical Lead',
    ),
    Education(
      'Apr 2016',
      'May 2019',
      'Techugo Pvt. Ltd.',
      'Sr. Software Engineer',
    ),
    /*Education(
      'July 2014',
      'March 2016',
      'Citrusbits',
      'Software Engineer',
    ),*/
  ];

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildEducationContainerHeading(),
        SizedBox(width: 16.0),
        _buildEducationSummary(),
        SizedBox(height: 8.0),
        _buildEducationTimeline(),
      ],
    );
  }

  Widget _buildProjects(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildProjectsContainerHeading(),
          SizedBox(width: 40.0),
          _buildProjectsDetails(),
          SizedBox(width: 50.0),
          ResponsiveWidget.isSmallScreen(context)
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildProjectsCard(context),
              _buildProjectContent(context),
              _buildProjectsCard(context),
              _buildProjectContent2(context),
            ],
          )
              : Container(
          child:Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
            flex: 1,
            child:_buildProjectsCard(context),),
            Expanded(
              flex: 1,
              child:_buildProjectContent(context),), Expanded(
            flex: 1,
            child:_buildProjectsCard(context),),
            Expanded(
              flex: 1,
              child:_buildProjectContent2(context),),
        ],
      ),)],
    )
    ,
    );
  }

  Widget _buildEducationContainerHeading() {
    return Text(
      Strings.experience,
      style: TextStyles.sub_heading,
    );
  }

  Widget _buildProjectsContainerHeading() {
    return Text(
      Strings.projects,
      style: TextStyles.sub_heading_bold,
    );
  }

  Widget _buildProjectContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "Khaad Dealer",
              style: TextStyles.sub_heading,
            ),
          ),
          SizedBox(width: 40.0),
          Container(
            child: Text(
              'Get online with Khaad Dealer, connect with your network and grow your business with information at your fingertips. Here are a few of the many benefits that Khaad Dealer provides for the fertilizer dealers and farmers: \n 1. Analyze your stock and sales v/s your peer \n 2. Know what the farmers are purchasing in your distric \n 3. Directly connect with your distributors and retailers \n 4. Automated notifications with updates on stock and sales \n 5. Get competitive analysis, stock reorder alerts, and secondary sales digitization',
              style: TextStyles.body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectContent2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              "My Follow Up",
              style: TextStyles.sub_heading,
            ),
          ),
          SizedBox(width: 40.0),
          Container(
            child: Text(
              'My Follow Up is a smartphone application specially designed by a group of senior doctors keeping in mind the intricate relationship of the doctor and his or her patient for an online follow up . My Follow Up main desire is to keep it simple yet informative. My Follow Up enables patients to upload their reports before the call so that doctors can examine, diagnose accordingly and give medical advice on a simple phone call, followed by an online prescription.',
              style: TextStyles.body,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 350,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          disableCenter: true
        ),
        items: imageSliders,
      ),
    );
  }

  Widget _buildProjectsCard2(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 50),
      height: 350,
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 1.0,
          enlargeCenterPage: true,
          disableCenter: true
        ),
        items: imageSliders,
      ),
    );
  }

  Widget _buildProjectsDetails() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              'Here are some of my Projects I worked and delivered utilizing my knowledge and skills.',
              style: TextStyles.body,
            ),
          ),
        ],
      ),);
  }

  Widget _buildEducationSummary() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            '5 years (Android), 2 years (Flutter)',
            style: TextStyles.body,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationTimeline() {
    final List<Widget> widgets = educationList
        .map((education) => _buildEducationTile(education))
        .toList();
    return Column(children: widgets);
  }

  Widget _buildEducationTile(Education education) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            '${education.post}',
            style: TextStyles.company,
          ),
          Text(
            '${education.organization}',
            style: TextStyles.body.copyWith(
              color: Color(0xFF45405B),
            ),
          ),
          Text(
            '${education.from}-${education.to}',
            style: TextStyles.body,
          ),
        ],
      ),
    );
  }

  // Footer Methods:------------------------------------------------------------
  Widget _buildFooter(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(),
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                child: _buildCopyRightText(context),
                alignment: Alignment.centerLeft,
              ),
              Align(
                child: _buildSocialIcons(),
                alignment: Alignment.centerRight,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCopyRightText(BuildContext context) {
    return Text(
      Strings.rights_reserved,
      style: TextStyles.body1.copyWith(
        fontSize: ResponsiveWidget.isSmallScreen(context) ? 8 : 10.0,
      ),
    );
  }

  Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            html.window
                .open("https://www.linkedin.com/in/zubairehman/", "LinkedIn");
          },
          child: Image.network(
            Assets.linkedin,
            color: Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        GestureDetector(
          onTap: () {
            html.window.open("https://github.com/zubairehman", "Github");
          },
          child: Image.network(
            Assets.google,
            color: Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),
        SizedBox(width: 16.0),
        /*GestureDetector(
          onTap: () {
            html.window.open("https://twitter.com/zubair340", "Twitter");
          },
          child: Image.network(
            Assets.twitter,
            color: Color(0xFF45405B),
            height: 20.0,
            width: 20.0,
          ),
        ),*/
      ],
    );
  }
}
