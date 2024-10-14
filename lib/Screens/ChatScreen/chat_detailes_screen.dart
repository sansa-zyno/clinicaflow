import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/Screens/ChatScreen/draft_templates_screen.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  ChatDetailScreenState createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String userName = 'Ramesh Patel';
  String userImageUrl = 'assets/images/user_avatar.png';
  List<Map<String, dynamic>> messages = [];

  void receiveMessage(String messageText) {
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add({
          'text': messageText,
          'isUser': false,
          'time': DateTime.now(),
          'seen': true,
        });
      });
    }
  }

  void sendMessage(String messageText) {
    if (messageText.isNotEmpty) {
      setState(() {
        messages.add({
          'text': messageText,
          'isUser': true,
          'time': DateTime.now(),
          'seen': false,
        });
      });

      if (messageText.toLowerCase().contains('mag')) {
        receiveMessage(
            "You've mentioned 'mag'. Here is the information related to it...");
      }

      _textEditingController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFDF3D1),
      appBar: AppBar(
        backgroundColor: AppColors.greenColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        titleSpacing: 0.0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/homeimages/Ellipse 763.png',
              ),
            ),
            const SizedBox(width: 10),
            Text(
              userName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final messageIndex = messages.length - index - 1;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                  child: Align(
                    alignment: messages[messageIndex]['isUser']
                        ? Alignment.topRight
                        : Alignment.topLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: messages[messageIndex]['isUser']
                            ? AppColors.greenColor
                            : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            messages[messageIndex]['text'],
                            style: TextStyle(
                              fontSize: 16,
                              color: messages[messageIndex]['isUser']
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.start,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('hh:mm a')
                                .format(messages[messageIndex]['time']),
                            style: TextStyle(
                              fontSize: 12,
                              color: messages[messageIndex]['isUser']
                                  ? Colors.white70
                                  : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 14.0, right: 8, top: 8, bottom: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _textEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'Write your message...',
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xFFF32856E),
                                size: 24,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 200,
                                      decoration: const BoxDecoration(
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'ADD FILES',
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 2,
                                                        decoration:
                                                            BoxDecoration(
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFF52CFAC),
                                                            width: 2,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: AppColors
                                                              .blackColor),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6),
                                                    ),
                                                    child: InkWell(
                                                      onTap: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Icon(
                                                        Icons.close_rounded,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Row(
                                              children: [
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              DraftTemplatesScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF32856E),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                              MdiIcons
                                                                  .accountMultiplePlus,
                                                              color:
                                                                  Colors.white,
                                                              size: 32),
                                                          const SizedBox(
                                                              height: 8),
                                                          const Text(
                                                              'Templates',
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      11)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFFF32856E),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5),
                                                            child: SvgPicture
                                                                .asset(
                                                              'assets/homeimages/solar_notes-linear.svg',
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                          const Text(
                                                            'Send',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'Poppins',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize:
                                                                    11 // Specify font size
                                                                ),
                                                          ),
                                                          const Text(
                                                              'Prescription',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      11)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: Container(
                                                      width: 80,
                                                      height: 100,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xFF32856E),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SvgPicture.asset(
                                                            'assets/homeimages/mingcute_bill-line.svg',
                                                            color: Colors.white,
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          const Text('Send',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 11,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white)),
                                                          const Text('files',
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  fontSize: 11,
                                                                  color: Colors
                                                                      .white)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.keyboard_voice,
                                color: Color(0xFF32856E),
                                size: 24,
                              ),
                              onPressed: () {
                                // Handle voice message input
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Material(
                    color: Colors.white,
                    child: InkWell(
                      onTap: () {
                        sendMessage(_textEditingController.text);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Icon(
                          Icons.send,
                          size: 32,
                          color: Color(0xFF32856E),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
