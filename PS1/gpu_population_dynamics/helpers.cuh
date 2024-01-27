#include <iostream>
#include <thread>
#include <vector>
#include <mutex>
#include <atomic>
#include <cstdlib>
#include <cmath>

// Some helpful constants
#define NUM_REGIONS 2
#define NUM_SPECIES 2
#define COMMUNITIES_PER_NUM_SPECIES 2
#define COMMUNITIES_PER_REGION (NUM_SPECIES*COMMUNITIES_PER_NUM_SPECIES)
#define TOTAL_COMMUNITIES (NUM_REGIONS*COMMUNITIES_PER_REGION)
#define MAX_STARTING_POPULATION 10
#define NUM_TIME_PERIODS 5
// for this pset we only need to consider 1 block :)
#define NUM_BLOCKS 1
#define NUM_THREADS (TOTAL_COMMUNITIES/NUM_BLOCKS)

// data structure to store information about each species
typedef struct {
    int population;        // the population of a speciies
    int food_collected;    // the food collected in the current time period
    int region_of_world;   // region of this species community
    int species_type;      // type of species for this species community
    float growth_rate;     // growth_rate for this species community
    bool flag;             // flag in case helpful to have one (you may not need this)
    int helperi;           // int storage in case helpful to have one (you may not need this)
    float helperf;         // float storage in case helpful to have one (you may not need this)
} Species_Community;

// food oracle function call
// call this with a community id to get a "random" amount of food back
// this represents one community member going out to get food
// we hardcode to 1 for determinism in testing but in theory should be random
__host__ __device__
int food_oracle(int community_id){return 1;};

// random range integer in range [0,max_range)
__host__
int rand_range(int max_range){return rand() % max_range;}
// random float in range [0,1]
__host__
float rand01(){return (float)rand() / (float)RAND_MAX;}