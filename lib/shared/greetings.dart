class Greetings {
  String welcomeGreetings() {
    int lTime = 12;
    int eTime = 18;
    DateTime current = DateTime.now();
    String greeting;
    if (current.hour > eTime) {
      greeting = "Good Evening";
    } else if (current.hour > lTime) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Morning";
    }
    return greeting;
  }
}
