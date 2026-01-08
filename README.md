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
- Photochemical activity, representing by the actual electron transport rate (J<sub>a</sub>) or photochemical quantum yield (Φ<sub>P</sub>)
- Non-photochemical quenching (NPQ), or equivalently the fraction of open photosystem II (PSII) reaction centers (q<sub>L</sub>)

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

At the leaf level, MLR explicitly couples light reactions, characterized by photosynthetically active radiation (PAR) and SIF emission, to carbon fixation through the regulation of photochemical efficiency. This coupling is mediated by q<sub>L</sub>, or equivalently, NPQ. Through this formulation, MLR establishes a mechanistic pathway that translates observed SIF into photosynthetic electron transport and, ultimately, carbon assimilation, rather than relying on empirical correlations.

At the canopy level, MLR integrates leaf-scale physiological processes with an explicit treatment of canopy radiative transfer, enabling physically consistent scaling from leaves to the canopy. This integration preserves mechanistic interpretability while accounting for vertical gradients in light availability, photosynthetic capacity, and fluorescence emission. As a result, the canopy-level MLR provides a coherent framework for linking remotely sensed SIF to canopy-scale GPP.

A key conceptual advantage of MLR is its forward inference strategy: measured SIF is used directly to estimate GPP without dependence on eddy-covariance (EC)–derived GPP products for calibration. By avoiding EC-based tuning, MLR breaks the common circularity in which satellite SIF is calibrated against EC GPP and then used to evaluate or constrain terrestrial biosphere models. This independence forms a critical foundation for the robustness and scalability of MLR across spatial scales, temporal resolutions, and ecosystem types.

### Scalability Across Scales

The MLR framework has demonstrated strong scalability and transferability across multiple observational and modeling scales:

- Leaf scale: MLR has been evaluated using pulse-amplitude-modulated (PAM) fluorescence measurements across 29 plant species representative of major global biomes, demonstrating its physiological generality.

- Canopy scale: MLR has been shown to outperform classical approaches, including the Farquhar, von Caemmerer, and Berry (FvCB) photosynthesis model and Radiation Use Efficiency (RUE) models, in estimating GPP across EC sites at hourly to multi-day timescales.

- Regional scale: MLR has been applied to regional crop systems to estimate crop productivity and yield.

- Global scale: A global SIF-based GPP product has been developed following the MLR strategy, demonstrating its applicability to large-scale Earth system analyses.

## III. MLR Functionalities and Scales

The MLR framework characterizes the intrinsic relationships among three coupled processes: SIF, J<sub>a</sub> or Φ<sub>P</sub>, and NPQ or, equivalently q<sub>L</sub>. Closing this system requires three independent equations. MLR explicitly establishes the theoretical relationship among SIF, J<sub>a</sub>, and NPQ (or q<sub>L</sub>) based on the physics and biochemistry of the photosynthetic light reactions. Two additional equations are required for closure. The first links J<sub>a</sub> (or Φ<sub>P</sub>) between the light and carbon reactions, allowing J<sub>a</sub> to be determined independently through the FvCB biochemical model. The second equation independently parameterizes either NPQ or q<sub>L</sub> (but not both).

In practice, computing SIF through q<sub>L</sub> has been shown to be both accurate and robust. Modeling q<sub>L</sub> as a direct function of incident PAR, which captures the dominant first-order controls on photochemical regulation without sacrificing performance. This formulation has been validated at both leaf and canopy scales and forms the basis of the q<sub>L</sub>-based MLR implementation.

### III.1 Leaf-level MLR model

![Fig1](Figs/SCOPE_SIF1.png)

Two alternative strategies for modeling leaf-level SIF emission (F<sub>e</sub>) implemented within the SCOPE framework: 

- the traditional NPQ-based approach
- the alternative q<sub>L</sub>-based approach

In both strategies, the FvCB biochemical model is used to compute the J<sub>a</sub>, which is then combined with an independent formulation of NPQ or q<sub>L</sub> to derive F<sub>e</sub>.

In the default SCOPE implementation, F<sub>e</sub> is calculated via the NPQ-based route, in which the rate constant of non-photochemical quenching (k<sub>N</sub>) is parameterized as a function of the degree of light saturation (x). While widely adopted, this formulation relies on an empirical representation of NPQ that can limit scalability across species and environmental conditions. As an alternative, we implemented a q<sub>L</sub>-based strategy, in which q<sub>L</sub> is parameterized directly as a function of incident PAR. This approach captures the first-order effects of light intensity on photochemical regulation while remaining parsimonious and mechanistically interpretable. Similar to the NPQ-based formulation, the q<sub>L</sub>-based approach relies on the FvCB model to estimate J<sub>a</sub> at the leaf level. Simulated F<sub>e</sub> from the two approaches were subsequently compared.

Specifically, q<sub>L</sub> is estimated using a simple exponential formulation:

$$
q_L = a_{q_L} * e^{-b_{q_L}*PAR}
$$

where a<sub>qL</sub> and b<sub>qL</sub> are empirical parameters, determined by fitting PAM chlorophyll fluorescence measurements across a wide range of PFTs and environmental conditions. These parameters exhibit relatively limited variability across PFTs, supporting the scalability and general applicability of the q<sub>L</sub>-based SIF formulation. Using the q<sub>L</sub>-based strategy, PSII F<sub>e</sub> (F<sub>e,PSII</sub>) is computed as:

$$
F_{e, PSII} = \frac{J_a*\Phi_{PSIIm}}{\Phi_{PSIIm}(1+k_{DF})q_L}
$$

where k<sub>DF</sub> ​denotes the ratio of the constitutive heat dissipation rate constant (k<sub>D</sub>) to the fluorescence rate constant (k<sub>F</sub>), and Φ<sub>PSIIm</sub> represents the maximum photochemical quantum yield for a darkadapted leaf. The corresponding PSII fluorescence yield (Φ<sub>F,PSII</sub>) is then obtained as:

$$
\Phi_{F, PSII} = \frac{F_e}{0.5*APAR}
$$

where APAR denotes absorbed photosynthetically active radiation, and the factor 0.5 accounts for the assumption that half of APAR is allocated to PSII.

In SCOPE, the canopy is stratified into sunlit and shaded leaf fractions. Accordingly, all state variables and fluxes relevant to the NPQ- and q<sub>L</sub>-based formulations—including PAR, J<sub>a</sub>, q<sub>L</sub>, and F<sub>e</sub>—are computed separately for sunlit and shaded leaves prior to canopy integration.

### III.2 Canopy-level MLR model

To be done...

## Annex 1: Abbreviations

Φ<sub>F</sub>: fluorescence yield  
Φ<sub>F, PSII</sub>: PSII ΦF  
Φ<sub>P</sub>: photochemical quantum yield  
Φ<sub>PSIIm</sub>: the maximum photochemical quantum yield for a darkadapted leaf
Cab: chlorophyll content a and b  
F<sub>e</sub>: SIF emission  
F<sub>e, PSII</sub>: PSII Fe  
J<sub>a</sub>: actual electron transport rate  
Jmax: maximum electron transport rate 
k<sub>D</sub>: The rate constant of internal conversion (unregulated heat dissipation)  
k<sub>F</sub>: The rate constant of SIF emission  
k<sub>DF</sub>: The ratio of k_D_ to k_F_      
k<sub>N</sub>: the rate constant of NPQ  
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
q<sub>L</sub>: the fraction of open PSII reaction centers  
RUE: Radiation Use Efficiency  
SIF: solar-induced chlorophyll fluorescence  
SCOPE: Soil Canopy Observation of Photosynthesis and Energy fluxes  
