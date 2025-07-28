/// Enum representing the visual state of the SmartProgressDialog.
enum SmartProgressState {
  /// Loading spinner
  loading,

  /// Success animation (✓)
  success,

  /// Info animation (ℹ️) - Optional, can be used for informational messages
  info,

  /// Failure animation (X)
  error,

  /// Warning animation (!)
  warning,
}
