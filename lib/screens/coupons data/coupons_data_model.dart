class CouponsModel {
  String? pimwickGiftCardId;
  String? number;
  String? active;
  String? createDate;
  Null? expirationDate;
  Null? pimwickGiftCardParent;
  String? recipientEmail;
  String? balance;

  CouponsModel(
      {this.pimwickGiftCardId,
        this.number,
        this.active,
        this.createDate,
        this.expirationDate,
        this.pimwickGiftCardParent,
        this.recipientEmail,
        this.balance});

  CouponsModel.fromJson(Map<String, dynamic> json) {
    pimwickGiftCardId = json['pimwick_gift_card_id'];
    number = json['number'];
    active = json['active'];
    createDate = json['create_date'];
    expirationDate = json['expiration_date'];
    pimwickGiftCardParent = json['pimwick_gift_card_parent'];
    recipientEmail = json['recipient_email'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pimwick_gift_card_id'] = this.pimwickGiftCardId;
    data['number'] = this.number;
    data['active'] = this.active;
    data['create_date'] = this.createDate;
    data['expiration_date'] = this.expirationDate;
    data['pimwick_gift_card_parent'] = this.pimwickGiftCardParent;
    data['recipient_email'] = this.recipientEmail;
    data['balance'] = this.balance;
    return data;
  }
}

















// class CouponsModel {
//   late int id;
//   late String code;
//   late String description;
//   late String amount;
//   late String number;
//   late String balance;
//
//   CouponsModel({
//     required this.id,
//     required this.code,
//     required this.description,
//     required this.amount,
//     required this.number,
//     required this.balance,
//   });
//
//   CouponsModel.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     code = json['code'];
//     description = json['description'];
//     amount = json['amount'];
//     number = json['number'];
//     balance = json['balance'];
//   }
//
//   Map<String , Object? > toMap() {
//     return {
//       'id' : id,
//       'code' : code,
//       'description' : description,
//       'amount' : amount,
//       'number' : number,
//       'balance' : balance,
//     };
//   }
// }
//
//
//
