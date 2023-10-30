extension RoundNumber on double {
  double roundDecimalPlaces(int value) {
    return num.parse(this.toStringAsFixed(value));
  }
}
