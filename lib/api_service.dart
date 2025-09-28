import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      validateStatus: (status) => status! < 500, // evita lançar exceção em 404
    ),
  );

  ApiService() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Adiciona token simulado
          options.headers['Authorization'] = 'Bearer token-simulado-123';
          print("➡️ Enviando para: ${options.uri}");
          return handler.next(options);
        },
        onResponse: (response, handler) {
          print("✅ Resposta: ${response.data}");
          return handler.next(response);
        },
        onError: (DioError e, handler) {
          print("❌ Erro: ${e.message}");
          return handler.next(e);
        },
      ),
    );
  }

  
  /// Requisição POST para login (body)
  Future<Response> loginPost(String email, String senha) async {
    return await _dio.post(
      "https://mobile.free.beeceptor.com/api/muser", // aqui você pode usar a URL de teste POST
      data: {
        "email": email,
        "senha": senha,
      },
    );
  }
}
