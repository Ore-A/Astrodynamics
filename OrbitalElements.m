
r_x = input("Enter radius x value:");
r_y = input("Enter radius y value:");
r_z = input("Enter radius z value:");

v_x = input("Enter velocity x value:");
v_y = input("Enter velocity y value:");
v_z = input("Enter velocity z value:");

r = [r_x r_y r_z];
v = [v_x v_y v_z];

I = [1 0 0]; % I unit vector
K = [0 0 1]; % K unit vector
mu = 3.986e5; % gravitational constant

h = cross(r,v) % specific angular momentum

n = cross(K,h) % node vector 

% Magnitudes
R = norm(r);
V = norm(v);
H = norm(h);
N = norm(n);

p = H^2/mu % semi-latus parameter

m = (V^2 - (mu/R)).*r;
l = (dot(r,v)).*v;

e = (1/mu).*(m-l) % eccentricity vector

E = norm(e) % eccentricity

a = p/(1-(E^2)) % semi-major axis

T = 2*pi*sqrt(a^3/mu) % time of periapses passage

i = acosd(dot(h,K)/H) % inclination

O = acosd(dot(n,I)/N) % longitude of ascending node

w = acosd(dot(n,e)/(N*E)) % argument of periapse

b_pi = acosd(dot(e,I)/(E)); % longitude of periapse

nu = acosd(dot(e,r)/(E*R)) % true anomaly

u_0 = w + nu; % argument of latitude at epoch
l_0 = O + w + nu; % true longitude at epoch
