function [ phi ] = G11sol_ChanVeseIpol_GDExp( I, phi_0, mu, nu, eta, lambda1, lambda2, tol, epHeaviside, dt, iterMax, reIni )
%Implementation of the Chan-Vese segmentation following the explicit
%gradient descent in the paper of Pascal Getreur "Chan-Vese Segmentation".
%It is the equation 19 from that paper

%I     : Gray color image to segment
%phi_0 : Initial phi
%mu    : mu lenght parameter (regularizer term)
%nu    : nu area parameter (regularizer term)
%eta   : epsilon for the total variation regularization
%lambda1, lambda2: data fidelity parameters
%tol   : tolerance for the sopping criterium
% epHeaviside: epsilon for the regularized heaviside. 
% dt     : time step
%iterMax : MAximum number of iterations
%reIni   : Iterations for reinitialization. 0 means no reinitializacion

[ni,nj]=size(I);
hi=1;
hj=1;


phi=phi_0;
dif=inf;
nIter=0;
while dif>tol && nIter<iterMax
    
    phi_old=phi;
    nIter=nIter+1;
    nIter
    
    
    %Fixed phi, Minimization w.r.t c1 and c2 (constant estimation)
    c1 = (sum(sum((phi>=0) .* I)))./(sum(sum(double(phi>=0)))); %TODO 1: Line to complete
    c2 = (sum(sum((phi<0) .* I)))./(sum(sum(double(phi<0)))); %TODO 2: Line to complete
    
    %Boundary conditions
    phi(1,:)   = phi(2,:); %TODO 3: Line to complete
    phi(end,:) = phi(end-1,:); %TODO 4: Line to complete

    phi(:,1)   = phi(:,2); %TODO 5: Line to complete
    phi(:,end) = phi(:,end-1); %TODO 6: Line to complete

    %Regularized Dirac's Delta computation
    delta_phi = G11_diracReg(phi, epHeaviside);   %notice delta_phi=H'(phi)	
    
        
    %derivatives estimation
    %i direction, forward finite differences
    phi_iFwd  = DiFwd(phi,hi); %TODO 7: Line to complete
    phi_iBwd  = DiBwd(phi,hi); %TODO 8: Line to complete
    
    %j direction, forward finitie differences
    phi_jFwd  = DjFwd(phi,hj); %TODO 9: Line to complete
    phi_jBwd  = DjBwd(phi,hj); %TODO 10: Line to complete
    
    %centered finite diferences
    phi_icent   = (phi_iFwd-phi_iBwd)./2; %TODO 11: Line to complete
    phi_jcent   = (phi_jFwd-phi_jBwd)./2; %TODO 12: Line to complete
    
    %A and B estimation (A y B from the Pascal Getreuer's IPOL paper "Chan
    %Vese segmentation
    A = mu./(sqrt((eta^2)+(phi_iFwd.^2)+(phi_jcent.^2))); %TODO 13: Line to complete
    B = mu./(sqrt((eta^2)+(phi_jFwd.^2)+(phi_icent.^2))); %TODO 14: Line to complete
    
    
    %%Equation 22, for inner points
    mediate= (phi +(dt.* delta_phi .*(A.*circshift(phi,-1,1) ...
        + circshift(A,1,1).*circshift(phi,1,1) + B.*circshift(phi,-1,2)...
        + circshift(B,1,2).*circshift(phi,1,2) - nu -lambda1.*((I-c1).^2)+lambda2.*((I-c2).^2))))...
        ./(1+(dt .* delta_phi .*(A + circshift(A,1,1) + B + circshift(B,1,2)))); %TODO 15: Line to complete
    
    phi(2:(end-1), 2:(end-1))= mediate(2:(end-1), 2:(end-1));
    
    %Reinitialization of phi
    if reIni>0 && mod(nIter, reIni)==0
        indGT = phi >= 0;
        indLT = phi < 0;
        
        phi=double(bwdist(indLT) - bwdist(indGT));
        
        %Normalization [-1 1]
        nor = min(abs(min(phi(:))), max(phi(:)));
        phi=phi/nor;
    end
  
    %Diference. This stopping criterium has the problem that phi can
    %change, but not the zero level set, that it really is what we are
    %looking for.
    dif = mean(sum( (phi(:) - phi_old(:)).^2 ))
          
    %Plot the level sets surface
    subplot(1,2,1) 
        %The level set function
        surfc(phi)  %TODO 16: Line to complete
        shading interp  %added to better show the Phi function
        hold on
        %The zero level set over the surface
        contour(phi >= 0,'r'); %TODO 17: Line to complete
        hold off
        title('Phi Function');
    
    %Plot the curve evolution over the image
    subplot(1,2,2)
        imagesc(I);        
        colormap gray;
        hold on;
        contour(phi >= 0,'r') %TODO 18: Line to complete
        title('Image and zero level set of Phi')

        axis off;
        hold off
    drawnow;
    pause(.0001); 
end