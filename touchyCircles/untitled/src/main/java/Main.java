import processing.core.PApplet;
import processing.core.PVector;

import java.util.ArrayList;

public class Main extends PApplet {

    private ArrayList<PVector> ps;
    private float d, scale, scaleStep, sizeStep;
    private int cols, rows;

    public void settings() {
        size(1000, 1000);
    }

    public void setup() {
        ps = new ArrayList<PVector>();
        d = 150;
        scale = 0.2f;
        scaleStep = 0.01f;
        sizeStep = 2.0f;
        cols = 10;
        rows = 10;
        init();
    }

    public void draw() {
        background(0);
        if (scale <= 0 || scale >= 0.7) {
            scaleStep *= -1;
        }
        scale += scaleStep;
        if (d <= 10 || d >= 200) {
            sizeStep *= -1;
        }
        d += sizeStep;
        for (PVector p : ps) {
            fill(255);
            noStroke();
            float diff = max(abs(width / 2 - p.x), abs(height / 2 - p.y));
            float size = d * map(diff, 0, width / 2, 1, scale);
            ellipse(p.x, p.y, size, size);
        }
        for (PVector p : ps) {
            fill(0);
            noStroke();
            float diff = max(abs(width / 2 - p.x), abs(height / 2 - p.y));
            float size = d * map(diff, 0, width / 2, 1, scale) - 4;
            ellipse(p.x, p.y, size, size);
        }
    }

    void init() {
        for (int y = 0; y <= cols; y++) {
            for (int x = 0; x <= rows; x++) {
                ps.add(new PVector(x * width / rows, y * height / cols));
            }
        }
    }
}
