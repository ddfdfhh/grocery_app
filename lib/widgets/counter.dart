import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputWithIncrementDecrement extends StatefulWidget {
  @override
  _NumberInputWithIncrementDecrementState createState() =>
      _NumberInputWithIncrementDecrementState();
}

class _NumberInputWithIncrementDecrementState
    extends State<NumberInputWithIncrementDecrement> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = "0"; // Setting the initial value for the field.
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: TextFormField(
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
            ),
            controller: _controller,
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: true,
            ),
            inputFormatters: <TextInputFormatter>[],
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(5),
                  ),
                  color: Colors.lightGreen,
                ),
                child: InkWell(
                  child: Icon(
                    color: Colors.white,
                    CupertinoIcons.plus,
                    size: 10.0,
                  ),
                  onTap: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      currentValue++;
                      _controller.text =
                          (currentValue).toString(); // incrementing value
                    });
                  },
                ),
              )),
              Expanded(
                  child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: InkWell(
                  child: Icon(
                    color: Colors.white,
                    CupertinoIcons.minus,
                    size: 10.0,
                  ),
                  onTap: () {
                    int currentValue = int.parse(_controller.text);
                    setState(() {
                      if(currentValue>0) {
                        currentValue--;
                        _controller.text =
                            (currentValue).toString();
                      }// incrementing value
                    });
                  },
                ),
              )),
            ],
          ),
        ),
      ],
    );
  }
}
