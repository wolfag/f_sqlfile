import 'package:flutter/material.dart';

class NoteForm extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? description;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const NoteForm({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.description = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      style: const TextStyle(
        color: Colors.white70,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Title',
        hintStyle: TextStyle(color: Colors.white70),
      ),
      validator: (title) =>
          title != null && title.isEmpty ? 'The title can not be empty' : null,
      onChanged: onChangedTitle,
    );
  }

  Widget buildDescription() {
    return TextFormField(
      maxLines: 5,
      initialValue: description,
      style: const TextStyle(color: Colors.white60, fontSize: 18),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Type something...',
        hintStyle: TextStyle(color: Colors.white60),
      ),
      validator: (val) => val != null && val.isEmpty
          ? 'The description can not be empty'
          : null,
      onChanged: onChangedDescription,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Switch(
                  value: isImportant ?? false,
                  onChanged: onChangedImportant,
                ),
                Expanded(
                  child: Slider(
                    value: (number ?? 0).toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    onChanged: (val) => onChangedNumber(val.toInt()),
                  ),
                ),
              ],
            ),
            buildTitle(),
            SizedBox(height: 8),
            buildDescription(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
