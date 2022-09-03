# ME748-Project
## Optimization of Theo-Jensen Mechanism's Link Lengths

The Theo-Jansen linkage is an eleven-bar mechanism designed by Theo Jansen in his collection “Strandbeest.” The mechanism is crank driven and mimics the motion of a leg. Its energy efficiency, and predeterminable foot motion show promise of applicability in legged robotics. Theo Jansen himself has demonstrated the usefulness of the mechanism through his "strandbeest” sculptures that utilize duplicates of the linkage whose cranks are turned by wind sails to supply a walking motion. The motion yielded is smooth flowing and comparatively agile. Because the linkage has been recently invented within a previous couple of decades, walking movement is currently the first application. Further investigation and optimization could cause more useful applications that need an identical output path when simplicity in design is important.

The tricky part is figuring out what lengths to make each of the 11 rods so that we actually get a walking motion and not some other weird path traced out by the machine's "foot." So.. I wrote this Matlab code to first _solve_ the joint positions for all joints given the motor's position and joint lengths.

You can play around with that solver in the first half of `test.m`.

Changing the lengths of the rods drastically changes the "output" (i.e. the path of the foot through one cycle). The script `optimize.m` is my first ever attempt at doing genetic algorithms - it generates 100 machines with random length rods, simulates them, and the _scores_ them based on the trajectory of the joints.

The bottom few lines of of `optimize.m` plot the worst- and best-score of each generation. The good news is that the scores get better over the generations. The bad news is that the resulting machine is really ugly and clearly not fit for actually walking.

So _after_ doing all of this, I discovered that [Jansen's website](http://www.strandbeest.com/beests_leg.php) includes a description of how he came up with the lengths that he did. He took the same exact approach - the problem is too high-dimensional to be done analytically, so we need to evolve the best solution (i.e. genetic algorithms). He also includes the ideal ratio of the limbs.

So.. can I at least reproduce his results? Or do better?

Ultimately I want to produce little desktop size strandbeests - maybe 3D print them. Turns out Jansen already did that too. Oh, well..

## Fitness Function

As mentioned above, the optimization works. That is - scores get better over time. But, that doesn't mean that the machine is ready to walk just because it scored well on my test. I'm not actually simulating any walking.. I basically made up a few criteria that I thought would be good, and used some ideas from Jansen's site (like triangles). So, here's how the score for a given linkage is calculated:

1. Break up the foot's path into two sections at min- and max-x (works since it's always a loop)
2. score the weight-bearing (lower) section for flatness: `exp(-(average difference from the mean))`
3. score the recovery (upper) section for height: `1-exp(peak minus average of endpoints)`
4. multiply together the results from 2. and 3.

with a few caveats from testing:

1. if it would literally wouldn't fit together, or would tear itself apart because the dimensions don't work, score 0
2. if the foot ever goes above y=0, score it a 0 (it can't stand up at all)
3. if either endpoint of the foot's recovery path is higher than the middle of that path (i.e. not a triangle), multiply by 0.01 to penalize it
4. if the foot ever goes above the "heel" joints, multiply by 0.01 to penalize it (foot is not weight-bearing at these points)

Originally I wanted to keep all scores on the range `[0, 1]`, but that's been changed. The actual number is arbitrary as long as the following holds: a linkage with score `x` is _better_ than a linkage with score `y` if and only if `x > y`. 

The reason this is a good idea, as Jansen says on his site, is because the leg will be supporting weight while at the bottom of its motion. The flatter it is, the less weight it's throwing around (imagine balancing a book on your head while walking - you want your head to move as little as possible, so you keep your feet moving as horizontally as possible). So: flat base is good.

Let's say we try to do this with only 2 legs on each side. By the time the second leg is ready to pick its foot up off the ground, the first leg better be ready to catch it, otherwise it will fall flat on its face. So - we want the "recovery" of the motion to be fast compared to the weight-bearing part; hence, the score is multiplied by the ratio of ground-time to recovery-time.

## Todo

* Come up with a better fitness function.
    * Jansen suggests that the more _triangular_ the foot's path, the better. Flat motion on the ground and picking the foot up high are both pluses. How to measure _triangleness_?
    * Also need to consider torque of actually driving it.. Give a worse score if ever trying to push on a joint close to 180º or pull close to 0º. 90ºish is ideal.
* speed up simulation
    * can anything be parallelized?
    * putting this on git and running it remotely (thayer school computing cluster) help a bit, at least to reduce strain on my dinky laptop
