import 'dart:convert';
import 'dart:developer';

import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/firestore_functions.dart';
import 'package:ambulancecheckup/models/car_model.dart';
import 'package:ambulancecheckup/models/user_model.dart';
import 'package:ambulancecheckup/routes/routes.dart';
import 'package:ambulancecheckup/widgets/car_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    context.read<GlobalCubit>().dateTimeNow =
        DateTime.now().toString().substring(0, 10);
    context.read<GlobalCubit>().userModel =
        UserModel.fromJson(jsonDecode(Hive.box('localStorage').get('user')));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(context.read<GlobalCubit>().userModel.toString());
    log(context.read<GlobalCubit>().dateTimeNow ?? '');
    return KeyboardDismisser(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainRedColor,
          centerTitle: true,
          actions: [
            // GestureDetector(
            //     onTap: () async {
            //       // await FireStoreAPIs.createCar(
            //       //     carModel: CarModel(
            //       //   carNumber: 'B 12941',
            //       //   reservedBy: 'Jad2',
            //       //   lastReservedDate: '2023-05-04',
            //       // ));
            //     },
            //     child: const Icon(Icons.add, color: Colors.white)),
          ],
          leading: GestureDetector(
              onTap: () {
                Hive.box('localStorage').clear().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Routes.loginScreen, (route) => false);
                });
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              )),
          title: Column(
            children: [
              Text(
                'Welcome ${context.read<GlobalCubit>().userModel?.username}',
                style: GoogleFonts.acme(color: Colors.white),
              ),
              Text(
                context.read<GlobalCubit>().dateTimeNow ?? '',
                style: GoogleFonts.acme(color: Colors.white),
              ),
            ],
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: StreamBuilder<List<CarModel>>(
              stream: FireStoreAPIs.streamCars(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: mainRedColor),
                  );
                }
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }
                List<CarModel> cars = snapshot.data ?? [];
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (context, index) {
                    return AmbulanceCarCard(
                      carModel: CarModel(
                        carNumber: cars[index].carNumber ?? '',
                        reservedBy: cars[index].reservedBy,
                        lastReservedDate: cars[index].lastReservedDate,
                      ),
                    );
                  },
                  itemCount: cars.length,
                );
              },
            )),
      ),
    );
  }
}

const Color mainRedColor = Color(0xFFCC2027);
const Color mainSilverColor = Color(0xffC0C0C0);
