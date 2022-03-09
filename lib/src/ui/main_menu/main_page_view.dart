import 'package:flutter/material.dart';

import '../home_page/home_page_view.dart';

class MainMenuPageView extends StatelessWidget {
  const MainMenuPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Menu",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            child: const ListTile(
              leading: Icon(Icons.search, color: Colors.black),
              title: TextField(
                  decoration: InputDecoration(
                hintText: "search",
                border: InputBorder.none,
              )),
            ),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            decoration: BoxDecoration(
              border: Border.all(
                color: Color.fromARGB(255, 78, 66, 66),
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            constraints: BoxConstraints(
              maxHeight: 50,
              maxWidth: deviceWidth,
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 0.2 * deviceWidth,
                    maxHeight: 0.6 * deviceHeight,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: deviceWidth * 0.08,
                top: deviceHeight * 0.05,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomLeft: Radius.circular(80),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePageView()));
                    },
                    child: Container(
                      height: deviceHeight * 0.15,
                      width: deviceWidth * 0.85,
                      child: const Card(
                          child: Padding(
                        padding: EdgeInsets.only(left: 40.0),
                        child: Center(
                          child: ListTile(
                            title: Text(
                              "Food",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              "120 items",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: deviceWidth * 0.05,
                top: deviceHeight * 0.08,
                child: Container(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(
                            "https://picsum.photos/id/835/200/300"),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: deviceWidth * 0.03,
                top: deviceHeight * 0.1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.red,
                    // size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      primary: Colors.transparent),
                ),
              ),
// Second widget

              Positioned(
                left: deviceWidth * 0.08,
                top: deviceHeight * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    bottomLeft: Radius.circular(80),
                  ),
                  child: Container(
                    height: deviceHeight * 0.15,
                    width: deviceWidth * 0.85,
                    child: const Card(
                        child: Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            "Beverages",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "220 items",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                    )),
                  ),
                ),
              ),
              Positioned(
                left: deviceWidth * 0.05,
                top: deviceHeight * 0.28,
                child: Container(
                  height: 60,
                  width: 60,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                            "https://picsum.photos/id/431/200/300"),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                right: deviceWidth * 0.03,
                top: deviceHeight * 0.3,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.chevron_right_outlined,
                    color: Colors.red,
                    // size: 40,
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(10),
                      primary: Colors.transparent),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
