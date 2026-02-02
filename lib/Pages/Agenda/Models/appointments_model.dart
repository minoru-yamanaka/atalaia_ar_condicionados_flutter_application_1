class Appointment {
  final String id;
  final String customerName;
  final String service;
  final DateTime date;
  final String notes;

  Appointment({
    required this.id,
    required this.customerName,
    required this.service,
    required this.date,
    required this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerName': customerName,
        'service': service,
        'date': date.toIso8601String(),
        'notes': notes,
      };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        customerName: json['customerName'],
        service: json['service'],
        date: DateTime.parse(json['date']),
        notes: json['notes'] ?? '',
      );
}