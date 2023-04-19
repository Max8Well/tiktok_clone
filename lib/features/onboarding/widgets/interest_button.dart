import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class interest_button extends StatefulWidget {
  const interest_button({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<interest_button> createState() => _interest_buttonState();
}

class _interest_buttonState extends State<interest_button> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size24,
          horizontal: Sizes.size24,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.05),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 5,
            )
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
