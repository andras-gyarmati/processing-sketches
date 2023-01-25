public class User extends Player {

  public User(float x, float y, float size) {
    super(x, y, size, size);
  }
  
  public void setDirection(PVector swipeInput) {
    direction = swipeInput.normalize();
  }
}