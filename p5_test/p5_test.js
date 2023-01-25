var n = 0;
var c = 10;
function setup() {
  createCanvas(1280, 960);
  background(51);
  angleMode(DEGREES);
}

function draw() {
  background(51);
  noStroke();
  translate(width / 2, height / 2);
  for (var i = 0; i < n; i++) {
    var a = i * 137.5;
    var r = c * sqrt(i);
    var x = r * cos(a);
    var y = r * sin(a);
    fill(255, 255, 255, map(i, 0, n, 255, 0));
    ellipse(x, y, sqrt(sqrt(i)) + 10, sqrt(sqrt(i)) + 10);
  }
  n++;
  if (n > 1000) {
    noLoop();
  }
}