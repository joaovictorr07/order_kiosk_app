import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'api_error_model.dart';
import 'app_exception.dart';

class ErrorParser {
  ErrorParser._();

  static AppException parse(Object error) {
    debugPrint('Parsing error: $error');
    if (error is DioException) {
      final response = error.response;
      final statusCode = response?.statusCode;
      final data = response?.data;

      if (data is Map<String, dynamic>) {
        final apiError = ApiErrorModel.fromJson(data);

        return AppException(
          statusCode: apiError.status,
          title: apiError.error,
          message: apiError.message,
          path: apiError.path,
          supportId: apiError.supportId,
          technicalDetails: apiError.technicalDetails,
          raw: error,
        );
      }

      if (data is Map) {
        final mapped = Map<String, dynamic>.from(data);

        final apiError = ApiErrorModel.fromJson(mapped);

        return AppException(
          statusCode: apiError.status,
          title: apiError.error,
          message: apiError.message,
          path: apiError.path,
          supportId: apiError.supportId,
          technicalDetails: apiError.technicalDetails,
          raw: error,
        );
      }

      return AppException(
        statusCode: statusCode,
        title: 'Erro de comunicação',
        message: _resolveDioMessage(error),
        raw: error,
      );
    }

    return AppException(
      statusCode: null,
      title: 'Erro inesperado',
      message: 'Ocorreu um erro inesperado.',
      raw: error,
    );
  }

  static String _resolveDioMessage(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'Tempo esgotado ao conectar com o servidor.';
      case DioExceptionType.sendTimeout:
        return 'Tempo esgotado ao enviar dados ao servidor.';
      case DioExceptionType.receiveTimeout:
        return 'Tempo esgotado ao aguardar resposta do servidor.';
      case DioExceptionType.connectionError:
        return 'Não foi possível conectar ao servidor.';
      case DioExceptionType.badCertificate:
        return 'Certificado inválido na conexão.';
      case DioExceptionType.cancel:
        return 'Requisição cancelada.';
      case DioExceptionType.badResponse:
        return 'O servidor retornou uma resposta inválida.';
      case DioExceptionType.unknown:
        return 'Erro inesperado de comunicação.';
    }
  }
}