class APIList {
  static String? server = "https://visitor.elitecamp.net/api/v1/";
  static String? apiUrl = "visitor.elitecamp.net";
  static String? apiEndPoint = "/api/v1/";
  static String? login = "${server!}login";
  static String? logout = "${server!}logout";
  static String? refreshToken = "${server!}refresh-token";
  static String? device = "${server!}device";
  static String? fcmSubscribe = "${server!}fcm-subscribe";
  static String? fcmUnSubscribe = "${server!}fcm-unsubscribe";
  static String? profile = "${server!}me";
  static String? profileUpdate = "${server!}profile-update";
  static String? changePassword = "${server!}change-password";
  static String? dashboard = "${server!}dashboard";
  static String? visitorList = "${server!}visitors";
  static String? visitorSearchList = "${server!}visitors/search/";
  static String? visitorDetails = "${server!}visitors/show/";
  static String? changeStatus = "${server!}visitor/change-status/";
  static String? checkOut = "${server!}visitor/check-out/";
  static String? attendanceStatus = "${server!}attendance/user/status";
  static String? attendanceClockin = "${server!}attendance/user/clock-in";
  static String? attendanceClockout = "${server!}attendance/user/clock-out";
  static String? preRegisterList = "${server!}preregister";
  static String? preRegisterSearch = "${server!}preregister/search/";
  static String? preVisitorDetails = "${server!}preregister/";
  static String? preRegUpdate = "${server!}preregister/";
  static String? preRegisterDelete = "${server!}preregister/";
}
