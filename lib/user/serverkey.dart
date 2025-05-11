import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "installmentapp-1cf69",
          "private_key_id": "d584303a3070aa83c4b50c5d7471155c5770ad39",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDqgpuaEUcmQ7C3\nKRolSsNfgf/BRPzDY5IjEHA3JbSMxcGZymxnAgW1HpVp9HExBnU1Ss25h86ZV62K\nIgfjwjOP6/3bwiTLELnByJ0caeAs/Q2s1/7+bD7LaBkDdkrKI9hQal9IJjYQ6cKt\nJLO4xj6RA+nrGCCJe4C6jVJCqL9FNAmh+jYp3ijY4gnT3W+NQUf4MYyOow3ug1Om\nnw4c/xlIgZnsKNT6T7+begULSloBgVMF62PQGFTovyqm0HePDa6z6Rc+w5teRqVT\nr/Vp2SsPJd3roCFyQGlnnbgUOrAns5BP4JrOEd35zED12PSuodNd7ujiFfI4JMGE\nF1L3W9cPAgMBAAECggEAQULDhqaUREPGI9KeYg5iPGvy/pfyN3W4L2XdtJsbmalW\n7TN141yetf6i2e+aqGgBqij9A0qV5fqOYsiBpZJfwweLh+KJVrF64ECx6DxWlG5/\npcAeSDNbbkOz4lDDE2nSQt63UV7A4QgMkx6JnTweIUETkccPFvN1qXS2lbJcOCdw\nuysYHFTrCvl3PuVD+RPob4N5EOejH6GMZRTfGpDzUMiy56OhASh5fx+yf4JN7t7y\nXO56RZUswYsJ2if/AdG/a9Up+854imxMFckZ8Ogh4pYwEmphC5XIxIQ/BF9Rrt9J\nR69e8iTSMp5i5mqi9znUGEEu3drk+lwaW4LedyibYQKBgQD413KnEHuVV8NMeLNW\nWtIBK9dtQag7AMm3Mo+fya4e4oYoiPxLne85vOLTVHSPRxqbktbDQoZTEcUvaD4w\nU/MhQiLMaDQRvaUeSqKTq7BYD4UCncDYgiwLMJgPD0SvPPR9P++n6ZmWeafDC5rG\nn1iOTcDbUYAW+BhEwE7L3PnQuQKBgQDxQZ5khSTS5TGvn4sxDfDs+NJEhUG8kIMt\nPxF6SuTB5AC5nXmBH9SRjbkOTAFQMzAnJ5udUuB+yKJKAE6a+dnThWrqnhIoV1Hn\nk/+Lp/PWwBHJPp9B5FVTF/ynv1Wl/CqQl5wv0XevWfRovIvPprryqsLo4vSl6+Xn\nlsPBcFsyBwKBgQCULyCskik2BvxbJqmNLCpQ3j28Z1P6Rv7YZHiY6+4PoE/KBcFQ\nem2CUZQ1yt5akDotGOVhg9Uf1L46+/XEq8lmLc8xMICJbAjPIBzumVg7KIrJww2b\nIPF/fGGg3jPFsyPZDmD1+isnK60WfmueCjgfDfhh4ofHpdg14NtLlX0CqQKBgF60\nAXc4BLJ8obptCHijHlYHfpLDNIDOwY97WGMHDzFFTTuPo2ialBjm5yPDlihjT52v\nIJjrNZDPNVWTNUgEmAs+LjAXCM2pKU+cew3ZShCcqN60pFN7TDsoCVfX9ckIabUE\nrpzevvqodxa+HKvQqUYk3goJPTv8k+0K86D1d/b1AoGBAKQCmJnRH7v9F6lDW9di\ni0Rf/HFiGNv5VCZhyGmTZeB7RACg5bO8SMVX8VGlsnX4AI0Ws8uWLOrDS6sRb1Zr\nzs4UZ21hY32+p9nN+IkNlXh59KA2nWjN0NGfQ9kiSV5F00UTE4XYsbWyDdn8ptJl\n4EfE7VvkPnB0CD/yakF19+6D\n-----END PRIVATE KEY-----\n",
          "client_email": "firebase-adminsdk-v136d@installmentapp-1cf69.iam.gserviceaccount.com",
          "client_id": "105523744668287614603",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-v136d%40installmentapp-1cf69.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}