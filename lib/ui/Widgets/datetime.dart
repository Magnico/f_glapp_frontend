import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';

// taken from https://github.com/jifalops/datetime_picker_formfields

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
        },
      ),
    ]);
  }
}

class BasicTimeField extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

//modified
class BasicDateTimeField extends StatelessWidget {
  BasicDateTimeField(this.title, this.reference, {Key? key}) : super(key: key);
  var reference;
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title),
          DateTimeField(
            format: format,
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: //Fecha inicial es el día de hoy sin la hora
                      DateTime(DateTime.now().year, DateTime.now().month,
                          DateTime.now().day),
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                reference.updateDate(DateTimeField.combine(date, time));
                return DateTimeField.combine(date, time);
              } else {
                reference.updateDate(currentValue);
                return currentValue;
              }
            },
          ),
        ]);
  }
}
