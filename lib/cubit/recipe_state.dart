part of 'recipe_cubit.dart';

@immutable
abstract class RecipeState {}

class RecipeInitial extends RecipeState {
  RecipeInitial();
}

class RecipeLoading extends RecipeState {
  RecipeLoading();
}

class RecipeLoaded extends RecipeState {
  late List<Recipe> recipesLists;
  late List<Recipe> recommendedList;
  RecipeLoaded(this.recipesLists,this.recommendedList);
}

class RecipeError extends RecipeState {
  RecipeError();
}