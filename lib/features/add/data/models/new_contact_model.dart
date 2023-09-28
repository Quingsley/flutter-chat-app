class NewContactModel {
  final String userEmail;
  final String newContactEmail;

  NewContactModel({required this.userEmail, required this.newContactEmail});

  toJson() {
    return {
      "userEmail": userEmail,
      "newContactEmail": newContactEmail,
    };
  }
}
