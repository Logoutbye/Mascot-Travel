class MyStaticVariable {
  static String? button1link = '';

  static String? button1label = '';
  static String? button2link = '';
  static String? button2label = '';
  static String? button3link = '';
  static String? button3label = '';
  static String? button4link = '';
  static String? button4label = '';
  static String? button5link = '';
  static String? button5label = '';

  static String? BookNowButton1link = '';
  static String? BookNowButton1label = '';
  static String? BookNowButton2link = '';
  static String? BookNowButton2label = '';
  static String? BookNowButton3link = '';
  static String? BookNowButton3label = '';
  static String? BookNowButton4link = '';
  static String? BookNowButton4label = '';
  static String? BookNowButton5link = '';
  static String? BookNowButton5label = '';
  static String? BookNowButton6link = '';
  static String? BookNowButton6label = '';

  static int currentScreenIndex = 0;
  static int previousScreenIndex = 0;
  static void setData(int currentScreen, int previousScreen) {
    currentScreenIndex = currentScreen;
    previousScreenIndex = previousScreen;
    print(
        "Print my index current: $currentScreenIndex Previous: $previousScreenIndex");
  }
}
