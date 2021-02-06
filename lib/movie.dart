import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'package:http/http.dart' as Http;
import 'package:dotenv/dotenv.dart' show load, env;
void main(List<String> arguments) async {

  // Loading the .env
  load();

  stdout.writeln('Enter the name of a movie or show:');
  stdout.writeln('----------------------------------');

  // Getting search input from user
  String input = stdin.readLineSync();

  //API URL
  String url = 'http://www.omdbapi.com/?t=${Uri.encodeFull(input)}&apikey=${env['apikey']}';

  //Get request using the URL
  Http.Response response = await Http.get(url);

  //Parses the response body and assigns it to movie Map
  Map movie = jsonDecode(response.body);

  print('----------------------------------');
  print('TITLE: ${movie['Title']}');
  print('YEAR: ${movie['Year']}');
  print('GENRE: ${movie['Genre']}');
  print('PLOT: ${movie['Plot']}');
  print('TYPE: ${movie['Type']}');
  print('ACTORS: ${movie['Actors']}');
  print('IMDB RATING: ${movie['imdbRating']}');

  movie['Ratings'].forEach((r) => {
    print(r['Source'].toUpperCase() + ': ' + r['Value'])
  });

  print('POSTER: ${movie['Poster']}');
  print('LINK: https://www.imdb.com/title/${movie['imdbID']}');

}