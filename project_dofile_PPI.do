clear all

cd "C:\Users\GIDEON\Documents\GIDEONSFILE\UniversityofSussex\DESERTATION_DATA"

import exc using Project_Data_file2_edited.xlsx, firstrow

xtset id Year

*RENAME
rename SubsidiesUSD SUB_percent_GDP
rename Lending_Interest_rate_Percent LIR
rename change_GDP_per_capita GDP_per_capita
rename Money_Supply_Broad_Money_Percent MS_percent_GDP
rename unem_percent_lf UNEMP

*LOG FORM
gen ln_GDP_per_capita = log(GDP_per_capita)
replace ln_GDP_per_capita = ln_GDP_per_capita[_n-1] if missing(ln_GDP_per_capita)

gen ln_Change_PPI = log(Change_PPI)
replace ln_Change_PPI = ln_Change_PPI[_n-1] if missing(ln_Change_PPI)

gen ln_HCPI = log(HCPI)
replace ln_HCPI = ln_HCPI[_n-1] if missing(ln_HCPI)

gen ln_Change_PPI_ = log(Change_PPI_)
replace ln_Change_PPI_ = ln_Change_PPI_[_n-1] if missing(ln_Change_PPI_)


gen ln_Change_HCPI = log(Change_HCPI)
replace ln_Change_HCPI = ln_Change_HCPI[_n-1] if missing(ln_Change_HCPI)

gen ln_SUB_percent_GDP = log(SUB_percent_GDP)
replace ln_SUB_percent_GDP = ln_SUB_percent_GDP[_n-1] if missing(ln_SUB_percent_GDP)

gen ln_MS_percent_GDP = log(MS_percent_GDP)
replace ln_MS_percent_GDP = ln_MS_percent_GDP[_n-1] if missing(ln_MS_percent_GDP)


gen ln_LIR = log(LIR)
replace ln_LIR = ln_LIR[_n-1] if missing(ln_LIR)

gen ln_UNEMP = log(UNEMP)
replace ln_UNEMP = ln_UNEMP[_n-1] if missing(ln_UNEMP)


ssc install xtpmg
help install xtpmg

*...........................DESCRIPTIVE AND SUMMARY STATISTICS....................
xtsum Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
sum Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
xtsum Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
sum PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP


 
twoway (scatter ln_nge ln_percent_GDP, sort mlabel(Country))
twoway (scatter Change_HCPI SUB_percent_GDP, sort mlabel(Country))
twoway (scatter ln_Change_PPI ln_SUB_percent_GDP, sort mlabel(Country)), ///
    title("Subsidies VS Change in PPI (2002 - 2021)")
	 Subsidies VS Change in HCPI
	 VS
twoway (scatter ln_Change_HCPI ln_SUB_percent_GDP, sort mlabel(Country)), ///
	title("Subsidies VS Change in HCPI (2002 - 2021)")

xtsum Change_PPI_ SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
sum Change_PPI_ SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
xtsum Change_PPI_ SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP

*.........................VISUALIZATION...................
tsline Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP, by(id)
tsline Change_PPI_ SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP, by(id)

tsline Change_PPI_ SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP, by(Country)

tsline Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP, by(Country)

twoway scatter Change_PPI SUB_percent_GDP if Country == "Lithunaia", ///
	xlabel(0(100)500)///
	ylabel(0(50)100)///
    title("Impact of Subsidies on change in PPI for Lithuania") ///
    xtitle("Subsidies") ytitle("Changes in PPI")


*........CORRELATION...............
corr Change_PPI SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP
corr Change_PPI_ SUB_percent_GDP LIR GDP_per_capita MS_percent_GDP



*.....................UNIT ROOT TEST(Im-Pesaran-Shin Test(IPS))................
xtunitroot ips ln_Change_PPI, lags(1)
//Series is stationary at level
xtunitroot ips Change_PPI, lags(1)
//Series is stationary at level

xtunitroot ips Change_ln_HCPI, lags(1)

xtunitroot ips ln_PPI, lags(1)

ln_Change_HCPI

xtunitroot ips Change_PPI_, lags(1)
//Series is stationary at level

xtunitroot ips ln_Change_PPI_, lags(1)
//Series is stationary at level

xtunitroot ips UNEMP, lags(1)
//series is non-stationary at level

xtunitroot ips ln_UNEMP, lags(1)
//series is non-stationary at level

xtunitroot ips SUB_percent_GDP, lags(1)
//series is non-stationary at level
xtunitroot ips ln_SUB_percent_GDP, lags(1)
//series is stationary at level
xtunitroot ips GDP_per_capita, lags(1)
//series is stationary at level

