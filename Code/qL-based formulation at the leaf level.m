% We implemented an alternative SIF parameterization that computes Fe, PSII by explicitly modeling qL, 
% as opposed to NPQ-oriented strategy (qL-based approach in Figure 2). 
% Han et al. (2022a) demonstrated that qL can be effectively estimated using a parsimonious equation as a function of incident PAR.
----------------

function biochem_out = biochemical(leafbio,meteo,options,constants,fV)

    %% leafbio: leaf biochemical parameters
    %% meteo: meteorology
    %% options: SCOPE options
    %% constants: required constants (e.g., aqL & bqL)
    %% fV: Vertical profile of Vcmax
    
    %% aqL, bqL -> Han et al. (2022a)
    aqL = constants.aqL;
    bqL = constants.bqL;
    
    %% Phi_PSII_max (can be assumed to be 0.83); Jp
    po0 = Kp./(Kf+Kd+Kp);         % maximum dark photochemistry fraction, i.e. Kn = 0 (Genty et al., 1989)
    Je          = 0.5*po0 .* Q;          % potential electron transport rate (JAK: add fPAR);
    
    %% PAR: leaf-level PAR; Q: APAR
    PAR = meteo.PAR; % incident spectrally integrated PAR (micromoles m-2 s-1)
    Q = meteo.Q;                  % [umol m-2 s-1] absorbed PAR flux
    
    %% Fluorescence module
    %%% Phi_F, PSII: fluorescence as fraction of PAR; 
    %%% eta: fluorescence emission efficiency of PSII; 
    %%% fo0: the minimum fluorescence yield for dark-adapted leaves
    [eta,qE,qQ,fs,fo,fm,fo0,fm0,Kn]    = Fluorescencemodel(ps, ps_rel, Kp,Kf,Kd,Knparams);
    
    %% FvCB module
    %%% temperature corrections
    
    [f.Vcmax,f.Rd,f.TPU,f.Kc,f.Ko,f.Gamma_star] = deal(1);
    if tempcor
        if strcmpi('C4', Type)
            % RdPerVcmax25 = 0.025;  % Rd25 for C4 is different than C3
            %   Rd25 = RdPerVcmax25 * Vcmax25;
            % Constant parameters for temperature correction of Vcmax
            Q10 = leafbio.TDP.Q10;                           % Unit is  []
            s1  = leafbio.TDP.s1;                            % Unit is [K]
            s2  = leafbio.TDP.s2;                            % Unit is [K^-1]
            s3  = leafbio.TDP.s3;                            % Unit is [K]
            s4  = leafbio.TDP.s4;                            % Unit is [K^-1]
            
            % Constant parameters for temperature correction of Rd
            s5  = leafbio.TDP.s5;                            % Unit is [K]
            s6  = leafbio.TDP.s6;                            % Unit is [K^-1]
            
            fHTv = 1 + exp(s1.*(T - s2));
            fLTv = 1 + exp(s3.*(s4 - T));
            Vcmax = (Vcmax25 .* Q10.^(0.1.*(T-Tref)))./(fHTv .* fLTv); % Temp Corrected Vcmax
            
            % Temperature correction of Rd
            
            fHTv = 1 + exp(s5.*(T - s6));
            Rd = (Rd25 .* Q10.^(0.1.*(T-Tref)))./fHTv; % Temp Corrected Rd
            % Temperature correction of Ke
            Ke25 = 20000 .* Vcmax25 ;               % Unit is  []
            Ke = (Ke25 .* Q10.^(0.1.*(T-Tref)));    % Temp Corrected Ke
            
        else
            % temperature correction of Vcmax
            deltaHa     = leafbio.TDP.delHaV;                % Unit is  [J K^-1]
            deltaS      = leafbio.TDP.delSV;                 % unit is [J mol^-1 K^-1]
            deltaHd     = leafbio.TDP.delHdV;                % unit is [J mol^-1]
            fTv         = temperature_functionC3(Tref,R,T,deltaHa);
            fHTv        = high_temp_inhibtionC3(Tref,R,T,deltaS,deltaHd);
            f.Vcmax     = fTv .* fHTv;
            
    %         % temperature correction for TPU
    %         deltaHa     = leafbio.TDP.delHaP;                % Unit is  [J K^-1]
    %         deltaS      = leafbio.TDP.delSP;                 % unit is [J mol^-1 K^-1]
    %         deltaHd     = leafbio.TDP.delHdP;                % unit is [J mol^-1]
    %         fTv         = temperature_functionC3(Tref,R,T,deltaHa);
    %         fHTv        = high_temp_inhibtionC3(Tref,R,T,deltaS,deltaHd);
    %         f.TPU       = fTv .* fHTv;
            
            % temperature correction for Rd
            deltaHa     = leafbio.TDP.delHaR;               % Unit is  [J K^-1]
            deltaS      = leafbio.TDP.delSR;                % unit is [J mol^-1 K^-1]
            deltaHd     = leafbio.TDP.delHdR;               % unit is [J mol^-1]
            fTv         = temperature_functionC3(Tref,R,T,deltaHa);
            fHTv        = high_temp_inhibtionC3(Tref,R,T,deltaS,deltaHd);
            f.Rd        = fTv .* fHTv;
            
            % temperature correction for Kc
            deltaHa     = leafbio.TDP.delHaKc;               % Unit is  [J K^-1]
            fTv         = temperature_functionC3(Tref,R,T,deltaHa);
            f.Kc        = fTv;
            
            % temperature correction for Ko
            deltaHa     = leafbio.TDP.delHaKo;               % Unit is  [J K^-1]
            fTv         = temperature_functionC3(Tref,R,T,deltaHa);
            f.Ko        = fTv;
            
            % temperature correction for Gamma_star
            deltaHa     = leafbio.TDP.delHaT;               % Unit is  [J K^-1]
            fTv         = temperature_functionC3(Tref,R,T,deltaHa);
            f.Gamma_star = fTv;
            
            Ke          = 1; % dummy value (only needed for C4)
        end
    else
        Ke          = 1; % dummy value (only needed for C4)
    end
    
    if strcmp('C3', Type)
        Vcmax       = Vcmax25.*f.Vcmax.*stressfactor;
        Rd          = Rd25    .*f.Rd.* stressfactor;
        %TPU         = TPU25   .* f.TPU;
        Kc          = Kc25    .* f.Kc;
        Ko          = Ko25    .* f.Ko;
    end
    Gamma_star   = Gamma_star25 .* f.Gamma_star;
    
    if strcmp(Type, 'C3')
        MM_consts = (Kc .* (1+O./Ko)); % Michaelis-Menten constants
        Vs_C3 = (Vcmax/2);
        %  minimum Ci (as fraction of Cs) for BallBerry Ci. (If Ci_input is present we need this only as a placeholder for the function call)
        minCi = 0.3;
    else
        % C4
        MM_consts = 0; % just for formality, so MM_consts is initialized
        Vs_C3 = 0;     %  the same
        minCi = 0.1;  % C4
    end
    
    %% calculation of Ci (internal CO2 concentration)
    RH = min(1, eb./satvap(T-273.15) ); % jak: don't allow "supersaturated" air! (esp. on T curves)
    computeA()  % clears persistent fcount
    computeA_fun = @(x) computeA(x, Type, g_m, Vs_C3, MM_consts, Rd, Vcmax, Gamma_star, Je, effcon, atheta, Ke);
    
    if all(BallBerry0 == 0)
        % b = 0: no need to iterate:
        Ci = BallBerry(Cs, RH, [], BallBerrySlope, BallBerry0, minCi);
        %     A =  computeA_fun(Ci);   
    else
        % compute Ci using iteration (JAK)
        % it would be nice to use a built-in root-seeking function but fzero requires scalar inputs and outputs,
        % Here I use a fully vectorized method based on Brent's method (like fzero) with some optimizations.
        tol = 1e-7;  % 0.1 ppm more-or-less
        % Setting the "corner" argument to Gamma may be useful for low Ci cases, but not very useful for atmospheric CO2, so it's ignored.
        %                     (fn,                           x0, corner, tolerance)
        [Ci] = fixedp_brent_ari(@(x) Ci_next(x, Cs, RH, minCi, BallBerrySlope, BallBerry0, computeA_fun, ppm2bar), Cs, [], tol); % [] in place of Gamma: it didn't make much difference
        %NOTE: A is computed in Ci_next on the final returned Ci. fixedp_brent_ari() guarantees that it was done on the returned values.
        %     A =  computeA_fun(Ci);
    end
    
    [A, biochem_out]    = computeA_fun(Ci);
    Ag                  = biochem_out.Ag;
    CO2_per_electron    = biochem_out.CO2_per_electron;
    Ja = Ag ./ CO2_per_electron;   % actual electron transport rate
    
    %% leaf-level SIF
    function [SIF_ql, eta] = MLR(aqL, bqL, po0, PAR, fs, Q, fo0, Ja)
        kdf = 10; % [] (Han 2022a)
        qL =  aqL.*exp(-bqL.*PAR); % []
        SIF_ql = Ja.*(1 - po0)./(po0*(1 + kdf))./qL; % [umole-/m2/s]
        fs_ql= SIF_ql./(Q*0.5); % [] fluorescence as fraction of PAR -> !!!  APAR for PSII = 0.5 APAR LZQ 2025.12.06
        fs_ql(isnan(fs_ql)) = fs(isnan(fs_ql));
        ## update eta: 
        eta = fs_ql./fo0; % fo0 = 0.0102, % dark-adapted fluorescence yield Fo,0
    end
    
    [SIF_ql, eta] = MLR(aqL, bqL, po0, PAR, fs, Q, fo0, Ja);
    
    %% output
    biochem_out.SIF     = SIF_ql; %qL-based: SIF_ql; %NPQ-based: fs .* Q;
    biochem_out.eta     = eta;

