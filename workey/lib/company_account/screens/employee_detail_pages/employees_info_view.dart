import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workey/general/models/group_employee_model.dart';

enum TextFieldType {
  salary,
  position,
}

class EmployeesInfoView extends StatefulWidget {
  final name = 'Info';

  String get getName {
    return this.name;
  }

  final GroupEmployeeModel currentEmployee;

  EmployeesInfoView(this.currentEmployee);

  @override
  _EmployeesInfoViewState createState() => _EmployeesInfoViewState();
}

class _EmployeesInfoViewState extends State<EmployeesInfoView> {
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
    Widget textView(
      String title,
    ) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          height: 50,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.0),
            color: Colors.grey.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title == 'First Name'
                  ? Text(widget.currentEmployee.firstName)
                  : title == 'Last Name'
                      ? Text(widget.currentEmployee.lastName)
                      : title == 'E-Mail'
                          ? Text(widget.currentEmployee.email)
                          : title == 'Phone Number'
                              ? widget.currentEmployee.phoneNumber == null
                                  ? Text('no data')
                                  : Text(widget.currentEmployee.phoneNumber)
                              : title == 'Address'
                                  ? widget.currentEmployee.phoneNumber == null
                                      ? Text('no data')
                                      : Text(widget.currentEmployee.address)
                                  : title == 'Date Of Adddition'
                                      ? Text(
                                          DateFormat.yMd().format(
                                              widget.currentEmployee.entryDate),
                                        )
                                      : Text('')
            ],
          ),
        ),
      );
    }

    print(widget.currentEmployee.address);
    print(widget.currentEmployee.firstName);
    print(widget.currentEmployee.lastName);
    print(widget.currentEmployee.phoneNumber);
    print(widget.currentEmployee.entryDate);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                      Text("EDITABLE"),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                    ],
                  ),
                  textEditaleView(widget.currentEmployee.salary,
                      TextFieldType.salary, salaryController),
                  textEditaleView(widget.currentEmployee.role,
                      TextFieldType.position, positionController),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 10.0, right: 20.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                      Text("NOT EDITABLE"),
                      Expanded(
                        child: new Container(
                            margin:
                                const EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Divider(
                              color: Colors.black,
                              height: 36,
                            )),
                      ),
                    ],
                  ),
                  textView('First Name'),
                  textView('Last Name'),
                  textView('E-Mail'),
                  textView('Phone Number'),
                  textView('Address'),
                  textView('Date Of Addition'),
                ],
              ),
            ),
          )
        ],
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
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.0),
          color: Colors.grey.withOpacity(0.2),
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
