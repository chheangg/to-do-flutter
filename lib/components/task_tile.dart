import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  final String title;
  final String description;
  final String content;
  final bool isDone;
  final Color color;

  const TaskTile({
    super.key,
    required this.title,
    required this.description,
    required this.content,
    required this.isDone,
    required this.color,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
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
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0)
                )
                ),
            child: Row(children: [
              Container(
                height: 75,
                width: 8,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0)
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<CircleBorder>(
                        CircleBorder(
                          side: BorderSide(
                            color: widget.color,
                            width: 2.0,
                          ),
                        ),
                      ),
                      iconColor: MaterialStateProperty.all<Color>(Colors.red),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white)),
                  child: widget.isDone
                      ? const Icon(Icons.circle, size: 42)
                      : const Icon(null, size: 42),
                ),
              ),
              _buildMainTaskButton(widget.title, widget.description),
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
          if (isExpanded) _buildExpandedContainer(widget.content)
        ],
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
}
