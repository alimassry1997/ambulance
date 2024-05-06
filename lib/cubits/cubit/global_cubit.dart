import 'package:ambulancecheckup/models/emergency_kit.dart';
import 'package:ambulancecheckup/models/last_step_kit.dart';
import 'package:ambulancecheckup/models/trauma_kit.dart';
import 'package:ambulancecheckup/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'global_state.dart';

class GlobalCubit extends Cubit<GlobalState> {
  GlobalCubit() : super(GlobalInitial());
  UserModel? userModel;

  String? dateTimeNow;
  String? carNumberClicked;

  EmergencyKit? emergencyKit;
  TraumaKit? traumaKit;
  LastStepKit? lastStepKit;
}
