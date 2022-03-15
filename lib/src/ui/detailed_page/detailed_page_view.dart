import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/bloc/detailed_drink_bloc/detailed_drink_bloc.dart';
import 'package:recipe_app/src/bloc/detailed_drink_bloc/detailed_drink_event.dart';
import 'package:recipe_app/src/bloc/detailed_drink_bloc/detailed_drink_state.dart';
import 'package:recipe_app/src/bloc/detailed_food_bloc/detailed_food_bloc.dart';
import 'package:recipe_app/src/bloc/detailed_food_bloc/detailed_food_event.dart';
import 'package:recipe_app/src/bloc/detailed_food_bloc/detailed_food_state.dart';
import 'package:recipe_app/src/model/detailed_drink_model.dart';
import 'package:recipe_app/src/model/detailed_food_model.dart';

class DetailedPageView extends StatefulWidget {
  String selectedID;
  String category;
  DetailedPageView({Key? key, required this.selectedID, required this.category})
      : super(key: key);

  @override
  State<DetailedPageView> createState() =>
      _DetailedPageViewState(selectedID, category);
}

class _DetailedPageViewState extends State<DetailedPageView>
    with SingleTickerProviderStateMixin {
  String selectedId;
  String category;
  _DetailedPageViewState(this.selectedId, this.category);
  final DetailedFoodBloc _foodBloc = DetailedFoodBloc();
  final DetailedDrinkBloc _drinkBloc = DetailedDrinkBloc();

  late TabController _tabController;
  var noOfServings = 1;
  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    category == "food"
        ? _foodBloc.add(GetDetailedFoodData(selectedId))
        : _drinkBloc.add(GetDetailedDrinkData(selectedId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          if (category == "food") {
            return FoodData();
          } else {
            return DrinkData();
          }
        },
      ),
    );
  }

  Widget FoodData() {
    return Container(
      child: BlocProvider(
        create: (context) => _foodBloc,
        child: BlocListener<DetailedFoodBloc, DetailedFoodState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is DetailedFoodStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<DetailedFoodBloc, DetailedFoodState>(
            builder: (context, state) {
              if (state is DetailedFoodStateInitial) {
                return loader();
              } else if (state is DetailedFoodStateLoading) {
                return loader();
              } else if (state is DetailedFoodStateLoaded) {
                return foodDetailedData(state.foodModel);
              } else {
                return const Center(
                  child: Text("No Data Found"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget foodDetailedData(DetailedFoodModel data) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 250.0,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                data.meals[0]["strMealThumb"]!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: 0,
              left: 20,
              child: Row(
                children: const [
                  Icon(Icons.star_half),
                  SizedBox(
                    width: 10,
                  ),
                  Text("4.5"),
                ],
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
                  const Divider(
                    color: Colors.black45,
                    thickness: 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TabBar(
                      controller: _tabController,
                      indicator: const BoxDecoration(
                          color: Colors.red,
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      unselectedLabelColor: Colors.black38,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(
                          text: ("Ingredients"),
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
                  Container(
                    height: 200,
                    child: TabBarView(controller: _tabController, children: [
                      //////////// Ingredients tab ////////////////
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Ingredients For",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "$noOfServings servings",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                color: Colors.black45,
                                thickness: 0.4,
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        noOfServings++;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text("$noOfServings"),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        noOfServings--;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Builder(builder: (context) {
                                  if (data.meals[0]
                                              ["strIngredient${index + 1}"] ==
                                          "" ||
                                      data.meals[0]
                                              ["strIngredient${index + 1}"] ==
                                          null) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return ListTile(
                                        leading: Image.network(
                                            data.meals[0]["strMealThumb"]!),
                                        title: Text(data.meals[0]
                                                ["strIngredient${index + 1}"] ??
                                            ""),
                                        subtitle: Row(
                                          children: [
                                            Builder(builder: (context) {
                                              if ((data.meals[0][
                                                      "strMeasure${index + 1}"])
                                                  .toString()
                                                  .contains(RegExp(r'[0-9]'))) {
                                                return Text((int.parse(
                                                          ((data.meals[0][
                                                                  "strMeasure${index + 1}"])!)
                                                              .replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  ''),
                                                        ) *
                                                        noOfServings)
                                                    .toString());
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            }),
                                            Text((data.meals[0]
                                                    ["strMeasure${index + 1}"]!)
                                                .replaceAll(
                                                    RegExp("[^A-Za-z]"), ""))
                                          ],
                                        ));
                                  }
                                });
                              },
                              itemCount: 20,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Text("${data.meals[0]['strInstructions']}")),
                      ),
                      const Text("Nice work"),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget DrinkData() {
    return Container(
      child: BlocProvider(
        create: (context) => _drinkBloc,
        child: BlocListener<DetailedDrinkBloc, DetailedDrinkState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is DetailedDrinkStateError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.messsage!),
                ),
              );
            }
          },
          child: BlocBuilder<DetailedDrinkBloc, DetailedDrinkState>(
            builder: (context, state) {
              if (state is DetailedDrinkStateInitial) {
                return loader();
              } else if (state is DetailedDrinkStateLoading) {
                return loader();
              } else if (state is DetailedDrinkStateLoaded) {
                return drinkDetailedData(state.drinkModel);
              } else {
                return const Center(
                  child: Text("No Data Found"),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget drinkDetailedData(DetailedDrinkModel data) {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: 250.0,
        flexibleSpace: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                data.drinks[0]["strDrinkThumb"]!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: 0,
              left: 20,
              child: Row(
                children: const [
                  Icon(Icons.star_half),
                  SizedBox(
                    width: 10,
                  ),
                  Text("4.5"),
                ],
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
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Icon(Icons.message),
                          ),
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
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.share_outlined),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.black45,
                    thickness: 0.4,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 20.0),
                    child: TabBar(
                      controller: _tabController,
                      indicator: const BoxDecoration(
                          color: Colors.red,
                          // shape: BoxShape.circle,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      unselectedLabelColor: Colors.black38,
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: const [
                        Tab(
                          text: ("Ingredients"),
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
                  const Divider(
                    color: Colors.black45,
                    thickness: 0.4,
                  ),
                  Container(
                    height: 200,
                    child: TabBarView(controller: _tabController, children: [
                      //////////// Ingredients tab ////////////////
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Text(
                                        "Ingredients For",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "$noOfServings servings",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.0),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        noOfServings++;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.add_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                  Text("$noOfServings"),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        noOfServings--;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.remove_circle,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              // physics: const NeverScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return Builder(builder: (context) {
                                  if (data.drinks[0]
                                              ["strIngredient${index + 1}"] ==
                                          "" ||
                                      data.drinks[0]
                                              ["strIngredient${index + 1}"] ==
                                          null ||
                                      data.drinks[0]
                                              ["strMeasure${index + 1}"] ==
                                          "" ||
                                      data.drinks[0]
                                              ["strMeasure${index + 1}"] ==
                                          null) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return ListTile(
                                        leading: Image.network(
                                            data.drinks[0]["strDrinkThumb"]!),
                                        title: Text(data.drinks[0]
                                                ["strIngredient${index + 1}"] ??
                                            ""),
                                        subtitle: Row(
                                          children: [
                                            Builder(builder: (context) {
                                              if ((data.drinks[0][
                                                      "strMeasure${index + 1}"])
                                                  .toString()
                                                  .contains(RegExp(r'[0-9]'))) {
                                                return Text((int.parse(
                                                          ((data.drinks[0][
                                                                  "strMeasure${index + 1}"])!)
                                                              .replaceAll(
                                                                  RegExp(
                                                                      '[^0-9]'),
                                                                  ''),
                                                        ) *
                                                        noOfServings)
                                                    .toString());
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            }),
                                            Text((data.drinks[0]
                                                    ["strMeasure${index + 1}"]!)
                                                .replaceAll(
                                                    RegExp("[^A-Za-z]"), ""))
                                          ],
                                        ));
                                  }
                                });
                              },
                              itemCount: 15,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child:
                                Text("${data.drinks[0]['strInstructions']}")),
                      ),
                      const Text("Nice work"),
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget loader() => const Center(
        child: CircularProgressIndicator(),
      );
}
