package com.processing.sketch;

import processing.core.PApplet;

import java.util.ArrayList;

public class Sketch extends PApplet {

    public void settings() {
        size(400, 400);
    }

    QuadTree qtree;

    public void setup() {
        background(255);
        Rectangle boundary = new Rectangle(200, 200, 200, 200);
        qtree = new QuadTree(boundary, 4);
        for (int i = 0; i < 30; i++) {
            Point p = new Point(random(width), random(height));
            qtree.insert(p);
        }
    }

    public void draw() {
        background(0);
        qtree.show();
        stroke(0, 255, 0);
        rectMode(CENTER);
        Rectangle range = new Rectangle(mouseX, mouseY, 25, 25);
        rect(range.x, range.y, range.w * 2, range.h * 2);
        ArrayList<Point> points = qtree.query(range);
        for (Point p : points) {
            strokeWeight(4);
            point(p.x, p.y);
        }
    }
}