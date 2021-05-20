class UserDetails {
  String email = '';
  String firstname = '';
  String imagePath = '';
  String lastname = '';
  String role = '';
  String telephone = '';


  UserDetails({
    this.email,
    this.firstname,
    this.imagePath,
    this.lastname,
    this.role,
    this.telephone,
  });

  UserDetails defaultValue() =>
      UserDetails(
          email: 'unknown',
          firstname: "unknown",
          imagePath: "000000" ,
          lastname: "unknown",
          role: "unknown",
          telephone: "0000000000");
}