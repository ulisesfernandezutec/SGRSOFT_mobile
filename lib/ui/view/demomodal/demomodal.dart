import 'package:flutter/material.dart';

void main() {
  runApp(const DemoModal());
}

class DemoModal extends StatefulWidget {
  const DemoModal({Key? key}) : super(key: key);
  static const String routeName = '/demo/modal';
  @override
  DemoModalState createState() => DemoModalState();
}

class DemoModalState extends State<DemoModal> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modal Bottom Sheet Demo',
      home: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Creating a Modal Bottom Sheet'),
          backgroundColor: Colors.black38,
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Column(children: <Widget>[
                ElevatedButton(
                  child: const Text('Show Modal Bottom Sheet'),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                            color: Colors.transparent,
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 50),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      color: Colors.white,
                                      constraints:
                                          const BoxConstraints(maxWidth: 500),
                                      child: Wrap(
                                        children: const [
                                          ListTile(
                                            leading: Icon(Icons.share),
                                            title: Text('Share'),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.copy),
                                            title: Text('Copy Link'),
                                          ),
                                          ListTile(
                                            leading: Icon(Icons.edit),
                                            title: Text('Edit'),
                                          ),
                                        ],
                                      ))
                                ]));
                      },
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Show Modal AlertDialog'),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.all(10),
                            content: Container(
                              constraints: BoxConstraints(
                                  maxHeight:
                                      MediaQuery.of(context).size.height * 0.5,
                                  maxWidth: MediaQuery.of(context).size.width *
                                      0.5 // 80% of screen height
                                  ),
                              clipBehavior: Clip.none,
                              child: Column(children: <Widget>[
                                Center(
                                  // right: -15.0,
                                  // top: -15.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                Form(
                                  // key: 123,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        // height: 60,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        constraints:
                                            const BoxConstraints(maxWidth: 360),
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.yellow.withOpacity(0.2),
                                            border: Border(
                                                bottom: BorderSide(
                                                    color: Colors.grey
                                                        .withOpacity(0.3)))),
                                        child: const Center(
                                            child: Text("Contact Me",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    fontStyle: FontStyle.italic,
                                                    fontFamily: "Helvetica"))),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.2))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Container(
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                        border: Border(
                                                            right: BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2)))),
                                                    child: Center(
                                                        child: Icon(
                                                            Icons.person,
                                                            size: 35,
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.4))),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 4,
                                                  child: TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            hintText: "Name",
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            20),
                                                            border: InputBorder
                                                                .none,
                                                            focusedBorder:
                                                                InputBorder
                                                                    .none,
                                                            errorBorder:
                                                                InputBorder
                                                                    .none,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .black26,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500)),
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: ElevatedButton(
                                          // padding: EdgeInsets.zero,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 60,
                                            decoration: const BoxDecoration(
                                                gradient: LinearGradient(
                                                    begin: Alignment.topCenter,
                                                    end: Alignment.bottomCenter,
                                                    colors: [
                                                  Color(0xffc9880b),
                                                  Color(0xfff77f00),
                                                ])),
                                            child: const Center(
                                                child: Text(
                                              "Submit",
                                              style: TextStyle(
                                                  color: Colors.white70,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w800),
                                            )),
                                          ),
                                          onPressed: () {
                                            // if (_formKey.currentState
                                            //     .validate()) {
                                            //   _formKey.currentState.save();
                                            // }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          );
                        });
                  },
                ),
                ElevatedButton(
                  child: const Text('Show Modal FULL'),
                  onPressed: () {
                    showGeneralDialog(
                        context: context,
                        barrierDismissible: false,
                        barrierLabel: MaterialLocalizations.of(context)
                            .modalBarrierDismissLabel,
                        barrierColor: Colors.black45,
                        transitionDuration: const Duration(milliseconds: 200),
                        pageBuilder: (BuildContext buildContext,
                            Animation animation, Animation secondaryAnimation) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.all(20),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )
              ]),
            );
          },
        ),
      ),
    );
  }
}
