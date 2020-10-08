import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  //final TextEditingController dateController;
  final firstDate;
  final lastDate;
  final String labelText;
  final Function selectedDate;

  DatePicker({
    this.firstDate,
    this.lastDate,
    this.labelText,
    this.selectedDate,
  });
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final _dateController = TextEditingController();
  DateTime _selectedDate;
  String dateStr;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat.yMd().format(_selectedDate);
      });
      widget.selectedDate(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: _dateController,
      onTap: _presentDatePicker,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.calendar_today),
        labelText: widget.labelText,
      ),
    );
  }
}
