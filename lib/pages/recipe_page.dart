import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recepies_app/models/recipe.dart';

class RecipePage extends StatelessWidget{
  final Recipe recipe;

  RecipePage({required this.recipe,});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar
        (
        title: const Text("Recipe Page"),
        centerTitle: true,
        backgroundColor: Colors.white70,
      ),
      body: _buildUI(),
    );
  }
  Widget _buildUI(){
    return Column(
      children: [],
    );
  }

}