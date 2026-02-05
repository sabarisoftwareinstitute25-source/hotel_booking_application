/// Phone number normalization utility
/// Ensures consistent phone format: "+919876543210" (no spaces, exactly 13 characters)
/// This matches the backend Java normalizePhone() method exactly
class PhoneUtils {
  /// Normalize phone number to consistent format: "+919876543210"
  /// Handles: "+91 9876543210", "+919876543210", "9876543210", "919876543210", "09876543210"
  /// Returns: "+919876543210" (always 13 characters, no spaces)
  /// 
  /// This method matches the backend Java normalizePhone() logic exactly
  static String normalizePhone(String phone) {
    if (phone.isEmpty) return phone;
    
    // Remove all spaces, dashes, parentheses (same as backend)
    String cleaned = phone
        .trim()
        .replaceAll(RegExp(r'\s+'), '') // Remove all spaces
        .replaceAll('-', '') // Remove dashes
        .replaceAll('(', '') // Remove opening parenthesis
        .replaceAll(')', ''); // Remove closing parenthesis
    
    // If starts with +91 and is 13 characters, return as is (target format)
    if (cleaned.startsWith('+91') && cleaned.length == 13) {
      return cleaned;
    }
    
    // If starts with 91 and is 12 characters, add +
    if (cleaned.startsWith('91') && cleaned.length == 12) {
      return '+$cleaned';
    }
    
    // If 10 digits without prefix, add +91
    if (cleaned.length == 10 && !cleaned.startsWith('+') && !cleaned.startsWith('91')) {
      return '+91$cleaned';
    }
    
    // If 11 digits starting with 0, remove 0 and add +91
    if (cleaned.length == 11 && cleaned.startsWith('0')) {
      return '+91${cleaned.substring(1)}';
    }
    
    // Default: ensure it starts with + (best effort)
    return cleaned.startsWith('+') ? cleaned : '+$cleaned';
  }
  
  /// Format phone for display: "+91 9876543210" (with space)
  /// Use this only for UI display, not for API calls
  static String formatForDisplay(String phone) {
    String normalized = normalizePhone(phone);
    if (normalized.startsWith('+91') && normalized.length == 13) {
      return '+91 ${normalized.substring(3)}';
    }
    return normalized;
  }
  
  /// Validate phone number format
  /// Returns true if phone is in correct format: "+919876543210"
  static bool isValidPhone(String phone) {
    String normalized = normalizePhone(phone);
    return normalized.startsWith('+91') && normalized.length == 13 && 
           RegExp(r'^\+91\d{10}$').hasMatch(normalized);
  }
}

