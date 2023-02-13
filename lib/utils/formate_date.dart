/// Returns [date.toString()] without milliseconds
String formateDate(DateTime date) {
  var formatedDate = date.toString();
  return formatedDate.substring(0, formatedDate.length - 7);
}
