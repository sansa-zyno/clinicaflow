import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:healtether_clinic_app/business_logic/cubits/home_page_bottom_nav_cubit/home_page_bottom_nav_cubit.dart';
import 'package:healtether_clinic_app/business_logic/blocs/login_bloc/login_bloc.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/enums/route_enums.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  // int page = 0;
  // final PageController _pageController = PageController();
  final NotchBottomBarController _notchBottomBarController = NotchBottomBarController();

  void navigationTapped(int page) {
    context.read<HomePageBottomNavCubit>().onPageChanged(page);

    log("Current page: $page");
    widget.shell.goBranch(page);
    _notchBottomBarController.index = page;
  }

  @override
  void initState() {
    super.initState();
    context.read<HomePageBottomNavCubit>().onPageChanged(0);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        //? listen for logout event
        BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) {
            return current is LoginInitial;
          },
          listener: (context, state) {
            if (state is LoginInitial) {
              log("User logged out.\nRedirecting to login page");
              context.goNamed(AppRoutes.login.name);
            }
          },
        ),

        //? listen for home page bottom nav changes
        BlocListener<HomePageBottomNavCubit, int>(
          listener: (context, state) {
            print("NEW PAGE: $state");
            navigationTapped(state);
          },
        )
      ],
      child: Scaffold(
        body: Stack(
          children: [
            widget.shell,
            widget.shell.currentIndex == 3
                ? Container()
                : Positioned(
                    bottom: 0,
                    right: 20,
                    child: FloatingActionButton(
                      shape: const CircleBorder(),
                      backgroundColor: const Color(0xff32856E),
                      onPressed: () {
                        context.pushNamed(AppRoutes.scheduleAppointment.name);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return const AddPersonalDetailsScreen();
                        //   // AddAppointScreen();
                        // }));
                      },
                      child: Icon(
                        MdiIcons.accountMultiplePlus,
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
        // body: PageView(
        //   controller: _pageController,
        //   onPageChanged: context.read<HomePageBottomNavCubit>().onPageChanged,
        //   physics: const NeverScrollableScrollPhysics(),
        //   children: HomeScreenItems,
        // ),
        bottomNavigationBar: AnimatedNotchBottomBar(
          notchBottomBarController: _notchBottomBarController,
          elevation: 0,
          removeMargins: true,
          color: const Color(0xffA1EBD6),
          notchColor: const Color(0xffA1EBD6),
          bottomBarItems: const [
            BottomBarItem(
              inActiveItem: SizedBox(
                width: 10.0,
                height: 10.0,
                child: ImageIcon(
                  AssetImage('assets/homeimages/Home.png'),
                  color: Color(0xff03BF9C),
                ),
              ),
              activeItem: SizedBox(
                width: 10.0,
                height: 10.0,
                child: ImageIcon(
                  AssetImage('assets/homeimages/Home.png'),
                  color: Colors.black,
                ),
              ),
              itemLabel: 'Home',
            ),
            BottomBarItem(
              inActiveItem: SizedBox(
                width: 10.0,
                height: 10.0,
                child: ImageIcon(
                  AssetImage('assets/homeimages/Calender.png'),
                  color: Color(0xff03BF9C),
                ),
              ),
              activeItem: SizedBox(
                width: 10.0,
                height: 10.0,
                child: ImageIcon(
                  AssetImage('assets/homeimages/Calender.png'),
                  color: Colors.black,
                ),
              ),
              itemLabel: 'Appointments',
            ),
            BottomBarItem(
              inActiveItem: SizedBox(
                width: 10.0,
                height: 10.0,
                child: ImageIcon(
                  AssetImage('assets/homeimages/whatsapp12.png'),
                  color: Color(0xff03BF9C),
                ),
              ),
              activeItem: SizedBox(
                width: 10.0,
                height: 10.0,
                child: ImageIcon(
                  AssetImage('assets/homeimages/whatsapp12.png'),
                  color: Colors.black,
                ),
              ),
              itemLabel: 'Chat',
            ),
            BottomBarItem(
              inActiveItem: ImageIcon(
                AssetImage('assets/homeimages/Notifications.png'),
                color: Color(0xff03BF9C),
              ),
              activeItem: ImageIcon(
                AssetImage('assets/homeimages/Notifications.png'),
                color: Colors.black,
              ),
              itemLabel: 'Notifications',
            ),
          ],
          onTap: navigationTapped,
          kBottomRadius: 0,
          kIconSize: 20,
        ),
      ),
    );
  }
}
