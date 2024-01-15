# COMS BC 3159 - SP24
# PS0: Math and Coding Background and Environment
* Due: 11:59pm Friday, January 26th

## Submission Information

**This year for submission we are using Gradescope - you must submit to [Gradescope](https://www.gradescope.com/courses/693842) to get credit!** Gradecope will allow for infinite submissions until the deadline and then will start marking submissions as late and will then lock 2 days after the due date. Please make sure to mark the page for each question on the written via Gradescope and only upload the requested files for the code section. Also if you are having issues with autograders make sure you didn't rename files! Submissions not following the requirements *will not be graded* so make sure to ask quesitons before the deadline (but we'll try to be nice for PS0).

Good luck!

## Written Assignment (10 points)

Please go to the PDF in the `written` folder for the written instructions (also available on Gradescope). Please use the provided latex template to write up your solutions and *submit the **pdf output** from LaTex to Gradescope*. Please refer to the software install guide for more information on Latex. Please make sure to mark which pages each question appears on.

## Coding Assignment (10 points)
**You must submit to gradescope to get credit for the assignment --- make sure you submit the required files before the deadline!**

You are tasked with creating a program that simulates a modifed version of the [Agar.io](http://agar.io/) game using C++. We have provided some starter code for you, and your job is to fill in the missing code as specified by the `#TODO#` blocks in the code. You can either just work in the `ipynb` locally or in Google Colab OR you can work locally with the various files in the `singlecell` folder. 

**Files in this assignment:**

`helpers.h`   		Defines a series of (very useful) helper functions and structs.

`util.h`      		The main file you will edit and implement helper functions (and thus submit to Gradescope for Autograding).

`moves.h`   		Defines the hard coded moves to produce the debug and test output (see hints below).

`singlecell.cpp`    Main function that calls the helper functions and constants in `util`, `helpers`, and `moves` in order to run the program.

`run.sh`   		 	Compiles and runs the program

`singlecell.ipynd`  Optional ipynb file that you can use in Google Colab (or locally) to edit, compile, run, and test your code.

To work locally, make your changes to the `util.h` file and then on the terminal run the `run.sh` file to compile and run the code. Note that if you look at the run file you will notice that it simply calls the compile command and the runs the executable, and so you can also execute those two commands yourself on the command line. Note that the runfile is designed for a Linux style environment and so you may need to modify it slightly to run on Mac machine (although it may also just work as the Mac terminal is a modifed linux terminal) and will need to leverage the Windows Subsytem for Linux or the Linux Bash Shell on a Windows machine.

To access your version of the notebook in Colab naviagate to `https://colab.research.google.com/github/COMS-BC3159-SP24/psets-<YOUR_GITHUB_ID>/blob/main/PS0/singlecell/singlecell.ipynb` where you replace `<YOUR_GITHUB_ID>` with your GitHub ID. Then you should be able to save any changes you make directly back into your private repository by going to `file -> Save a copy in GitHub` and the select your `psets-<YOUR_GITHUB_ID>` repository.

### Game Description
In this version of the game, each character starts as a circle with a fixed size (radius) in a random location on a 2D grid. Each character is given a unique ID indicating when they joined the game. IDs start at 0 and increase over time.

On each turn, each of the characters remaining in the game can move either up, down, left, or right by one unit. For this version of the game those moves are hard-coded at compile time and constant for all characters (to make the grading scripts work and make it easier for you to debug). Characters that run into walls (as defined by the max and min xy values bounce off of the walls and stay put.

When characters run into each other, one of two things happens:
1. If the characters are different sizes, the smaller character is removed from the game and the larger character wins and grows in size by the size of the smaller character. For example, if a character of size 3 runs into a character of size 2, the character of size 2 is removed from the game and the character of size 3 becomes size 5.

2. If the characters are the same size, the character that joined the game first (has a smaller `id`) wins and grows in size as described above.

At the end of the game your code should print the final surviving characters, their ID, location, and size.

### Functions You'll Need To Implement (2 Points Each)
All functions you need to implement are in `util.h` and that is the only file you need to submit to gradescope!
+ `allocate_memory`
+ `apply_moves`
+ `in_collision`
+ `resolve_collision`
+ `check_resolve_all_collision`

**Finally don't forget to fill in the AI Tool Disclosure at the top of `util.h`!**

### Submission
To test and submit your code in the autograder, whether you are working locally or in the cloud, copy your functions into the `util.h` file and submit it to the assignment on [Gradescope](https://www.gradescope.com/courses/693842). Remember that you have INFINITE submissions so we suggested submitting and testing your code early and often. We will use the last submission before the deadline as your final score!

### Notes and Hints
+ **DO NOT CHANGE FUNCTION DEFINITIONS** or you will break our grading scripts
+ When implementing your code make sure to break ties based on id and evaluate all of the possible collisions in id order! That is, first check if id=0 collides with all other characters before moving onto id=1! (This is just so that the grading scripts and example outputs work correctly).
+ See the syllabus for our course collaboration policy (long story short you are welcome to collaborate at a high level but please do not copy each others code).
+ If you are working in Colab, you can change the formatting of the code to different color schemes: just change the `%%cpp -n <filename>.h -s xcode` to a different `-s` flag. The list can be [found at this link](https://gist.github.com/akshaykhadse/7acc91dd41f52944c6150754e5530c4b).
+ Please reach out on Slack with any and all questions!
+ If your code is implemented correctly then the hard coded moves should result in the final output of `[10] at (2,1) with size [40]`. If you instead get the following output (or something else with lots of very very large sizes) you aren't handling characters being alive or dead correctly! Note that as we start with 20 characters of size 2 the total size should be 40!
```
[6] at (-6,3) with size [16]
[7] at (12,2) with size [24]
[8] at (-3,-16) with size [32]
[10] at (4,1) with size [24]
[11] at (18,2) with size [32]
[12] at (22,11) with size [32]
[13] at (21,23) with size [32]
[14] at (-17,-2) with size [30]
[15] at (16,19) with size [32]
[17] at (8,6) with size [16]
[18] at (1,0) with size [24]
[19] at (-1,2) with size [16]
```