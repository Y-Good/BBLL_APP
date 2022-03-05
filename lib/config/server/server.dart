class Server {
  Server._();

  static String _host = 'http://192.168.1.114';
  // static String _host = 'http://192.168.0.174';
  static String port = '3000';
  // static String host = 'http://192.168.0.174:$port';
  static String host = '$_host:$port';
  static String resources = '$host/static';
}
