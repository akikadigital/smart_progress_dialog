/// Enum representing the visual state of the SmartProgressDialog.
enum SmartProgressState {
  /// Loading spinner
  loading,

  /// Success animation (✓)
  success,

  /// Info animation (i) - Optional, can be used for informational messages
  info,

  /// Failure animation (X)
  error,

  /// Warning animation (!)
  warning,
}

enum SmartSnackBarType {
  /// Success snackbar type
  success,

  /// Info snackbar type
  info,

  /// Warning snackbar type
  warning,

  /// Error snackbar type
  error,
}

enum SmartSnackBarDuration {
  /// Short duration for snackbars
  short,

  /// Long duration for snackbars
  long,

  /// Indefinite duration for snackbars
  indefinite,
}

/// Enum for snackbar position.
enum SmartSnackBarPosition {
  /// Snackbar appears at the top of the screen.
  top,

  /// Snackbar appears at the bottom of the screen.
  bottom,
}
