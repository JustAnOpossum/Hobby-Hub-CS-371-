class FBUser {
  final String uid;
  FBUser({this.uid});
}

class UserData {
  final String uid;
  final String displayName;
  final List calendarEvents;
  //@required this.lastName,
  //@required this.password,
  final String email;
  //@required this.metadata,
  UserData({this.uid, this.displayName, this.email, this.calendarEvents});
}
