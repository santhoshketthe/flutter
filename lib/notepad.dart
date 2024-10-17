import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'database_helper.dart';
import 'note.dart';

class NotePad extends StatefulWidget {
  const NotePad({super.key});

  @override
  NotesAppState createState() => NotesAppState();
}

class NotesAppState extends State<NotePad> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  List<Note> _notes = [];
  Note? editingNote;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  void _loadNotes() async {
    List<Note> notes = await _databaseHelper.getNotes();
    setState(() {
      _notes = notes;
    });
  }

  void _saveNote() async {

    if (_titleController.text.isNotEmpty &&
        _contentController.text.isNotEmpty) {
      bool exitingUser = await _databaseHelper.checkExistingNote(_titleController.text);
      if (editingNote == null && !exitingUser) {
        Note note = Note(
          title: _titleController.text,
          content: _contentController.text,
        );
        await _databaseHelper.insertNote(note);
        _titleController.clear();
        _contentController.clear();
        editingNote = null;
        _loadNotes();
        Fluttertoast.showToast(msg: "Notes saved successful");
      } else if (editingNote != null && exitingUser) {
        Fluttertoast.showToast(msg: "Notes already exists");
      } else if (editingNote != null) {
        Note note = Note(
          id: editingNote?.id,
          title: _titleController.text,
          content: _contentController.text,
        );
        await _databaseHelper.updateNote(note);
        _titleController.clear();
        _contentController.clear();
        editingNote = null;
        _loadNotes();
        Fluttertoast.showToast(msg: "Notes updated successful");
      }
    } else {
      Fluttertoast.showToast(msg: "Please fill all fields and try to save");
    }
  }

  void _editNote(Note note) {
    setState(() {
      _titleController.text = note.title;
      _contentController.text = note.content;
      editingNote = note;
    });
  }

  void _deleteNote(int id) async {
    await _databaseHelper.deleteNote(id);
    _loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _contentController,
                  decoration: const InputDecoration(labelText: 'Content'),
                ),
                ElevatedButton(
                  onPressed: _saveNote,
                  child:
                      Text(editingNote == null ? 'Save Note' : 'Update Note'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _notes.length,
              itemBuilder: (context, index) {
                final note = _notes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.content),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          _editNote(note);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          _deleteNote(note.id!);
                        },
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
}
