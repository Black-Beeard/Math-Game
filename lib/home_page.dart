import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app/const.dart';
import 'package:test_app/util/my_button.dart';
import 'package:test_app/util/return_message.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Number Pad List

  List<String> numberPad = [
    '7',
    '8',
    '9',
    'AC',
    '4',
    '5',
    '6',
    'DEL',
    '1',
    '2',
    '3',
    '=',
    '0',
  ];

  //Number A, Number B
  int numberA = 1;
  int numberB = 1;

  //user answer

  String userAnswer = '';

  //user tapped a button

  void buttonTapped(String button) {
    setState(() {
      if (button == '=') {
        //calculate if user is correct or wrong
        checkResult();
      } else if (button == 'AC') {
        //clear the input
        userAnswer = '';
      } else if (button == 'DEL') {
        //delete the last number
        if (userAnswer.isNotEmpty) {
          userAnswer = userAnswer.substring(0, userAnswer.length - 1);
        }
      } else if (userAnswer.length < 3) {
        //maximum of 3 numbers can be inputed
        userAnswer += button;
      }

      // useranswer = useranswer + button;
    });
  }

  //check if user is correct or wrong
  void checkResult() {
    if (numberA + numberB == int.parse(userAnswer)) {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
                message: 'Correct !',
                onTap: goToNextQuestion,
                icon: Icons.arrow_forward);
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return ResultMessage(
                message: 'Sorry try again !',
                onTap: goBackToQuestion,
                icon: Icons.rotate_left);
          });
    }
  }

  //create random numbers
  var randomNumber = Random();

  void goToNextQuestion() {
    //dismiss alert dialog
    Navigator.of(context).pop();

    //reset values
    setState(() {
      userAnswer = '';
    });

    //create a new question
    numberA = randomNumber.nextInt(10);
    numberB = randomNumber.nextInt(10);
  }

  //go Back to next question
  void goBackToQuestion() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[300],
      body: Column(
        children: [
          //level progress, player need 5 correct answers in a row to proceed next level
          Container(
            height: 100,
            color: Colors.deepPurple,
          ),

          //question
          Expanded(
            child: Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //question
                    Text(
                      numberA.toString() + ' + ' + numberB.toString() + ' = ',
                      style: whiteTextStyle,
                    ),
                    //answer box

                    Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.deepPurple[400],
                      ),
                      child: Center(
                        child: Text(
                          userAnswer,
                          style: whiteTextStyle,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              color: Colors.deepPurple[300],
            ),
          ),

          //number pad
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: numberPad.length,
                // physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MyButton(
                    sufi: numberPad[index],
                    onTap: () => buttonTapped(numberPad[index]),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
