Map<dynamic, String> dayConvertMap = {
  "Mon": "Pn",
  "Tue": "Wt",
  "Wed": "Sr",
  "Thr": "Cz",
  "Fri": "Pt",
  "Sat": "Sb",
  "Sun": "Nd",
};

Map<dynamic, String> monthConvertMap = {
  "January": "Styczeń",
  "February": "Luty",
  "March": "Marzec",
  "April": "Kwiecień",
  "May": "Maj",
  "June": "Czerwiec",
  "July": "Lipiec",
  "August": "Sierpień",
  "September": "Wrzesień",
  "October": "Październik",
  "November": "Listopad",
  "December": "Grudzień",
};

String replaceMonth(String input) {
  return input
  .replaceAll("January", "Styczeń")
  .replaceAll("February", "Luty")
  .replaceAll("March", "Marzec")
  .replaceAll("April", "Kwiecień")
  .replaceAll("May", "Maj")
  .replaceAll("June", "Czerwiec")
  .replaceAll("July", "Lipiec")
  .replaceAll("August", "Sierpień")
  .replaceAll("September", "Wrzesień")
  .replaceAll("October", "Październik")
  .replaceAll("November", "Listopad")
  .replaceAll("December", "Grudzień");
}