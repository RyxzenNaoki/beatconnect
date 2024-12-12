import 'package:flutter/material.dart';
import 'package:beatconnect/koneksi.dart';
import 'package:beatconnect/model.dart';

class AddSongPage extends StatefulWidget {
  final SongModel? song; // Optional song for editing

  const AddSongPage({Key? key, this.song}) : super(key: key);

  @override
  _AddSongPageState createState() => _AddSongPageState();
}

class _AddSongPageState extends State<AddSongPage> {
  final _formKey = GlobalKey<FormState>();
  final _apiService = ApiService();

  String? _id;
  late String _name = '';
  late String _artist = '';
  late String _genre = '';
  late String _releaseDate = '';

  bool _isSaving = false;
  bool _isLoading = true;
  List<SongModel> _songs = [];

  @override
  void initState() {
    super.initState();
    // Initialize values from existing song or empty
    _id = widget.song?.id;
    _name = widget.song?.name ?? '';
    _artist = widget.song?.artist ?? '';
    _genre = widget.song?.genre ?? '';
    _releaseDate = widget.song?.releaseDate ?? '';

    // Fetch songs
    _fetchSongs();
  }

  void _fetchSongs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final fetchedSongs = await _apiService.getSongs();
      if (fetchedSongs != null) {
        setState(() {
          _songs = fetchedSongs;
          _isLoading = false;
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load songs')),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading songs: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isEditing = widget.song != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Edit Song" : "Add Song"),
      ),
      body: Column(
        children: [
          // Song Form
          Padding(
            padding: EdgeInsets.all(16.0),
            child: _isSaving
                ? Center(child: CircularProgressIndicator())
                : Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        // Show ID field only when creating a new song
                        if (!isEditing)
                          TextFormField(
                            initialValue: _id,
                            decoration: InputDecoration(
                              labelText: "Song ID",
                              labelStyle: TextStyle(color: Colors.green),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Please enter a Song ID";
                              }
                              return null;
                            },
                            onSaved: (value) => _id = value!.trim(),
                          ),
                        TextFormField(
                          initialValue: _name,
                          decoration: InputDecoration(
                            labelText: "Song Name",
                            labelStyle: TextStyle(color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter a song name";
                            }
                            return null;
                          },
                          onSaved: (value) => _name = value!.trim(),
                        ),
                        TextFormField(
                          initialValue: _artist,
                          decoration: InputDecoration(
                            labelText: "Artist",
                            labelStyle: TextStyle(color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter an artist name";
                            }
                            return null;
                          },
                          onSaved: (value) => _artist = value!.trim(),
                        ),
                        TextFormField(
                          initialValue: _genre,
                          decoration: InputDecoration(
                            labelText: "Genre",
                            labelStyle: TextStyle(color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter a genre";
                            }
                            return null;
                          },
                          onSaved: (value) => _genre = value!.trim(),
                        ),
                        TextFormField(
                          initialValue: _releaseDate,
                          decoration: InputDecoration(
                            labelText: "Release Date",
                            labelStyle: TextStyle(color: Colors.green),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Please enter a release date";
                            }
                            return null;
                          },
                          onSaved: (value) => _releaseDate = value!.trim(),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _saveSong,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(isEditing ? "Update" : "Create"),
                        ),
                      ],
                    ),
                  ),
          ),

          // Song List
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _songs.isEmpty
                    ? Center(child: Text('No songs available'))
                    : ListView.builder(
                        itemCount: _songs.length,
                        itemBuilder: (context, index) {
                          SongModel song = _songs[index];
                          return ListTile(
                            title: Text(song.name),
                            subtitle: Text('${song.artist} - ${song.genre}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.green),
                                  onPressed: () {
                                    // Navigate to edit page with the selected song
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AddSongPage(song: song),
                                      ),
                                    ).then((_) => _fetchSongs());
                                  },
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteSong(song),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  void _deleteSong(SongModel song) async {
    // Show confirmation dialog
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Song'),
        content: Text('Are you sure you want to delete "${song.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm) {
      setState(() {
        _isSaving = true;
      });

      try {
        bool success = await _apiService.deleteSong(song.id);
        if (success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Song deleted successfully')),
          );
          _fetchSongs(); // Refresh the list
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to delete song')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting song: $e')),
        );
      } finally {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _saveSong() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isSaving = true;
      });

      try {
        SongModel? result;

        if (widget.song != null) {
          // Editing existing song
          if (_id == null || _id!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Song ID is missing. Cannot update.')),
            );
            setState(() {
              _isSaving = false;
            });
            return;
          }

          SongModel updatedSong = SongModel(
            id: _id!,
            name: _name,
            artist: _artist,
            genre: _genre,
            releaseDate: _releaseDate,
          );

          result = await _apiService.updateSong(updatedSong.id, updatedSong);
        } else {
          // Creating new song
          if (_id == null || _id!.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Please provide a valid ID for the song')),
            );
            setState(() {
              _isSaving = false;
            });
            return;
          }

          SongModel newSong = SongModel(
            id: _id!,
            name: _name,
            artist: _artist,
            genre: _genre,
            releaseDate: _releaseDate,
          );

          result = await _apiService.addSong(newSong);
        }

        if (result != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Song ${widget.song != null ? 'updated' : 'created'} successfully')),
          );
          _fetchSongs(); // Refresh the list
          _resetForm();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save song')),
          );
        }
      } catch (e) {
        print('Error during save: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    setState(() {
      _id = null;
      _name = '';
      _artist = '';
      _genre = '';
      _releaseDate = '';
    });
  }
}
