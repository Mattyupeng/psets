# PS1: GPU Population Dynamics Simulation (20 Points)

## Problem Statement
In this assignment you are going to build a simulation for population dynamics using C++ in a multithreaded environment. We have provided some starter code for you, and your job is to fill in the missing code as specified by the `#TODO#` blocks in the code. You can either just work in the ipynb OR you can work locally with the various files in this folder. If you don't have a GPU on your machine you will need to upload the ipynb to [Google Colaboratory](https://colab.google/) and work there.

### Instalation Instructions
**You should be able to run the ipynb directly in Google Colab and not need to install anything.** If you have an NVIDIA GPU and want to run the code locally you should follow the instructions here: https://developer.nvidia.com/cuda-downloads. Note that some distributions of Linux run a gcc/g++ version beyond what CUDA can support. If so you can use compiler flags to downgrade. First install the lower version of gcc/g++ and then compile with something like the following: `--compiler-bindir /usr/bin/g++-10` (adjusting for your path and version).

## Simulation Description
Assume the world is split into `NUM_REGIONS` different regions. Each region is filled with `COMMUNITIES_PER_NUM_SPECIES` different communities of each of the `NUM_SPECIES` different species. Each of the communities is intialized with this information and a `population` and a `growth_rate` which is all packed into a `Species_Community` struct. Note that the struct also contains additional variables which you may or may not need to use depending upon your implementation (aka you explicitly don't need to use all of them, I just put them there to enable a bit of flexibility in how you implement things).

```
typedef struct {
    int population;        // the population of a speciies
    int food_collected;    // the food collected in the current time period
    int region_of_world;   // region of this species community
    int species_type;      // type of species for this species community
    float growth_rate;     // growth_rate for this species community
    bool flag;             // flag in case helpful to have one (you may not need this)
    int helperi;           // flag in case helpful to have one (you may not need this)
    float helperf;         // flag in case helpful to have one (you may not need this)
} Species_Community;
```

The simulation runs for `NUM_TIMEPERIODS`. At each time period all of the members of each species calls the `food_oracle` inorder for everyone to `gather_all_food`. After all food is collected we can `update_all_populations` based on the amount of food gathered. In order to do so we need to first `compute_local_population_share` which is the percentage of all species WITHIN A SINGLE REGION that belong to a given species. We can then use that to `update_community_population` for each community of each species based on 3 rules as listed in later sections of this document.

When the simulation is done it prints out the populations of the various communities of species.

## Functions You'll Need To Implement
All functions you need to implement are in `util.h` and that is the only file you need to submit to gradescope!

#### First we'll implement helper functions:

`update_community_population` (3 points)

For a given community, update its population based on the input `local_population_share` and the following three rules:
1. The change in population for a community is directly proportional to its growth_rate and local_population_share (aka the percent change is the multiplication of both the growth_rate and local_population_share). And make sure to round down!
2. If it has collected enough food to feed the population it grows, else it shrinks by the percent change determined above.
3. If the population drops below 5 it goes extinct (aka becomes 0).

`compute_local_population_share` (3 points)

Returns the population share for a given community. Population share is defined as the percentage of the total population in a region for a given species across all communities of all species.

#### Then we'll implement the overall population update step:

`update_all_populations` (5 points)

Updates the population for all communities of all species. Some quick hints/notes:
1. You will need to use compute_local_population_share and update_community_population
2. Make sure your logic is thread safe! Remember when you launch a kernel every line of the code is run by every thread in parallel!
3. Feel free to use helper functions if that makes your life easier!

#### Next we'll implement the food gathering step:

`gather_all_food` (3 points)

Each simualtion step we reset the food counts to 0 and then each member of the population tries to collect food using the food_oracle(). Try to maximize parallelism.

#### Then we'll implement the main kernel and function:

`population_dynamics_kernel` (3 points)

The kernel is the code that will run on the GPU. You want to make sure all NUM_TIME_PERIODS of gather_all_food and update_all_populations are run. To maximize performance on the GPU, you'll want to use shared memory to speed things up, but then make sure to save things back to RAM once you're done! Be careful that you copy the values from inside structs as needed!

Finally, we'll launch the main kernel from the main function:

`population_dynamics` (3 points)

Remember that we need to be careful about GPU vs. CPU memory! So set up GPU memory, run the kernel, and clean up GPU memory!

#### Example Output:
With the presets of 2,2,2,10,5 (the constants in the helpers for the number of regions and species etc.) and any number of threads you should get the following (note only tested on Linux/Colab and so if you run locally on another setup the answer may differ a tad #compilerChaos):
``` 
ID[0]: of type [1]: in region [0]: had final population [11]
ID[1]: of type [1]: in region [0]: had final population [14]
ID[2]: of type [1]: in region [1]: had final population [237]
ID[3]: of type [0]: in region [1]: had final population [9]
ID[4]: of type [0]: in region [0]: had final population [97]
ID[5]: of type [0]: in region [0]: had final population [24]
ID[6]: of type [0]: in region [0]: had final population [5]
ID[7]: of type [1]: in region [1]: had final population [218]
```

## Submission
Once you are done, download and submit (or just submit if you are working locally) your `ipynb` or `util.h` file to **Courseworks**! Sadly Gradescope does not support GPU autograders at this time.

## Notes and Hints
+ **DO NOT CHANGE FUNCTION DEFINITIONS** or you will break our grading scripts
+ See the syllabus for our course collaboration policy (long story short you are welcome to collaborate at a high level but please do not copy each others code).
+ Please reach out on Slack with any and all questions!