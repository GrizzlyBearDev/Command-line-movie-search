import 'dart:convert';
import 'dart:collection';
import 'dart:io';
import 'package:http/http.dart' as Http;
import 'package:dotenv/dotenv.dart' show load, env;
import 'package:ansicolor/ansicolor.dart';

void main(List<String> arguments) async {
  while (true) {
    //Terminal text colors
    AnsiPen penGreen = new AnsiPen()..green(bold: true);
    AnsiPen penBlue = new AnsiPen()..blue(bold: true);

    // Loading the .env
    load();

    stdout.writeln('${penBlue('Enter the name of a movie or show:')}');
    stdout.writeln('${penBlue('----------------------------------')}');

    // Getting search input from user
    String input = stdin.readLineSync();

    //API URL
    String url =
        'http://www.omdbapi.com/?t=${Uri.encodeFull(input)}&apikey=${env['apikey']}';

    //Get request using the URL
    Http.Response response = await Http.get(url);

    //Parses the response body and assigns it to movie Map
    Map movie = jsonDecode(response.body);

    print('${penBlue('----------------------------------')}');
    print('${penGreen("TITLE:")} ${movie['Title']}');
    print('${penGreen("YEAR:")} ${movie['Year']}');
    print('${penGreen("GENRE:")} ${movie['Genre']}');
    print('${penGreen("PLOT:")} ${movie['Plot']}');
    print('${penGreen("TYPE:")} ${movie['Type']}');
    print('${penGreen("ACTORS:")} ${movie['Actors']}');
    print('${penGreen("IMDB RATING:")} ${movie['imdbRating']}');

    movie['Ratings'].forEach((r) =>
        {print('${penGreen(r['Source'].toUpperCase())}: ${r['Value']}')});

    print('${penGreen("POSTER:")} ${movie['Poster']}');
    print(
        '${penGreen("LINK:")}LINK: https://www.imdb.com/title/${movie['imdbID']}');

    print('');

    // String waiting = stdin.readLineSync();
  }
}
