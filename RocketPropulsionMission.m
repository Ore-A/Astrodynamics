clear,clc

%Design a 2-stage rocket, with core booster and inertial upper stage (IUS), to boost a satellite system (consisting
%of rocket motor, structure, propellant, guidance, and payload) with a total mass of 1800 kg into a geostationary
%transfer orbit (GTO)

%% Variables
re = 6378; % Radius of Earth in km
g = 9.81*(10^-3); % Acceleration due to gravity in km/sec
mu = 3.986*10^5; 
nu = 20; % True anomaly angle
launch = 28.5; % Cape Kennedy geodetic latitude
sday = 86164.09054; % Number of seconds GEO orbit satellites go around Earth 
m_sat = 1800; % Total mass of the satellite system
rp_alt = 80; % Perigee altitude
ra_alt = 35786; % Apogee altitude
epsilon_1 = 0.10; % First stage structure ratio
Isp_1 = 300; 
epsilon_2 = 0.11; % Second stage structure ratio
Isp_2 = 455;
epsilon_3 = 0.16; % Third stage structure ratio
Isp_3 = 275;
v_penalty = 1.6; % Velocity penalty 

%% Calculations

V_ex1 = Isp_1*g;
V_ex2 = Isp_2*g;
V_ex3 = Isp_3*g;
rp = rp_alt+re;
ra = ra_alt+re;
e = (ra-rp)/(ra+rp); 
a = (ra+rp)/2;
p = a*(1-(e^2));
r = p/(1+(e*(cosd(nu))));
v = sqrt(((2*(mu))/r)-((mu)/a)); 
av_earth = (2*pi)/sday;
vequator = av_earth*6378;
v_c = vequator*cosd(launch);
v_bo = v + v_penalty - v_c;

%% Optimization loop

i = 1;
for x = 0:0.01:v_bo
    delta_v1(i)=x;
    delta_v2(i)=v_bo-x;

    pi_1(i)=((exp(-delta_v1(i)/V_ex1))-epsilon_1)/(1-epsilon_1);
    pi_2(i)=((exp(-delta_v2(i)/V_ex2))-epsilon_2)/(1-epsilon_2);

    if pi_1(i)>0 && pi_2(i)>0
        m02(i) = m_sat/pi_2(i);
        m01(i) = m02(i)/pi_1(i);
        i = i+1;
    end
end

[min_m01, index] = min(m01); 
min_m02 = m02(index);

%%
ms1 = epsilon_1*(min_m01-min_m02);
mp1 = (min_m01-min_m02)-ms1;
pi1min = min_m02/min_m01;
delta_v1min = -V_ex1*log(epsilon_1+((1-epsilon_1)*pi1min));

ms2 = (min_m02-m_sat)*epsilon_2;
mp2 = (min_m02-m_sat)-ms2;
pi2min = m_sat/min_m02;
delta_v2min = v_bo - delta_v1min;

v_apogee = sqrt(((2*(mu))/ra)-((mu)/a));
vc = sqrt((mu)/ra);
delta_v3 = sqrt(((v_apogee^2)+(vc^2))-(2*v_apogee*vc*(cosd(launch))));

pi3 = ((exp(-delta_v3/V_ex3))-epsilon_3)/(1-epsilon_3); 
mstar = m_sat*pi3;
ms3 = epsilon_3*(m_sat-mstar);
mp3 = m_sat-(mstar+ms3);


%%  Results

fprintf('----------------------------------------------------------------\n')
fprintf('-----------------Rocket Optimization--------------------\n')
fprintf('First Stage Properties:\n')
fprintf('Total Mass = %g\n', min_m01)
fprintf('Structure Mass = %g\n', ms1)
fprintf('Propellant Mass = %g\n', mp1)
fprintf('Payload Ratio = %g\n', pi1min)
fprintf('Structure Ratio = %g\n', epsilon_1)
fprintf('Velocity Change = %g\n', delta_v1min)
fprintf('----------------------------------------------------------------\n')
fprintf('Second Stage Properties:\n')
fprintf('Total Mass = %g\n', min_m02)
fprintf('Structure Mass = %g\n', ms2)
fprintf('Propellant Mass = %g\n', mp2)
fprintf('Payload Ratio = %g\n', pi2min)
fprintf('Structure Ratio = %g\n', epsilon_2)
fprintf('Velocity Change = %g\n', delta_v2min)
fprintf('----------------------------------------------------------------\n')
fprintf('Third Stage Properties:\n')
fprintf('Total Mass = %g\n', m_sat)
fprintf('Structure Mass = %g\n', ms3)
fprintf('Propellant Mass = %g', mp3)
fprintf('Payload Mass = %g\n', mstar)
fprintf('Payload Ratio = %g\n', pi3)
fprintf('Structure Ratio = %g\n', epsilon_3)
fprintf('Velocity Change = %g\n', delta_v3)

%% Graph

figure(1)
semilogy((delta_v1(1:length(delta_v1)-1)/v_bo)*100,m01)
title('Rocket Optimization')
legend('Mass change')
xlabel('Percentage of \DeltaV1 from Burnout Speed')
ylabel('Total Rocket Mass')