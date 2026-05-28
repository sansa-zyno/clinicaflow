import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:clinica_flow/features/home/drawer_menu.dart';
import 'package:clinica_flow/features/appointment/viewmodel/appointment_cubit.dart';
import 'package:clinica_flow/core/navigation/home_page_bottom_nav_cubit.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/enums/route_enums.dart';

import '../../core/constants/app_colors.dart';
import 'utils/time_slot_utils.dart';
import 'widgets/appointment_card.dart';
import 'widgets/custom_header.dart';
import 'package:clinica_flow/core/utils/responsive_layout.dart';
import 'widgets/patient_search_overlay.dart';
import 'widgets/time_slot_chip.dart';
import 'widgets/tool_card.dart';

// ── Data ────────────────────────────────────────────────────────────

/// Quick-access tools shown on the home screen grid.
class _ToolItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final AppRoutes route;

  const _ToolItem(this.title, this.subtitle, this.icon, this.route);
}

const _tools = [
  _ToolItem('Patient', 'Records', Icons.folder_shared_outlined,
      AppRoutes.patientRecords),
  _ToolItem('Manage', 'Team', Icons.groups_outlined, AppRoutes.manageStaff),
  _ToolItem('Payment', 'Records', Icons.receipt_long_outlined,
      AppRoutes.paymentRecords),
  _ToolItem('Analytics', 'Overview', Icons.insights_outlined,
      AppRoutes.patientAnalysis),
];

// ── HomeScreen ──────────────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── State ──

  //DateTime _selectedDate = DateTime.now();
  String _selectedTimeRange = TimeSlotUtils.getCurrentTimeRange();
  bool _showAllSlots = true;

  // ── Overlay ──

  OverlayEntry? _overlayEntry;
  final _layerLink = LayerLink();

  // ── Lifecycle ──

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() {
    context.read<HomePageBottomNavCubit>().onPageChanged(0);
    context.read<AppointmentCubit>().fetchAppointments(status: 'upcoming');
    // _fetchAppointmentCount();
    // context.read<PatientRecordsCubit>().fetchPatients();
    // context.read<StaffCubit>().fetchStaffs();
  }

  // ── Date navigation ──

  /*void _navigateDay(int offset) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: offset));
    });
    _fetchAppointmentCount();
  }*/

  /*void _fetchAppointmentCount() {
    context.read<AppointmentCubit>().getCompletedAndRemainingAppointmentCount(
          date: TimeSlotUtils.formatDateForApi(_selectedDate),
        );
  }*/

  // ── Overlay helpers ──

  void _showOverlay(Widget content) {
    _removeOverlay();
    _overlayEntry = OverlayEntry(
      builder: (_) => Positioned(
        width: 360,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 60.0),
          child: Material(
            elevation: 1.0,
            child: SizedBox(
              height: 325,
              child: SingleChildScrollView(child: content),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  // ── Build ──

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    return SafeArea(
      child: Scaffold(
        drawer: const Drawer(child: DrawerMenu()),
        body: GestureDetector(
          onTap: _removeOverlay,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              CustomHeader(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined,
                        color: AppColors.grey),
                    onPressed: () {
                      // context.push(AppRoutes.notifications.path);
                    },
                  ),
                ],
              ),
              _buildSearchBar(),
              const SizedBox(height: 8),
              //DateNavigatorBar(
              //  selectedDate: _selectedDate,
              //  onPreviousDay: () => _navigateDay(-1),
              //  onNextDay: () => _navigateDay(1),
              //),
              //const SizedBox(height: 12),
              //const PatientsHelpedIndicator(),
              //const SizedBox(height: 30),
              _buildTimeSlotFilter(),
              const SizedBox(height: 16),
              _buildUpcomingAppointmentsHeader(),
              const SizedBox(height: 12),
              _buildAppointmentsList(),
              const SizedBox(height: 12),
              _buildSectionTitle('Quick Actions'),
              const SizedBox(height: 12),
              _buildToolsGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // ── Section builders ─────────────────────────────────────────────

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CompositedTransformTarget(
        link: _layerLink,
        child: TextField(
          decoration: InputDecoration(
            fillColor: AppColors.whiteSmoke2,
            filled: true,
            hintText: 'Search',
            hintStyle: GoogleFonts.montserrat(
              color: Colors.grey,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none),
            suffixIcon: const Icon(Icons.search, color: Colors.grey),
          ),
          onChanged: (query) {
            _showOverlay(
              PatientSearchResults(
                query: query,
                onPatientSelected: _removeOverlay,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTimeSlotFilter() {
    final slots = TimeSlotUtils.generateTimeSlots(
      const TimeOfDay(hour: 6, minute: 0),
      const TimeOfDay(hour: 24, minute: 0),
      const Duration(hours: 1, minutes: 30),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              TimeSlotChip(
                isSelected: _showAllSlots,
                onTap: () => setState(() => _showAllSlots = true),
                label: 'All',
              ),
              ...slots.map((slot) {
                final isActive = !_showAllSlots &&
                    TimeSlotUtils.isTimeRangeWithin(_selectedTimeRange, slot);
                return TimeSlotChip(
                  isSelected: isActive,
                  onTap: () => setState(() {
                    _showAllSlots = false;
                    _selectedTimeRange = slot;
                  }),
                  label: slot,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointmentsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Upcoming Appointments',
            style: GoogleFonts.urbanist(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              context.read<HomePageBottomNavCubit>().onPageChanged(1);
              context.goNamed(AppRoutes.appointment.name);
            },
            child: Column(
              children: [
                const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xff32856E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width * 0.14,
                  color: const Color(0xff32856E),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentsList() {
    return BlocBuilder<AppointmentCubit, AppointmentState>(
      builder: (context, state) {
        // Loading state (includes initial before fetch completes)
        if (state.state == AppointmentStates.initial ||
            state.state == AppointmentStates.fetchingAppointments) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xff03BF9C)),
          );
        }

        // Error state
        else if (state.state == AppointmentStates.fetchingAppointmentsFailed) {
          return const SizedBox(
            height: 100,
            child: Center(child: Text('Something went wrong')),
          );
        }

        // Apply time-slot filter
        else {
          final appointments = _showAllSlots
              ? state.appointments!
              : state.appointments!
                  .where((a) => TimeSlotUtils.isTimeRangeWithin(
                      _selectedTimeRange, a.timeSlot!))
                  .toList();

          if (appointments.isEmpty) {
            return const _EmptyAppointmentsMessage();
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 160.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(right: 8.0, top: 1, bottom: 1),
                    child: AppointmentCard(appointment: appointments[index]),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.urbanist(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToolsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _tools.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveLayout.isDesktop(context) ? 4 : 2,
          mainAxisExtent: 80,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final tool = _tools[index];
          return GestureDetector(
            onTap: () => context.pushNamed(tool.route.name),
            child: Center(
              child: ToolCard(
                title: tool.title,
                subtitle: tool.subtitle,
                icon: tool.icon,
              ),
            ),
          );
        },
      ),
    );
  }
}

// ── Small private widgets ──────────────────────────────────────────

/*class _GreenLine extends StatelessWidget {
  const _GreenLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 2,
      width: 47,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF52CFAC),
      ),
    );
  }
}*/

class _EmptyAppointmentsMessage extends StatelessWidget {
  const _EmptyAppointmentsMessage();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Center(child: Text('No Appointments Found')),
      ),
    );
  }
}
