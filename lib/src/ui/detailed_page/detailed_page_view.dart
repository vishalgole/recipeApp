import 'package:flutter/material.dart';

class DetailedPageView extends StatefulWidget {
  const DetailedPageView({Key? key}) : super(key: key);

  @override
  State<DetailedPageView> createState() => _DetailedPageViewState();
}

class _DetailedPageViewState extends State<DetailedPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: 250.0,
          // flexibleSpace: FlexibleSpaceBar(
          //   title: const Text(
          //     "Vishal",
          //     textScaleFactor: 1,
          //   ),
          //   background: Image.network(
          //     "https://images.hindustantimes.com/img/2021/12/28/1600x900/8606d7ba-67bd-11ec-8650-baa05d62cfe0_1640684458053.jpg",
          //     fit: BoxFit.cover,
          //   ),
          // ),
          flexibleSpace: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  "https://images.hindustantimes.com/img/2021/12/28/1600x900/8606d7ba-67bd-11ec-8650-baa05d62cfe0_1640684458053.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 10.0),
                    child: Image.asset(
                      "assets/images/play_button.png",
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.message),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text("350"),
                          ],
                        ),
                        SizedBox(
                          height: 50.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              Icon(Icons.star_border_outlined),
                              SizedBox(
                                width: 30.0,
                              ),
                              Icon(Icons.bookmark_add_outlined),
                              SizedBox(
                                width: 30.0,
                              ),
                              Icon(Icons.share_outlined),
                            ],
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      child: TabBar(
                        controller: _tabController,
                        indicator: const BoxDecoration(
                            color: Colors.red,
                            // shape: BoxShape.circle,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        unselectedLabelColor: Colors.black38,
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: const [
                          Tab(
                            text: ("Ingredeints"),
                          ),
                          Tab(
                            text: ("Steps"),
                          ),
                          Tab(
                            text: ("Nutritions"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: TabBarView(controller: _tabController, children: [
                        Text("Vishal"),
                        Text("Rajendra"),
                        Text("Gole"),
                      ]),
                    )
                    // TabBarView(
                    //   children: const [
                    //     Text("Vishal"),
                    //     Text("Rajendra"),
                    //     Text("Gole"),
                    //   ],
                    //   controller: _tabController,
                    // ),
                  ],
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
