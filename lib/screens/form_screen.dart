import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../models/models.dart';
import 'package:uuid/uuid.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({
    super.key,
    this.task,
    required this.onCreate,
    required this.onUpdate,
    required this.isUpdating,
  });

  final Task? task;
  final Function(Task) onCreate;
  final Function(Task) onUpdate;
  final bool isUpdating;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  String _id = '';
  String _name = '';
  String _description = '';
  String _content = '';
  bool _isDone = false;
  DateTime _timestamp = DateTime.now();
  Color _color = Colors.red;

  @override
  void initState() {
    final originalTask = widget.task;
    if (originalTask != null) {
      _id = originalTask.id;
      _nameController.text = originalTask.name;
      _name = originalTask.name;
      _descriptionController.text = originalTask.description;
      _description = originalTask.description;
      _contentController.text = originalTask.content;
      _content = originalTask.content;
      _color = originalTask.color;
      _timestamp = originalTask.timestamp;
      _isDone = originalTask.isDone;
    } else {
      _id = const Uuid().v4().toString();
    }

    _nameController.addListener(() {
      setState(() {
        _name = _nameController.text;
      });
    });

    _descriptionController.addListener(() {
      setState(() {
        _description = _descriptionController.text;
      });
    });

    _contentController.addListener(() {
      setState(() {
        _content = _contentController.text;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Grocery Item',
            style:
                TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  final task = Task(
                    id: _id,
                    name: _nameController.text,
                    description: _descriptionController.text,
                    content: _contentController.text,
                    isDone: _isDone,
                    timestamp: _timestamp,
                    color: _color,
                  );
                  if (widget.isUpdating) {
                    widget.onUpdate(task);
                  } else {
                    widget.onCreate(task);
                  }
                },
                icon: const Icon(Icons.check))
          ],
          backgroundColor: theme.primaryColor,
        ),
        body: SizedBox(
            width: size.width,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildNameField(),
                const SizedBox(height: 16.0),
                _buildDescriptionField(),
                const SizedBox(height: 16.0),
                _buildContentField(),
                const SizedBox(height: 16.0),
                _buildColortField()
              ],
            )));
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Name',
          style:
              TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(hintText: 'E.g Clean the room'),
        )
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style:
              TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w600),
        ),
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(
              hintText: 'E.g Clean the chairs, table, and etc.'),
        )
      ],
    );
  }

  Widget _buildContentField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Content',
          style:
              TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w600),
        ),
        TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          controller: _contentController,
          decoration: const InputDecoration(
              hintText: 'E.g First do this, then do that, then do this'),
        )
      ],
    );
  }

  Widget _buildColortField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Color',
          style:
              TextStyle(fontFamily: 'Open Sans', fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Row(
          children: [
            Container(
              height: 50.0,
              width: 75.0,
              color: _color,
            ),
            TextButton(
              child: const Text('Select'),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: BlockPicker(
                          pickerColor: _color,
                          onColorChanged: (color) {
                            setState(() {
                              _color = color;
                            });
                          },
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Save'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    });
              },
            )
          ],
        )
      ],
    );
  }
}
