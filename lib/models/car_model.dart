import 'package:cloud_firestore/cloud_firestore.dart';

class CarModel {
  String? carNumber;
  String? reservedBy;
  String? lastReservedDate;

  CarModel({
    required this.carNumber,
    this.reservedBy,
    this.lastReservedDate,
  });

  CarModel.fromJson(Map<String, dynamic> json) {
    carNumber = json['carNumber'];
    reservedBy = json['reservedBy'];
    lastReservedDate = json['lastReservedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carNumber'] = carNumber;
    data['reservedBy'] = reservedBy;
    data['lastReservedDate'] = lastReservedDate;
    return data;
  }

  factory CarModel.fromDocument(Map<String, dynamic> document) {
    return CarModel(
      carNumber: document['carNumber'],
      reservedBy: document['reservedBy'],
      lastReservedDate: document['lastReservedDate'],
    );
  }

  factory CarModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return CarModel(
      carNumber: data['carNumber'],
      reservedBy: data['reservedBy'],
      lastReservedDate: data['lastReservedDate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'carNumber': carNumber,
      'reservedBy': reservedBy,
      'lastReservedDate': lastReservedDate,
    };
  }
}
