import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import '../../constants/style.dart';
import '../overview/widgets/driver dialog.dart';
import 'package:http/http.dart' as http;

class ChatMessage {
  String messageContent;
  String messageType;

  ChatMessage({required this.messageContent, required this.messageType});
}

class ServiceDialog extends StatefulWidget {
  final String name, ticket;

  const ServiceDialog({Key? key, required this.name, required this.ticket})
      : super(key: key);

  @override
  State<ServiceDialog> createState() => _ServiceDialogState();
}

class _ServiceDialogState extends State<ServiceDialog> {
  TextEditingController messageController = TextEditingController();
  String baseUrl = "https://clownfish-app-lfvmm.ondigitalocean.app/complaint/";
  StreamController<List> streamController = StreamController();

  Future<void> getComplaints() async {
    final headers = {
      "Content-type": "application/json",
    };
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: headers,
    );
    List<dynamic> data = jsonDecode(response.body);
    streamController.add(data.toList());
  }

  Future<void> updateCompStatus(id, status) async {
    final headers = {"Content-type": "application/json"};
    final json = {"id": id, "Status": status};
    final response = await http.patch(Uri.parse(baseUrl),
        headers: headers, body: jsonEncode(json));
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }

  // var id, status;
  late int id;
  late String status;
  int progress = 0;
  int step = 0;

  final controller = ScrollController();
  final popController = ScrollController();
  bool pressed = false;

  List<ChatMessage> messages = [
    ChatMessage(
        messageContent: "क्या आपके वाहन में कोई खराबी है?",
        messageType: "sender"),
    ChatMessage(
        messageContent: "हेडलाइट काम नहीं कर रहा हे", messageType: "receiver"),
    ChatMessage(
        messageContent: "मुझे नई हेडलाइट चाहिए", messageType: "receiver"),
    ChatMessage(
        messageContent:
            "नमस्ते, दिलावर, हमने आपकी सेवा अनुरोध स्वीकार कर ली है",
        messageType: "sender"),
    ChatMessage(
        messageContent: "आपका टिकट नंबर 2538 है", messageType: "sender"),
  ];

  Widget controlWindow(index) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Align(
              alignment: Alignment.topLeft,
              child: CircleAvatar(
                radius: 35,
                backgroundColor: Colors.tealAccent.shade100,
                child: Icon(
                  Icons.person,
                  color: Colors.blueGrey,
                  size: 30,
                ),
              ),
            ),
            trailing: Text(
              (index + 1).toString(),
              style: TextStyle(color: ecosperity, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      status = 'Accepted';
                    });
                    updateCompStatus(id, "Accepted");
                  },
                  child: Text(
                    "Accept",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      status = 'Rejected';
                    });
                    updateCompStatus(id, "Rejected");
                  },
                  child: Text(
                    "Reject",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List>(
        stream: streamController.stream,
        builder: (context, snapshot) {
          getComplaints();
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          List filter = snapshot.data!
              .where((element) => element["Name"] == widget.name)
              .where((element) => element["Ticket"] == widget.ticket)
              .toList();

          progress = int.parse(filter.first['Progress']);
          id = filter.first['id'];

          return Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              ListView(
                scrollDirection: Axis.horizontal,
                itemExtent: MediaQuery.of(context).size.width,
                physics: PageScrollPhysics(),
                controller: popController,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Material(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(255, 250, 250, 250),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.height / 1.5,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.1),
                              blurRadius: 1,
                              offset: const Offset(0.0, 2.0),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            LimitedBox(
                              maxHeight: 50,
                              child: Stack(
                                alignment: AlignmentDirectional.centerStart,
                                children: [
                                  LinearProgressIndicator(
                                    color: Colors.tealAccent,
                                    backgroundColor: Colors.tealAccent,
                                    valueColor: const AlwaysStoppedAnimation(
                                        ecosperity),
                                    value: progress == 0 ? 0 : progress / 200,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 6,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.jumpTo(
                                              index *
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.55),
                                            );
                                            setState(() {
                                              progress = 36 * index;
                                            });
                                            // updateComp();
                                          },
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(right: 125),
                                            child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: progress >=
                                                          30 * index +
                                                              (index * 6)
                                                      ? ecosperity
                                                      : Colors.tealAccent,
                                                  shape: BoxShape.circle),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15),
                                                child: Text(
                                                  (index + 1).toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                            LimitedBox(
                              maxHeight:
                                  (MediaQuery.of(context).size.width / 1.5) / 4,
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width:
                                          (MediaQuery.of(context).size.width /
                                                  1.5) /
                                              1.7,
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 6,
                                          controller: controller,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2.55,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 1,
                                                      color:
                                                          Colors.tealAccent)),
                                              child: controlWindow(index),
                                            );
                                          }),
                                    ),
                                    Container(
                                      width: 320,
                                      height: 400,
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 1,
                                              color: Colors.tealAccent)),
                                      child: ListView.builder(
                                        itemCount: messages.length,
                                        shrinkWrap: true,
                                        padding: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(
                                                left: 14,
                                                right: 14,
                                                top: 10,
                                                bottom: 10),
                                            child: Align(
                                              alignment: (messages[index]
                                                          .messageType ==
                                                      "receiver"
                                                  ? Alignment.topLeft
                                                  : Alignment.topRight),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: (messages[index]
                                                              .messageType ==
                                                          "receiver"
                                                      ? Colors.grey.shade200
                                                      : ecosperity),
                                                ),
                                                padding: EdgeInsets.all(12),
                                                child: Text(
                                                  messages[index]
                                                      .messageContent,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color: messages[index]
                                                                  .messageType ==
                                                              "receiver"
                                                          ? ecosperity
                                                          : Colors.white),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: messageController,
                                decoration: InputDecoration(
                                    labelText: "Please write a message",
                                    suffixIcon: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.send,
                                        color: Colors.blueGrey.shade200,
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Driver(driver: widget.name)
                ],
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Material(
                    shape: CircleBorder(),
                    color: Colors.white10,
                    child: IconButton(
                        padding: const EdgeInsets.all(15.0),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: ecosperity,
                        ))),
              )
            ],
          );
        });
  }
}
