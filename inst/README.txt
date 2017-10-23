This README file provides original source context to the MGBT package and other package design NOTES. These are partial notes and the man/MGBT-package.Rd is expected to contain much more information.


DIRECTORY inst/

FILE: COHN_MGBT_LowOutliers(R).txt

On or about August 21, 2013, Tim A. Cohn sent a file titled "COHN_MGBT_LowOutliers.R" to William H. Asquith. Asquith was needing the MGBT for a study of "modern periods of statitic flood flow regulation" through flood frequency computations on annual peak streamflow data for USACE Fort Worth. Asquith was using the method of L-moments, but wanted the MGBT as protection against some mixed population effects. This communication to Asquith appears to be 100 percent independent of from Cohn's personal R code base related to the Expected Moments Algorithm (EMA) and Bulletin 17C (log-Pearson type III distribution). This file has been retitled so R will not complain on R CMD check when a .R file exits in the inst/ directory. Asquith's design of R packages is to break as much code into separate .R files as possibly (logically) and generally have about a one-to-one pairing of .Rd files. Cohn has many functions related to low-outliers in his code base, but many are not directly related to MGBT for purposes of implementation.  All of these are ported into the MGBT package and documented. It is clear that Cohn shared functions with Asquith that are not available in P3_089(R).txt.

FILE: P3_089(R).txt

On May 16, 2017, Julie E. Kiang sent was she believes to be Cohn's master .R file of the EMA-17C code. Within which separate "MGBT" functions from the Asquith communication appear present. Tim's short comments indicate changes as late as June 28, 2016. These are left currently left intact. The MGBT package will first pass into maturity as CRAN-compliant through Cohn's communication to Asquith and then port evidently Cohn's later developments. Asquith suggests appending "2013" to the original functions (e.g. MGBT.2013) given to Asquith and eventually use "MGBT()" as the canonical version as embedded into 17C.

FILE: tim-low-outliers-2010-notes.pdf

John F. England visited Reston, VA (USGS HQ) in Spring 2017 after Tim's passing. He scanned Cohn's personal note books. One is titled "Tim Cohn Low Outliers" and is 33 pages of mathematical notes. Cohn within COHN_MGBT_LowOutliers(R).txt describes "Orthogonal evaluation of p-value" via "mathematical notes dated December 16, 2009" as spanning 39 pages and that these are "not for the faint of heart ;-)" This note is not found in P3_089(R).txt. It does not appear that the 33 pages scanned are the 39 pages referenced.

