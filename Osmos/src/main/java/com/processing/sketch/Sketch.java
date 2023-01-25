package com.processing.sketch;

import processing.core.PApplet;

public class Sketch extends PApplet {

    public void settings() {
        size(600, 600);
    }

    public void setup() {

    }

    public void draw() {
        background(255);
        ellipse(mouseX, mouseY, 10, 10);
    }
}