end

%% Fluorescence model
function [eta,qE,qQ,fs,fo,fm,fo0,fm0,Kn] = Fluorescencemodel(ps,x, Kp,Kf,Kd,Knparams)
% note: x isn't strictly needed as an input parameter but it avoids code-duplication (of po0) and it's inherent risks.

    Kno = Knparams(1);
    alpha = Knparams(2);
    beta = Knparams(3);
    
    x_alpha = exp(log(x).*alpha); % this is the most expensive operation in this fn; doing it twice almost doubles the time spent here (MATLAB 2013b doesn't optimize the duplicate code)
    Kn = Kno * (1+beta).* x_alpha./(beta + x_alpha);
    
    fo0         = Kf./(Kf+Kp+Kd);        % dark-adapted fluorescence yield Fo,0 -> Phi_Fo
    fo          = Kf./(Kf+Kp+Kd+Kn);     % light-adapted fluorescence yield in the dark Fo
    fm          = Kf./(Kf   +Kd+Kn);     % light-adapted fluorescence yield Fm -> Phi_F'm
    fm0         = Kf./(Kf   +Kd);        % dark-adapted fluorescence yield Fm
    fs          = fm.*(1-ps);            % steady-state (light-adapted) yield Ft (aka Fs) -> Phi_F
    eta         = fs./fo0;
    qQ          = 1-(fs-fo)./(fm-fo);    % photochemical quenching
    qE          = 1-(fm-fo)./(fm0-fo0);  % non-photochemical quenching

end

