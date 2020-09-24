import 'package:flutter/material.dart';

enum TextFieldType {
  salary,
  position,
}

class EmployeesInfoView extends StatefulWidget {
  final name = 'Info';

  String get getName {
    return this.name;
  }

  @override
  _EmployeesInfoViewState createState() => _EmployeesInfoViewState();
}

class _EmployeesInfoViewState extends State<EmployeesInfoView> {
  //TODO:get employees data.
  final salaryController = TextEditingController();
  final positionController = TextEditingController();

  @override
  void dispose() {
    salaryController.dispose();
    positionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  textView('First Name'),
                  textView('Last Name'),
                  textView('Phone Number'),
                  textView('Address'),
                  textView('Date Of Addition'),
                  textEditaleView(
                      'Salary', TextFieldType.salary, salaryController),
                  textEditaleView(
                      'position', TextFieldType.position, positionController),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget textView(
    String title,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.grey,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            //TODO: enter real data.
            Text('data'),
          ],
        ),
      ),
    );
  }

  Widget textEditaleView(
    String title,
    TextFieldType textFieldType,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
        height: 50,
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.grey,
        ),
        child: TextFormField(
          controller: controller,
          onSaved: textFieldType == TextFieldType.salary
              ? (value) {
                  setState(() {
                    controller.text = value;
                  });
                }
              : textFieldType == TextFieldType.position
                  ? (value) {
                      setState(() {
                        controller.text = value;
                      });
                    }
                  : null,
          decoration: InputDecoration(
            labelText: title,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
