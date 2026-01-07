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
**III. MLR Functionalities and Scales**    
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



## Annex 1: Abbreviations

ΦP: photochemical quantum yield
Cab: chlorophyll content a and b
Jmax: maximum electron transport rate
Vcmax: maximum carboxylation rate
GPP: gross primary production
LSM: land surface model
Ja: actual electron transport rate
MLR: mechanistic light reaction
NPQ: non-photochemical quenching
PFT: plant functional types
PSII: photosystem II
qL: the fraction of open PSII reaction centers
SIF: solar-induced chlorophyll fluorescence
SCOPE: Soil Canopy Observation of Photosynthesis and Energy fluxes
