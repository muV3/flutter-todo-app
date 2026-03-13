import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/util/app_colors.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool isCompleted;
  Function(bool?)? onChanged;
  Function(BuildContext)? deleteFunction;

  ToDoTile({
    super.key,
    required this.taskName,
    required this.isCompleted,
    required this.onChanged,
    required this.deleteFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Slidable(
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: AppColors.deleteTask,
              borderRadius: BorderRadius.circular(10),
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: AppColors.taskCard,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Checkbox
              Checkbox(
                value: isCompleted,
                onChanged: onChanged,
                activeColor: AppColors.primary,
                checkColor: Colors.white,
                side: BorderSide(color: AppColors.primary, width: 1.5),
              ),

              // Text
              Expanded(
                child: Text(
                  taskName,
                  style: GoogleFonts.merriweather(
                    color: isCompleted
                        ? AppColors.completedTask
                        : AppColors.text,
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    decorationColor: AppColors.completedTask,
                    decorationThickness: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
