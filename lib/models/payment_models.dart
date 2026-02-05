class PaymentRequest {
  final String bookingId;
  final double amount;
  final String paymentMethod;

  PaymentRequest({
    required this.bookingId,
    required this.amount,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'bookingId': bookingId,
      'amount': amount,
      'paymentMethod': paymentMethod,
    };
  }
}

class PaymentResponse {
  final bool success;
  final String message;
  final String? transactionId;
  final double? amount;
  final String? status;
  final String? paymentMethod;

  PaymentResponse({
    required this.success,
    required this.message,
    this.transactionId,
    this.amount,
    this.status,
    this.paymentMethod,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      transactionId: json['transactionId'],
      amount: json['amount'] != null ? (json['amount'] as num).toDouble() : null,
      status: json['status'],
      paymentMethod: json['paymentMethod'],
    );
  }
}

class PaymentStatusResponse {
  final bool success;
  final String message;
  final String? transactionId;
  final String? status;

  PaymentStatusResponse({
    required this.success,
    required this.message,
    this.transactionId,
    this.status,
  });

  factory PaymentStatusResponse.fromJson(Map<String, dynamic> json) {
    return PaymentStatusResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      transactionId: json['transactionId'],
      status: json['status'],
    );
  }
}

