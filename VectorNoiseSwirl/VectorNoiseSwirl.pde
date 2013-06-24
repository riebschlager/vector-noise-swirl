ArrayList<PShape> shapes = new ArrayList<PShape>();
Point point;
int currentShape;
PGraphics canvas;
PImage src;
static int OUTPUT_WIDTH = 12 * 300;
static int OUTPUT_HEIGHT = 12 * 300;

void setup() {
  size(800, 800);
  background(255);
  colorMode(HSB);
  canvas = createGraphics(OUTPUT_WIDTH, OUTPUT_HEIGHT);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  loadVectors("flourish");
  src = loadImage("bitmap/tumblr_motoq9BjYq1qdylsxo1_500.jpg");
  point = new Point();
}

void draw() {
  canvas.beginDraw();
  for (int i=0; i<100; i++) {
    point.render();
  }
  canvas.endDraw();
  image(canvas, 0, 0, width, height);
}

void keyPressed() {
  if (key == ' ') {
    canvas.beginDraw();
    canvas.background(255);
    canvas.endDraw();
  }
  if (key == 's') {
    canvas.save("data/output/composition-" + month() + "-" + day() + "-" + hour() + "-" + minute() + "-" + second() + ".tif");
  }
}

void mousePressed() {
  point.beginStroke();
}

void loadVectors(String folderName) {
  File folder = new File(this.sketchPath+"/data/vector/" + folderName);
  File[] listOfFiles = folder.listFiles();
  for (File file : listOfFiles) {
    if (file.isFile()) {
      PShape shape = loadShape(file.getAbsolutePath());
      for (PShape layer : shape.getChildren()) {
        if (layer!=null) shapes.add(layer);
      }
    }
  }
}

