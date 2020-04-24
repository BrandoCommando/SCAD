egginess = 0; //[-100:100]

egg(curveFactor = (100 + egginess) / 100);

//This makes an egg
//New
//-Fixed egg floating above 0 now sits on 0 like a cylinder

module egg( steps = 60, height = 100, curveFactor = 1, faces = 45 ) {	
    a = height;
    b = height * (0.78 * curveFactor);  //Through keen observation I have determined that egginess should be 0.78

    //Equation for the egg curve
    function eggCurve( offset ) = sqrt( 
                                  a - b - 2 * offset * step 
                                  + sqrt( 4 * b * offset * step + pow(a - b, 2) ) ) 
                                  * sqrt(offset * step) / sqrt(2);
	
	step = a / steps;
	union() {
        //This resembles the construction of a UV sphere
        //A series of stacked cylinders with slanted sides
        for( i = [0:steps]) {
		  //echo(i * step);
		  translate( [0, 0, a - ( i + 1 ) * step - 0.01] )
		    cylinder( r1 = eggCurve( i + 1 ),
		              r2 = eggCurve( i ), 
		              h = step,
		              $fn = faces );
		}
    }
}