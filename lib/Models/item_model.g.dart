// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DateTime? _itemParseDateTime(dynamic val) {
  if (val == null) return null;
  if (val is DateTime) return val;
  if (val is String) return DateTime.tryParse(val);
  try {
    return (val as dynamic).toDate();
  } catch (_) {
    return null;
  }
}

double? _itemParseDouble(dynamic val) {
  if (val == null) return null;
  if (val is double) return val;
  if (val is int) return val.toDouble();
  if (val is String) return double.tryParse(val);
  return null;
}

int? _itemParseInt(dynamic val) {
  if (val == null) return null;
  if (val is int) return val;
  if (val is double) return val.toInt();
  if (val is String) return int.tryParse(val);
  return null;
}

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) => ItemModel(
      imageUrls: (json['imageUrls'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList(),
      itemId: json['itemId']?.toString(),
      title: json['title'] as String?,
      description: json['description'] as String?,
      make: json['make'] as String?,
      model: json['model'] as String?,
      year: _itemParseInt(json['year']),
      sellerPrice: _itemParseDouble(json['sellerPrice']),
      minimumBid: _itemParseDouble(json['minimumBid']),
      currentBid: _itemParseDouble(json['currentBid']),
      bidEndTime: _itemParseDateTime(json['bidEndTime']),
      isActive: (json['isActive'] as bool?) ?? true,
      mileage: _itemParseInt(json['mileage']),
      registeredIn: json['registeredIn'] as String?,
      bodyType: json['bodyType'] as String?,
      engineSize: json['engineSize']?.toString(),
      numberOfCylinders: _itemParseInt(json['numberOfCylinders']),
      fuelType: json['fuelType'] as String?,
      transmission: json['transmission'] as String?,
      wheelType: json['wheelType'] as String?,
      carOptions: json['carOptions'] as String?,
      safetyBeltStatus: json['safetyBeltStatus'] as String?,
      trim: json['trim'] as String?,
      interiorType: json['interiorType'] as String?,
      keys: _itemParseInt(json['keys']),
      specification: json['specification'] as String?,
      exteriorColor: json['exteriorColor'] as String?,
      enteriorColor: (json['enteriorColor'] ?? json['interiorColor']) as String?,
      firstOwner: json['firstOwner'] as String?,
      wheels: json['wheels'] as String?,
      exteriorCondition: json['exteriorCondition'] as String?,
      history: json['history'] as String?,
      steering: json['steering'] as String?,
      interior: json['interior'] as String?,
      specs: json['specs'] as String?,
      createdAt: _itemParseDateTime(json['createdAt']),
      currentBidUserId: json['currentBidUserId'] as String?,
      winnerUserId: json['winnerUserId'] as String?,
      winnerBidAmount: _itemParseDouble(json['winnerBidAmount']),
      auctionEndedAt: _itemParseDateTime(json['auctionEndedAt']),
    );

Map<String, dynamic> _$ItemModelToJson(ItemModel instance) => <String, dynamic>{
      'itemId': instance.itemId,
      'title': instance.title,
      'description': instance.description,
      'make': instance.make,
      'model': instance.model,
      'year': instance.year,
      'sellerPrice': instance.sellerPrice,
      'minimumBid': instance.minimumBid,
      'currentBid': instance.currentBid,
      'bidEndTime': instance.bidEndTime?.toIso8601String(),
      'isActive': instance.isActive,
      'mileage': instance.mileage,
      'registeredIn': instance.registeredIn,
      'bodyType': instance.bodyType,
      'engineSize': instance.engineSize,
      'numberOfCylinders': instance.numberOfCylinders,
      'fuelType': instance.fuelType,
      'transmission': instance.transmission,
      'wheelType': instance.wheelType,
      'carOptions': instance.carOptions,
      'safetyBeltStatus': instance.safetyBeltStatus,
      'trim': instance.trim,
      'interiorType': instance.interiorType,
      'keys': instance.keys,
      'specification': instance.specification,
      'exteriorColor': instance.exteriorColor,
      'enteriorColor': instance.enteriorColor,
      'firstOwner': instance.firstOwner,
      'wheels': instance.wheels,
      'exteriorCondition': instance.exteriorCondition,
      'history': instance.history,
      'steering': instance.steering,
      'interior': instance.interior,
      'specs': instance.specs,
      'createdAt': instance.createdAt?.toIso8601String(),
      'currentBidUserId': instance.currentBidUserId,
      'winnerUserId': instance.winnerUserId,
      'winnerBidAmount': instance.winnerBidAmount,
      'auctionEndedAt': instance.auctionEndedAt?.toIso8601String(),
      'imageUrls': instance.imageUrls,
    };
