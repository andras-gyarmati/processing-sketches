class Space {
  ArrayList<Orb> orbs;

  Space() {
    orbs = new ArrayList<Orb>();
  }

  void update() {
    ArrayList<Orb> blewUpOrbs = new ArrayList<Orb>();
    for (Orb orb : orbs) {
      applyAllGravitationalForcesFromOtherOrbsOn(orb);
      orb.move();
      checkIfOtherOrbsTouchingAndAbsorbThemInto(orb);
      //orb.deflate();
      bowUpOrbIfTooFast(orb, blewUpOrbs);
    }
    for (Orb o : blewUpOrbs) { 
      orbs.add(o);
    }
    deleteZeroRadiusOrbs();
    addOrbIfLessThan(30);  //ha tul gyorsan megy akkor kisebb lesz nem nagyobb, valami bugos, korlatozni kell hogy minusz nem lehet a novekedes. bele kell tenni a felrobbanast is
  }

  private void bowUpOrbIfTooFast(Orb orb, ArrayList<Orb> blewUpOrbs) {
    if (orb.vel.mag() > 30) {
      for (Orb o : orb.blowUp()) { 
        blewUpOrbs.add(o);
      }
    }
  }

  private void addOrbIfLessThan(int desiredOrbCount) {
    if (orbs.size() < desiredOrbCount) {
      orbs.add(new Orb(new PVector(random(height), random(width))));
    }
  }

  private void deleteZeroRadiusOrbs() {
    for (int i = orbs.size() - 1; i >= 0; i--) {
      Orb orb = orbs.get(i);
      if (orb.radius <= 0) {
        orbs.remove(orb);
      }
    }
  }

  private void checkIfOtherOrbsTouchingAndAbsorbThemInto(Orb orb) {
    for (Orb otherOrb : orbs) {
      if (orb != otherOrb) {
        orb.absorb(otherOrb);
      }
    }
  }

  private void applyAllGravitationalForcesFromOtherOrbsOn(Orb orb) {
    ArrayList<PVector> forces = new ArrayList<PVector>();
    orb.resetAcc();
    for (Orb otherOrb : orbs) {
      if (orb != otherOrb) {
        forces.add(orb.calculateGravitationalForceFrom(otherOrb));
      }
    }
    orb.soreAndApplyForces(forces);
  }

  void show() {
    for (Orb orb : orbs) {
      orb.show();
    }
  }

  void spawnNewOrbAtMousePos() {
    orbs.add(new Orb(new PVector(mouseX, mouseY)));
  }
}
