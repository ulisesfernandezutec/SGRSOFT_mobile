import 'package:flutter/material.dart';
import 'package:sgrsoft/ui/const/web.dart';

class AppHeadModal extends StatelessWidget {
  final String title;
  const AppHeadModal({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 3,
          ),
        ),
      ),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .headline5
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}
