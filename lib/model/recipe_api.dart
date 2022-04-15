import 'dart:convert';
import 'recipe.dart';
import 'package:http/http.dart' as http;
class RecipeApi{

    static Future<List<Recipe>> getRecipe() async{
      var uri = Uri.http('yummly2.p.rapid api.com', '/feeds/list', { 
        "limit":"18",
        "start": "0",
        "tag":"list.recipe.popular"});
      final response = await http.get(uri, headers:{
        'X-RapidAPI-Host': 'yummly2.p.rapidapi.com',
        'X-RapidAPI-Key': '036b670554msh7dd7a730e068ec1p172186jsndc95cdc9e01b',
        'useQueryString': "true"
      });

      Map data = jsonDecode(response.body);
      List _temp = [];

      for (var i in data['feed']){
        _temp.add(i['conten']['details']);
      }
      return Recipe.recipesFromSnapshot(_temp);
    }
}