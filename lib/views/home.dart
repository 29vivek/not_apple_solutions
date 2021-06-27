

import 'package:flutter/material.dart';
import 'package:not_apple_solutions/views/about_page.dart';
import 'package:not_apple_solutions/views/order_page.dart';
import 'package:not_apple_solutions/views/status_page.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {

  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    // _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    // _tabController.removeListener(_handleTabChange);
    // _tabController.dispose();
    super.dispose();
  }

  // void _handleTabChange() {
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            // controller: _tabController,
            tabs: [
              Tab(text: 'Order'),
              Tab(text: 'Status'),
              Tab(text: 'About',)
            ],
          ),
          title: Text('Print RVCE Final Year Reports'),
        ),
        body: TabBarView(
          // controller: _tabController,
          children: [
            OrderPage(),
            StatusPage(),
            AboutPage()
          ],
        ),
        // floatingActionButton: _renderFAB(),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  // Widget? _renderFAB() {
  //   switch(_tabController.index) {
  //     case 0:
  //       return Visibility(
  //         visible: MediaQuery.of(context).viewInsets.bottom == 0,
  //         child: FloatingActionButton.extended(onPressed: () {}, label: Text("Place Order"))
  //       );
  //     case 1:
  //       return Visibility(
  //         visible: MediaQuery.of(context).viewInsets.bottom == 0,
  //         child: FloatingActionButton.extended(onPressed: () {}, label: Text("Search"))
  //       );
  //     default:
  //       return Visibility(
  //         visible: MediaQuery.of(context).viewInsets.bottom == 0,
  //         child: FloatingActionButton.extended(onPressed: () {}, label: Text("Buy Tea"))
  //       );
  //   }
  // }
}
