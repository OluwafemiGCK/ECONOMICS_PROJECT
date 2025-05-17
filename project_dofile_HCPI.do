clear all

cd "C:\Users\GIDEON\Documents\GIDEONSFILE\UniversityofSussex\DESERTATION_DATA"

import exc using Project_Data_file2_edited.xlsx, firstrow

xtset id Year

*RENAME
rename SubsidiesUSD_Percent_of_GDP SUB_percent_GDP
rename Lending_Interest_rate_Percent LIR
rename change_GDP_per_capita GDP_per_capita
rename Money_Supply_Broad_Money_Percent MS_percent_GDP

*LOG FORM
gen ln_GDP_per_capita = log(GDP_per_capita)
replace ln_GDP_per_capita = ln_GDP_per_capita[_n-1] if missing(ln_GDP_per_capita)

gen ln_Change_PPI = log(Change_PPI)
replace ln_Change_PPI = ln_Change_PPI[_n-1] if missing(ln_Change_PPI)

gen ln_Change_HCPI = log(Change_HCPI)
replace ln_Change_HCPI = ln_Change_HCPI[_n-1] if missing(ln_Change_HCPI)

gen ln_SUB_percent_GDP = log(SUB_percent_GDP)
replace ln_SUB_percent_GDP = ln_SUB_percent_GDP[_n-1] if missing(ln_SUB_percent_GDP)

gen ln_MS_percent_GDP = log(MS_percent_GDP)
replace ln_MS_percent_GDP = ln_MS_percent_GDP[_n-1] if missing(ln_MS_percent_GDP)

gen ln_LIR = log(LIR)
replace ln_LIR = ln_LIR[_n-1] if missing(LIR)

gen ln_Change_HCPI_ = log(Change_HCPI_)
replace ln_Change_HCPI_ = ln_Change_HCPI_[_n-1] if missing(Change_HCPI_)


ssc install xtpmg

*...........................DESCRIPTIVE AND SUMMARY STATISTICS....................

xtsum Change_HCPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
sum Change_HCPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
sum Change_HCPI Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP if Country=="United States"

*.........................VISUALIZATION...................
tsline Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP, by(id)


*........CORRELATION ANALYSIS...............
corr Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP



*.....................UNIT ROOT TEST(Im-Pesaran-Shin Test(IPS))................
xtunitroot ips ln_Change_HCPI, lags(1)
//Series is stationary at level
xtunitroot ips Change_HCPI, lags(1)
//Series is stationary at level
xtunitroot ips SUB_percent_GDP, lags(1)
//series is non-stationary at level
xtunitroot ips ln_GDP_per_capita, lags(1)
//series is stationary at level
xtunitroot ips LIR, lags(1)
//series is non-stationary at level
xtunitroot ips ln_MS_percent_GDP, lags(1)
//series is non-stationary at level
xtunitroot ips MS_percent_GDP, lags(1)
//series is non-stationary at level

*We take the first difference of the non-stationary variable- SUB_percent_GDP
xtunitroot ips d.SUB_percent_GDP, lags(1)
// Series is stationary @ 1st difference
xtunitroot ips d.LIR, lags(1)
// Series is stationary @ 1st difference
xtunitroot ips d.ln_MS_percent_GDP, lags(1)
// Series is non-stationary @ 1st difference
xtunitroot ips d.MS_percent_GDP, lags(1)
// Series is non-stationary @ 1st difference

*We take the second difference of the non-stationary first-differenced variable - SUB_percent_GDP
gen D1_ln_MS_percent_GDP = d.ln_MS_percent_GDP
xtunitroot ips d.D1_ln_MS_percent_GDP, lags(1)
//series is stationary at 2nd difference

gen D1_MS_percent_GDP = d.MS_percent_GDP
xtunitroot ips d.D1_MS_percent_GDP, lags(1)
//series is stationary at 2nd difference


*WE CAN PERFORM THIS TEST USING TREND

xtunitroot ips ln_Change_HCPI, trend lags(1)
//Series is stationary at level
xtunitroot ips Change_HCPI, trend lags(1)
//Series is stationary at level
xtunitroot ips SUB_percent_GDP, trend lags(1)
//series is non-stationary at level
xtunitroot ips ln_GDP_per_capita, trend lags(1)
//series is stationary at level
xtunitroot ips LIR, trend lags(1)
//series is stationary at level
xtunitroot ips ln_MS_percent_GDP, trend lags(1)
//series is non-stationary at level
xtunitroot ips MS_percent_GDP, trend lags(1)
//series is non-stationary at level

