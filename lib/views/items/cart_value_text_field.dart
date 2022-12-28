import 'package:dsd/db/item/item_db_contants.dart';
import 'package:dsd/theme/colors.dart';
import 'package:flutter/material.dart';

class CartEditior extends StatefulWidget {
  final int existingQuantity;
  final double reOrderQuantity;
  const CartEditior(
      {Key? key, required this.existingQuantity, required this.reOrderQuantity})
      : super(key: key);

  @override
  State<CartEditior> createState() => _CartEditiorState();
}

class _CartEditiorState extends State<CartEditior> {
  final TextEditingController _controller = TextEditingController();
  void _valueChange(val) {
    setState(() {});
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _controller.text = widget.existingQuantity.toString();
  }

  void submit() {
    int val = int.parse(_controller.text);

    if (val % widget.reOrderQuantity == 0) {
      Navigator.pop(context, int.parse(_controller.text));
    } else {
      const s = SnackBar(
        content: Text(
          'you have entered wrong value',
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      // title: Center(child: const Text('update quantity')),
      content: SizedBox(
        height: 125,
        width: size.width * 0.8,
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: size.width * 0.4,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    border: const OutlineInputBorder(
                        gapPadding: 1.0,
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    contentPadding: EdgeInsets.zero,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  style: const TextStyle(color: textBlack, height: 1.0),
                  onChanged: _valueChange,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: GestureDetector(
                      onTap: _cancel,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: GestureDetector(
                      onTap: submit,
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: secondary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
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
