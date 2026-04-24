// ignore_for_file: avoid_print

class MyLog {
  static const String _reset = "\x1B[0m";

  
  static const String _red     = "\x1B[1;91m"; 
  static const String _green   = "\x1B[1;92m"; 
  static const String _white   = "\x1B[1;97m"; 
  static const String _purple  = "\x1B[1;95m"; 
  static const String _cyan    = "\x1B[1;96m"; 
  static const String _orange  = "\x1B[1;38;5;208m"; 

  static void error(String msg) {
    
    print("$_red[ERROR] $msg$_reset");
  }

  static void success(String msg) {
    print("$_green[SUCCESS] $msg$_reset");
  }

  static void warning(String msg) {
    print("$_orange[WARNING] $msg$_reset"); 
  }

  static void info(String msg) {
    print("$_white[INFO] $msg$_reset");
  }

  static void debug(String msg) {
    print("$_purple[DEBUG] $msg$_reset");
  }

  static void highlight(String msg) {
    print("$_cyan[HIGHLIGHT] $msg$_reset");
  }
}