class TpvUtils {
  static String maskAccountNumber(String account) {
    final trimmed = account.trim();
    if (trimmed.isEmpty) return '';
    if (trimmed.length <= 4) return trimmed;
    return 'XXXX${trimmed.substring(trimmed.length - 4)}';
  }
}
