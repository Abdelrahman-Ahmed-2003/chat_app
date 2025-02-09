class StatusModel {
  final String phoneNumber;
  final String name;
  final String? profilePic;
  final List<Details> statusDetails;

  StatusModel({
    required this.phoneNumber,
    required this.name,
    required  this.profilePic,
    required this.statusDetails,
  });
}

class Details {
  final String type;
  final String path;
  final String url;
  final String createdAt;
  final String endAt;

  Details({
    required this.type,
    required this.path,
    required this.url,
    required this.createdAt,
    required this.endAt,
  });
}
