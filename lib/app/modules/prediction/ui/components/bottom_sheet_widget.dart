import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({Key key}) : super(key: key);

  @override
  _BottomSheetWidget createState() => _BottomSheetWidget();
}

class _BottomSheetWidget extends State<BottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, left: 15, right: 15),
      height: 220,
      color: Color.fromRGBO(255, 255, 255, 0.5),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 185,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey[300],
                  spreadRadius: 5
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                DecoratedTextField(),
                SheetButtom(),
              ],
            )
          )
        ],
      ),
    );
  }
}

class DecoratedTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        minLines: 6,
        keyboardType: TextInputType.multiline,
        maxLines: 500,
        decoration: InputDecoration.collapsed(hintText: 'Please tell us the details'),
      ),
    );
  }
}

class SheetButtom extends StatefulWidget {
  const SheetButtom({Key key}) : super(key: key);

  @override
  _SheetButtomState createState() => _SheetButtomState();
}

class _SheetButtomState extends State<SheetButtom> {
  bool details = false;
  bool success = false;

  @override
  Widget build(BuildContext context) {
    return !details ? MaterialButton(
      color: Colors.grey[800],
      onPressed: () async {
        setState(() {
          details = true;
        });

        await Future.delayed(Duration(seconds: 1));

        setState(() {
          success = true;
        });

        await Future.delayed(Duration(milliseconds: 500));

        Navigator.pop(context);
      },
      child: Text(
        'Send',
        style: TextStyle(color: Colors.white),
      ),
    ) : !success ? CircularProgressIndicator() : Icon(
      Icons.check,
      color: Colors.green,
    );
  }
}
