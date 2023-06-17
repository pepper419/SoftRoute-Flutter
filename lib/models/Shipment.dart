class Shipment {
  final String description;
  final int quantity;
  final int freight;
  final int weight;
  final String date;
  final int destinyId;
  final int consigneesId;
  final int senderId;
  final int typeOfPackageId;
  final int documentId;

  Shipment(
      this.description,
      this.quantity,
      this.freight,
      this.weight,
      this.date,
      this.destinyId,
      this.consigneesId,
      this.senderId,
      this.typeOfPackageId,
      this.documentId);
}