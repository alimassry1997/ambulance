import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/models/emergency_kit.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/widgets/button.dart';
import 'package:ambulancecheckup/widgets/main_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckUpFirstStep extends StatefulWidget {
  const CheckUpFirstStep({super.key, required this.onPressed});
  final Function() onPressed;

  @override
  State<CheckUpFirstStep> createState() => _CheckUpFirstStepState();
}

class _CheckUpFirstStepState extends State<CheckUpFirstStep> {
  @override
  void initState() {
    context.read<GlobalCubit>().emergencyKit = EmergencyKit(
        o2Bottle: true,
        regulator: true,
        psiValue: 0,
        bvm: true,
        maskNumber: 0,
        oxygenTubing: 0,
        nonRebreatherO2Mask: 0,
        oximeter: true,
        thermometer: true,
        adultSimpleO2Mask: 0,
        adultNasalCannula: 0,
        airwaycannulaSet: 0,
        sphygmomanometer: 0,
        stethoscope: true,
        glucometer: true,
        glucometerNeedles: 0,
        glucometerStrips: 0);
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
                'Emergeny Kit',
                style: GoogleFonts.acme(color: mainRedColor),
              ),
            ],
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: context.read<GlobalCubit>().emergencyKit?.o2Bottle ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(o2Bottle: value);
              setState(() {});
            },
            title: Text(
              'O2 Bottle',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().emergencyKit?.regulator ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(regulator: value);
              setState(() {});
            },
            title: Text(
              'O2 Regulator',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'PSI',
                  hintText: 'PSI',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(psiValue: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Mask Number',
                  hintText: 'Mask Number',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(maskNumber: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().emergencyKit?.bvm ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(bvm: value);
              setState(() {});
            },
            title: Text(
              'BVM',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Oxygen Tubing',
                  hintText: 'Oxygen Tubing',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(oxygenTubing: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Non Rebreathing O2 Mask',
                  hintText: 'Non Rebreathing O2 Mask',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(nonRebreatherO2Mask: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value: context.read<GlobalCubit>().emergencyKit?.oximeter ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(oximeter: value);
              setState(() {});
            },
            title: Text(
              'Oximeter',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value:
                context.read<GlobalCubit>().emergencyKit?.thermometer ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(thermometer: value);
              setState(() {});
            },
            title: Text(
              'Thermometer',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value:
                context.read<GlobalCubit>().emergencyKit?.glucometer ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(glucometer: value);
              setState(() {});
            },
            title: Text(
              'Glucometer',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          CheckboxListTile(
            value:
                context.read<GlobalCubit>().emergencyKit?.stethoscope ?? false,
            onChanged: (value) {
              context.read<GlobalCubit>().emergencyKit = context
                  .read<GlobalCubit>()
                  .emergencyKit
                  ?.copyWith(stethoscope: value);
              setState(() {});
            },
            title: Text(
              'Stethoscope',
              style: GoogleFonts.acme(
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Adult O2 Mask',
                  hintText: 'Adult O2 Mask',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(adultSimpleO2Mask: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Adult Nasal Cannula',
                  hintText: 'Adult Nasal Cannula',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(adultNasalCannula: int.parse(p0));
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
                  labelText: 'Airway Cannula Set',
                  hintText: 'Airway Cannula Set',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(airwaycannulaSet: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Sphygmomanometer',
                  hintText: 'Sphygmomanometer',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(sphygmomanometer: int.parse(p0));
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
                  labelText: 'Glucometer Needles',
                  hintText: 'Glucometer Needles',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(glucometerNeedles: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: MainTextFormField(
                  textInputAction: TextInputAction.next,
                  labelText: 'Glucometer Strips',
                  hintText: 'Glucometer Strips',
                  keyboardType: TextInputType.number,
                  onChanged: (p0) {
                    context.read<GlobalCubit>().emergencyKit = context
                        .read<GlobalCubit>()
                        .emergencyKit
                        ?.copyWith(glucometerStrips: int.parse(p0));
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          // const SizedBox(height: 8),
          // MainTextFormField(
          //   textInputAction: TextInputAction.done,
          //   labelText: 'Stethoscope',
          //   hintText: 'Stethoscope',
          //   keyboardType: TextInputType.number,
          //   onChanged: (p0) {
          //     context.read<GlobalCubit>().emergencyKit = context
          //         .read<GlobalCubit>()
          //         .emergencyKit
          //         ?.copyWith(stethoscope: int.parse(p0));
          //     setState(() {});
          //   },
          // ),
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
