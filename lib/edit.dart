// import 'package:flutter/material.dart';
// import 'package:beatconnect/koneksi.dart';

// class EditSongPage extends StatefulWidget {
//   final String songId;
//   final Map<String, dynamic> initialData;

//   const EditSongPage({required this.songId, required this.initialData, Key? key}) : super(key: key);

//   @override
//   _EditSongPageState createState() => _EditSongPageState();
// }

// class _EditSongPageState extends State<EditSongPage> {
//   late TextEditingController _titleController;
//   late TextEditingController _descriptionController;
//   late TextEditingController _artistController;

//   final ApiService _apiService = ApiService(); // Using the static baseUrl

//   @override
//   void initState() {
//     super.initState();
//     _titleController = TextEditingController(text: widget.initialData['title']);
//     _descriptionController = TextEditingController(text: widget.initialData['description']);
//     _artistController = TextEditingController(text: widget.initialData['artist']);
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     _descriptionController.dispose();
//     _artistController.dispose();
//     super.dispose();
//   }

//   Future<void> _updateSong() async {
//     final updatedData = {
//       'title': _titleController.text,
//       'description': _descriptionController.text,
//       'artist': _artistController.text,
//     };

//     try {
//       final success = await _apiService.updateSong(widget.songId, updatedData);
//       if (success) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Song updated successfully!')),
//         );
//         Navigator.pop(context, true);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to update song.')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Song'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             TextField(
//               controller: _descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             TextField(
//               controller: _artistController,
//               decoration: InputDecoration(labelText: 'Artist'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _updateSong,
//               child: Text('Update Song'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
