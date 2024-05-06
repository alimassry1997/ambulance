class EmergencyKit {
  final bool o2Bottle;
  final bool regulator;
  final int psiValue;
  final bool bvm;
  final int maskNumber;
  final int oxygenTubing;
  final int nonRebreatherO2Mask;
  final bool oximeter;
  final bool thermometer;
  final int adultSimpleO2Mask;
  final int adultNasalCannula;
  final int airwaycannulaSet;
  final int sphygmomanometer;
  final bool stethoscope;
  final bool glucometer;
  final int glucometerNeedles;
  final int glucometerStrips;

  EmergencyKit({
    required this.o2Bottle,
    required this.regulator,
    required this.psiValue,
    required this.bvm,
    required this.maskNumber,
    required this.oxygenTubing,
    required this.nonRebreatherO2Mask,
    required this.oximeter,
    required this.thermometer,
    required this.adultSimpleO2Mask,
    required this.adultNasalCannula,
    required this.airwaycannulaSet,
    required this.sphygmomanometer,
    required this.stethoscope,
    required this.glucometer,
    required this.glucometerNeedles,
    required this.glucometerStrips,
  });

  EmergencyKit copyWith({
    bool? o2Bottle,
    bool? regulator,
    int? psiValue,
    bool? bvm,
    int? maskNumber,
    int? oxygenTubing,
    int? nonRebreatherO2Mask,
    bool? oximeter,
    bool? thermometer,
    int? adultSimpleO2Mask,
    int? adultNasalCannula,
    int? airwaycannulaSet,
    int? sphygmomanometer,
    bool? stethoscope,
    bool? glucometer,
    int? glucometerNeedles,
    int? glucometerStrips,
  }) {
    return EmergencyKit(
      o2Bottle: o2Bottle ?? this.o2Bottle,
      regulator: regulator ?? this.regulator,
      psiValue: psiValue ?? this.psiValue,
      bvm: bvm ?? this.bvm,
      maskNumber: maskNumber ?? this.maskNumber,
      oxygenTubing: oxygenTubing ?? this.oxygenTubing,
      nonRebreatherO2Mask: nonRebreatherO2Mask ?? this.nonRebreatherO2Mask,
      oximeter: oximeter ?? this.oximeter,
      thermometer: thermometer ?? this.thermometer,
      adultSimpleO2Mask: adultSimpleO2Mask ?? this.adultSimpleO2Mask,
      adultNasalCannula: adultNasalCannula ?? this.adultNasalCannula,
      airwaycannulaSet: airwaycannulaSet ?? this.airwaycannulaSet,
      sphygmomanometer: sphygmomanometer ?? this.sphygmomanometer,
      stethoscope: stethoscope ?? this.stethoscope,
      glucometer: glucometer ?? this.glucometer,
      glucometerNeedles: glucometerNeedles ?? this.glucometerNeedles,
      glucometerStrips: glucometerStrips ?? this.glucometerStrips,
    );
  }
}
