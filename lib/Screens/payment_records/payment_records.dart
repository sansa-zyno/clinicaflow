import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healtether_clinic_app/Screens/payment_records/payment_record_listTile.dart';
// import 'package:healtether_clinic_app/Screens/payment_records/provider/payment_provider.dart';
import 'package:healtether_clinic_app/business_logic/cubits/payment_cubit/payment_cubit.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/constants/app_text.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_models/payment_response_model.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';

class PaymentsRecordScreen extends StatefulWidget {
  const PaymentsRecordScreen({super.key});

  @override
  _PaymentsRecordScreenState createState() => _PaymentsRecordScreenState();
}

class _PaymentsRecordScreenState extends State<PaymentsRecordScreen> {
  final NotchBottomBarController _controller = NotchBottomBarController(index: 0);
  //OverlayEntry? _overlayEntry;
  //final layerLink = LayerLink();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PaymentCubit>().fetchPayments();
    });
  }

  List<GetPayment>? searchResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _controller.index == 0
            ? AppBar(
                leadingWidth: 30,
                title: const Text(
                  'Payment Records',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              )
            : null,
        body: _buildPaymentsPage());
  }

  Widget _buildPaymentsPage() {
    return BlocBuilder<PaymentCubit, PaymentState>(
      builder: (context, state) {
        if (state.state == PaymentStates.fetchingPayments) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.payments?.isEmpty ?? true) {
          return const Center(child: Text('No payment records available.'));
        }
        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shrinkWrap: true,
          children: [
            customSearchBar(state.payments),
            const SizedBox(height: 8),
            if (searchResult?.isNotEmpty ?? true)
              Text('All ${searchResult != null ? searchResult!.length : state.payments?.length ?? ''} Payments Records are Listed'),
            const SizedBox(height: 10),
            searchResult?.isNotEmpty ?? true
                ? ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: searchResult != null ? searchResult!.length : state.payments?.length ?? 0,
                    itemBuilder: (context, index) {
                      final payment = searchResult != null ? searchResult![index] : state.payments![index];
                      String formatDate(DateTime date) {
                        final DateFormat formatter = DateFormat('dd-MM-yy');
                        return formatter.format(date);
                      }

                      return InkWell(
                        child: PaymentRecordTile(
                          name: payment.name,
                          number: payment.mobile,
                          date: formatDate(payment.appointmentDate),
                          status: payment.paymentStatus == true ? 'Completed' : 'Pending',
                          invoiceId: payment.invoiceDetail[0].id,
                        ),
                      );
                    },
                  )
                : const Align(heightFactor: 25, alignment: Alignment.center, child: Text('No data found')),
          ],
        );
      },
    );
  }

  Widget customSearchBar(List<GetPayment>? payments) {
    return Container(
      height: 58,
      color: AppColors.white1Color,
      child: Padding(
        padding: const EdgeInsets.only(top: 15, bottom: 10, left: 10, right: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppText.quickSearch,
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  border: InputBorder.none,
                ),
                onChanged: (query) {
                  if (query.isEmpty) {
                    searchResult = null;
                  } else {
                    searchResult = payments?.where((e) => e.name.toLowerCase().trim().startsWith(query.toLowerCase())).toList() ?? [];
                  }
                  setState(() {});
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* void _showOverlay(
    BuildContext context,
    Widget widget,
  ) {
    _overlayEntry = _createOverlayEntry(widget);
    Overlay.of(context)?.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry(Widget widget) {
    return OverlayEntry(
      builder: (context) => Positioned(
        width: 360,
        child: CompositedTransformFollower(
          link: layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0.0, 60.0),
          child: Material(elevation: 1.0, child: Container(height: 400, child: SingleChildScrollView(child: widget))),
        ),
      ),
    );
  }

  Widget buildPaymentResults(String query) {
    return BlocBuilder<PaymentCubit, PaymentState>(builder: (context, state) {
      if (state.state == PaymentStates.fetchingPayments) {
        return Container();
      } else if (state.state == PaymentStates.fetchingPaymentsFailed) {
        return Container();
      } else {
        List<GetPayment> result = state.payments?.where((e) => e.name.toLowerCase().trim().startsWith(query.toLowerCase())).toList() ?? [];
        return Column(
            children: List<Widget>.generate(result.length, (index) {
          GetPayment payment = result.elementAt(index);

          return TextListTile(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            text: payment.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            onTap: () {
              _removeOverlay();
            },
          ).pOnly(bottom: 8);
        }));
      }
    });
  }*/
}
