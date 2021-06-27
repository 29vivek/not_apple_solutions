import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({ Key? key }) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with AutomaticKeepAliveClientMixin<AboutPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(

    );
  }

  @override
  bool get wantKeepAlive => true;
}
