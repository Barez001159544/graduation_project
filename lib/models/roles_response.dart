class RolesResponse {
  List<String>? roles;

  RolesResponse(this.roles);

  RolesResponse.fromJson(List<dynamic> json) {
    roles = List<String>.from(json);
  }
}