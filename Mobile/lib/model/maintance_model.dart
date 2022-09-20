class MaintanceModel {
  final int id;
  final int assetId;
  final String name;
  final String requirement;
  final int budget;
  final String proposal;
  final String type;
  final bool districtApproval;
  final bool stateApproval;

  final String? district;
  final String? subArea;

  MaintanceModel(
      {required this.id,
      required this.assetId,
      required this.name,
      required this.requirement,
      required this.budget,
      required this.proposal,
      required this.type,
      required this.districtApproval,
      required this.stateApproval,this.district,this.subArea});
}
