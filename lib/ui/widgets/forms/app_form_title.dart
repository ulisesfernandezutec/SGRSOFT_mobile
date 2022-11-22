import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/const/forms.dart';

class AppFromTitle extends StatelessWidget {
  final String title;
  const AppFromTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      width: double.infinity,
      constraints: BoxConstraints(maxWidth: FormConst.maxWidth),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // borderRadius: const BorderRadius.only(
        //   topLeft: Radius.circular(0),
        //   topRight: Radius.circular(0),
        // ),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 3,
          ),
        ),
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: const Color.fromARGB(255, 71, 150, 74)),
      ),
    );
  }
}
