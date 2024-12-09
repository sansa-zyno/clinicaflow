import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/AppointmentScreen/appointment_screen.dart';
import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/constants/constants.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String selectedDate = 'All';

  @override
  void initState() {
    super.initState();
    context.read<HomePageBottomNavCubit>().onPageChanged(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text(
          'Chat',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                color: const Color(0xffF5F5F5),
                child: const Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.search),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: AppText.quickSearch,
                              hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: 16, fontWeight: FontWeight.w400),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              const Text(
                'Recent Chats',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InfoCard(),
                  SizedBox(
                    height: 12,
                  ),
                  InfoCard(),
                  SizedBox(
                    height: 12,
                  ),
                  InfoCard(),
                  SizedBox(
                    height: 12,
                  ),
                  InfoCard(),
                  SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class InfoCard extends StatefulWidget {
  const InfoCard({Key? key}) : super(key: key);

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(AppRoutes.chatDetails.name);
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ChatDetailScreen()),
        // );
      },
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          color: AppColors.white1Color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/homeimages/Ellipse 763.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Ramesh Patel',
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          width: 95,
                        ),
                        Text(
                          '14:30',
                          style: GoogleFonts.montserrat(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Image.asset('assets/homeimages/Vector 224.png'),
                        const SizedBox(
                          width: 5,
                        ),
                        FittedBox(
                          child: Text(
                            'You have a scheduled a appointment...',
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomBarChat extends StatefulWidget {
  const BottomBarChat({super.key});

  @override
  State<BottomBarChat> createState() => _BottomBarChatState();
}

class _BottomBarChatState extends State<BottomBarChat> {
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xff03BF9C),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff6CEBC6).withOpacity(0.5),
            blurRadius: 25,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () => setState(() {
              _selectedIndex = 0;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 0 ? 'assets/homeimages/icon_home.png' : 'assets/homeimages/Group.png'),
                Text(
                  'Home',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 0 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _selectedIndex = 1;
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const AppointmentScreen();
                }));
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 1 ? 'assets/homeimages/Vector (9).png' : 'assets/homeimages/Group (1).png'),
                Text(
                  'Appointments',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 1 ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              _selectedIndex = 2;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 2 ? 'assets/homeimages/Vector (10).png' : 'assets/homeimages/Vector (4).png'),
                Text(
                  'Chat',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 2 ? Colors.white : Colors.black,
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () => setState(() {
              _selectedIndex = 3;
            }),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(_selectedIndex == 3 ? 'assets/homeimages/Vector (11).png' : 'assets/homeimages/Vector (5).png'),
                Text(
                  'Notifications',
                  style: GoogleFonts.montserrat(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: _selectedIndex == 3 ? Colors.white : Colors.black,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
