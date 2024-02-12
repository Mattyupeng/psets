# PS2: Matrix Inverse (8 Points)

### Problem Statement
In this assignment you are going to wite a kernel to compute a matrix inverse which we can then use to solve a linear system. We have provided some starter code for you, and your job is to fill in the missing code as specified by the `#TODO#` blocks in the code. You can either just work in the ipynb OR you can work locally with the various files in this folder. If you don't have a GPU on your machine you will need to upload the ipynb to [Google Colaboratory](https://colab.research.google.com/) and work there.

### Functions You'll Need To Implement
All functions you need to implement are in `util.h` and that is the only file you need to submit to courseworks! Please do not change function definitions. Also be careful with your syncs!

**`matrix_inverse_inner` (5 points):** this device function will do all of the heavy lifting and actually implement the matrix inverse function. It takes in the input matrix and outputs the inverse. You should assume these pointers are already in shared memory. There is also an additional input of additional shared temporary memory which you may or may not need to use (and you will get to specify how big it is in later functions). You can implement this in any way, but/and the simplest way to do this is through the use of the Gauss Jordan elimination method. You can see some graphical examples of "elementary row operations" [at this link](https://www.mathsisfun.com/algebra/matrix-inverse-row-operations-gauss-jordan.html). But/and in short you can simply walk through the rows in order (aka do not swap any rows and just do them in order) and for each row divide it to ensure that it is leading with a 1 and then subtract down along the rest of the rows to ensure they are all leading with a 0. If you repeat this and move down and to the right through the matrix you will end up with the identity in place of the original matrix and the inverse to the right! You can assume that the input matrix does not have a zero in the top left corner and is of a relatively small size (aka less than 30x30) and that it is a square matrix. The function input `matrix_dim` is the number of rows (and since the matrix is square also the number of columns) of the input matrix.

Note: there are a number of ways to actually implement it. Do whatever you think is simplest and easiest first. Then see if you can optimize it!

**`matrix_inverse_kernel` (2 points):** this kernel will call the `_inner` function and will and should move the device matrix into shared memory, make sure the computation occurs in shared memory, and return the value to device memory. You will note that we specified dynamic shared memory. Please use that and make sure to allocate enough of it in the host function to support however much your device function needs! As with `_inner`, the function input `matrix_dim` is the number of rows (and since the matrix is square also the number of columns) of the input matrix.

**`matrix_inverse` (1 point):** the host function will call the `_kernel` and will move the input host matrix into device memory, launch the kernel (with dynamic shared memory), and return the solution to host memory. As with `_inner` and `_kernel`, the function input `matrix_dim` is the number of rows (and since the matrix is square also the number of columns) of the input matrix.

### Example Output
If you compute the inverse in Python with:
``` 
import numpy as np
test1 = 2*np.eye(5)
print(test1)
print(np.linalg.inv(test1))
test2 = 7*np.tri(5)
print(test2)
print(np.linalg.inv(test2))
```
You will get the output:
```
[[2. 0. 0. 0. 0.]
 [0. 2. 0. 0. 0.]
 [0. 0. 2. 0. 0.]
 [0. 0. 0. 2. 0.]
 [0. 0. 0. 0. 2.]]
[[0.5 0.  0.  0.  0. ]
 [0.  0.5 0.  0.  0. ]
 [0.  0.  0.5 0.  0. ]
 [0.  0.  0.  0.5 0. ]
 [0.  0.  0.  0.  0.5]]
[[7. 0. 0. 0. 0.]
 [7. 7. 0. 0. 0.]
 [7. 7. 7. 0. 0.]
 [7. 7. 7. 7. 0.]
 [7. 7. 7. 7. 7.]]
[[ 0.14285714  0.          0.          0.          0.        ]
 [-0.14285714  0.14285714  0.          0.          0.        ]
 [ 0.         -0.14285714  0.14285714  0.          0.        ]
 [ 0.          0.         -0.14285714  0.14285714  0.        ]
 [ 0.          0.          0.         -0.14285714  0.14285714]]
```

### Submission
Once you are done, download and submit (or just submit if you are working locally) your `ipynb` or `util.h` file to **Courseworks**! Sadly Gradescope does not support GPU autograders at this time.

### Notes and Hints
+ **DO NOT CHANGE FUNCTION DEFINITIONS** or you will break our grading scripts
+ See the syllabus for our course collaboration policy (long story short you are welcome to collaborate at a high level but please do not copy each others code).
+ Please reach out on Slack with any and all questions!