import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recepies_app/models/recipe.dart';

class RecipePage extends StatelessWidget {
  Recipe recipe;

  RecipePage({required this.recipe,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar
        (

        title: const Text("Recipe Page"),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: _buildUI(context,),
    );
  }

  Widget _buildUI(BuildContext context,) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipeDetails(context),
          _recipeIngridients(context),
          _recipeInstructions(context)
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery
          .sizeOf(context)
          .height * 0.40,
      width: MediaQuery
          .sizeOf(context)
          .width,

      decoration: BoxDecoration(

        image: DecorationImage(
          image: NetworkImage(recipe.image),
          fit: BoxFit.fill,
        ),
      ),
    );
  }


  Widget _recipeDetails(BuildContext context) {
      return Container(
        color: Colors.white70,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${recipe.cuisine},${recipe.difficulty}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              recipe.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )
            ),
            Text(
              "Prep Time: ${recipe.prepTimeMinutes} Minutes| CookTime : ${recipe.cookTimeMinutes} Minutes",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              " ${recipe.rating}⭐|   ${recipe.reviewCount} Reviews ",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),

          ],
        ),
      );
  }

  Widget _recipeIngridients(BuildContext context)
  {
    return Container(
        color: Colors.white70,
        width: MediaQuery.sizeOf(context).width,
    padding: const EdgeInsets.symmetric(
    vertical: 10.0,
  horizontal: 15.0,
  ),
  child:  Column(
      children: recipe.ingredients.map((e)
      {
          return Row(
            children: [
              const Icon(Icons.check_box),
              Text("$e"),
            ],
          );
      }
      ).toList(),
  ),
    );
  }
  Widget _recipeInstructions(BuildContext context){
    return Container(
        color: Colors.white70,
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 15.0,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: recipe.instructions.map((e)
    {
      return Text(
        e,
        maxLines: 3,
        textAlign:  TextAlign.start,
        style: TextStyle(
          fontSize: 15.0
        ),

      );
    }
    ).toList(),)
    );
  }
}
