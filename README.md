
# Production Subsidies: Its Impact on Producer and Consumer Price Index

This project explores the empirical relationship between production subsidies and inflation dynamics, measured via the Producer Price Index (PPI) and Headline Consumer Price Index (HCPI), in five countries: Lithuania, Morocco, South Africa, the United Kingdom, and the United States. It was developed as part of an MSc dissertation in Development Economics at the University of Sussex.

## Project Overview

Governments often deploy production subsidies as part of fiscal policy to stimulate output and manage inflation. This project investigates both the short-run and long-run effects of such subsidies on producer and consumer prices using panel data from 2002 to 2021.

### Key Questions

- Do production subsidies significantly affect producer prices?
- Is there a pass-through effect of production subsidies on consumer prices?
- How do these relationships vary across countries and over time?

## Methodology

- **Data Sources**: World Bank (WDI), OECD, FRED, CEIC
- **Countries Studied**: Lithuania, Morocco, South Africa, United Kingdom, United States
- **Econometric Model**: Panel Autoregressive Distributed Lag (ARDL)
- **Estimation Strategy**: Pooled Mean Group (PMG) estimator selected via Hausman test
- **Key Variables**:
  - PPI (Producer Price Index)
  - HCPI (Headline Consumer Price Index)
  - Production Subsidies (% of GDP)
  - Lending Interest Rate
  - Unemployment Rate
  - Money Supply

## Findings

- **Long-Run Impact**: Production subsidies have a statistically significant positive impact on both PPI and HCPI, suggesting that over time, they may contribute to inflationary pressure.
- **Short-Run Dynamics**: Vary across countries. For instance:
  - In **Lithuania**, subsidies reduce PPI in the short run.
  - In **South Africa**, subsidies increase PPI significantly.
  - Pass-through effects to consumer prices are evident but modest in magnitude.

## Repository Contents

- `project_dofile_PPI.do`: STATA script analyzing the impact on Producer Price Index.
- `project_dofile_HCPI.do`: STATA script analyzing the impact on Headline Consumer Price Index.


## How to Run

1. Open STATA.
2. Load each `.do` file as needed (`project_dofile_PPI.do` or `project_dofile_HCPI.do`).
3. Execute the scripts to replicate the analysis.

> Note: Ensure all required datasets and STATA packages are available in your environment.

## License

This project is made available for academic and non-commercial use only. Please cite the author if used in derivative work.

## Acknowledgements

Supervised by **Prof. Richard Tol**, University of Sussex.
