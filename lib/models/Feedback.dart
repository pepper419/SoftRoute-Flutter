class Feedback {
  final int id;
  final String description;
  final String date;
  final int typeOfComplaintId;
  final int shipmentId;


  Feedback(
      {
        required this.id,
        required this.description,
        required this.date,
        required this.shipmentId,
        required this.typeOfComplaintId

      });
}