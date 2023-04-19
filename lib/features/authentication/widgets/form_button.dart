import 'package:flutter/material.dart';
import '../../../constants/sizes.dart';

class FormButton extends StatelessWidget {
  final bool disabled;
  final String? text;

  const FormButton({
    super.key,
    required this.disabled,
    this.text,
  });

  bool _textValid() {
    if (text == null) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: AnimatedContainer(
        //Next 버튼에 애니메이션 효과
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            Sizes.size5,
          ),
          color:
              disabled ? Colors.grey.shade300 : Theme.of(context).primaryColor,
        ),
        child: AnimatedDefaultTextStyle(
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontWeight: FontWeight.w600,
          ),
          duration: const Duration(milliseconds: 300),
          child: Text(
            _textValid() ? text! : 'Next',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