*We take the first difference of the non-stationary variable- SUB_percent_GDP
xtunitroot ips d.SUB_percent_GDP, trend lags(1)
//series is non-stationary 1st difference
xtunitroot ips d.ln_MS_percent_GDP, trend lags(1)
//series is non-stationary 1st difference
xtunitroot ips d.MS_percent_GDP, trend lags(1)
//series is non-stationary 1st difference

*We take the second difference of the non-stationary first-differenced variable - SUB_percent_GDP
gen D1_SUB_percent_GDP = d.SUB_percent_GDP
xtunitroot ips d.D1_SUB_percent_GDP, trend lags(1)
//series is stationary at 2nd difference

*gen D1_ln_MS_percent_GDP = d.ln_MS_percent_GDP
xtunitroot ips d.D1_ln_MS_percent_GDP, trend lags(1)
//series is stationary at 2nd difference

*gen D1_MS_percent_GDP = d.MS_percent_GDP
xtunitroot ips d.D1_MS_percent_GDP, trend lags(1)
//series is stationary at 2nd difference

*.....................UNIT ROOT TEST(Levin-Lin-Chiu (LLC))................
*xtunitroot llc ln_Change_HCPI, lags(1)
//Levin-Lin-Chiu test requires strongly balanced data
xtunitroot llc Change_HCPI, lags(1)
//Series is stationary at level
xtunitroot llc SUB_percent_GDP, lags(1)
//Series is stationary at level
xtunitroot llc ln_GDP_per_capita, lags(1)
//Series is stationary at level
xtunitroot llc LIR, lags(1)
//Series is stationary at level
xtunitroot llc ln_MS_percent_GDP, lags(1)
//Series is stationary at level



forval i =1/5{
ardl Change_HCPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP if (id == `i'), maxlag(1 1 1 1 1)
matrix list e(lags)
di
}


*...................COINTEGRATION TEST..........................
*xtpedroni Change_PPI SUB_percent_GDP LIR ln_GDP_per_capita ln_MS_percent_GDP, nopdols
xtpedroni Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita ln_MS_percent_GDP, nopdols



*.................PERFORM HAUSMAN (1978) TEST...............
*To determine the most appropriate estimator either 'pmg' or 'mg' using Hausman test
xtpmg d.ln_Change_HCPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita d.ln_MS_percent_GDP, lr(l.ln_Change_HCPI l.ln_SUB_percent_GDP l.ln_LIR ln_GDP_per_capita l.ln_MS_percent_GDP) ec(ECT) replace mg
xtpmg d.ln_Change_HCPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita d.ln_MS_percent_GDP, lr(l.ln_Change_HCPI l.ln_SUB_percent_GDP l.ln_LIR ln_GDP_per_capita l.ln_MS_percent_GDP) ec(ECT) replace pmg
hausman mg pmg, sigmamore

*To determine the most appropriate estimator either 'dfe' or 'pmg' using Hausman test
xtpmg Change_HCPI d.SUB_percent_GDP d.LIR ln_GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace dfe
xtpmg Change_HCPI d.SUB_percent_GDP d.LIR ln_GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace pmg
hausman DFE pmg, sigmamore

*To determine the most appropriate estimator either 'dfe' or 'mg' using Hausman test
xtpmg Change_HCPI d.SUB_percent_GDP d.LIR ln_GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace dfe
xtpmg Change_HCPI d.SUB_percent_GDP d.LIR ln_GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace mg
hausman DFE mg, sigmamore

*.....................ESTIMTE THE MODEL(S).....................................
xtpmg d.ln_Change_HCPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita d.ln_MS_percent_GDP, lr(l.ln_Change_HCPI l.ln_SUB_percent_GDP l.ln_LIR ln_GDP_per_capita l.ln_MS_percent_GDP) ec(ECT) replace pmg
xtpmg Change_HCPI d.SUB_percent_GDP d.LIR ln_GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_HCPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace pmg full

save project_dofile_HCPI, replace
