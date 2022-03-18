class Server {
  Server._();

  static String _host = 'http://192.168.0.192';
  // static String _host = 'http://192.168.1.120';
  static String port = '3000';
  static String socketPort = '3003';
  // static String host = 'http://192.168.0.174:$port';
  static String host = '$_host:$port';
  static String socket = '$_host:$socketPort';

  static String resources = '$host/static';
}
