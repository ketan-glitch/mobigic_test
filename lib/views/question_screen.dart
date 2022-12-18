import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobigic_test/views/base/common_button.dart';
import 'package:mobigic_test/views/base/custom_appbar.dart';
import 'package:mobigic_test/views/base/input_decoration.dart';
import 'package:mobigic_test/views/base/route_helper.dart';
import 'package:mobigic_test/views/dashboard.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

final RegExp nameRegExp = RegExp('[A-Za-z]');

class _QuestionScreenState extends State<QuestionScreen> {
  int xAxis = 0;
  int yAxis = 0;

  TextEditingController xAxisEditingController = TextEditingController();
  TextEditingController yAxisEditingController = TextEditingController();
  TextEditingController gridTextEditingController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String getReplacementString() {
    if (gridTextEditingController.text.isNotEmpty) {
      gridTextEditingController.text.substring(gridTextEditingController.text.length - 4);
    }
    return '';
  }

  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        bgColor: Theme.of(context).primaryColor,
        title: "Question Screen",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      itemCount: 6,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemBuilder: (context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (xAxis > 0 && yAxis > 0)
                  Text(
                    "$xAxis x $yAxis",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 14.0,
                        ),
                  ),
                const SizedBox(height: 30),
                Text(
                  "Enter a value for grid row",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 14.0,
                      ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: xAxisEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else if (int.parse(value) < 1) {
                      return "Required value < 0";
                    }
                    return null;
                  },
                  cursorColor: Theme.of(context).primaryColor,
                  onEditingComplete: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (int.parse(value) > 0) {
                        xAxis = int.parse(value);
                      }

                      // setState(() {});
                    }
                    if (timer != null) {
                      timer!.cancel();
                    }
                    timer = Timer(const Duration(seconds: 1), () {
                      setState(() {});
                    });
                  },
                  decoration: CustomDecoration.inputDecoration(label: 'Row value'),
                ),
                const SizedBox(height: 20),
                Text(
                  "Enter a value for grid Column",
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        fontSize: 14.0,
                      ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: yAxisEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  cursorColor: Theme.of(context).primaryColor,
                  textAlign: TextAlign.center,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    } else if (int.parse(value) < 1) {
                      return "Required value < 0";
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    setState(() {});
                  },
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (int.parse(value) > 0) {
                        yAxis = int.parse(value);
                      }

                      // setState(() {});
                    }
                    if (timer != null) {
                      timer!.cancel();
                    }
                    timer = Timer(const Duration(seconds: 1), () {
                      setState(() {});
                    });
                  },
                  decoration: CustomDecoration.inputDecoration(label: 'Column value'),
                ),
                const SizedBox(height: 30),
                if (xAxis > 0 && yAxis > 0)
                  Text(
                    "Enter a ${xAxis * yAxis} alphabets for grid",
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                          fontSize: 14.0,
                        ),
                  ),
                const SizedBox(height: 10),
                if (xAxis > 0 && yAxis > 0)
                  TextFormField(
                    controller: gridTextEditingController,
                    maxLength: xAxis * yAxis,
                    minLines: 1,
                    maxLines: 4,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    textInputAction: TextInputAction.done,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value?.length != xAxis * yAxis) {
                        return 'Please enter all ${xAxis * yAxis} characters ';
                      }
                      return null;
                    },
                    inputFormatters: [
                      // FilteringTextInputFormatter(RegExp(r'^[a-zA-Z]+$'), allow: true, replacementString: getReplacementString()),
                      FilteringTextInputFormatter.allow(nameRegExp),
                    ],
                    cursorColor: Theme.of(context).primaryColor,
                    textAlign: TextAlign.center,
                    onChanged: (value) {},
                    decoration: CustomDecoration.inputDecoration(label: 'Enter ${xAxis * yAxis} characters'),
                  ),
                // const Spacer(),
                CustomButton(
                  type: ButtonType.primary,
                  onTap: (xAxis > 0 && yAxis > 0)
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.pushReplacement(
                                context, getCustomRoute(child: Dashboard(message: gridTextEditingController.text.toLowerCase(), xAxis: xAxis, yAxis: yAxis)));
                          }
                        }
                      : null,
                  title: "Continue",
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
