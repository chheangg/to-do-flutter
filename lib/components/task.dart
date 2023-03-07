import 'package:flutter/material.dart';

class Task extends StatelessWidget {
  final String title;
  final String description;
  final bool isDone;

  const Task(
      {super.key,
      required this.title,
      required this.description,
      required this.isDone});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 75,
      width: width - 25,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: ElevatedButton(
              onPressed: () {
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<CircleBorder>(
                  const CircleBorder(
                    side: BorderSide(
                      color: Colors.red,
                      width: 2.0,
                      ),
                  ),
                ),
                iconColor: MaterialStateProperty.all<Color>(
                  Colors.red
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.white
                )
              ),
              child: isDone ? 
                const Icon(Icons.circle, size: 42) : Icon(null, size: 42),
            ),
          ),
          _buildMainTaskButton(title, description),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(Icons.more_vert)
          )
        ]
      ),
    );
  }

  Widget _buildMainTaskButton(String title, String description) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            )
          ),
          Text(
            description,
            style: const TextStyle(
              fontFamily: 'Open Sans',
              fontSize: 16,
            )
          )],
      ),
    );
  }
}
