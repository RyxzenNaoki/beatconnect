class SliderModel {
  final String title;
  final String image;

  SliderModel({required this.title, required this.image});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      title: json['title'],
      image: json['image'],
    );
  }

  static List<SliderModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SliderModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'image': image,
    };
  }
}

class TopMixModel {
  final String title;
  final String description;
  final String image;
  final String color;

  TopMixModel(
      {required this.title,
      required this.description,
      required this.image,
      required this.color});

  factory TopMixModel.fromJson(Map<String, dynamic> json) {
    return TopMixModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      color: json['color'],
    );
  }

  static List<TopMixModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TopMixModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
      'color': color,
    };
  }
}

class ArtistModel {
  final String image;
  final String name;

  ArtistModel({required this.image, required this.name});

  factory ArtistModel.fromJson(Map<String, dynamic> json) {
    return ArtistModel(
      image: json['image'],
      name: json['name'],
    );
  }

  static List<ArtistModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ArtistModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'name': name,
    };
  }
}

class PodcastModel {
  final String title;
  final String description;
  final String image;

  PodcastModel(
      {required this.title, required this.description, required this.image});

  factory PodcastModel.fromJson(Map<String, dynamic> json) {
    return PodcastModel(
      title: json['title'],
      description: json['description'],
      image: json['image'],
    );
  }

  static List<PodcastModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PodcastModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': image,
    };
  }
}

class PlaylistModel {
  final String image1;
  final String image2;
  final String image3;
  final String image4;
  final String title;

  PlaylistModel(
      {required this.image1,
      required this.image2,
      required this.image3,
      required this.image4,
      required this.title});

  factory PlaylistModel.fromJson(Map<String, dynamic> json) {
    return PlaylistModel(
      image1: json['image_1'],
      image2: json['image_2'],
      image3: json['image_3'],
      image4: json['image_4'],
      title: json['title'],
    );
  }

  static List<PlaylistModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PlaylistModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'image_1': image1,
      'image_2': image2,
      'image_3': image3,
      'image_4': image4,
      'title': title,
    };
  }
}

class TopHitModel {
  final String image;
  final String title;
  final String description;
  final bool favorite;

  TopHitModel(
      {required this.image,
      required this.title,
      required this.description,
      required this.favorite});

  factory TopHitModel.fromJson(Map<String, dynamic> json) {
    return TopHitModel(
      image: json['image'],
      title: json['title'],
      description: json['description'],
      favorite: json['favorite'],
    );
  }

  static List<TopHitModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TopHitModel.fromJson(json)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'description': description,
      'favorite': favorite,
    };
  }
}

class SearchListModel {
  final String searchItem;

  SearchListModel({required this.searchItem});

  factory SearchListModel.fromJson(String json) {
    return SearchListModel(searchItem: json);
  }

  static List<SearchListModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => SearchListModel.fromJson(item)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'searchItem': searchItem,
    };
  }
}

class SongModel {
  final String id; // ID is now required
  final String name;
  final String artist;
  final String genre;
  final String releaseDate;

  SongModel({
    required this.id,
    required this.name,
    required this.artist,
    required this.genre,
    required this.releaseDate,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json['id'],
      name: json['name'],
      artist: json['artist'],
      genre: json['genre'],
      releaseDate: json['releaseDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artist': artist,
      'genre': genre,
      'releaseDate': releaseDate,
    };
  }

  static List<SongModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SongModel.fromJson(json)).toList();
  }
}

class User {
  final String email;
  final String password;

  User({required this.email, required this.password});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
      };
}

