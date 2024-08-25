bool isHover = false;
String globalHintText = 'More tiles you select\n  More points you get';
String globalHintTitle = 'Title';
int globalPoints = 0;
double globalTimeRemaining = 30;
double globalProgress = 0.5;
bool isGameOver = false;

void resetGlobals() {
  isHover = false;
  globalHintText = 'More tiles you select\n  More points you get';
  globalHintTitle = 'Title';
  globalPoints = 0;
  globalTimeRemaining = 30;
  globalProgress = 0.5;
  isGameOver = false;
}
