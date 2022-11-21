import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/widgets/calendario.dart';
import 'package:sgrsoft/ui/widgets/forms/app_combo_box.dart';
import 'package:sgrsoft/ui/widgets/forms/app_text_form.dart';

class StepDatos extends StatelessWidget {
  const StepDatos({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      AppTextForm(hintText: 'Nombre', labelText: 'Nombre'),
      CalendarWidget(
        selectDateFunction: (DateTime? date) {},
      ),
      AppComboBox(),
      AppComboBox()
    ]);
  }
}
