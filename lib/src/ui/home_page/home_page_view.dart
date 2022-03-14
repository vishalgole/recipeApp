import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_app/src/bloc/drink_category_bloc/drink_category_bloc.dart';
import 'package:recipe_app/src/bloc/drink_category_bloc/drink_category_event.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_bloc.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_event.dart';
import 'package:recipe_app/src/bloc/food_category_bloc/food_category_state.dart';
import 'package:recipe_app/src/bloc/selected_category_bloc/selected_category_bloc.dart';
import 'package:recipe_app/src/bloc/selected_category_bloc/selected_category_event.dart';
import 'package:recipe_app/src/bloc/selected_category_bloc/selected_category_state.dart';
import 'package:recipe_app/src/bloc/selected_drink_category_bloc/selected_drink_category_bloc.dart';
import 'package:recipe_app/src/bloc/selected_drink_category_bloc/selected_drink_category_event.dart';
import 'package:recipe_app/src/bloc/selected_drink_category_bloc/selected_drink_category_state.dart';
import 'package:recipe_app/src/model/selected_category_model.dart';
import 'package:recipe_app/src/model/selected_drink_category_model.dart';
import 'package:recipe_app/src/ui/detailed_page/detailed_page_view.dart';

import '../../bloc/drink_category_bloc/drink_category_state.dart';

class HomePageView extends StatefulWidget {
  String selectedVal = "";
  HomePageView({Key? key, required this.selectedVal}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState(selectedVal);
}

class _HomePageViewState extends State<HomePageView> {
  String selectedVal = "";
  _HomePageViewState(this.selectedVal);

  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 0);
  double _page = 0;

  final FoodCategoryBloc _fcBloc = FoodCategoryBloc();
  final DrinkCategoryBloc _dcBloc = DrinkCategoryBloc();
  final SelectedCategoryBloc _scBloc = SelectedCategoryBloc();
  final SelectedDrinkCategoryBloc _sdBloc = SelectedDrinkCategoryBloc();
  bool isCatSelected = false;

  @override
  void initState() {
    super.initState();
    _fcBloc.add(GetFoodCategoryList());
    _dcBloc.add(GetDrinkCategoryList());

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
                  child: ListTile(
                    leading: const Icon(Icons.search, color: Colors.black),
                    title: TextField(
                        decoration: InputDecoration(
                      hintText: selectedVal == "food"
                          ? "Search Food"
                          : "Search Drink",
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
                selectedVal == "food" ? foodCatModel() : drinkCatModel(),
                isCatSelected
                    ? Column(
                        children: const [
                          SizedBox(height: 40.0),
                          Text(
                            "Popular Food",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20.0),
                        ],
                      )
                    : const SizedBox.shrink(),
                Builder(builder: (context) {
                  if (isCatSelected && selectedVal == "food") {
                    return categoryListData();
                  } else if (isCatSelected && selectedVal == "drink") {
                    return categoryDrinkListData();
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
              ]),
        ),
      ),
    );
  }

  Widget categoryDrinkListData() {
    return BlocProvider(
      create: (context) => _sdBloc,
      child:
          BlocListener<SelectedDrinkCategoryBloc, SelectedDrinkCategoryState>(
        listener: (context, state) {
          if (state is SelectedDrinkCategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child:
            BlocBuilder<SelectedDrinkCategoryBloc, SelectedDrinkCategoryState>(
                builder: (context, state) {
          if (state is SelectedDrinkCategoryInitial) {
            return loader();
          } else if (state is SelectedDrinkCategoryLoading) {
            return loader();
          } else if (state is SelectedDrinkCategoryLoaded) {
            return selectedDrinkCatModel(state.categoriesModel);
          } else {
            return const Center(
              child: Text("No Data Found"),
            );
          }
        }),
      ),
    );
  }

  Widget selectedDrinkCatModel(SelectedDrinkCategoriesModel data) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              margin: const EdgeInsets.only(right: 20.0, bottom: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                    child: FittedBox(
                      child: Image.network(
                          data.drinks[index].strDrinkThumb.toString()
                          // data.drinks![index].strDrinkThumb,
                          ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                    child: Text(
                      data.drinks[index].strDrink.toString(),
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w800),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
                    child: Row(children: const [
                      Icon(
                        Icons.star,
                        color: Colors.red,
                      ),
                      Text(
                        "4.9",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        " (124 ratings ) Cafe Western Food",
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
          ],
        );
      },
      itemCount: data.drinks.length,
    );
  }

  Widget categoryListData() {
    return BlocProvider(
      create: (context) => _scBloc,
      child: BlocListener<SelectedCategoryBloc, SelectedCategoryState>(
        listener: (context, state) {
          if (state is SelectedCategoryStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<SelectedCategoryBloc, SelectedCategoryState>(
            builder: (context, state) {
          if (state is SelectedCategoryStateInitial) {
            return loader();
          } else if (state is SelectedCategoryStateLoading) {
            return loader();
          } else if (state is SelectedCategoryStateLoaded) {
            return selectedCatModel(state.categoriesModel);
          } else {
            return const Center(
              child: Text("No Data Found"),
            );
          }
        }),
      ),
    );
  }

  Widget selectedCatModel(SelectedCategoriesModel data) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => const DetailedPageView())));
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                margin: const EdgeInsets.only(right: 20.0, bottom: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 140,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.only(top: 0.0, bottom: 10.0),
                      child: FittedBox(
                        child: Image.network(
                          data.meals[index].strMealThumb,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                      child: Text(
                        data.meals[index].strMeal,
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w800),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, bottom: 5.0),
                      child: Row(children: const [
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        Text(
                          "4.9",
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          " (124 ratings ) Cafe Western Food",
                          style: TextStyle(fontWeight: FontWeight.w300),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),
            ],
          ),
        );
      },
      itemCount: data.meals.length,
    );
  }

  Widget drinkCatModel() {
    return BlocProvider(
      create: (context) => _dcBloc,
      child: BlocListener<DrinkCategoryBloc, DrinkCategoryState>(
        listener: (context, state) {
          if (state is DrinkCategoryStateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child: BlocBuilder<DrinkCategoryBloc, DrinkCategoryState>(
          builder: (context, state) {
            if (state is DrinkCategoryStateInitial) {
              return loader();
            } else if (state is DrinkCategoryStateLoading) {
              return loader();
            } else if (state is DrinkCategoryStateLLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  disableCenter: true,
                  scrollPhysics: const BouncingScrollPhysics(),
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
                items: state.drinkCatModel.drinks.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _sdBloc.add(GetSelectedDrinkCategoryList(
                                      i.strCategory));
                                  isCatSelected = true;
                                });
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: FittedBox(
                                  child: Image.network(
                                    "https://picsum.photos/id/431/200/300",
                                  ),
                                  fit: BoxFit.fill,
                                ),
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
    );
  }

  Widget foodCatModel() {
    return BlocProvider(
      create: (context) => _fcBloc,
      child: BlocListener<FoodCategoryBloc, FoodCategoryState>(
        listener: (context, state) {
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
                  scrollPhysics: const BouncingScrollPhysics(),
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
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _scBloc.add(
                                      GetSelectedCategoryList(i.strCategory));
                                  isCatSelected = true;
                                });
                              },
                              child: Container(
                                height: 130,
                                width: MediaQuery.of(context).size.width,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: FittedBox(
                                  child: Image.network(
                                    i.strCategoryThumb,
                                  ),
                                  fit: BoxFit.fill,
                                ),
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
    );
  }

  Widget loader() => const Center(
        child: CircularProgressIndicator(),
      );
}
