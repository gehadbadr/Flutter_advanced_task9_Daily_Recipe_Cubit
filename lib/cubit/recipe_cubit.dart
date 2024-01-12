import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:daily_recipe2/models/recipes.models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'recipe_state.dart';

class RecipeCubit extends Cubit<RecipeState> {
  List<Recipe> recipesLists = [];
  List<Recipe> recommendedList = [];

  RecipeCubit() : super(RecipeInitial());

  void getRecipes() async {
    var recipesData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(recipesData)['recipes']);
    recipesLists = dataDecoded.map((e) => Recipe.fromJson(e)).toList();
    recommendedList = recipesLists.where((e) => e.recommended == true).toList();
    emit(RecipeLoading());
    await Future.delayed(const Duration(seconds:1), () {
      emit(RecipeLoaded(recipesLists, recommendedList));
    });
  }
}
