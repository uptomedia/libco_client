import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PinEntryTextField extends StatefulWidget {
  late int fields;
  late TextStyle textStyle;
  late bool isTextObscure;
  late double width;
  late List<TextEditingController> textControllers;

  PinEntryTextField(
      {required this.fields,
      required this.textStyle,
      required this.isTextObscure,
      required this.width,
      required this.textControllers})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  List<FocusNode> _focusNodes = <FocusNode>[];

  //late List<TextEditingController> _textControllers=<TextEditingController>[];

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    _focusNodes.forEach((FocusNode f) => f.dispose());
    //widget.textControllers.forEach((TextEditingController t) => t.dispose());
  }

  Widget buildTextField(int i, BuildContext context) {
    return Container(
      width: widget.width,
      //margin: EdgeInsets.only(right:5.0),
      child: TextField(
        controller: widget.textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        //maxLength: 1,
        style: widget.textStyle,
        focusNode: _focusNodes[i],
        //obscureText: widget.isTextObscure,
        decoration: InputDecoration(counterText: "", border: null),
        onChanged: (String str) {
          if (i + 1 != widget.fields && widget.textControllers[i].text != '') {
            print(widget.textControllers[i].text);
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          }
        },
      ),
    );
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });
    // FocusScope.of(context).requestFocus(_focusNodes[0]);

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  _init() {
    for (int i = 0; i < widget.fields; i++) {
      print(widget.fields);
      _focusNodes.add(FocusNode());
      widget.textControllers.add(TextEditingController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: generateTextFields(context),
    );
  }
}
