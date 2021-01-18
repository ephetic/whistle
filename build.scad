use <main.scad>;
build=false;
piece="mouthpiece";

if (build) {
  if (piece == "mouthpiece") mouth();
  if (piece == "window") win();
  if (piece == "fipple") fip();
  if (piece == "pipe") non_last();
  if (piece == "last") last();
}
