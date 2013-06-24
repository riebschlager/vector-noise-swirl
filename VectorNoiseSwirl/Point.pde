class Point {
  PVector location, velocity, noiseVector;
  float noiseFloat, lifetime, age, startRotation, endRotation;
  boolean isDead;
  int hue;
  PShape shape;

  public Point() {
    location = new PVector();
    velocity = new PVector();
    noiseVector = new PVector();
  }

  void beginStroke() { 
    location.x = map(mouseX, 0, width, 0, OUTPUT_WIDTH);
    location.y = map(mouseY, 0, height, 0, OUTPUT_HEIGHT);
    lifetime = random(1900, 3000);
    age = 10;
    hue = src.get((int) random(src.width), (int) random(src.height));
    shape = shapes.get((int) random(shapes.size()));
    shape.disableStyle();
    startRotation = random(-TWO_PI, TWO_PI);
    endRotation = random(-TWO_PI, TWO_PI);
  }

  void render() {
    if (1.0 - (age / lifetime) <= 0 || shape == null) return;
    noiseFloat = noise(location.x * 0.0001, location.y * 0.0001, frameCount * 0.0001);
    noiseVector.x = cos(((noiseFloat - 3) * TWO_PI) * 10);
    noiseVector.y = sin(((noiseFloat - 3) * TWO_PI) * 10);
    velocity.add(noiseVector);
    velocity.div(3.0f);
    location.add(velocity);
    shape.resetMatrix();
    shape.disableStyle();
    shape.rotate(map((age / lifetime), 0, 1, startRotation, endRotation));
    shape.scale(map((age / lifetime), 0, 1, 10, 0));
    canvas.noStroke();
    float b = map(age / lifetime, 0.0f, 1.0f, 0.0f, 255.0f);
    float a = map(age / lifetime, 0.0f, 1.0f, 0.0f, 255.0f);
    canvas.fill(color(hue(hue), saturation(hue), b, a));
    canvas.shape(shape, location.x, location.y);
    age++;
  }
}

