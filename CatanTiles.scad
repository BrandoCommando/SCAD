tile_width=74;
inner_width=64;

base_tile();

module base_tile()
{
  difference() {
    circle(d=tile_width,$fn=6);
    circle(d=inner_width,$fn=6);
  }
}