import 'package:flutter/material.dart';
import '../models/models.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({
    super.key,
    this.task,
  });

  final Task? task;

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _contentController = TextEditingController();
  String _name = '';
  String _description = '';
  String _content = '';
  DateTime _timestamp = DateTime.now();
  Color _color = Colors.red;

  @override
  void initState() {
    final originalTask = widget.task;
    if (originalTask != null) {
      _nameController.text = originalTask.name;
      _name = originalTask.name;
      _descriptionController.text = originalTask.description;
      _description = originalTask.description;
      _contentController.text = originalTask.content;
      _content = originalTask.content;
      _color = originalTask.color;
      _timestamp = originalTask.timestamp;
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
          style: TextStyle(
            fontFamily: 'Open Sans',
            fontWeight: FontWeight.w600
          ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  print(_name);
                  print(_description);
                  print(_content);
                  print(_timestamp);
                },
                icon: const Icon(
                  Icons.check
                ))
          ],
          backgroundColor: theme.primaryColor,
        ),
        body: Container(
            width: size.width,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildNameField(),
                _buildDescriptionField(),
                _buildContentField(),
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
          style: TextStyle(
            fontFamily: 'Open Sans'
          ),
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
          style: TextStyle(
            fontFamily: 'Open Sans'
          ),
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
          style: TextStyle(
            fontFamily: 'Open Sans'
          ),
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
          style: TextStyle(
            fontFamily: 'Open Sans'
          ),
        )
      ],
    );
  }
}
