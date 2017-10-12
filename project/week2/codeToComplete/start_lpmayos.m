clearvars;
clc

I=double(imread('demo_image.png'));
I=mean(I,3);
I=I-min(I(:));
I=I/max(I(:));

[ni, nj]=size(I);

%Lenght and area parameters
%phantom18 mu=0.2 mu=0.5
mu=0.2;
nu=0;

%%Parameters
lambda1=1;
lambda2=1;

epHeaviside=1;

eta=0.01;
% eta=1;

tol=10^-6;

dt=(10^-1)/mu;
%dt=(10^-2)/mu; 


iterMax=10000

%reIni=0; %Try both of them
%reIni=500;

reIni=500;

[X, Y]=meshgrid(1:nj, 1:ni);

%%Initial phi
phi_0=(-sqrt( ( X-round(ni/2)).^2 + (Y-round(nj/4)).^2)+50);
%phi_0=(-sqrt( ( X-round(ni/2)).^2 + (Y-round(nj/2)).^2)+50);

%Normalization of the initial phi to [-1 1]
phi_0=phi_0-min(phi_0(:));
phi_0=2*phi_0/max(phi_0(:));
phi_0=phi_0-1;

%%Explicit Gradient Descent
seg=G11_ChanVeseIpol_GDExp( I, phi_0, mu, nu, eta, lambda1, lambda2, tol, epHeaviside, dt, iterMax, reIni );
