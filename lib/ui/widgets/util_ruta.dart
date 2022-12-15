class UtilRuta {
// Funcion que toma segundos y regresa el tiempo en string
  static String getTiempo(int segundos) {
    int horas = segundos ~/ 3600;
    int minutos = (segundos - horas * 3600) ~/ 60;
    int segundosRestantes = segundos - horas * 3600 - minutos * 60;
    String tiempo = '';
    if (horas > 0) {
      tiempo += '${horas}h ';
    }
    if (minutos > 0) {
      tiempo += '${minutos}m ';
    }
    if (segundosRestantes > 0) {
      tiempo += '${segundosRestantes}s';
    }
    return tiempo;
  }

  // Funcion que toma metros y regresa la distancia en string
  static String getDistancia(int metros) {
    int kilometros = metros ~/ 1000;
    int metrosRestantes = metros - kilometros * 1000;
    String distancia = '';
    if (kilometros > 0) {
      distancia += '${kilometros}km ';
    }
    if (metrosRestantes > 0) {
      distancia += '${metrosRestantes}m';
    }
    return distancia;
  }
}
