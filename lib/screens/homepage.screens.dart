import 'package:daily_recipe2/consts/consts.dart';
import 'package:daily_recipe2/cubit/auth_cubit.dart';
import 'package:daily_recipe2/cubit/carsoul_cubit.dart';
import 'package:daily_recipe2/cubit/recipe_cubit.dart';

import 'package:daily_recipe2/widgets/appbar.widgets.dart';
import 'package:daily_recipe2/widgets/carsoul.widget.dart';
import 'package:daily_recipe2/widgets/fresh_recipes.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CarsoulCubit>(context).getAds();
    BlocProvider.of<RecipeCubit>(context).getRecipes();

    return Scaffold(
      backgroundColor: ColorsApp.whiteColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: CustomAppBar(
              leadingIcon: Icons.menu,
              actionIcon: Icons.notification_add_outlined,
              onPressLeading: () {},
              onPressAction: () {})),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                child: Column(
              children: [
                BlocConsumer<AuthCubit, AuthState>(
                  builder: (context, state) {
                    String? name = BlocProvider.of<AuthCubit>(context).prefsFile.getString('name');

                        return Align(
                      alignment: Alignment.centerLeft,
                      child: Text('${TextApp.bonjour}, ${name}',
                          style: TextStyle(fontSize: 20, color: ColorsApp.fontGrey)));
                  },
                  listener: (context, state) {
                    if (state is CarsoulError) {
                      Text('Error');
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    TextApp.whatToCook,
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorsApp.lightGrey,
                          ),
                          child: TextFormField(
                            cursorColor: ColorsApp.borderLine,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: ColorsApp.borderLine,
                                ),
                                filled: true,
                                fillColor: ColorsApp.lightGrey,
                                hintText: TextApp.searchAnyThing,
                                hintStyle:
                                    TextStyle(color: ColorsApp.borderLine)),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: 60,
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.tune,
                            //  size: 25,
                          ),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorsApp.lightGrey),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                BlocConsumer<CarsoulCubit, CarsoulState>(
                  builder: (context, state) {
                    if (state is CarsoulLoading) {
                      return CircularProgressIndicator();
                    } else if (state is CarsoulLoaded) {
                      return CarsoulWidget(adsLists: state.adsLists);
                    } else {
                      return "Error".text.makeCentered();
                    }
                  },
                  listener: (context, state) {
                    if (state is CarsoulError) {
                      Text('Error');
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocConsumer<RecipeCubit, RecipeState>(
                  builder: (context, state) {
                    if (state is RecipeLoading) {
                      return CircularProgressIndicator();
                    } else if (state is RecipeLoaded) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  TextApp.todayFreshRecipe,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                              Text(
                                TextApp.seeAll,
                                style: TextStyle(
                                    color: ColorsApp.PKColor, fontSize: 16),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: List.generate(
                                  state.recipesLists.length,
                                  (index) => FreshRecipes(
                                        id: state.recipesLists[index].id,
                                        title: state.recipesLists[index].title!,
                                        image: state.recipesLists[index].image,
                                        meal_type:
                                            state.recipesLists[index].meal_type,
                                        rating:
                                            state.recipesLists[index].rating,
                                        calerios:
                                            state.recipesLists[index].calerios,
                                        serving:
                                            state.recipesLists[index].serving,
                                        prep_time:
                                            state.recipesLists[index].prep_time,
                                        recommended: false,
                                      )),
                            ),
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  TextApp.recomended,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
                                ),
                              ),
                              Text(
                                TextApp.seeAll,
                                style: TextStyle(
                                    color: ColorsApp.PKColor, fontSize: 16),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          state.recommendedList.isEmpty
                              ? CircularProgressIndicator()
                              : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: 
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    state.recommendedList.length,
                                    (index) => FreshRecipes(
                                        id: state.recommendedList[index].id,
                                        title:
                                            state.recommendedList[index].title!,
                                        image:
                                            state.recommendedList[index].image,
                                        meal_type: state
                                            .recommendedList[index].meal_type,
                                        rating:
                                            state.recommendedList[index].rating,
                                        calerios: state
                                            .recommendedList[index].calerios,
                                        serving: state
                                            .recommendedList[index].serving,
                                        prep_time: state
                                            .recommendedList[index].prep_time,
                                        recommended: true),
                                  ),
                                ),
                          ),
                        ],
                      );
                    } else {
                      return "Error".text.makeCentered();
                    }
                  },
                  listener: (context, state) {
                    if (state is RecipeError) {
                      Text('Error');
                    }
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
