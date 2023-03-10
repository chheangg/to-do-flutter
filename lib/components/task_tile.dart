import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../screens/form_screen.dart';
import '../models/models.dart';
import 'package:uuid/uuid.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  const TaskTile({super.key, required this.task});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Slidable(
      key: ValueKey(const Uuid().v4().toString()),
      startActionPane: buildDeletePane(context),
      endActionPane: buildDeletePane(context),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 75,
              width: width - 25,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(Radius.circular(8.0))),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => FormScreen(
                              task: widget.task,
                              onCreate: (_) {},
                              onUpdate: (task) {
                                final updateTask = Provider.of<TaskManager>(
                                        context,
                                        listen: false)
                                    .updateTask;
                                updateTask(task);
                                Navigator.of(context).pop();
                              },
                              isUpdating: true)));
                },
                child: Row(children: [
                  Container(
                    height: 75,
                    width: 8,
                    decoration: BoxDecoration(
                        color: widget.task.color,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: ElevatedButton(
                      onPressed: () {
                        final changeStatus =
                            Provider.of<TaskManager>(context, listen: false)
                                .changeStatusTask;
                        changeStatus(widget.task);
                      },
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<CircleBorder>(
                            CircleBorder(
                              side: BorderSide(
                                color: widget.task.color,
                                width: 2.0,
                              ),
                            ),
                          ),
                          iconColor:
                              MaterialStateProperty.all<Color>(Colors.red),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white)),
                      child: widget.task.isDone
                          ? Icon(Icons.circle,
                              color: widget.task.color, size: 42)
                          : const Icon(null, size: 42),
                    ),
                  ),
                  _buildMainTaskButton(
                      widget.task.name, widget.task.description),
                  Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        icon: isExpanded
                            ? const Icon(Icons.expand_less)
                            : const Icon(Icons.expand_more),
                      )),
                ]),
              ),
            ),
            if (isExpanded) _buildExpandedContainer(widget.task.content)
          ],
        ),
      ),
    );
  }

  Widget _buildExpandedContainer(String content) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0)),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.all(12.0),
      child: Text(content),
    );
  }

  Widget _buildMainTaskButton(String title, String description) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(title,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 20,
                fontWeight: FontWeight.w600,
              )),
          Text(description,
              style: const TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 16,
              ))
        ],
      ),
    );
  }

  ActionPane buildDeletePane(BuildContext context) {
    return ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
            onPressed: (_) {
              final deleteTask = Provider
                .of<TaskManager>(context, listen: false)
                .deleteTask;
              deleteTask(widget.task.id);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: "Delete")
      ],
    );
  }
}
