\encoding{utf8}
\name{MGBT-package}
\docType{package}
\alias{MGBT-package}
\title{Multiple Grubbs--Beck Low-Outlier Test}
\description{
The \pkg{MGBT} package provides the Multiple Grubbs--Beck low-outlier test (MGBT; Cohn and others, 2013), and almost all users are only interested in the function \code{\link{MGBT}} that explicitly wraps the recommended implementation.

When logarthimic transformation of the data prior to parameter estimation of probability models is made and interest in the the right-tail of the distribution exists, the MGBT is highly effective in adding robustness to analyses such as flood-frequency analyses and likely other similar analyses of earth-system data. The test can be used to objectively identify \dQuote{low outliers} (generic or specific to floods) or \dQuote{potentially influential low floods} (PILFs)---in general, these terms are synonymous.

The focus and motivation of the MGBT is for the so-called Bulletin 17C guidelines (England and others, 2017) for flood-frequency analyses, which are updated guidelines to those in Bulletin 17B (IACWD, 1982). The MGBT is implemented in the U.S. Geological Survey (USGS)-PeakFQ software (USGS, 2014; Veilleux and others, 2014), which implements much of Bulletin 17C (England and others, 2017). The Bulletin 17C is a standard Federal guideline for performing flood-frequency analyses in the United States.

The MGBT is especially useful in practical applications for which small events (low-magnitude tail, left-tail side) could be formed by divergent populations or processes than exist in the high-magnitude tail (right-tail side) of the probability distribution. One such location is much of the arid to semi-arid hydrologic setting for much of Texas for which a heuristic method predating and unrelated to MGBT was used for low-outlier threshold identification (see \code{\link{ASlo}}).

\bold{Note on Sources and Historical Preservation}---Various text files (\code{.txt}) of \R code are available in directory \code{/inst/sources} of the \pkg{MGBT} package. The late Timothy A. Cohn (TAC) communicated \R code to WHA in August 2013 for computation of MGBT within a flood-frequency project of WHA's. This 2013 code is preserved verbatim in file \code{LowOutliers_wha(R).txt}, which also contain related concepts by TAC. Separately, TAC communicated \R code to JFE in 2016 (actually over many years) for computation of MGBT and other low-outlier related concepts. This 2016 code is preserved verbatim in file \code{LowOutliers_jfe(R).txt}. TAC also communicated \R code to JFE for computation of MGBT and other low-outlier related concepts for production of figures for a MGBT paper. These are preserved verbatim in file \code{FigureMacros_jfe(R)}\code{.txt} for which that file is dependent on \code{P3_075_jfe(R).txt}. The \code{_jfe} has been added to denote stewardship at some point by JFE. The \code{P3_075_jfe(R).txt} though is superceded by \code{P3_089(R)}\code{.txt} in which TAC was editing as late as the summer of 2016. The \code{P3_089(R).txt} comes to WHA via Julie E. Kiang (USGS, May 2016). This file should be considered TAC's canonical and last version for MGBT as it appears in the last set of algorithms TAC while he was working on development of a USGS-PeakFQ-like Bulletin 17C implementation in \R. As another historical note, file \code{P3_085_wha(R).txt} is preserved verbatim and was given to WHA at the end of November 2015 less than two weeks before TAC dismissed himself for health reasons from their collaboration on a cooperative research project of the USGS in cooperation with the U.S. Nuclear Regulatory Commission project (Asquith and others, 2017).

Because of a need for historical preservation, there is considerable excess and directly-unrelated code to MGBT and low-outlier identification in the aforementioned files though MGBT obviously is contained therein. In greater measure, much of the other code is related to the expected moments algorithm (EMA) for fitting the log-Pearson type III distribution to annual flood data. The \pkg{MGBT} package is purely organized around MGBT and related concepts in a framework suitable for more general application than the purposes of Bulletin 17C and thus the contents of the \code{P3_###(R).txt} series of files. \bold{It is, however, the prime objective of the \pkg{MGBT} package to be nearly plug in replacement for code presently (2017) bundled into \code{P3_###(R).txt} or derivative products.}

\bold{Note on Potential Bugs in Sources by TAC}---During the development phase of this package to stabilized that history left by TAC and other parts intimately known by JFE (co-author and contributor), several inconsistencies to even bugs manifested. First, there is the risk that the author (WHA) ported TAC-based \R to code in this package and introduced new problems. Second, there is a chance that TAC had errors and (or) WHA has misunderstood some idiom. Third, as examples herein show, there is (June 2017) a great deal of evidence that TAC incompletely ported from presumably earlier(?) FORTRAN that is used in USGS-PeakFQ software, which seems correct, to \R---very subtle issues. Fourth, WHA and GRH (contributor) in several very large batch processing tests (1,400+ time series of real-world peak streamflows) on Texas data pushed limits of \R numerics---These are discussed in detail as are WHA's compensating mechanisms. Several questions of bugs or edges of \R performance would be just minutes long conversations with TAC, but this is unfortunately not possible.

In short, it appears that several versions of MGBT by TAC in \R incorrectly \dQuote{swept out} from the median (\code{\link{MGBTcohn2016}} and \code{\link{MGBTcohn2013}}) and curiously a specific branch (\code{\link{MGBTnb}}) seems to fix that but caused a \dQuote{sweep in} problem from the first order statistic. Numerically, cases can be found triggering divergent integral warnings from \code{integrate()}---WHA compensated by adding a Monte Carlo integration backup. Numerically, cases can be found trigging numerical precision warnings from the cumulative distribution function of the t-distribution (\code{pt()})---WHA compensated by setting p-value to limiting small value (zero). Numerically, cases can be found triggering a square-root of negative number in \code{\link{peta}}---WHA compensates by effectively using a vanishingly small probability of the t-distribution. TAC's MGBT approach fails if all data values are equal---WHA compensates by returning a default result of a zero-value MGBT threshold. This complexity leads to a lengthy \bold{Examples} section here as well as in the \code{\link{MGBT}} function, and finally led WHA to leave herein several MGBT-focused algorithms.

\bold{Note on Mathematic Nomenclature}---On first development of this package, mathematics are largely shown in a port from the sources into a minimal structure for complete description of this package. TAC and others have published authoritative mathematics elsewhere. The primary author of this package (WHA), deliberately decided to build the \pkg{MGBT} package up from the TAC sources first.
}
\references{
Asquith, W.H., Kiang, J.E., and Cohn, T.A., 2017, Application of at-site peak-streamflow frequency analyses for very low annual exceedance probabilities: U.S. Geological Survey Scientific Investigation Report 2017--5038, 93 p., \url{https://doi.org/10.3133/sir20175038}.

Cohn, T.A., 2013--2016, Personal communication of original R source code: U.S. Geological Survey, Reston, Va.

Cohn, T.A., England, J.F., Berenbrock, C.E., Mason, R.R., Stedinger, J.R., and Lamontagne, J.R., 2013, A generalized Grubbs--Beck test statistic for detecting multiple potentially influential low outliers in flood series: Water Resources Research, v. 49, no. 8, pp. 5047--5058.

England, J.F., Cohn, T.A., Faber, B.A., Stedinger, J.R., Thomas Jr., W.O., Veilleux, A.G., Kiang, J.E., and Mason, R.R., 2017, Guidelines for determining flood flow frequency Bulletin 17C, U.S. Geological Survey Techniques and Methods, book 4, chap. 5.B, [in press]

Interagency Advisory Committee on Water Data (IACWD), 1982, Guidelines for determining flood flow frequency: Bulletin 17B of the Hydrology Subcommittee, Office of Water Data Coordination, U.S. Geological Survey, Reston, Va., 183 p.

U.S. Geological Survey (USGS), 2014, PeakFQ---Flood frequency analysis based on Bulletin 17B and recommendations of the Advisory Committee on Water Information (ACWI) Subcommittee on Hydrology (SOH) Hydrologic Frequency Analysis Work Group (HFAWG): Accessed May 25, 2017, at \url{https://water.usgs.gov/software/PeakFQ/}.

Veilleux, A.G., Cohn, T.A., Flynn, K.M., Mason, R.R., Jr., and Hummel, P.R., 2014, Estimating magnitude and frequency of floods using the PeakFQ 7.0 program: U.S. Geological Survey Fact Sheet 2013--3108, 2 p., \url{https://pubs.usgs.gov/fs/2013/3108/}.
}
\author{William H. Asquith (WHA) \email{wasquith@usgs.gov} }
\seealso{
   \code{\link{MGBT}}
}
\examples{
\dontrun{
# Peaks for 08165300 (1968--2016, systematic record only)
#https://nwis.waterdata.usgs.gov/nwis/peak?site_no=08385600&format=hn2
Peaks <- c(3200, 44, 5270, 26300, 1230, 55, 38400, 8710, 143, 23200, 39300, 1890,
  27800, 21000, 21000, 124, 21, 21500, 57000, 53700, 5720, 50, 10700, 4050, 4890, 1110,
  10500, 475, 1590, 26300, 16600, 2370, 53, 20900, 21400, 313, 10800, 51, 35, 8910,
  57.4, 617, 6360, 59, 2640, 164, 297, 3150, 2690)

MGBTcohn2016(Peaks)
#$klow
#[1] 24
#$pvalues
# [1] 0.8245714657 0.7685258183 0.6359392507 0.4473443285 0.2151390091 0.0795065159
# [7] 0.0206034851 0.0036001474 0.0003376923 0.0028133490 0.0007396869 0.0001427225
#[13] 0.0011045550 0.0001456356 0.0004178758 0.0004138897 0.0123954279 0.0067934260
#[19] 0.0161448464 0.0207025800 0.0483890616 0.0429628125 0.0152045539 0.0190853626
#$LOThresh
#[1] 3200

# ---***--------------***--- Note the mismatch ---***--------------***---
#The USGS-PeakFQ (v7.1) software reports:
#EMA003I-PILFS (LOS) WERE DETECTED USING MULTIPLE GRUBBS-BECK TEST  16    1110.0
#  THE FOLLOWING PEAKS (WITH CORRESPONDING P-VALUES) WERE CENSORED:
#            21.0    (0.8243)
#            35.0    (0.7680)
#            44.0    (0.6349)
#            50.0    (0.4461)      # Authors' note:
#            51.0    (0.2150)      # Note that the p-values from USGS-PeakFQv7.1 are
#            53.0    (0.0806)      # slightly different from those emanating from R,
#            55.0    (0.0218)      # which is thought to be from numerical issues.
#            57.4    (0.0042)
#            59.0    (0.0005)
#           124.0    (0.0034)
#           143.0    (0.0010)
#           164.0    (0.0003)
#           297.0    (0.0015)
#           313.0    (0.0003)
#           475.0    (0.0007)
#           617.0    (0.0007)
# ---***--------------***--- Note the mismatch ---***--------------***---

# There is a problem somewhere. Let us test each of the TAC versions available.
# Note that MGBTnb() works because the example peaks are ultimately a "sweep out"
# problem. MGBT17c() is a WHA fix to TAC algorithm, whereas, MGBT17c.verb() is
# a verbatim, though slower, WHA port of the written language in Bulletin 17C.
MGBTcohn2016(Peaks)$LOThres # LOT=3200  (WHA sees TAC problem with "sweep out".)
MGBTcohn2013(Peaks)$LOThres # LOT=16600 (WHA sees TAC problem with "sweep out".)
MGBTnb(Peaks)$LOThres       # LOT=1110  (WHA sees TAC problem with "sweep in". )
MGBT17c(Peaks)$index        # LOT=1110  (sweep indices: out=16, in=0)
MGBT17c.verb(Peaks)$index   # LOT=1110  (sweep indices: out=16, in=0)

# Let us now make a problem, which will have both "sweep in" and "sweep out"
# characteristics, and note the zero and unity outliers for the "sweep in" to grab.
Peaks <- c(0,1,Peaks)
MGBTcohn2016(Peaks)$LOThres # LOT=3150         ..ditto..
MGBTcohn2013(Peaks)$LOThres # LOT=16600        ..ditto..
MGBTnb(Peaks)$LOThres       # LOT=1110         ..ditto..
MGBT17c(Peaks)$index        # LOT=1110  (sweep indices: out=18, in=2)
MGBT17c.verb(Peaks)$index   # LOT=1110  (sweep indices: out=18, in=2)

#The USGS-PeakFQ (v7.1) software reports:
#    EMA003I-PILFS (LOS) WERE DETECTED USING MULTIPLE GRUBBS-BECK TEST  17    1110.0
#      THE FOLLOWING PEAKS (WITH CORRESPONDING P-VALUES) WERE CENSORED:
#               1 ZERO VALUES
#             1.0    (0.0074)
#            21.0    (0.4305)
#            35.0    (0.4881)
#            44.0    (0.3987)
#            50.0    (0.2619)
#            51.0    (0.1107)
#            53.0    (0.0377)
#            55.0    (0.0095)
#            57.4    (0.0018)
#            59.0    (0.0002)
#           124.0    (0.0018)
#           143.0    (0.0006)
#           164.0    (0.0002)
#           297.0    (0.0010)
#           313.0    (0.0002)
#           475.0    (0.0005)
#           617.0    (0.0005) #}
}
\keyword{Multiple Grubbs--Beck Test}
\keyword{Bulletin 17B}
\keyword{Bulletin 17C}
