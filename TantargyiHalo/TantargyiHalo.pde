ArrayList<Felev> halo;

void setup() {
  size(1280, 720);
  colorMode(HSB);
  init();
}

void init() {
  halo = new ArrayList<Felev>();
  ArrayList<Targy> elsoFelev = new ArrayList<Targy>();
  elsoFelev.add(new Targy("info1", 1));
  elsoFelev.add(new Targy("matek1", 1));
  elsoFelev.add(new Targy("fizika", 1));
  elsoFelev.add(new Targy("kozg", 1));
  halo.add(new Felev(elsoFelev));
  ArrayList<Targy> masodikFelev = new ArrayList<Targy>();
  masodikFelev.add(new Targy("info2", 2));
  masodikFelev.add(new Targy("asd", 2));
  masodikFelev.add(new Targy("fgf", 2));
  masodikFelev.add(new Targy("thrhrt", 2));
  masodikFelev.add(new Targy("erferr", 2));
  halo.add(new Felev(masodikFelev));
  ArrayList<Targy> harmadikFelev = new ArrayList<Targy>();
  harmadikFelev.add(new Targy("asdsafd", 3));
  harmadikFelev.add(new Targy("avfvfsd", 3));
  harmadikFelev.add(new Targy("dfgdaf", 3));
  harmadikFelev.add(new Targy("tasdhrt", 3));
  harmadikFelev.add(new Targy("erdvfferr", 3));
  halo.add(new Felev(harmadikFelev));
}

void draw() {
  for (Felev f : halo) {
    for (int i = 0; i < f.targyak.size(); i++) {
      f.targyak.get(i).display(i);
    }
  }
}