xtunitroot ips ln_GDP_per_capita, lags(1)
//series is stationary at level

ln_GDP_per_capita
xtunitroot ips LIR, lags(1)
//series is non-stationary at level

xtunitroot ips ln_LIR, lags(1)
ln_LIR

xtunitroot ips ln_MS_percent_GDP, lags(1)
//series is non-stationary at level
xtunitroot ips MS_percent_GDP, lags(1)
//series is non-stationary at level

*We take the first difference of the non-stationary variable- SUB_percent_GDP
xtunitroot ips d.LIR, lags(1)
// Series is stationary @ 1st difference

xtunitroot ips d.ln_LIR, lags(1)
// Series is stationary @ 1st difference

xtunitroot ips d.ln_MS_percent_GDP, lags(1)
// Series is stationary @ 1st difference
xtunitroot ips d.MS_percent_GDP, lags(1)
// Series is stationary @ 1st difference
xtunitroot ips d.UNEMP, lags(1)
// Series is stationary @ 1st difference
xtunitroot ips d.ln_UNEMP, lags(1)
// Series is stationary @ 1st difference

*WE CAN PERFORM THIS TEST USING TREND

xtunitroot ips ln_Change_PPI, trend lags(1)
//Series is stationary at level
xtunitroot ips Change_PPI, trend lags(1)
//Series is stationary at level
xtunitroot ips SUB_percent_GDP, trend lags(1)
//series is non-stationary at level
xtunitroot ips GDP_per_capita, trend lags(1)
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
*xtunitroot ips d.D1_ln_MS_percent_GDP, trend lags(1)
//series is stationary at 2nd difference

*gen D1_MS_percent_GDP = d.MS_percent_GDP
*xtunitroot ips d.D1_MS_percent_GDP, trend lags(1)
//series is stationary at 2nd difference

*.....................UNIT ROOT TEST(Levin-Lin-Chiu (LLC))................
*xtunitroot llc Change_HCPI, lags(1)
//Series is stationary at level
*xtunitroot llc ln_Change_PPI, lags(1)
//Levin-Lin-Chiu test requires strongly balanced data

xtunitroot llc ln_Change_PPI, lags(1)

Change_ln_HCPI

xtunitroot llc Change_ln_HCPI, lags(1)


xtunitroot llc ln_PPI, lags(1)

xtunitroot llc SUB_percent_GDP, lags(1)
//Series is stationary at level

xtunitroot llc ln_SUB_percent_GDP, lags(1)


xtunitroot llc GDP_per_capita, lags(1)
//Series is stationary at level

xtunitroot llc ln_GDP_per_capita, lags(1)
//Series is stationary at level


xtunitroot llc LIR, lags(1)

xtunitroot llc ln_LIR, lags(1)

//Series is stationary at level
xtunitroot llc ln_MS_percent_GDP, lags(1)
//Series is stationary at level
xtunitroot llc MS_percent_GDP, lags(1)
//Series is non-stationary at level

*We take the first difference of the non-stationary variable- MS_percent_GDP
xtunitroot llc d.MS_percent_GDP, lags(1)

xtunitroot llc d.ln_LIR, lags(1)


