Extrema of a polynomial saddle points

github
https://tinyurl.com/y7hm98sw
https://github.com/rogerjdeangelis/utl-extrema-of-a-polynomial-saddle-points

StackOverflow
https://tinyurl.com/y9qfuoxj
https://stackoverflow.com/questions/52658713/for-a-polynomial-get-all-its-extrema-and-plot-it-by-highlighting-all-monotonic

Profile
https://stackoverflow.com/users/4891738/%E6%9D%8E%E5%93%B2%E6%BA%90

INPUT
=====

 %let coef=%str(1, -2.2, -13.4, -5.1, 1.9, 0.52);

 y = 1 -2.2*x -13.4*x**2 -5.1*x**3 + 1.9*x**4 +0.52*x**5;


EXAMPLE OUTPUT
--------------

WORK.WANT

 Obs     EXTREMA

   1    -3.77436
   2    -1.20748
   3    -0.08654
   4     2.14531


          Plot of Y*X.  Symbol used is '*'.

    +--------------------------------------------+
  Y |                                            |
    |    -3.8        -1.2 -0.09      2.14        |
100 +      +            +    +          +        + 100
    |      |            |    |          |        |
    |      *            |    |          |        |
    |     *|*           |    |          |        |
    |    * | *          |    |          |        |
    |    * | **         |    |          |        |
    |      |  *         |    |          |        |
 50 +   *  |   *        |    |          |        +  50
    |   *  |    *       |    |          |        |
    |      |    *       |    |          |        |
    |   *  |     *      |    |          |        |
    |      |      *     |    *          |        |
    |   *  |      **    |   *|*         |        |
    |      |       **   |  * | *        |        |
  0 +      |         ** | *  |  *       |   *    +  0
    |      |           *|*   |  **      |        |
    |      |            *    |    **    |   *    |
    |      |            |    |     **   |        |
    |      |            |    |      *   |  *     |
    |      |            |    |       *  |  *     |
    |      |            |    |        * | *      |
-50 +      |            |    |         *|*       + -50
    |      |            |    |          *        |
    ---+---X-----+------X--+-X-------+--X------+-+
     -4.5      -2.5      -0.5       1.5       3.5

                           X

PROCESS
=======

%utl_submit_r64("
library(polynom);
library(SASxport);
SaddlePoly <- function (pc) {
  pc1 <- pc[-1] * seq_len(length(pc) - 1);
  croots <- polyroot(pc1);
  rroots <- Re(croots)[abs(Im(croots)) < 1e-14];
  sort(unique(rroots));
  };
pc <- c(&coef);
want <- as.data.frame(SaddlePoly(pc));
colnames(want)<-c('EXTREMA');
write.xport(want,file='d:/xpt/want.xpt');
");

libname xpt xport "d:/xpt/want.xpt";

proc print data=xpt.want ;
run;quit;


*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

%let coef=%str(1, -2.2, -13.4, -5.1, 1.9, 0.52);

data have;

 do x=-4.5 to +3 by .1;
    y = 1 -2.2*x -13.4*x**2 -5.1*x**3 + 1.9*x**4 +0.52*x**5;
    output;
 end;

run;quit;

options ls=64 ps=36;
proc plot;
 plot y*x='*'/hvref=-3.8 -1.2 -0.086  2.14;
run;quit;


