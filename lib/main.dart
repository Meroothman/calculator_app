import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic displaytxt = 5;
  //Button Widget
  Widget calcbutton(String btntxt,Color btncolor,Color txtcolor){
    return  MaterialButton(
      onPressed: (){
        calculation(btntxt);
      },
      
      shape: const CircleBorder(),
      color: btncolor,
      padding: const EdgeInsets.all(10),
      child: Text(btntxt,
        style: TextStyle(
          fontSize: 25,
          color: txtcolor,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //Calculator
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){},
            child: const Icon(Icons.apps,color: Colors.black,),
          ),
        ],
        leading: const Icon(Icons.calculate,color: Colors.black,),
        title: const Text('Calculator App'),backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Calculator display
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text('$text',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 70,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  calcbutton('AC',Colors.grey,Colors.black),
                  calcbutton('+/-',Colors.grey,Colors.black),
                  calcbutton('%',Colors.grey,Colors.black),
                  calcbutton('/',Colors.amber,Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  calcbutton('7',Colors.grey,Colors.white),
                  calcbutton('8',Colors.grey,Colors.white),
                  calcbutton('9',Colors.grey,Colors.white),
                  calcbutton('x',Colors.amber,Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  calcbutton('4',Colors.grey,Colors.white),
                  calcbutton('5',Colors.grey,Colors.white),
                  calcbutton('6',Colors.grey,Colors.white),
                  calcbutton('-',Colors.amber,Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  calcbutton('1',Colors.grey,Colors.white),
                  calcbutton('2',Colors.grey,Colors.white),
                  calcbutton('3',Colors.grey,Colors.white),
                  calcbutton('+',Colors.amber,Colors.white),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  //this is button Zero
                  MaterialButton(
                    padding: const EdgeInsets.fromLTRB(34, 20, 128, 20),
                    onPressed: (){
                      calculation('0');
                    },
                    shape: const StadiumBorder(),
                     color: Colors.grey[850],
                    child:  const Text('0',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white),
                    ),
                   
                  ),
                  calcbutton('.',Colors.grey,Colors.white),
                  calcbutton('=',Colors.amber,Colors.white),
                ],
              ),
            ),
            const SizedBox(height:20,),
          ],
        ),
      ),
    );
  }

  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-$result';
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}

