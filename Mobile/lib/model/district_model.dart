class DistrictModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String username;
  final int stateId;
  final int districtId;
  DistrictModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.username,
      required this.stateId,
      required this.districtId});
}
