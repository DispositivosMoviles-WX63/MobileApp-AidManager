import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessfullyProjectUpdateDialog extends StatelessWidget {
  const SuccessfullyProjectUpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.folder,
                color: Color.fromARGB(255, 44, 44, 44),
                size: 72,
              ),
              Positioned(
                right: 0,
                bottom: 3,
                child: Icon(
                  Icons.check_circle,
                  color: Color.fromARGB(255, 76, 175, 80),
                  size: 30,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Project Updated Successfully',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      content: const Text(
        'The project has been\n updated successfully.',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18, height: 1.65),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            context.go('/projects');
          },
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}