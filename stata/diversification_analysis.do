* Start log file
capture log close
log using diversification_analysis.txt, text replace

*** DESCRIPTIVE STATISTICS ***
* Load and describe dataset
import delimited "data/sa_diversification_1990_2021.csv", clear
*remove additional variables
drop v7-v36
describe 

* Declare Time-Series
tsset year

* generate Non-Oil GDP share of total GDP
gen div = services + industry

* Descriptive Statistics
summarize oil_rents div fdi 
summarize oil_rents div fdi if vision2030 == 0 //pre-policy
summarize oil_rents div fdi if vision2030 == 1 // post-policy

log close

log using diversification_analysis.txt, text append

* Generate log variables for the Log-Log (Elasticity) model
gen ln_fdi = log(fdi + 2)
gen ln_oil = log(oil_rents)
gen ln_services = log(services)
gen ln_industry = log(industry)
gen ln_div = log(div)

*** REGRESSION ANALYSIS ***

* Standard OLS Regression
regress div oil_rents fdi vision2030
predict r_linear, residuals // Generate residuals for diagnostic testing

* Log-Log Model
regress ln_div ln_oil ln_fdi vision2030

*** DIAGNOSTIC TESTS ***

* Test for first-order autocorrelation
estat dwatson

* Test for higher-order autocorrelation
estat bgodfrey, lags(1 2 3 4)

* Testing for Heteroskedasticity
estat hettest

*** ROBUSTNESS CHECKS ***

* HAC Standard Errors
regress div oil_rents fdi vision2030, vce(hac nwest 2)

* Structual Break Analysis
regress div oil_rents vision2030 c.fdi#i.vision2030

* 2SLS Regression
ivregress 2sls div oil_rents vision2030 (fdi = L.fdi), first 

* Post-Estimation
estat firststage // Check if instrument is weak

* Chow Test for Structural Break
regress div oil_rents services industry fdi if year < 2016
scalar rss_pre = e(rss)
regress div oil_rents services industry fdi if year >= 2016
scalar rss_post = e(rss)
regress div oil_rents services industry fdi // Pooled model
scalar rss_pooled = e(rss)

* Calculate Chow F-stat
display ((rss_pooled - (rss_pre + rss_post)) / 5) / ((rss_pre + rss_post) / (_N - 10))

log close

log using diversification_analysis.txt, text append

log close
