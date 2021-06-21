import 'dart:convert';

class LoadScreenCardsModal {
  String? loadId;
  String? loadingPoint;
  String? loadingPointCity;
  String? loadingPointState;
  String? id;
  String? unloadingPoint;
  String? unloadingPointCity;
  String? unloadingPointState;
  String? productType;
  String? truckType;
  String? noOfTrucks;
  String? weight;
  String? comment;
  String? status;
  String? date;

  LoadScreenCardsModal(
      {this.loadId,
      this.loadingPoint,
      this.loadingPointCity,
      this.loadingPointState,
      this.id,
      this.unloadingPoint,
      this.unloadingPointCity,
      this.unloadingPointState,
      this.productType,
      this.truckType,
      this.noOfTrucks,
      this.weight,
      this.comment,
      this.status,
      this.date});

  factory LoadScreenCardsModal.fromJson(dynamic json) {
    return new LoadScreenCardsModal(status: json[0]["status"] as String);
  }

  @override
  String toString() {
    return 'Stats{status: $status';
  }
}
