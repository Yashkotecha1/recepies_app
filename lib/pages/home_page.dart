import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recepies_app/models/recipe.dart';
import 'package:recepies_app/pages/recipe_page.dart';
import 'package:recepies_app/services/auth_service.dart';
import 'package:recepies_app/services/data_service.dart';
import 'package:status_alert/status_alert.dart';

class HomePage  extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
    String _mealTypeFilter ="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        centerTitle: true,
      ),
      body: SafeArea(
          child: _buildUI()
      ),
    );
  }
    Widget _buildUI()
    {
      return Padding(
      padding: const EdgeInsets.all(15),
        child:  Column(

          children: [
            _recipeTypeButtons(),
            _recipesList()
          ],
        ),
      );
    }
    Widget _recipeTypeButtons()
    {

      return SizedBox(
        height: MediaQuery.sizeOf(context).height*0.05,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: (){
                    setState(() {
                      _mealTypeFilter ="Snack";
                    });
                  },
                  child: const Text("Snack")
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: (){
                    setState(() {
                      _mealTypeFilter ="BreakFast";
                    });
                  },
                  child: const Text("BreakFast")
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: (){
                    setState(() {
                      _mealTypeFilter ="Lunch";
                    });
                  },
                  child: const Text("Lunch")
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: FilledButton(
                  onPressed: (){
                    setState(() {
                      _mealTypeFilter ="Dinner";
                    });
                  },
                  child: const Text("Dinner")
              ),
            ),
          ],
        ),
      );
    }
    Widget _recipesList()
    {
      return Expanded(
          child: FutureBuilder(
            future: DataService().getRecipes(_mealTypeFilter),
            builder:(context,snapshot)
            {
              if(snapshot.connectionState ==ConnectionState.waiting)
                {
                  return const Center(child: CircularProgressIndicator(),);
                }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  itemBuilder: (context , index)
                  {
                    Recipe recipe =snapshot.data![index];
                    return ListTile(
                      onTap: (){
                        Navigator.push(context,MaterialPageRoute(builder: (context){
                          return RecipePage(recipe: recipe,);
                        }));
                      },
                      contentPadding: const EdgeInsets.only(top: 20.0),
                      isThreeLine: true,
                      subtitle:  Text("${recipe.cuisine}\nDifficulty : ${recipe.difficulty}"),
                      leading: Image.network(recipe.image),
                      title: Text(recipe.name,

                      ),
                      trailing:  Text("${recipe.rating.toString()} ⭐",
                      style: const TextStyle(fontSize: 15),),
                    );
                  }
              );
            },
          )
      );
    }
}
