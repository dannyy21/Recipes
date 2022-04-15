import 'package:flutter/material.dart';
import 'package:stopwatch/model/recipe.dart';
import 'package:stopwatch/ui/widget/recipe.dart';

import '../model/recipe_api.dart';
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Recipe> _recipe;
  bool _isloading = true;
  @override
  void initState(){
    super.initState();
  }
  Future<void> getRecipe()async{
    _recipe = await RecipeApi.getRecipe();
    setState((){
      _isloading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width:12),
          Text("Food Recipe")
        ],
        )
        ),
        body: _isloading? Center(child: CircularProgressIndicator())
        :ListView.builder(
          itemCount: _recipe.length,
          itemBuilder: (context, index){
            return RecipeCard(
              title: _recipe[index].name,
              cookTime: _recipe[index].totalTime,
              thumbnailUrl: _recipe[index].images,
              rating: _recipe[index].rating.toString());
          },
        )
      
    );
  }
}