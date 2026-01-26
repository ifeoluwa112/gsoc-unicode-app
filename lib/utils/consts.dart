// Define control codepoints to exclude (based on your Rust list)
/// A set of Unicode control codepoints.
///
/// This set contains the numeric values of Unicode control characters,
/// which are special characters used to control the interpretation or
/// display of text data. Control codepoints are typically in the ranges
/// U+0000-U+001F (C0 controls) and U+007F-U+009F (C1 controls).
///
/// Example:
/// ```dart
/// if (controlCodepoints.contains(charCode)) {
///   // Handle control character
/// }
/// ```
const Set<int> controlCodepoints = {
  0x0000,
  0x0001,
  0x0002,
  0x0003,
  0x0004,
  0x0005,
  0x0006,
  0x0007,
  0x0008,
  0x0009,
  0x000A,
  0x000B,
  0x000C,
  0x000D,
  0x000E,
  0x000F,
  0x0010,
  0x0011,
  0x0012,
  0x0013,
  0x0014,
  0x0015,
  0x0016,
  0x0017,
  0x0018,
  0x0019,
  0x0020,
  0x001A,
  0x001B,
  0x001C,
  0x001D,
  0x001E,
  0x001F,
  0x007F,
  // No-break space
  0x00A0,
};
