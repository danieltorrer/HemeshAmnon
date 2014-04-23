
// HemeshHexagon example by Amnon Owed (23.04.2014)
// (for discussion purposes, not optimized for speed)
// Dependencies: Processing 2.1.2, HE_Mesh 2014 & Peasycam v2.00

import peasy.*;
PeasyCam cam;

import wblut.math.*;
import wblut.processing.*;
import wblut.hemesh.*;
import wblut.geom.*;
import wblut.*;

WB_Render render;
HE_Mesh mesh1, mesh2;

boolean bDrawFaces = true;
boolean bDrawEdges = true;
boolean bDrawFaceNormals = false;

void setup() {
  size(1024, 512, P3D);
  smooth(16);

  cam = new PeasyCam(this, 600);
  cam.rotateY(PI);
  render = new WB_Render(this);
  HE_Mesh base = HexagonGrid.createHemesh(0, 0, 5, 10);
  mesh1 = base.get();
  mesh2 = base.get();
  HEM_Extrude extrude = new HEM_Extrude().setChamfer(1).setRelative(false).setFuse(true);
 
  mesh1.modify(extrude);
   HE_Selection faces=extrude.extruded;
   mesh1.delete(faces); 
   extrude = new HEM_Extrude().setChamfer(0).setDistance(15);
 
  mesh1.modify(extrude);
WB_Plane P=new WB_Plane(0,0,1,0,0,1);
mesh1.modify(new HEM_Slice().setPlane(P).setSimpleCap(false));

}

void draw() {
  background(225);
  perspective(PI/3, float(width)/height, 1, 10000000);
  directionalLight(255, 255, 255, 1, 1, -1);
  directionalLight(127, 127, 127, -1, -1, 1);
  if (bDrawFaces) { noStroke(); fill(255); render.drawFaces(mesh1);  }
  if (bDrawEdges) { noFill(); stroke(0); render.drawEdges(mesh1);  }
  if (bDrawFaceNormals) { stroke(0, 0, 255); render.drawFaceNormals(15, mesh1);  }
  drawControls();
}

void keyPressed() {
  if (key == 'f') { bDrawFaces = !bDrawFaces; }
  if (key == 'e') { bDrawEdges = !bDrawEdges; }
  if (key == 'n') { bDrawFaceNormals = !bDrawFaceNormals; }
  if (key == 's') { saveFrame("screen-######.tif"); println("Screenshot saved: " + "screen-" + nf(frameCount, 6) + ".tif"); }
}

void drawControls() {
  cam.beginHUD();
  noLights();
  fill(0);
  text("bDrawFaces (f): " + bDrawFaces, 10, 20);
  text("bDrawEdges (e): " + bDrawEdges, 10, 40);
  text("bDrawFaceNormals (n): " + bDrawFaceNormals, 10, 60);
  text("Screenshot (s)", 10, 80);
  cam.endHUD();
}

