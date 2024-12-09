import 'package:flutter/material.dart';
import 'package:healtether_clinic_app/data_layer/models/appointment_slot/time_slot.dart';
import 'package:healtether_clinic_app/constants/app_colors.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';
import 'package:healtether_clinic_app/utils/mixins/ui_info_mixin.dart';
import 'package:healtether_clinic_app/widgets/time_slot_text_field.dart';

class TimeSlotItem extends StatefulWidget {
  const TimeSlotItem(
      {super.key,
      this.slot,
      this.onDelete,
      required this.onStartChanged,
      required this.onFinishChanged,
      this.selected = false,
      this.showDelete = true,
      this.onTap});
  final TimeSlot? slot;
  final void Function()? onTap;
  final void Function()? onDelete;
  final void Function(TimeOfDay newTime) onStartChanged;
  final void Function(TimeOfDay newTime) onFinishChanged;
  final bool selected;
  final bool showDelete;

  @override
  State<TimeSlotItem> createState() => _TimeSlotItemState();
}

class _TimeSlotItemState extends State<TimeSlotItem> with UiInfoMixin {
  late final TextEditingController startController;
  late final TextEditingController finishController;

  @override
  void initState() {
    super.initState();

    startController = TextEditingController(text: '');
    finishController = TextEditingController(text: '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    startController.text = widget.slot?.start?.format(context) ?? '';
    finishController.text = widget.slot?.finish?.format(context) ?? '';
  }

  @override
  void dispose() {
    startController.dispose();
    finishController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              // start timeslot
              Expanded(
                  child: TimeSlotTextField(
                controller: startController,
                hintText: 'From',
                onTap: () async {
                  log("Start pressed");
                  final TimeOfDay? selectedTime = await pickTime(context, returnTimeObject: true);

                  if (selectedTime != null) {
                    setState(() {
                      startController.text = selectedTime.format(context);
                    });

                    widget.onStartChanged(selectedTime);
                    if (widget.onTap != null) widget.onTap!();
                  }
                },
              )),

              GestureDetector(
                onTap: widget.onTap,
                child: SizedBox(
                  width: 24,
                  height: 48,
                  child: widget.selected
                      ? const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: Divider(
                            color: AppColors.primaryColor,
                          ),
                        )
                      : Container(
                          width: 24,
                          height: 48,
                          color: Colors.transparent,
                        ),
                ),
              ),

              // end timeslot
              Expanded(
                  child: TimeSlotTextField(
                controller: finishController,
                onTap: () async {
                  final TimeOfDay? selectedTime = await pickTime(context, returnTimeObject: true);

                  if (selectedTime != null) {
                    setState(() {
                      finishController.text = selectedTime.format(context);
                    });

                    widget.onFinishChanged(selectedTime);
                    if (widget.onTap != null) widget.onTap!();
                  }
                },
                hintText: "To",
              )),

              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 10,
        ),

        // delete
        Opacity(
            opacity: widget.showDelete ? 1 : 0,
            child: GestureDetector(
              onTap: widget.onDelete,
              child: const Icon(Icons.delete),
            ))
      ],
    );
  }
}