forval i =1/5{
ardl ln_Change_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita ln_MS_percent_GDP if (id == `i'), maxlag(1 1 1 1 1)
matrix list e(lags)
di
}



*...................COINTEGRATION TEST..........................
xtpedroni Change_PPI SUB_percent_GDP LIR GDP_per_capita ln_MS_percent_GDP, nopdols
xtpedroni Change_PPI_ SUB_percent_GDP LIR GDP_per_capita ln_MS_percent_GDP, nopdols
xtpedroni Change_HCPI SUB_percent_GDP LIR GDP_per_capita ln_MS_percent_GDP, nopdols




1 1 1 1 1
*................OPTIMAL LAG LENGTH..........................
L(0/1).d.ln_Change_HCPI

l.ln_Change_HCPI
L(0/1).d.ln_MS_percent_GDP

L(0/1).d.ln_Change_PPI
l.ln_MS_percent_GDP
d.ln_Change_PPI L(0/1).d.ln_Change_PPI

xtpmg d.ln_PPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita d.ln_MS_percent_GDP, lr(ln_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita ln_MS_percent_GDP) ec(ECT) replace mg
xtpmg d.ln_PPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita d.ln_MS_percent_GDP, lr(ln_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita ln_MS_percent_GDP) ec(ECT) replace pmg
hausman mg pmg, sigmamore


xtpmg d.ln_Change_PPI L(0/1).d.ln_Change_PPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita L(0/1).d.ln_MS_percent_GDP, lr(l.ln_Change_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita l.ln_MS_percent_GDP) ec(ECT) replace mg
xtpmg d.ln_Change_PPI L(0/1).d.ln_Change_PPI d.ln_SUB_percent_GDP d.ln_LIR d.ln_GDP_per_capita L(0/1).d.ln_MS_percent_GDP, lr(l.ln_Change_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita l.ln_MS_percent_GDP) ec(ECT) replace pmg
hausman mg pmg, sigmamore





}
forval i =1/5{
ardl ln_Change_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita ln_MS_percent_GDP if (id == `i'), maxlag(1 1 1 1 1)
matrix list e(lags)
di
}




forval i =1/5{
ardl ln_Change_PPI ln_SUB_percent_GDP ln_UNEMP ln_LIR ln_MS_percent_GDP if (id == `i'), maxlag(1 1 1 1 1) aic
matrix list e(lags)
di
}



forval i =1/5{
ardl ln_Change_PPI ln_SUB_percent_GDP ln_LIR ln_GDP_per_capita ln_MS_percent_GDP if (id == `i'), maxlag(1 1 1 1 1) aic
matrix







forval i =1/5{
ardl ln_HCPI ln_SUB_percent_GDP ln_UNEMP ln_LIR ln_MS_percent_GDP if (id == `i'), maxlag(1 1 1 1 1) aic
matrix list e(lags)
di
}



*.................PERFORM HAUSMAN (1978) TEST...............
*To determine the most appropriate estimator either 'pmg' or 'mg' using Hausman test
xtpmg d.ln_Change_PPI d.ln_SUB_percent_GDP d.ln_UNEMP d.ln_LIR d.ln_MS_percent_GDP, lr(l.ln_Change_PPI ln_SUB_percent_GDP ln_UNEMP l.ln_LIR l.ln_MS_percent_GDP) ec(ECT) replace mg
xtpmg d.ln_Change_PPI d.ln_SUB_percent_GDP d.ln_UNEMP d.ln_LIR d.ln_MS_percent_GDP, lr(l.ln_Change_PPI ln_SUB_percent_GDP ln_UNEMP l.ln_LIR l.ln_MS_percent_GDP) ec(ECT) replace pmg
hausman mg pmg, sigmamore

*To determine the most appropriate estimator either 'dfe' or 'pmg' using Hausman test
xtpmg Change_PPI d.SUB_percent_GDP d.LIR GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_PPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace dfe
xtpmg Change_PPI d.SUB_percent_GDP d.LIR GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_PPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace pmg
hausman DFE pmg, sigmamore

*To determine the most appropriate estimator either 'dfe' or 'mg' using Hausman test
xtpmg Change_PPI d.SUB_percent_GDP d.LIR GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_PPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace dfe
xtpmg Change_PPI d.SUB_percent_GDP d.LIR GDP_per_capita d.D1_MS_percent_GDP, lr(l.Change_PPI SUB_percent_GDP LIR ln_GDP_per_capita MS_percent_GDP) ec(ECT) replace mg
hausman DFE mg, sigmamore

*.....................ESTIMTE THE MODEL(S).....................................
ARDL(1 0 0 1 1)
xtpmg d.ln_Change_PPI d.ln_SUB_percent_GDP d.ln_UNEMP d.ln_LIR d.ln_MS_percent_GDP, lr(l.ln_Change_PPI ln_SUB_percent_GDP ln_UNEMP l.ln_LIR l.ln_MS_percent_GDP) ec(ECT) replace pmg
xtpmg d.ln_Change_PPI d.ln_SUB_percent_GDP d.ln_UNEMP d.ln_LIR d.ln_MS_percent_GDP, lr(l.ln_Change_PPI ln_SUB_percent_GDP ln_UNEMP l.ln_LIR l.ln_MS_percent_GDP) ec(ECT) replace pmg full 



xtpmg d.ln_HCPI d.ln_SUB_percent_GDP d.ln_UNEMP d.ln_LIR d.ln_MS_percent_GDP, lr(l.ln_HCPI l.ln_SUB_percent_GDP ln_UNEMP ln_LIR l.ln_MS_percent_GDP) ec(ECT) replace mg
xtpmg d.ln_HCPI d.ln_SUB_percent_GDP d.ln_UNEMP d.ln_LIR d.ln_MS_percent_GDP, lr(l.ln_HCPI l.ln_SUB_percent_GDP ln_UNEMP ln_LIR l.ln_MS_percent_GDP) ec(ECT) replace pmg
hausman mg pmg, sigmamore


save project_dofile_PPI, replace
