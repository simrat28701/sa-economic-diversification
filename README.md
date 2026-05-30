# Economic Diversification in Saudi Arabia: The Role of Oil Rents, FDI, and Vision 2030

**Author:** Simrat Kaur Khalsa  
**Institution:** University of Kent  
**Module:** ECON7007 — Sustainable Growth and Environmental Valuation  
**Date:** March 2026  
**SSRN:** *(link to be added upon publication)*

---

## Overview

This repository contains all materials for the working paper *"Economic Diversification in Saudi Arabia: The Role of Oil Rents, FDI, and Vision 2030"*, including the dataset, Stata analysis code and log, LaTeX source, and compiled PDF.

The paper examines the drivers of economic diversification in Saudi Arabia over the period 1990–2021 using time-series econometric methods. The central findings are:

- **Oil rents** have a positive and statistically significant effect on diversification, supporting the *resource blessing* hypothesis
- **Vision 2030** is associated with a significant upward level shift in the diversification index since 2016
- **FDI** remains statistically insignificant across all specifications, suggesting foreign capital has not yet become a primary driver of structural change

---

## Repository Structure

```
sa-economic-diversification/
│
├── data/
│   └── sa_diversification_1990_2021.csv      # World Bank dataset (1990–2021)
│
├── latex/
│   ├── saudi_report.tex                       # LaTeX source
│   ├── saudi_references.bib                   # BibTeX bibliography
│   └── figures/
│       ├── sa_fig1_gdp_sectors.png            # GDP by sector time-series plot
│       └── sa_fig2_residuals.png              # Residuals vs. fitted values plot
│
├── output/
│   └── saudi_diversification_report.pdf       # Final compiled paper
│
├── stata/
│   ├── diversification_analysis.do            # Stata analysis script
│   └── diversification_analysis.txt           # Stata log file
│
├── README.md
└── LICENSE
```

---

## Data

The dataset was compiled from the **World Bank World Development Indicators** and covers Saudi Arabia from 1990 to 2021.

| Variable | Description |
|---|---|
| `Year` | Year (1990–2021) |
| `Oil_Rents` | Oil rents as % of GDP |
| `Services` | Services value added as % of GDP |
| `Industry` | Industry value added as % of GDP |
| `FDI` | Net FDI inflows as % of GDP |
| `Vision2030` | Binary dummy: 0 = pre-2016, 1 = 2016–2021 |

> **Note:** The variable `div` (non-oil share of GDP) is generated in the Stata script as `div = Services + Industry`.

**Dataset also available on Kaggle:**  
[https://www.kaggle.com/datasets/simratkhalsa287/sa-economic-diversification-1990-2021-world-bank](https://www.kaggle.com/datasets/simratkhalsa287/sa-economic-diversification-1990-2021-world-bank)

---

## Methods

The following econometric methods are used:

- **OLS regression** — baseline and log-log (elasticity) specifications
- **Diagnostic testing** — Durbin-Watson, Breusch-Godfrey (serial correlation), Breusch-Pagan (heteroskedasticity)
- **HAC standard errors** (Newey-West, 2 lags) to correct for autocorrelation
- **Interaction analysis** — tests whether Vision 2030 altered the FDI–diversification slope
- **2SLS / IV estimation** — addresses potential endogeneity in FDI using L1.fdi as instrument
- **Chow Test** — tests for structural break in all parameters at the 2016 threshold

---

## Reproducing the Analysis

1. Open Stata and set the working directory to the root of this repository
2. Run `stata/diversification_analysis.do`
3. The log output will be saved to `stata/diversification_analysis.txt`

To recompile the PDF from LaTeX source, run from the `latex/` folder:

```bash
pdflatex saudi_report.tex
bibtex saudi_report
pdflatex saudi_report.tex
pdflatex saudi_report.tex
```

---

## Citation

If you use this paper or dataset, please cite:

> Khalsa, S.K. (2026) *Economic Diversification in Saudi Arabia: The Role of Oil Rents, FDI, and Vision 2030*. University of Kent. Available at SSRN: *(link to be added)*

**Dataset:**
> Khalsa, S.K. (2026) *Saudi Arabia Economic Diversification Dataset, 1990–2021 (World Bank)*. Kaggle. Available at: https://www.kaggle.com/datasets/simratkhalsa287/sa-economic-diversification-1990-2021-world-bank

---

## License

Code (`stata/`) is licensed under the [MIT License](LICENSE).  
Written content and data are licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
