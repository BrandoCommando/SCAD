/*skew takes an array of six angles:
 *x along y
 *x along z
 *y along x
 *y along z
 *z along x
 *z along y
 */
module skew(dims) {
matrix = [
	[ 1, dims[0]/45, dims[1]/45, 0 ],
	[ dims[2]/45, 1, dims[4]/45, 0 ],
	[ dims[5]/45, dims[3]/45, 1, 0 ],
	[ 0, 0, 0, 1 ]
];
multmatrix(matrix)
children();
}

skew([45, 0, 0, 0, 0, 0])
cube([10,10,10]);