//_cCubeVertex(h=0,rb=3);
//cCube([20,25,30],h1=2,l=4,h2=4);

function _r(l) = l/sqrt(2-sqrt(2));

module _cCubeVertex(h,rt=0,rb=0){
    translate([0,0,-h])
    rotate([0,0,22.5])
    if(h==0){
        r=max(rb,rt);
        translate([0,0,-1])
        cylinder(h=1,r=r,center=false,$fn=8);
    }else if(rb>0){
        cylinder(h=h,r1=rb,r2=rb-h,center=false,$fn=8);
    }else if(rt>0){
        cylinder(h=h,r1=rt+h,r2=rt,center=false,$fn=8);
    }
}

module cCube(size,h1,h2,l){
    r=_r(l);
    t=cos(22.5)*r;
    hull(){
        translate([0,0,size[2]]){
            translate([t,t,0])                 _cCubeVertex(h=h1,rb=r);
            translate([size[0]-t,t,0])         _cCubeVertex(h=h1,rb=r);
            translate([size[0]-t,size[1]-t,0]) _cCubeVertex(h=h1,rb=r);
            translate([t,size[1]-t,0])         _cCubeVertex(h=h1,rb=r);
        }
        mirror([0,0,1]){
            translate([t,t,0])                 _cCubeVertex(h=h2,rb=r);
            translate([size[0]-t,t,0])         _cCubeVertex(h=h2,rb=r);
            translate([size[0]-t,size[1]-t,0]) _cCubeVertex(h=h2,rb=r);
            translate([t,size[1]-t,0])         _cCubeVertex(h=h2,rb=r);
        }
    }
}
