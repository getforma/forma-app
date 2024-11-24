import 'package:core_feature/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PinCodeInputWidget extends StatefulWidget {
  const PinCodeInputWidget(
      {super.key,
      required this.focusNode,
      required this.onFill,
      required this.isInvalid});

  @override
  PinCodeInputWidgetState createState() => PinCodeInputWidgetState();

  final FocusNode focusNode;
  final Function(String) onFill;
  final bool isInvalid;
}

class PinCodeInputWidgetState extends State<PinCodeInputWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.focusNode.requestFocus();
    });
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Opacity(
          opacity: 0.0,
          child: TextField(
            onChanged: (value) async {
              if (value.length == 6) {
                //short delay for better UX
                await Future.delayed(const Duration(milliseconds: 100));
                await widget.onFill(_controller.text);
              }
            },
            autofocus: true,
            controller: _controller,
            focusNode: widget.focusNode,
            keyboardType: TextInputType.number,
            maxLength: 6,
          ),
        ),
        // Visible squares
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            var isFilled = _controller.text.length > index;
            return Container(
              width: 43.w,
              height: 56.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              decoration: BoxDecoration(
                border: Border.all(
                    color: isFilled
                        ? AppColors.appBlack
                        : widget.isInvalid
                            ? Colors.red
                            : AppColors.background),
                borderRadius: BorderRadius.circular(8.r),
              ),
              alignment: Alignment.center,
              child: isFilled
                  ? Icon(Icons.circle, size: 15.w, color: AppColors.pureWhite)
                  : Container(),
            );
          }),
        ),
      ],
    );
  }
}
