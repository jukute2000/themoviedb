import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String? content;
  final bool isInput;
  final String confirmText;
  final String cancelText;
  final Function(String?) onConfirm;

  const CustomAlertDialog({
    super.key,
    required this.title,
    this.content,
    this.isInput = false,
    this.confirmText = 'OK',
    this.cancelText = 'Hủy',
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: content);

    return AlertDialog(
      title: Text(title, style: const TextStyle(color: Colors.black)),
      content: isInput
          ? TextField(
        controller: controller,
        decoration: const InputDecoration(hintText: "Nhập nội dung..."),
      )
          : (content != null ? Text(content!) : null),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: () {
            if (isInput) {
              onConfirm(controller.text.trim());
            } else {
              onConfirm(null);
            }
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}