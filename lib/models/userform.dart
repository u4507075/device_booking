class UserTextFormFields {
  List<UserTextFormField> formFields;

  UserTextFormFields(this.formFields);
}

class UserTextFormField {
  var collectVar;
  String labelText;
  String hintText;
  String errorText;

  UserTextFormField(
      this.collectVar, this.labelText, this.hintText, this.errorText);
}
