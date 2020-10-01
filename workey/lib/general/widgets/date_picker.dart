import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final TextEditingController dateController;
  final String labelText;

  DatePicker(this.dateController, this.labelText);
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime _selectedDate;
  String dateStr;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        widget.dateController.text = DateFormat.yMd().format(_selectedDate);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: widget.dateController,
      onTap: _presentDatePicker,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.calendar_today),
        labelText: widget.labelText,
      ),
    );
  }
}
