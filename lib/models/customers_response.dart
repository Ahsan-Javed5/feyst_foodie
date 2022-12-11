import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomerListResponse extends Equatable {
  const CustomerListResponse({required this.customers});
  factory CustomerListResponse.fromJson(List<dynamic> json) {
    final customers = <Customer>[];
    for (var v in json) {
      customers.add(Customer.fromJson(v));
    }
    return CustomerListResponse(customers: customers);
  }
  final List<Customer> customers;

  static List<Customer> customerListFromJson(String str) =>
      List<Customer>.from(json.decode(str).map((x) => Customer.fromJson(x)));
  static String customerListToJson(List<Customer> data) =>
      json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

  @override
  List<Object?> get props => [customers];
}

class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.name,
    required this.description,
    required this.contactname,
    required this.contactnumber,
    required this.contactemail,
    required this.address,
    required this.city,
    required this.country,
    required this.pincode,
    required this.tenantId,
    required this.message,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'] ?? json['_id'],
      name: json['name'],
      description: json['description'],
      contactname: json['contactname'],
      contactnumber: json['contactnumber'],
      contactemail: json['contactemail'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      pincode: json['pincode'],
      tenantId: json['tenantID'],
      message: json['message'] ?? '',
    );
  }

  factory Customer.empty() {
    return const Customer(
      id: '',
      name: '',
      description: '',
      contactname: '',
      contactnumber: '',
      contactemail: '',
      address: '',
      city: '',
      country: '',
      pincode: '',
      tenantId: '',
      message: '',
    );
  }

  factory Customer.fromErrorJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      contactname: json['contactname'],
      contactnumber: json['contactnumber'],
      contactemail: json['contactemail'],
      address: json['address'],
      city: json['city'],
      country: json['country'],
      pincode: json['pincode'],
      tenantId: json['tenantID'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['pincode'] = pincode;
    data['_id'] = id;
    data['description'] = description;
    data['name'] = name;
    data['contactname'] = contactname;
    data['contactnumber'] = contactnumber;
    data['contactemail'] = contactemail;
    data['address'] = address;
    data['city'] = city;
    data['country'] = country;
    data['tenantID'] = tenantId;
    return data;
  }

  final String id;
  final String name;
  final String description;
  final String contactname;
  final String contactnumber;
  final String contactemail;
  final String address;
  final String city;
  final String country;
  final dynamic pincode;
  final String tenantId;
  final String message;

  @override
  String toString() {
    return 'Customer(id: $id, name: $name, description: $description, contactname: $contactname, contactnumber: $contactnumber, contactemail: $contactemail, address: $address, city: $city, country: $country, pincode: $pincode, tenantId: $tenantId, message: $message)';
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
