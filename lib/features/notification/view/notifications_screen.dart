import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/core/navigation/home_page_bottom_nav_cubit.dart';
import 'package:clinica_flow/features/notification/viewmodel/notification_cubit.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String calcTimesAgo(DateTime dt) {
    Duration dur = DateTime.now().difference(dt);
    if (dur.inSeconds < 60) {
      return "Just now";
    } else if (dur.inMinutes >= 1 && dur.inMinutes < 60) {
      return dur.inMinutes == 1
          ? "${dur.inMinutes} min ago"
          : "${dur.inMinutes} mins ago";
    } else if (dur.inHours >= 1 && dur.inHours < 24) {
      return dur.inHours == 1
          ? "${dur.inHours} hour ago"
          : "${dur.inHours} hours ago";
    } else if (dur.inHours >= 24) {
      DateTime dateNow =
          DateTime.parse(DateTime.now().toString().substring(0, 10));
      DateTime dte = DateTime.parse(dt.toString().substring(0, 10));
      String date = "${dte.year} ${dte.month} ${dte.day}" ==
              "${dateNow.year} ${dateNow.month} ${(dateNow.day) - 1}"
          ? "Yesterday"
          : DateFormat('MMM d, yyyy').format(dte);

      return date;
    }
    return "";
  }

  @override
  void initState() {
    super.initState();
  }

  //payments Color(0xFF876C05)
  //appointments Color(0xFF5351C7)
  //status Color(0xFFC31E0B)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 30,
        title: const Text('Notifications'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.of(context).pop();
            context.read<HomePageBottomNavCubit>().onPageChanged(0);
          },
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
        if (state.state == NotificationStates.fetchingNotifications) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state ==
            NotificationStates.fetchingNotificationsFailed) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.notificationList?.isEmpty ?? true) {
          return const Center(child: Text('No Notifications found.'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${state.notificationList!.length} notifications found',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12.0,
                      height: 1.2,
                      // line height
                      color: Color(0xFF8E8E8E),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.notificationList!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(
                                    0.05), // Transparent white color
                                offset: const Offset(1, 1),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                              const BoxShadow(
                                color: Color.fromRGBO(
                                    170, 170, 170, 0.36), // Grey color
                                offset: Offset(-1, -1),
                                blurRadius: 4,
                                spreadRadius: 0,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.notificationList![index]['header']}',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16.0,
                                  color: state.notificationList![index]
                                              ['header'] ==
                                          'Appointment'
                                      ? const Color(0xFF5351C7)
                                      : state.notificationList![index]
                                                  ['header'] ==
                                              'Payment'
                                          ? const Color(0xFF876C05)
                                          : const Color(0xFFC31E0B),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${state.notificationList![index]['notificationMessage']}'
                                          .trimLeft(),
                                      style: const TextStyle(
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  /*Text(
                                ' Oak',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                              ),*/
                                ],
                              ),
                              /* Row(
                                children: [
                                  Text(
                                    'Kumar',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    '  ₹250/- consultation fees.',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),*/
                              const SizedBox(height: 10),
                              Text(
                                calcTimesAgo(DateTime.parse(state
                                    .notificationList![index]['showTime'])),
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.0,
                                  color: Color(0xFF564A4D), // Custom color code
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
