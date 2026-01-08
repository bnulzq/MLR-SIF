# MLR USER'S MANUAL (0.0.0) 
- - -

---
Reference: MLR_User_Manual  
Release date: 2026  
Author: Zhenqi Luo (zl725@cornell.edu)  
---

## Content

[**I. Interactive Effects of Structure, Parameter, and Subgrid Heterogeneity on Modeling Solar-induced Chlorophyll Fluorescence (SIF)**](#i-interactive-effects-of-structure-parameter-and-subgrid-heterogeneity-on-modeling-solar-induced-chlorophyll-fluorescence-sif)      
[**II. The MLR Model Framework**](#II-The-MLR-Model-Framework)  
[**III. MLR Functionalities and Scales**](#III-MLR-Functionalities-and-Scales)    
_**III.1 Leaf-level MLR model**_  
_**III.2 Canopy-level MLR model**_  
[**Annex 1: Abbreviations**](#Annex-1-Abbreviations)  

### Overview

The mechanistic light reaction (MLR) describes the mechanistic relationship among three core components of the photosynthetic light reactions: 

- Solar-induced chlorophyll fluorescence (SIF)
- Photochemical activity, representing by the actual electron transport rate (Ja) or photochemical quantum yield (ΦP)
- Non-photochemical quenching (NPQ), or equivalently the fraction of open photosystem II (PSII) reaction centers (qL)

MLR provides a physically and physiologically grounded representation of energy partitioning during photosynthesis, enabling a direct mechanistic linkage between remotely sensed SIF and carbon assimilation.

This manual documents the conceptual foundation, functional design, and implementation scales of the MLR framework at both leaf and canopy levels:

- Chapter I: Interactive effects of model structure, model parameter, and subgrid heterogeneity on SIF modeling in land surface models (LSMs)  
- Chapter II: Overvew of the MLR model formulation
- Chapter III: MLR functionalities across leaf- and canopy- scale

## I. Interactive Effects of Structure, Parameter, and Subgrid Heterogeneity on Modeling Solar-induced Chlorophyll Fluorescence (SIF)

SIF is an optical signal emitted by chlorophyll molecules during photosynthetic light harvesting. It has emerged as a powerful, mechanistically informative observable for constraining gross primary production (GPP) across spatial and temporal scales. Consequently, substantial effort has been devoted to integrating SIF into LSMs to 
- 1. constrain simulated GPP and downstream carbon fluxes  
- 2. infer key photosynthetic parameters such as the maximum carboxylation rate (Vcmax)

The success of these efforts critically depends on the realism of SIF model parameterizations, which must faithfully represent photosynthetic light reactions, energy partitioning pathways, and the steady-state coupling between light and carbon reactions. In practice, three strongly interacting factors govern the fidelity of SIF simulations in LSMs: model structure, model parameters, and subgrid spatial heterogeneity.

* _1. Model structure_

Model structure refers to the mathematical formulation and process representation embedded within a model. Current LSMs exhibit structural limitations arising from necessary simplifications and debatable assumptions in their representation of biological and physical processes. These limitations extend directly to SIF parameterizations. Inadequate representations of vegetation structure, canopy radiative transfer, and leaf-level physiological responses to environmental variability can lead to substantial biases in simulated SIF. To date, most LSMs adopt a leaf-level SIF formulation originally developed for the Soil Canopy Observation of Photosynthesis and Energy fluxes (SCOPE) model. This formulation links SIF and GPP through a closure relationship based on an empirical representation of NPQ. However, this approach often struggles to reproduce observed SIF patterns and functional relationships. These shortcomings primarily stem from the complexity of NPQ itself. NPQ comprises multiple components operating on different timescales, with distinct regulatory mechanisms and environmental sensitivities, and involves processes occurring across multiple chloroplast compartments. As a result, simplified empirical NPQ formulations may inadequately capture the dynamic regulation of energy dissipation, limiting the robustness of SIF–GPP coupling in LSMs.

* _2. Model parameters_

Model parameters define the physiological and structural properties that govern model behavior. Uncertainties in parameter values substantially affect the realism and robustness of LSM simulations, including those of SIF. Key parameters for SIF and GPP modeling include leaf chlorophyll content (chlorophyll a and b; Cab) and photosynthetic capacity parameters such as Vcmax and the maximum electron transport rate (Jmax). GPP is well known to be highly sensitive to variations in Vcmax and Jmax. However, widely used NPQ-based SIF parameterizations often fail to exhibit a corresponding sensitivity of simulated SIF to these photosynthetic capacity parameters. Consequently, even when photosynthetic parameters are realistically specified, SIF simulations may not respond in a physiologically consistent manner. Thus, the accuracy of SIF simulations depends jointly on the realism of photosynthetic capacity parameters and the structural adequacy of the model formulation. Combined deficiencies in model structure and parameterization can propagate into biased SIF estimates, limiting the effectiveness of satellite-observed SIF for constraining LSMs and inferring photosynthetic parameters.

* _3. Spatial heterogeneity_

Subgrid heterogeneity refers to unresolved spatial variability within a model grid cell. A fundamental challenge in evaluating SIF simulations from LSMs arises from the spatial mismatch between models and satellite observations. LSMs typically represent multiple plant functional types (PFTs) within a single grid cell, whereas coarse-resolution satellite SIF retrievals integrate signals from all contributing PFTs within a pixel. Even under idealized conditions: perfect model structure and biologically realistic parameters, LSM-simulated SIF may still diverge from satellite observations due to unresolved heterogeneity in phenology, canopy structure, and SIF emission capacity among PFTs. This subgrid variability can strongly confound comparisons between simulated SIF (at grid or site scales) and satellite-derived SIF (at coarse spatial resolution). As a result, subgrid heterogeneity complicates model evaluation, hampers parameter inference, and limits the effectiveness of satellite SIF for constraining GPP and diagnosing model behavior in LSMs.

## II. The MLR Model Framework

Developed since 2019, the MLR model represents one of the most mechanistically grounded frameworks for linking SIF to GPP, with a central focus on the photosynthetic light reactions.

At the leaf level, MLR explicitly couples light reactions, characterized by photosynthetically active radiation (PAR) and SIF emission, to carbon fixation through the regulation of photochemical efficiency. This coupling is mediated by qL, or equivalently, NPQ. Through this formulation, MLR establishes a mechanistic pathway that translates observed SIF into photosynthetic electron transport and, ultimately, carbon assimilation, rather than relying on empirical correlations.

At the canopy level, MLR integrates leaf-scale physiological processes with an explicit treatment of canopy radiative transfer, enabling physically consistent scaling from leaves to the canopy. This integration preserves mechanistic interpretability while accounting for vertical gradients in light availability, photosynthetic capacity, and fluorescence emission. As a result, the canopy-level MLR provides a coherent framework for linking remotely sensed SIF to canopy-scale GPP.

A key conceptual advantage of MLR is its forward inference strategy: measured SIF is used directly to estimate GPP without dependence on eddy-covariance (EC)–derived GPP products for calibration. By avoiding EC-based tuning, MLR breaks the common circularity in which satellite SIF is calibrated against EC GPP and then used to evaluate or constrain terrestrial biosphere models. This independence forms a critical foundation for the robustness and scalability of MLR across spatial scales, temporal resolutions, and ecosystem types.

### Scalability Across Scales

The MLR framework has demonstrated strong scalability and transferability across multiple observational and modeling scales:

- Leaf scale: MLR has been evaluated using pulse-amplitude-modulated (PAM) fluorescence measurements across 29 plant species representative of major global biomes, demonstrating its physiological generality.

- Canopy scale: MLR has been shown to outperform classical approaches, including the Farquhar, von Caemmerer, and Berry (FvCB) photosynthesis model and Radiation Use Efficiency (RUE) models, in estimating GPP across EC sites at hourly to multi-day timescales.

- Regional scale: MLR has been applied to regional crop systems to estimate crop productivity and yield.

- Global scale: A global SIF-based GPP product has been developed following the MLR strategy, demonstrating its applicability to large-scale Earth system analyses.

## III. MLR Functionalities and Scales

MLR describes the mechanistic relationship among three sets of unknowns: SIF, Ja or ΦP, and NPQ (or qL). Therefore, three equations are required to close this system. MLR itself establishes the theoretical relationship among Ja, SIF, and NPQ (or qL). It needs two additional independent equations for closure. One equation links Ja (or ΦP) between light and carbon reactions, thus, Ja can be determined independently from the FvCB model. The remaining equation must independently model either (not both) NPQ or qL. Computing SIF via qL can be achieved by modeling qL as a function of environmental variables such as incident PAR without sacrificing modeling accuracy, as demonstrated at both leaf and canopy scales.

### III.1 Leaf-level MLR model

![Fig1](Figs/SCOPE_SIF1.png)

The procedure of modeling SIF emission (F<sub>e</sub>), using two alternative strategies implemented in SCOPE: the qL-based and NPQ-based approaches. Both strategies utilize the FvCB biochemical model to compute Ja, which is then combined with independent NPQ- or qL-based formulations to derive Fe. The default SCOPE implementation computes Fe via the NPQ-based route, where the rate constant of NPQ (k_N_) is formulated as a function of the degree of light saturation (x). We explored the alternative qL-based route, in which qL is formulated as a function of incident PAR, capturing the first-order effects of light intensities on qL variation. Similar to the NPQ-based approach, this method relies on the FvCB to estimate Ja at the leaf level. We then compared simulated Fe from the qL-based and NPQ-based approaches. Specificly, qL can be effectively estimated using a parsimonious equation as a function of incident PAR: 

$$
q_L = a_{q_L} * e^{-b_{q_L}*PAR}
$$

where aqL and bqL are empirical parameters, which were determined by fitting leaf-level PAM measurements across diverse PFTs under varying environmental conditions. These parameters are relatively conservative across PFTs, lending support for greater scalability and broader applicability of the qL-based SIF formulation.
Then, PSII Fe (F_e, PSII_) based on the qL strategy can be computed directly below:

$$
F_{e, PSII} = \frac{J_a*\Phi_{PSIIm}}{\Phi_{PSIIm}(1+k_{DF})q_L}
$$

Here k_DF_ is the ratio of k_D_ and k_F_. Finally, fluorescence yield (ΦF) of PSII (Φ_F, PSII_) based on the qL strategy can be obtained from:

$$
\Phi_{F, PSII} = \frac{F_e}{0.5*APAR}
$$

where the factor 0.5 reflects the fraction of the absorbed PAR (APAR) allocated to PSII.

SCOPE stratifies the canopy into sunlit and shaded leaves. Therefore, all dynamic variables relevant to NPQ- and qL-based formulations above are calculated separately for sunlit and shaded leaves.

### III.2 Canopy-level MLR model

To be done...

## Annex 1: Abbreviations

ΦF: fluorescence yield  
Φ_F, PSII_: PSII ΦF  
ΦP: photochemical quantum yield  
Cab: chlorophyll content a and b  
F_e_: SIF emission  
F_e, PSII_: PSII Fe  
Ja: actual electron transport rate  
Jmax: maximum electron transport rate 
k_D_: The rate constant of internal conversion (unregulated heat dissipation)  
k_F_: The rate constant of SIF emission  
k_DF_: The ratio of k_D_ to k_F_      
k_N_: the rate constant of NPQ  
Vcmax: maximum carboxylation rate  
x: the degree of light saturation  
APAR: absorbed PAR  
EC: eddy-covariance  
FvCB: Farquhar, von Caemmerer and Berry  
GPP: gross primary production  
LSM: land surface model  
MLR: mechanistic light reaction  
NPQ: non-photochemical quenching  
PAM: pulse-amplitude-modulated  
PAR: photosynthetically active radiation  
PFT: plant functional types  
PSII: photosystem II  
qL: the fraction of open PSII reaction centers  
RUE: Radiation Use Efficiency  
SIF: solar-induced chlorophyll fluorescence  
SCOPE: Soil Canopy Observation of Photosynthesis and Energy fluxes  
