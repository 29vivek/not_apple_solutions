import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({ Key? key }) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> with AutomaticKeepAliveClientMixin<StatusPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(

    );
  }

  @override
  bool get wantKeepAlive => true;
}
