# MLR USER'S MANUAL (0.0.0) 
- - -

---
Reference: MLR_User_Manual  
Release date: 2026  
Author: Zhenqi Luo  
---

## Content

**[I. Interactive Effects of Structure, Parameter, and Subgrid Heterogeneity on Modeling Solar-induced Chlorophyll Fluorescence (SIF)**](#I-Interactive-Effects-of-Structure-Parameter-and-Subgrid-Heterogeneity-on-Modeling-Solar-induced-Chlorophyll-Fluorescence (SIF))      
**II. MLR model**  
**III. MLR functionalities and scales**    
_**III.1 Leaf-level MLR model**_  
_**III.2 Canopy-level MLR model**_  
[**Annex 1: Abbreviations**](#Annex-1-Abbreviations)  

Mechanistic light reaction (MLR) describes the mechanistic relationship among three sets of unknowns: solar-induced chlorophyll fluorescence (SIF), the actual electron transport rate (Ja) or photochemical quantum yield (ΦP), and non-photochemical quenching (NPQ) (or the fraction of open photosystem II (PSII) reaction centers, qL).

This document explains MLR functionalities and scales at leaf and canopy levels:

- Chapter 1: Major effects on modeling SIF, model structure, model parameter, and subgrid heterogeneity, in land surface models (LSMs)  
- Chapter 2: Overvew of MLR model
- Chapter 3: MLR functionalities, at leaf- and canopy- scale

## I. Interactive Effects of Structure, Parameter, and Subgrid Heterogeneity on Modeling Solar-induced Chlorophyll Fluorescence (SIF)

Remotely sensed SIF, an optical signal emitted by plant chlorophyll molecules upon excitation during light harvesting, has been demonstrated to be a promising mechanistic measurement to improve gross primary production (GPP) estimates across scales. A major effort is to integrate SIF into LSM to constrain simulated GPP and downstream carbon fluxes, or to infer photosynthetic parameters (e.g., maximum carboxylation rate, Vcmax). The rigor of such efforts hinges upon a realistic SIF model parameterization, which mechanistically represents light reactions and energy partitioning among the dissipation pathways of absorbed photons, and links SIF and GPP through the steady state balance between light and carbon reactions. Three interactive effects of modeling SIF are mentioned below:

* _Model structure_

(definition of model structure)
Current LSMs contain structural deficiencies due to simplifications and debatable assumptions made in their mathematical formulation of major biological and physical processes. These common shortcomings also apply to SIF model parameterization. Deficiencies in representing vegetation structure, canopy radiative transfer, and leaf physiological responses to environmental variability can lead to considerable model prediction biases in SIF. So far, LSMs have all adopted the same leaf-level SIF modeling approach originally developed for the Soil Canopy Observation of Photosynthesis and Energy fluxes (SCOPE) model. This approach establishes the SIF-GPP closure equation via an empirical formulation of NPQ. However, it struggles to capture patterns and relationships drawn from observations. These limitations mainly arise from the complexity of realistically modeling NPQ, which has multiple components with poorly understood, varying responses to environmental variations at different timescales, and its activation and regulation occurring in various chloroplast compartments. 

* _Model parameters_

(definition of model parameters)
Parameter uncertainties affect the realism and robustness of LSM simulations (Bonan 
106 and Doney, 2018), including SIF modeling. Specific to SIF and GPP modeling in LSMs, key 
107 parameters include leaf chlorophyll content (both a and b, Cab; Koffi et al., 2015; Zhang et al., 
108 2025) and photosynthetic parameters (e.g., Vcmax; maximum electron transport rate, Jmax; Prikaziuk 
109 et al., 2023; Han et al., 2022b), among others (Migliavacca et al., 2017; Wang Na et al., 2023). It 
110 is well-known that GPP is highly sensitive to parameters such as Vcmax and Jmax (Walker et al., 
111 2014; Walker et al., 2017). However, the widely used NPQ-based SIF parameterization struggles 
112 to capture the expected SIF sensitivity (Prikaziuk et al., 2023). For example, simulated SIF exhibits 
113 weak sensitivity to Vcmax variations under moderate light and leaf area index (LAI) conditions 
114 (Vilfan et al., 2019; Pacheco-Labrador et al., 2019). This contrasts with Han et al. (2022b), which 
115 utilized theoretical analysis and extensive measurements of leaf gas exchanges and pulse 
116 amplitude modulated (PAM) chlorophyll fluorescence to reveal that, Vcmax strongly impacts SIF. 
117 These findings suggest that the accuracy of SIF simulations should depend on the realism of 
118 photosynthetic capacity parameters and is subject to their uncertainties. Therefore, combined 
119 deficiencies in model structure and parameters can bias SIF simulations, impairing the practical 
120 utility of remotely sensed SIF in constraining and informing LSMs.


## Annex 1: Abbreviations

ΦP: photochemical quantum yield
Vcmax: maximum carboxylation rate
GPP: gross primary production
LSM: land surface model
Ja: actual electron transport rate
MLR: mechanistic light reaction
NPQ: non-photochemical quenching
PSII: photosystem II
qL: the fraction of open PSII reaction centers
SIF: solar-induced chlorophyll fluorescence
SCOPE: Soil Canopy Observation of Photosynthesis and Energy fluxes
