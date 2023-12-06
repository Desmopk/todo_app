import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final bool user;
  final String task;
  Function(bool?)? onChanged;
  Function(BuildContext)? delTask;

  TodoTile(
      {super.key,
      required this.task,
      required this.user,
      required this.onChanged,
      required this.delTask});

  @override
  Widget build(BuildContext context) {
    return Slidable(
          startActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: delTask,
                icon: Icons.delete_forever_sharp,
                backgroundColor: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(24),
              ),
            ],
          ),
          child: Card(
            child: SizedBox(
              height: 96,
              child: Row(
                children: [
                  Checkbox(
                    value: user,
                    onChanged: onChanged,
                  ),
                  Text(
                    task,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        decoration: user
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
