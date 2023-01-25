class Targy {

  ArrayList<Targy> kovetelmeny;
  ArrayList<Targy> raepulo;
  String nev;
  int felev;
  int colour;
  boolean teljesitett;

  Targy(String nev, int felev) {
    this.nev = nev;
    this.felev = felev;
    teljesitett = false;
    colour = 180;
  }

  void display(int i) {
    int posX = (felev - 1) * 150 + 20;
    int posY = i * 50 + 20;
    fill(colour, 255, 255);
    rect(posX, posY, 140, 40);
    fill(0, 0, 255);
    textSize(20);
    text(nev, posX + 10, posY + 27);
  }

  boolean elozmenyekTeljesitve() {
    boolean mindenTeljesitve = true;
    for (Targy t : kovetelmeny) {
      if (t.teljesitett) {
        colour = 130;
      }
    }
    return mindenTeljesitve;
  }
}