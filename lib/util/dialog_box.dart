import 'package:flutter/material.dart';
import 'package:todo_app/util/app_colors.dart';
import 'package:todo_app/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  DialogBox({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.taskCard,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: SizedBox(
          height: 120,
          child: Column(
            children: [
              TextField(
                controller: controller,
                style: const TextStyle(color: AppColors.text),
                decoration: InputDecoration(
                  hintText: "Add a new task",
                  hintStyle: const TextStyle(color: AppColors.completedTask),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // save button
                  MyButton(
                    text: "Save",
                    onPressed: onSave,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // cancel button
                  MyButton(
                    text: "Cancel",
                    onPressed: onCancel,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
