import 'package:flutter/material.dart';
import 'package:gsoc_unicode_app/app/app_theme.dart';

/// A widget that displays a labeled piece of information
/// (e.g., character detail).
class InformationTile extends StatelessWidget {
  /// Creates an [InformationTile].
  const InformationTile({
    required this.detail,
    required this.style,
    required this.info,
    this.lastItem = false,
    this.isFontText = false,
    this.script = '',
    super.key,
  });

  /// Information tile detail
  final String detail;

  /// Text style
  final TextStyle style;

  /// Character information value.
  final String info;

  /// Whether this is the last item (removes bottom border if true).
  final bool lastItem;

  /// Whether to use font styling for the info text.
  final bool isFontText;

  /// Character script name
  final String script;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: !lastItem
              ? const BorderSide(color: AppTheme.whiteShade)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              detail,
              style: style.copyWith(fontSize: 14),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              info.trim(),
              softWrap: true,
              overflow: TextOverflow.visible,
              style: style.copyWith(
                fontSize: isFontText ? 49 : 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
