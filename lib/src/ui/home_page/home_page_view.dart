import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_bloc.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_event.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_state.dart';

import '../../model/item.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);
  double _page = 0;

  final FoodCategoryBloc _fcBloc = FoodCategoryBloc();

  @override
  void initState() {
    super.initState();
    _fcBloc.add(GetFoodCategoryList());
    _pageController.addListener(() {
      if (_pageController.page != null) {
        _page = _pageController.page!;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    var deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Good Morning Akila!",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text("Delivering to"),
                DropdownButton<String>(
                  hint: const Text("Current Location"),
                  items: <String>['Current Location'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
                Container(
                  child: const ListTile(
                    leading: Icon(Icons.search, color: Colors.black),
                    title: TextField(
                        decoration: InputDecoration(
                      hintText: "Search Food",
                      border: InputBorder.none,
                    )),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 78, 66, 66),
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 50,
                    maxWidth: deviceWidth,
                  ),
                ),
                BlocProvider(
                  create: (context) => _fcBloc,
                  child: BlocListener<FoodCategoryBloc, FoodCategoryState>(
                    listener: (context, state) {
                      // TODO: implement listener
                      if (state is FoodCategoryStateError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.message!),
                          ),
                        );
                      }
                    },
                    child: BlocBuilder<FoodCategoryBloc, FoodCategoryState>(
                      builder: (context, state) {
                        if (state is FoodCategoryStateIniitial) {
                          return loader();
                        } else if (state is FoodCategoryStateLoading) {
                          return loader();
                        } else if (state is FoodCategoryStateLoaded) {
                          return CarouselSlider(
                            options: CarouselOptions(
                              disableCenter: true,
                              scrollPhysics: BouncingScrollPhysics(),
                              height: 150,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.3,
                              initialPage: 0,
                              enableInfiniteScroll: false,
                              reverse: false,
                              autoPlay: false,
                              enlargeCenterPage: false,
                              scrollDirection: Axis.horizontal,
                            ),
                            items: state.foodCatModel.categories.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(25)),
                                        child: Container(
                                          height: 130,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          child: FittedBox(
                                            child: Image.network(
                                              i.strCategoryThumb,
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          i.strCategory,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            }).toList(),
                          );
                        } else {
                          return const Center(
                            child: Text("No Data Found"),
                          );
                        }
                      },
                    ),
                  ),
                )
              ]),
        ),
      ),
    );
  }

  Widget loader() => const Center(
        child: CircularProgressIndicator(),
      );
}
