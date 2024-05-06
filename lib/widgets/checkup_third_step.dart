import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/models/last_step_kit.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/widgets/button.dart';
import 'package:ambulancecheckup/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckupThirdStep extends StatefulWidget {
  const CheckupThirdStep({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<CheckupThirdStep> createState() => _CheckupThirdStepState();
}

class _CheckupThirdStepState extends State<CheckupThirdStep> {
  @override
  void initState() {
    context.read<GlobalCubit>().lastStepKit = LastStepKit(
        cprBoard: true,
        vaccumSplin: 0,
        vaccumMattressAndPump: true,
        headImmobilizer: true,
        blankets: true,
        patches: 0,
        ked: true,
        aed: true,
        scoopStretcher: true,
        stairChair: true,
        spinalBoard: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.health_and_safety_outlined,
                color: mainRedColor,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Text(
                  'Rear Compartment + Cabinets/Lifting, Immobilization and Splinting',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.acme(color: mainRedColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.cprBoard ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(cprBoard: value);
              setState(() {});
            },
            title: Text(
              'CPR board',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context
                    .read<GlobalCubit>()
                    .lastStepKit
                    ?.vaccumMattressAndPump ??
                false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(vaccumMattressAndPump: value);
              setState(() {});
            },
            title: Text(
              'Vaccum Mattress & Pump',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.headImmobilizer ??
                false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(headImmobilizer: value);
              setState(() {});
            },
            title: Text(
              'Head Mobilizer',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.blankets ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(blankets: value);
              setState(() {});
            },
            title: Text(
              'Blankets',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.ked ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit =
                  context.read<GlobalCubit>().lastStepKit?.copyWith(ked: value);
              setState(() {});
            },
            title: Text(
              'KED',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.aed ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit =
                  context.read<GlobalCubit>().lastStepKit?.copyWith(aed: value);
              setState(() {});
            },
            title: Text(
              'AED',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.scoopStretcher ??
                false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(scoopStretcher: value);
              setState(() {});
            },
            title: Text(
              'Scoop Stretcher',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().lastStepKit?.stairChair ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(stairChair: value);
              setState(() {});
            },
            title: Text(
              'Stair Chair',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value:
                context.read<GlobalCubit>().lastStepKit?.spinalBoard ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().lastStepKit = context
                  .read<GlobalCubit>()
                  .lastStepKit
                  ?.copyWith(spinalBoard: value);
              setState(() {});
            },
            title: Text(
              'Spinal Board',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Vaccum Splin',
                  hintText: 'Vaccum Splin',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().lastStepKit = context
                        .read<GlobalCubit>()
                        .lastStepKit
                        ?.copyWith(vaccumSplin: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Patches',
                  hintText: 'Patches',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().lastStepKit = context
                        .read<GlobalCubit>()
                        .lastStepKit
                        ?.copyWith(patches: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          MainButton(
            height: 45,
            child: 'Save',
            width: double.infinity,
            onPressed: widget.onPressed,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
