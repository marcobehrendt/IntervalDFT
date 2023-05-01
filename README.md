# The interval discrete Fourier transform

This repository provides two methods that can be used to propagate interval uncertainty through the discrete Fourier transform. The *interval extension* provides an approximation of the DFT of an interval signal, while the *selective algorithm* yields the exact bounds on the Fourier amplitude and an estimation of the Power Spectral Density function. Both algorithms apply to real sequences of intervals. These methods allow technical analysts to project interval uncertainty present in the time signals to their Fourier amplitude without making assumptions about the error distribution at each time step. Thus, it is possible to calculate and analyse system responses in the frequency domain without conducting extensive Monte Carlo simulations in the time domain.

*Disclaimer:* This code was developed for illustration purposes and for proof-of-concept. Thus, this code is not optimised for large-scale applications.

## References
**Behrendt, M.; de Angelis, M.; Comerford, L.; Zhang, Y,; Beer, M. (2022):** Projecting interval uncertainty through the discrete Fourier transform: an application to time signals with poor precision, Mechanical Systems and Signal Processing, 172, Article 108920, DOI: [10.1016/j.ymssp.2022.108920](https://doi.org/10.1016/j.ymssp.2022.108920).

**Behrendt, M.; de Angelis, M.; Beer, M. (2023):** Uncertainty propagation of missing data signals with the interval discrete Fourier transform, ASCE-ASME Journal of Risk and Uncertainty in Engineering Systems, Part A: Civil Engineering, DOI: [10.1061/AJRUA6/RUENG-1048](https://doi.org/10.1061/AJRUA6/RUENG-1048).


## Computing the interval DFT of an interval signal
To calculate the interval DFT and an estimate of the interval PSD, the file `main_interval_DFT.m` can be used. The file loads an example signal, converts it into an interval signal and calculates the interval DFT and an estimate of the interval PSD with the interval extension as well as with the selective algorithm. 

## Application to missing data signals
The algorithms allow signals with missing data to be transformed into the frequency domain, taking into account the existing uncertainties. Running the file `main_missing_data.m` will illustrate this example. A simple reconstruction method is used to replace the missing data with intervals. The resulting interval signal is then transformed into the frequency domain via interval extension and the selective algorithm. 