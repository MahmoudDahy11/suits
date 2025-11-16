import 'package:dio/dio.dart';
import 'package:suits/core/error/custom_excption.dart';
import 'package:suits/core/error/failure.dart';

/*
 * ApiService class
 * provides methods for making HTTP requests (GET, POST, PUT, PATCH, DELETE)
 * uses Dio package for network operations
 * handles authorization headers if a token is provided
 * throws CustomException on errors with appropriate messages
 */
class ApiService {
  final Dio _dio;
  ApiService(this._dio);

  final String _baseUrl = 'https://api.unsplash.com';

  Future<dynamic> get({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    try {
      final Map<String, String> headers = {};
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }

      final response = await _dio.get(
        '$_baseUrl$endPoint',
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );

      return response.data;
    } on DioException catch (e) {
      throw CustomException(
        errMessage: ServerFailure.fromDioException(e).errMessage,
      );
    } catch (e) {
      throw CustomException(errMessage: 'Unexpected error: $e');
    }
  }
}
