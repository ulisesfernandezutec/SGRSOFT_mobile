import 'package:flutter/material.dart';

class AppHeadModal extends StatelessWidget {
  final String title;
  const AppHeadModal({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).primaryColor,
        margin: EdgeInsets.zero,
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(10),
          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   color: Theme.of(context).primaryColor,
          //   border: Border(
          //     bottom: BorderSide(
          //       color: Theme.of(context).dividerColor,
          //       width: 3,
          //     ),
          //   ),
          // ),
          child: Text(
            title.toUpperCase(),
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
        ));
  }
}
