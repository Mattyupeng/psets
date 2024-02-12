//%%cuda_group_save -n util.h -g default

// the GPU device function
//
// Hints: actually solve the matrix inverse!
//
__device__
void matrix_inverse_inner(float *s_input, float *s_output, float *s_temp, const int matrix_dim){
  // first set up the matrix with identity next to it
  // #TODO
  

  // Next we are going to guassian elimination walking down the matrix (assuming no leading 0s).
  // We therefore use the columns in order as the pivot column for each pivot we need to rescale
  // that row so that the pivot value is 1 THEN for all other row values we need to add a multiple
  // of the NEW pivot row value such that we transorm the other row pivot column value to 0.
  // See https://www.mathsisfun.com/algebra/matrix-inverse-row-operations-gauss-jordan.html
  //
  // Note if you would prefer to use another method that is fine but/and this is the method
  // we have a solution for and are prepared to help you with!
  for (unsigned pivRC = 0; pivRC < matrix_dim; pivRC++){
      //
      // #TODO
      //
  }

  // Make sure to write the result to the output
  // # TODO
}

// the GPU kernel
//
// Hints: set up shared memory, run the _inner, clean up shared memory
//
__global__
void matrix_inverse_kernel(float *d_input, float *d_output, const int matrix_dim){
  // get shared pointers
  extern __shared__ float s_dynShared[];
  // #TODO

  // copy the data into shared memory
  // #TODO

  // run the code
  // #TODO
  
  // copy the memory back out
  // #TODO
}

// the host function
//
// Hints: set up GPU memory, run the kernel, clean up GPU memory
//
__host__
void matrix_inverse(float *h_input, float *h_output, const int matrix_dim){
  // transfer memory to the device
  // #TODO

  // run the kernel
  // #TODO
  
  // transfer data back to the host
  // #TODO
}