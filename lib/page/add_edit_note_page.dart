import 'dart:ffi';

import 'package:f_sqlfile/db/database.dart';
import 'package:f_sqlfile/model/note.dart';
import 'package:f_sqlfile/widget/note_form.dart';
import 'package:flutter/material.dart';

class AddEditNotePage extends StatefulWidget {
  final Note? note;

  AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  State<AddEditNotePage> createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String description;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    description = widget.note?.description ?? '';
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      isImportant: isImportant,
      number: number,
      title: title,
      description: description,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: const Text('Save'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [buildButton()]),
      body: Form(
        key: _formKey,
        child: NoteForm(
          isImportant: isImportant,
          number: number,
          title: title,
          description: description,
          onChangedImportant: (val) {
            setState(() {
              isImportant = val;
            });
          },
          onChangedNumber: (val) {
            setState(() {
              number = val;
            });
          },
          onChangedTitle: (val) {
            setState(() {
              title = val;
            });
          },
          onChangedDescription: (val) {
            setState(() {
              description = val;
            });
          },
        ),
      ),
    );
  }
}
