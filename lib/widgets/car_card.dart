import 'dart:developer';

import 'package:ambulancecheckup/cubits/cubit/global_cubit.dart';
import 'package:ambulancecheckup/models/car_model.dart';
import 'package:ambulancecheckup/routes/routes.dart';
import 'package:ambulancecheckup/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AmbulanceCarCard extends StatelessWidget {
  final CarModel carModel;

  const AmbulanceCarCard({super.key, required this.carModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GlobalCubit>().carNumberClicked = carModel.carNumber;
        log(context.read<GlobalCubit>().carNumberClicked ?? '');
        Navigator.of(context).pushNamed(Routes.checkupScreen);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color:
            context.read<GlobalCubit>().dateTimeNow == carModel.lastReservedDate
                ? mainSilverColor
                : mainRedColor,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Car Number:',
                style: GoogleFonts.acme(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text(
                '${carModel.carNumber}',
                style: GoogleFonts.acme(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16),
              ),
              const SizedBox(height: 4),
              context.read<GlobalCubit>().dateTimeNow ==
                      carModel.lastReservedDate
                  ? Text(
                      'Reserved By: ${carModel.reservedBy ?? 'Not Reserved'} for the whole day',
                      style: GoogleFonts.acme(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    )
                  : Text(
                      'Reserved By: ${carModel.reservedBy ?? 'Not Reserved'}',
                      style: GoogleFonts.acme(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16),
                    ),
              const SizedBox(height: 4),
              context.read<GlobalCubit>().dateTimeNow ==
                      carModel.lastReservedDate
                  ? const SizedBox()
                  : Text(
                      'Last Reserved Date: ${carModel.lastReservedDate ?? 'N/A'}',
                      style: GoogleFonts.acme(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 16), // Text color
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
