# Returns to Education Using Instrumental Variables (IV)

This repository contains a replication-style empirical project examining the causal relationship between **education and income** in Indonesia using an **Instrumental Variable (IV)** approach.

The project is developed as part of a graduate-level econometrics course and serves as a methodological portfolio demonstrating applied microeconometric analysis and causal inference.

## Project Overview
Education is potentially endogenous due to omitted variables such as ability and family background.  
To address this issue, the analysis implements an IV strategy using **month of birth** as an instrument for years of schooling, following the seminal approach of Angrist and Krueger (1991).

The empirical framework is aligned with studies on returns to education in Indonesia, particularly:
- Purnastuti (2013), *Instrumenting Education and Returns to Schooling in Indonesia*

## Methodology
- Ordinary Least Squares (OLS) estimation
- Instrumental Variable (IV) regression
- Endogeneity assessment
- Comparison between OLS and IV estimates

## Data
- Individual-level microdata (IFLS 5)
- Access to raw data is restricted and therefore **not included** in this repository
- All scripts assume that data access complies with IFLS usage regulations

## Repository Structure
- `01_setup/` : Data preparation and variable construction  
- `02_estimation/` : OLS and IV estimation scripts  
- `outputs/` : Tables or figures generated from the analysis (to be added)

## Project Status
This repository is a **work in progress**.  
The full estimation, robustness checks, and interpretation will be developed incrementally.

## Notes
- This project is intended for **academic and educational purposes**
- Results should not be interpreted as definitive policy conclusions
- Emphasis is placed on econometric reasoning, identification, and transparency

## Author
Chairunnisa Yulfianti  
Graduate Student in Economics  
Universitas Indonesia
---
