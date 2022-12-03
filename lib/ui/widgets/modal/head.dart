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
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Row(children: <Widget>[
            Expanded(
                child: Text(
              title.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  ?.copyWith(color: Colors.white),
              // overflow: TextOverflow.ellipsis,
              softWrap: true,
            )),
            // const Spacer(),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            )
          ]),
        ));
  }
}
