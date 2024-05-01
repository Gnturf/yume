import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

enum FocusStatus {
  focused,
  empty,
  filled,
}

class OTPSingleTextField extends StatefulWidget {
  const OTPSingleTextField({
    super.key,
    required this.focusNode,
    this.prevNode,
    this.nextNode,
  });

  final FocusNode focusNode;
  final FocusNode? prevNode;
  final FocusNode? nextNode;

  @override
  State<StatefulWidget> createState() {
    return _OTPSingleTextFieldState();
  }
}

class _OTPSingleTextFieldState extends State<OTPSingleTextField> {
  final _controller = TextEditingController();

  FocusStatus _focusState = FocusStatus.empty;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(focusChangeListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.focusNode.removeListener(focusChangeListener);
  }

  // Listening To TextField focus change
  void focusChangeListener() {
    // Check current TextField focus status
    bool isFocused = widget.focusNode.hasFocus;

    // If focus, change the "_focusState"
    if (isFocused) {
      setState(() {
        _focusState = FocusStatus.focused;
      });
      // If not, set the "_focusState" to wether textField has value or not
    } else {
      if (_controller.text.isEmpty) {
        setState(() {
          _focusState = FocusStatus.empty;
        });
      } else {
        setState(() {
          _focusState = FocusStatus.filled;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Used to get the dimension of the
    final otpNumberDimension = TextPainter(
      text: TextSpan(
        text: '0',
        style: Theme.of(context).textTheme.displayMedium,
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    /*
      Here we implement binary like system, means that:
      - If it has value it equals to 1
      - If it has no value after just deleted it has value of 0
      - If it deleted again after has no value it was null
    */
    bool isLastDigit = false;

    return SizedBox(
      // 8 Was from 4 + 4 on both sides
      width: otpNumberDimension.width + 8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 6,
          ),
          /* This whole KeyboardListener was basicly used for backtracking */
          KeyboardListener(
            focusNode: FocusNode(),
            onKeyEvent: (value) {
              // Check if a key on keyboard was pressed and if the one that was pressed was backspace
              if (value is KeyDownEvent &&
                  value.logicalKey == LogicalKeyboardKey.backspace) {
                // Check if the TextField was empty, if it was empty then it will-
                // just delete it and will not switch to prev TextField
                if (_controller.text.isEmpty) {
                  isLastDigit = true;
                }

                // Because it was already empty, if user press-
                // the backspace again then it will switch to prev TextField
                if (isLastDigit) {
                  FocusScope.of(context).requestFocus(widget.prevNode);
                }
              }
            },
            child: TextFormField(
              controller: _controller,
              focusNode: widget.focusNode,
              maxLength: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              style: Theme.of(context).textTheme.displayMedium,
              decoration: InputDecoration.collapsed(
                hintText: "",
                hintStyle: Theme.of(context).textTheme.displayMedium,
              ).copyWith(counterText: ''),
              /* This onChange was the reverse of KeyboardListener which basicly used for forward-tracking */
              onChanged: (value) {
                isLastDigit = false;
                if (value.isNotEmpty) {
                  if (widget.nextNode == null) {
                    widget.focusNode.unfocus();
                  }
                  FocusScope.of(context).requestFocus(widget.nextNode);
                }
              },
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: _focusState == FocusStatus.empty
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.6)
                  : _focusState == FocusStatus.focused
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.background,
              borderRadius: BorderRadius.circular(100),
            ),
          )
        ],
      ),
    );
  }
}
