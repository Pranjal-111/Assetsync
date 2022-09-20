class AssetModel {
  final int id;
  final int stateId;
  final int districtId;
  final int subAreaId;
  final String name;
  final String type;
  final String address;
  final double size;
  final double capacity;
  final String presentUse;
  final int year;
  final int rooms;
  final int labs;
  final bool maintance;
  final double lon;
  final double lat;
  final int? floors;
  final String? owner;
  final double? workingSpace;
  final double? vaccantSpace;
  final bool? parking;

  final String? subArea;
  final String? district;
  final String? state;

  final String? subAreaAdminEmial;

  AssetModel({
    required this.id,
    required this.stateId,
    required this.districtId,
    required this.subAreaId,
    required this.name,
    required this.address,
    required this.type,
    required this.size,
    required this.capacity,
    required this.presentUse,
    required this.year,
    required this.rooms,
    required this.labs,
    required this.maintance,
    required this.lon,
    required this.lat,
    this.floors,
    this.owner,
    this.workingSpace,
    this.vaccantSpace,
    this.parking,
    this.subArea,
    this.district,
    this.state,
    this.subAreaAdminEmial
  });
}
