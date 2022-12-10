import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef SelectDateFunction = void Function(DateTime? date);

class CalendarWidget extends StatefulWidget {
  final SelectDateFunction selectDateFunction;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? restorationId;

  const CalendarWidget(
      {super.key,
      required this.selectDateFunction,
      this.initialDate,
      this.firstDate,
      this.lastDate,
      this.restorationId});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: TextFormField(
          cursorHeight: 20,
          readOnly: true,
          textAlign: TextAlign.start,
          textInputAction: TextInputAction.next,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            // prefixIcon: Icon(
            //   Icons.date_range,
            //   color: Theme.of(context).primaryColor,
            //   size: 35,
            // ),
            suffixIcon: Icon(
              Icons.date_range,
              color: Theme.of(context).primaryColor,
              size: 35,
            ),
            hintText: "Ingrese fecha",
            labelText: 'Fecha',
          ),
          controller: _dateController,
          onTap: () async {
            DateTime? date = await showDatePicker(
              context: context,
              initialDate: widget.initialDate ?? DateTime.now(),
              firstDate: widget.firstDate ?? DateTime(2022),
              lastDate: widget.lastDate ?? DateTime(2023),
            );
            if (date != null) {
              _dateController.text = DateFormat('dd/MM/yyyy').format(date);
              widget.selectDateFunction(date);
            }
          },
        ));
  }
}
