import 'model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  var client = http.Client();
  static const String baseUrl = 'http://10.90.34.238:3000'; // Base URL

  // Fetch Slider list
  Future<List<SliderModel>?> getSliders() async {
    var uri = Uri.parse(
        '$baseUrl/slider'); // Replace with your actual endpoint for sliders
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return SliderModel.fromJsonList(
          jsonList); // Converts the JSON list to a List<SliderModel>
    } else {
      // Handle the error case here
      return null;
    }
  }

  // Fetch TopMix list
  Future<List<TopMixModel>?> getTopMixes() async {
    var uri = Uri.parse(
        '$baseUrl/topMixes'); // Replace with your actual endpoint for top mixes
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return TopMixModel.fromJsonList(
          jsonList); // Converts the JSON list to a List<TopMixModel>
    } else {
      // Handle the error case here
      return null;
    }
  }

  // Fetch Artist list
  Future<List<ArtistModel>?> getArtists() async {
    var uri = Uri.parse(
        '$baseUrl/artists'); // Replace with your actual endpoint for artists
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return ArtistModel.fromJsonList(
          jsonList); // Converts the JSON list to a List<ArtistModel>
    } else {
      // Handle the error case here
      return null;
    }
  }

  // Fetch Podcast list
  Future<List<PodcastModel>?> getPodcasts() async {
    var uri = Uri.parse(
        '$baseUrl/podCast'); // Replace with your actual endpoint for podcasts
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return PodcastModel.fromJsonList(
          jsonList); // Converts the JSON list to a List<PodcastModel>
    } else {
      // Handle the error case here
      return null;
    }
  }

  // Fetch Playlist list
  Future<List<PlaylistModel>?> getPlaylists() async {
    var uri = Uri.parse(
        '$baseUrl/playList'); // Replace with your actual endpoint for playlists
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return PlaylistModel.fromJsonList(
          jsonList); // Converts the JSON list to a List<PlaylistModel>
    } else {
      // Handle the error case here
      return null;
    }
  }

  // Fetch TopHit list
  Future<List<TopHitModel>?> getTopHits() async {
    var uri = Uri.parse(
        '$baseUrl/topHit'); // Replace with your actual endpoint for top hits
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return TopHitModel.fromJsonList(
          jsonList); // Converts the JSON list to a List<TopHitModel>
    } else {
      // Handle the error case here
      return null;
    }
  }

  Future<List<String>?> getSearchList() async {
    var uri = Uri.parse('$baseUrl/searchList');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return List<String>.from(jsonList);
    } else {
      // Handle error
      return null;
    }
  }

  Future<List<SongModel>?> getSongs() async {
    var uri = Uri.parse('$baseUrl/songs'); // Endpoint for songs
    var response = await client.get(uri);

    print('Response Status: ${response.statusCode}');
    print('Response Body: ${response.body}'); // Debugging line

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return SongModel.fromJsonList(jsonList); // Convert to List<SongModel>
    } else {
      return null; // Handle error
    }
  }

  // Add a new song (Create)
  Future<SongModel?> addSong(SongModel song) async {
    var uri = Uri.parse('$baseUrl/songs'); // Endpoint for songs
    try {
      var response = await client.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(song.toJson()), // Convert SongModel to JSON
      );

      if (response.statusCode == 201) {
        // Parse and return the created song
        return SongModel.fromJson(json.decode(response.body));
      } else {
        print('Failed to add song. Status code: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error adding song: $e');
      return null;
    }
  }

  // Modify updateSong to return SongModel
  Future<SongModel?> updateSong(String id, SongModel song) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/songs/$id'), // Use the song's ID in the URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': song.name,
          'artist': song.artist,
          'genre': song.genre,
          'releaseDate': song.releaseDate,
        }),
      );

      if (response.statusCode == 200) {
        // Parse and return the updated song
        return SongModel.fromJson(json.decode(response.body));
      } else {
        print('Failed to update song. Status code: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error updating song: $e');
      return null;
    }
  }

  // Delete a song by ID (Delete)
  Future<bool> deleteSong(id) async {
    var uri = Uri.parse('$baseUrl/songs/$id'); // Endpoint for specific song
    var response = await client.delete(uri);
    return response.statusCode == 200; // Return true if deleted successfully
  }

  Future<SongModel?> getSongById(songId) async {
    var uri =
        Uri.parse('$baseUrl/songs/$songId'); // Adjust the endpoint as needed
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return SongModel.fromJson(json.decode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> login(User user) async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      final List<dynamic> users = jsonDecode(response.body);

      // Cek apakah email dan password cocok dengan data
      final matchingUser = users.firstWhere(
        (u) =>
            u['email'] == user.email && u['password'] == user.password,
        orElse: () => null,
      );

      return matchingUser != null;
    } else {
      throw Exception('Failed to connect to API');
    }
  }
}
