import 'package:dio/dio.dart';

//models
import '../../models/payment_model.dart';
import '../../models/user_payment_model.dart';

//services
import '../networking/api_endpoint.dart';
import '../networking/api_service.dart';

//helpers
import '../../helper/typedefs.dart';

class PaymentsRepository {
  final ApiService _apiService;
  final CancelToken? _cancelToken;

  PaymentsRepository({
    required ApiService apiService,
    CancelToken? cancelToken,
  })  : _apiService = apiService,
        _cancelToken = cancelToken;

  Future<List<PaymentModel>> fetchAll({
    JSON? queryParameters,
  }) async {
    return await _apiService.getCollectionData<PaymentModel>(
      endpoint: ApiEndpoint.payments(PaymentEndpoint.BASE),
      queryParams: queryParameters,
      cancelToken: _cancelToken,
      converter: (responseBody) => PaymentModel.fromJson(responseBody),
    );
  }

  Future<PaymentModel> fetchOne({
    required int paymentId,
  }) async {
    return await _apiService.getDocumentData<PaymentModel>(
      endpoint: ApiEndpoint.payments(PaymentEndpoint.BY_ID, id: paymentId),
      cancelToken: _cancelToken,
      converter: (responseBody) => PaymentModel.fromJson(responseBody),
    );
  }

  Future<int> create({
    required JSON data,
  }) async {
    return await _apiService.setData<int>(
      endpoint: ApiEndpoint.payments(PaymentEndpoint.BASE),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['body']['payment_id'] as int,
    );
  }

  Future<String> update({
    required int paymentId,
    required JSON data,
  }) async {
    return await _apiService.updateData<String>(
      endpoint: ApiEndpoint.payments(PaymentEndpoint.BY_ID, id: paymentId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<String> delete({
    required int paymentId,
    JSON? data,
  }) async {
    return await _apiService.deleteData<String>(
      endpoint: ApiEndpoint.payments(PaymentEndpoint.BY_ID, id: paymentId),
      data: data,
      cancelToken: _cancelToken,
      converter: (response) => response['headers']['message'] as String,
    );
  }

  Future<List<UserPaymentModel>> fetchUserPayments({
    required int userId,
  }) async {
    return await _apiService.getCollectionData<UserPaymentModel>(
      endpoint: ApiEndpoint.payments(PaymentEndpoint.USERS, id: userId),
      cancelToken: _cancelToken,
      converter: (responseBody) => UserPaymentModel.fromJson(responseBody),
    );
  }

  void cancelRequests() {
    _apiService.cancelRequests(cancelToken: _cancelToken);
  }
}