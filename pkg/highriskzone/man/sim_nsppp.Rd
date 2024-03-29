% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simulationbase.R
\name{sim_nsppp}
\alias{sim_nsppp}
\title{Generation of a realisation of a Neyman-Scott process}
\usage{
sim_nsppp(ppdata, radius, clustering = 5, thinning = 0)
}
\arguments{
\item{ppdata}{observed point pattern, whose estimated intensity (adjusted for
thinning and divided by "clustering") is used for simulating the
parent process}

\item{radius}{radius of the circles around the parent points in which the cluster
points are located (Maximum radius of a random cluster)}

\item{clustering}{a value larger or equal 1 which describes the amount of clustering; the
adjusted estimated intensity of the observed pattern is divided by
this value; it is also the parameter of the Poisson distribution
for the number of points per cluster}

\item{thinning}{constant thinning probability (in case the observed pattern is a
thinned version of a full pattern); usually equal to the probability of having
unobserved events}
}
\value{
The simulated point pattern (an object of class "ppp").
       Additionally, some intermediate results of the simulation are returned as 
       attributes of this point pattern: see \code{\link[spatstat.random]{rNeymanScott}}.
}
\description{
This algorithm generates a realisation of a Neyman-Scott process whose
expected number of points equals the number of observations in a given
pattern.
}
\details{
First, the algorithm generates a Poisson point process (see \code{\link[spatstat.random]{rpoispp}} for
details) of parent points with intensity kappa, which is a pixel image
object of class "im" (see \code{\link[spatstat.geom]{im.object}}).\cr
This pixel image is derived from the observed pattern using \code{\link[spatstat.explore]{density.ppp}}.
The bandwidth is not chosen in advance.\cr
If only a thinned version of the original pattern has been observed,
this can be taken into account using the parameter \code{thinning}.
Usually, not the estimated intensity itself is used for simulating the
parent process, but its values are divided by a constant named "clustering".\cr
Second, each parent point is replaced by a random cluster of points, created
by calling the function \code{\link[spatstat.random]{runifdisc}}. Each cluster consists of a Poisson
distributed number of points (with \code{clustering} being the expected number of
points in each cluster) which are located in a disc of a given \code{radius}.
These clusters are combined to yield a single point pattern which is
then returned as the result.\cr
The estimation of the intensity (on an adequate window) and the
simulation of the Neyman-Scott process are performed seperately,
so the intensity does not need to be reestimated in every iteration.\cr
The resulting process is a \enc{Mat?rn}{Matern} process whose parent process is an
inhomogeneous Poisson point process.
}
\examples{
\dontrun{      
 data(craterA)
 data(craterB)
 set.seed(100)
 sim_pp1 <- sim_nsppp(craterA, radius=300, clustering=15, thinning=0.1)
 sim_pp2 <- sim_nsppp(craterB, radius=300, clustering=15, thinning=0.1)
 op <- par(mfrow = c(1, 2))
 plot(sim_pp1, main = "simulated cluster process 1")
 plot(sim_pp2, main = "simulated cluster process 2")
 par(op)
 }
}
\seealso{
\code{\link[spatstat.random]{rNeymanScott}}, \code{\link[spatstat.random]{rThomas}}, 
         \code{\link[spatstat.random]{rMatClust}}
}
