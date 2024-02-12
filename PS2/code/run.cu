//%%cuda_group_save -n run.cu -g default
#include <stdio.h>
#include "util.h"

__host__
void printMat(float *mat, const int matrix_dim){
    // loop through row by row and print
    for (int r = 0; r < matrix_dim; r++){
        for (int c = 0; c < matrix_dim; c++){
            printf("%f ",mat[r + c*matrix_dim]);
        }
        // Newline for new row
        printf("\n");
    }
    // Newline for end of print
    printf("\n");
}

__host__
void runTest(float *h_input, float *h_output, const int matrix_dim){
  // print the input matrix
  printMat(h_input,matrix_dim);

  // run the main function
  matrix_inverse(h_input,h_output,matrix_dim);

  // print the final result
  printMat(h_output,matrix_dim);
}

__host__
int main() {
  
  // initialize the first test matrix
  const int matrix_dim = 5;
  const int matrix_dim_sq = matrix_dim*matrix_dim;
  float *h_input = (float *)malloc(matrix_dim_sq*sizeof(float));
  float *h_output = (float *)malloc(matrix_dim_sq*sizeof(float));
  for (int c = 0; c < matrix_dim; c++){
      for (int r = 0; r < matrix_dim; r++){
          h_input[r + c*matrix_dim] = (r == c) ? 2 : 0;
      }
  }
  // run the test
  runTest(h_input,h_output,matrix_dim);

  // now do the second test
  for (int c = 0; c < matrix_dim; c++){
      for (int r = 0; r < matrix_dim; r++){
          h_input[r + c*matrix_dim] = r >= c ? 7 : 0;
      }
  }
  runTest(h_input,h_output,matrix_dim);
  
  return 0;
}