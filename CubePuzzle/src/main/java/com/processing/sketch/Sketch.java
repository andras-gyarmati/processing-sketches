package com.processing.sketch;

import processing.core.PApplet;

public class Sketch extends PApplet {

    public float ax, ay, az, camSpeed, boxSize;
    private int cols, rows;

    public void settings() {
        size(800, 800, P3D);
    }

    public void setup() {
        noFill();
        camSpeed = 0.05f;
        boxSize = 20;
        cols = 5;
        rows = 5;
        strokeWeight(2);
    }

    public void draw() {
        background(220);
        rotateX(ax);
        rotateY(ay);
        rotateZ(az);
        for (int i = -2; i <= 2; i++) {
            for (int j = -2; j <= 2; j++) {
                translate(width / 2 + i * boxSize, height / 2 + j * boxSize, 05f);
                box(boxSize);
            }
        }
        restrictRotation();
    }

    private void restrictRotation() {
        ax = ax % (PI * 2);
        ay = ay % (PI * 2);
        az = az % (PI * 2);
        ax = min(max(-PI / 4, ax), 0);
    }

    public void keyPressed() {
        switch (keyCode) {
            case LEFT:
                ay -= camSpeed;
                break;
            case RIGHT:
                ay += camSpeed;
                break;
            case DOWN:
                ax -= camSpeed;
                break;
            case UP:
                ax += camSpeed;
                break;
        }
    }
}
