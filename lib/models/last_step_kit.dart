class LastStepKit {
  final bool cprBoard;
  final int vaccumSplin;
  final bool vaccumMattressAndPump;
  final bool headImmobilizer;
  final bool blankets;
  final int patches;
  final bool ked;
  final bool aed;
  final bool scoopStretcher;
  final bool stairChair;
  final bool spinalBoard;

  LastStepKit({
    required this.cprBoard,
    required this.vaccumSplin,
    required this.vaccumMattressAndPump,
    required this.headImmobilizer,
    required this.blankets,
    required this.patches,
    required this.ked,
    required this.aed,
    required this.scoopStretcher,
    required this.stairChair,
    required this.spinalBoard,
  });

  LastStepKit copyWith({
    bool? cprBoard,
    int? vaccumSplin,
    bool? vaccumMattressAndPump,
    bool? headImmobilizer,
    bool? blankets,
    int? patches,
    bool? ked,
    bool? aed,
    bool? scoopStretcher,
    bool? stairChair,
    bool? spinalBoard,
  }) {
    return LastStepKit(
      cprBoard: cprBoard ?? this.cprBoard,
      vaccumSplin: vaccumSplin ?? this.vaccumSplin,
      vaccumMattressAndPump:
          vaccumMattressAndPump ?? this.vaccumMattressAndPump,
      headImmobilizer: headImmobilizer ?? this.headImmobilizer,
      blankets: blankets ?? this.blankets,
      patches: patches ?? this.patches,
      ked: ked ?? this.ked,
      aed: aed ?? this.aed,
      scoopStretcher: scoopStretcher ?? this.scoopStretcher,
      stairChair: stairChair ?? this.stairChair,
      spinalBoard: spinalBoard ?? this.spinalBoard,
    );
  }
}
