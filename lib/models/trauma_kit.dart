class TraumaKit {
  final bool spiderBelt;
  final int speedClips;
  final bool pelvicBelt;
  final bool adultCervicalCollar;
  final bool chestSeal;
  final int compressiveBandage;
  final bool tourniquet;
  final int triangleBandage;
  final int samSplints;
  final int icePack;
  final bool ductTape;
  final bool scissors;

  TraumaKit({
    required this.spiderBelt,
    required this.speedClips,
    required this.pelvicBelt,
    required this.adultCervicalCollar,
    required this.chestSeal,
    required this.compressiveBandage,
    required this.tourniquet,
    required this.triangleBandage,
    required this.samSplints,
    required this.icePack,
    required this.ductTape,
    required this.scissors,
  });

  TraumaKit copyWith({
    bool? spiderBelt,
    int? speedClips,
    bool? pelvicBelt,
    bool? adultCervicalCollar,
    bool? chestSeal,
    int? compressiveBandage,
    bool? tourniquet,
    int? triangleBandage,
    int? samSplints,
    int? icePack,
    bool? ductTape,
    bool? scissors,
  }) {
    return TraumaKit(
      spiderBelt: spiderBelt ?? this.spiderBelt,
      speedClips: speedClips ?? this.speedClips,
      pelvicBelt: pelvicBelt ?? this.pelvicBelt,
      adultCervicalCollar: adultCervicalCollar ?? this.adultCervicalCollar,
      chestSeal: chestSeal ?? this.chestSeal,
      compressiveBandage: compressiveBandage ?? this.compressiveBandage,
      tourniquet: tourniquet ?? this.tourniquet,
      triangleBandage: triangleBandage ?? this.triangleBandage,
      samSplints: samSplints ?? this.samSplints,
      icePack: icePack ?? this.icePack,
      ductTape: ductTape ?? this.ductTape,
      scissors: scissors ?? this.scissors,
    );
  }
}
