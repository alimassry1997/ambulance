import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/models/trauma_kit.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/widgets/button.dart';
import 'package:ambulancecheckup/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckUpSecondStep extends StatefulWidget {
  const CheckUpSecondStep({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<CheckUpSecondStep> createState() => _CheckUpSecondStepState();
}

class _CheckUpSecondStepState extends State<CheckUpSecondStep> {
  @override
  void initState() {
    context.read<GlobalCubit>().traumaKit = TraumaKit(
        spiderBelt: true,
        speedClips: 0,
        pelvicBelt: true,
        adultCervicalCollar: true,
        chestSeal: true,
        compressiveBandage: 0,
        tourniquet: true,
        triangleBandage: 0,
        samSplints: 0,
        icePack: 0,
        ductTape: true,
        scissors: true);
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
              Text(
                'Trauma Kit',
                style: GoogleFonts.acme(color: mainRedColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.spiderBelt ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(spiderBelt: value);
              setState(() {});
            },
            title: Text(
              'Spider Belt',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.pelvicBelt ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(pelvicBelt: value);
              setState(() {});
            },
            title: Text(
              'Pelvic Belt',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.adultCervicalCollar ??
                false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(adultCervicalCollar: value);
              setState(() {});
            },
            title: Text(
              'Adult Cervical Collar',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.chestSeal ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(chestSeal: value);
              setState(() {});
            },
            title: Text(
              'Chest Seal',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.tourniquet ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(tourniquet: value);
              setState(() {});
            },
            title: Text(
              'Tourniquet',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.ductTape ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(ductTape: value);
              setState(() {});
            },
            title: Text(
              'Duct Tape',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().traumaKit?.scissors ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(scissors: value);
              setState(() {});
            },
            title: Text(
              'Scissors',
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
                  labelText: 'Speed Clips',
                  hintText: 'Speed Clips',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().traumaKit = context
                        .read<GlobalCubit>()
                        .traumaKit
                        ?.copyWith(speedClips: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Compressive Bandage',
                  hintText: 'Compressive Bandage',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().traumaKit = context
                        .read<GlobalCubit>()
                        .traumaKit
                        ?.copyWith(compressiveBandage: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Triangle Bandage',
                  hintText: 'Triangle Bandage',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().traumaKit = context
                        .read<GlobalCubit>()
                        .traumaKit
                        ?.copyWith(triangleBandage: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Sam Splints',
                  hintText: 'Sam Splints',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().traumaKit = context
                        .read<GlobalCubit>()
                        .traumaKit
                        ?.copyWith(samSplints: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          MainTextFormField(
            textInputAction: TextInputAction.done,
            labelText: 'Ice Pack',
            hintText: 'Ice Pack',
            keyboardType: TextInputType.number,
            onChanged: (p0) {
              context.read<GlobalCubit>().traumaKit = context
                  .read<GlobalCubit>()
                  .traumaKit
                  ?.copyWith(icePack: int.parse(p0));
              setState(() {});
            },
          ),
          const SizedBox(height: 40),
          MainButton(
            height: 45,
            child: 'Next',
            width: double.infinity,
            onPressed: widget.onPressed,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
