import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/firestore_functions.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:ambulancecheckup/widgets/checkup_first_step.dart';
import 'package:ambulancecheckup/widgets/checkup_second_step.dart';
import 'package:ambulancecheckup/widgets/checkup_third_step.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class CheckUpScreen extends StatefulWidget {
  const CheckUpScreen({super.key});

  @override
  State<CheckUpScreen> createState() => _CheckUpScreenState();
}

class _CheckUpScreenState extends State<CheckUpScreen> {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainRedColor,
          title: Text(
            'Checkup',
            style: GoogleFonts.acme(color: Colors.white),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: PageView(
              controller: _pageViewController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CheckUpFirstStep(
                  onPressed: () {
                    if (context.read<GlobalCubit>().emergencyKit?.o2Bottle ==
                            false ||
                        context.read<GlobalCubit>().emergencyKit?.regulator ==
                            false ||
                        context
                                .read<GlobalCubit>()
                                .emergencyKit
                                ?.bvm ==
                            false ||
                        context.read<GlobalCubit>().emergencyKit?.oximeter ==
                            false ||
                        context.read<GlobalCubit>().emergencyKit?.thermometer ==
                            false ||
                        context.read<GlobalCubit>().emergencyKit?.glucometer ==
                            false ||
                        context.read<GlobalCubit>().emergencyKit?.stethoscope ==
                            false) {
                      Fluttertoast.showToast(
                          msg: "All CheckBoxes Are Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .psiValue <
                        600) {
                      Fluttertoast.showToast(
                          msg: "PSI should have minimum value 600",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .maskNumber <
                        2) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 2 masks minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .oxygenTubing <
                        2) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 2 oxygen tubings minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .adultSimpleO2Mask <
                        2) {
                      Fluttertoast.showToast(
                          msg:
                              "Car should contain 2 adult simple O2 masks minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .adultNasalCannula <
                        2) {
                      Fluttertoast.showToast(
                          msg:
                              "Car should contain 2 adult nasal cannula minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .airwaycannulaSet <
                        8) {
                      Fluttertoast.showToast(
                          msg:
                              "Car should contain 8 airway cannula set minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .sphygmomanometer <
                        1) {
                      Fluttertoast.showToast(
                          msg: "Car should contain a Sphygmomanometer",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .glucometerNeedles <
                        10) {
                      Fluttertoast.showToast(
                          msg:
                              "Car should contain minimum 10 glucometer needles",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .emergencyKit!
                            .glucometerStrips <
                        10) {
                      Fluttertoast.showToast(
                          msg:
                              "Car should contain minimum 10 glucometer strips",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      _pageViewController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                CheckUpSecondStep(
                  onPressed: () {
                    if (context
                                .read<GlobalCubit>()
                                .traumaKit
                                ?.spiderBelt ==
                            false ||
                        context.read<GlobalCubit>().traumaKit?.pelvicBelt ==
                            false ||
                        context
                                .read<GlobalCubit>()
                                .traumaKit
                                ?.adultCervicalCollar ==
                            false ||
                        context
                                .read<GlobalCubit>()
                                .traumaKit
                                ?.chestSeal ==
                            false ||
                        context.read<GlobalCubit>().traumaKit?.tourniquet ==
                            false ||
                        context.read<GlobalCubit>().traumaKit?.ductTape ==
                            false ||
                        context.read<GlobalCubit>().traumaKit?.scissors ==
                            false) {
                      Fluttertoast.showToast(
                          msg: "All CheckBoxes Are Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .traumaKit!
                            .speedClips <
                        3) {
                      Fluttertoast.showToast(
                          msg: "3 speed clips should be present",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .traumaKit!
                            .compressiveBandage <
                        10) {
                      Fluttertoast.showToast(
                          msg:
                              "Car should contain 10 compressive bandages minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .traumaKit!
                            .triangleBandage <
                        5) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 5 triangle bandages minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .traumaKit!
                            .samSplints <
                        2) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 2 sam splints minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context.read<GlobalCubit>().traumaKit!.icePack <
                        2) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 2 ice packs minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      _pageViewController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
                CheckupThirdStep(
                  onPressed: () async {
                    if (context.read<GlobalCubit>().lastStepKit?.cprBoard ==
                            false ||
                        context
                                .read<GlobalCubit>()
                                .lastStepKit
                                ?.vaccumMattressAndPump ==
                            false ||
                        context
                                .read<GlobalCubit>()
                                .lastStepKit
                                ?.headImmobilizer ==
                            false ||
                        context
                                .read<GlobalCubit>()
                                .lastStepKit
                                ?.blankets ==
                            false ||
                        context.read<GlobalCubit>().lastStepKit?.ked == false ||
                        context.read<GlobalCubit>().lastStepKit?.aed == false ||
                        context
                                .read<GlobalCubit>()
                                .lastStepKit
                                ?.scoopStretcher ==
                            false ||
                        context.read<GlobalCubit>().lastStepKit?.stairChair ==
                            false ||
                        context.read<GlobalCubit>().lastStepKit?.spinalBoard ==
                            false) {
                      Fluttertoast.showToast(
                          msg: "All CheckBoxes Are Required",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .lastStepKit!
                            .vaccumSplin <
                        3) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 3 vaccum splints minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else if (context
                            .read<GlobalCubit>()
                            .lastStepKit!
                            .patches <
                        3) {
                      Fluttertoast.showToast(
                          msg: "Car should contain 3 patches minimum",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: mainRedColor,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    } else {
                      await FireStoreAPIs.updateCarReservation(
                              carNumber: context
                                      .read<GlobalCubit>()
                                      .carNumberClicked ??
                                  '',
                              reservedBy: context
                                      .read<GlobalCubit>()
                                      .userModel
                                      ?.username ??
                                  '',
                              lastReservedDate:
                                  context.read<GlobalCubit>().dateTimeNow ?? '')
                          .then((value) {
                        if (value == true) {
                          Navigator.pop(context);
                          context.read<GlobalCubit>().emergencyKit = null;
                          context.read<GlobalCubit>().traumaKit = null;
                          context.read<GlobalCubit>().lastStepKit = null;
                          context.read<GlobalCubit>().carNumberClicked = null;
                        } else {
                          Fluttertoast.showToast(
                              msg: "Error Occured",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: mainRedColor,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        }
                      });
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
