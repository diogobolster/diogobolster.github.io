%rw_taylor

clear
clc
close all

%diffusion coefficient, mean velocity adn radius
D=0.01;
v=1;
a=1;

%timestep
dt=0.1;
N=1e4;

%initial condition
z=zeros(1,N);
x=zeros(1,N);
y=linspace(0,a,N);
r=sqrt(x.^2+y.^2);

Nsteps=1e4;

time=[];
for jj=1:Nsteps
    
   
    %update particle locations via random walk
  
    vel=zeros(size(x)); %all particles outside the tube have zero velocity
    apple=find(r<a);
    vel(apple)=2*v*(1-(r(apple)/a).^2);
    
    
    
    z=z+vel*dt+sqrt(2*D*dt)*randn(size(z));
    
    %It is really hard to write a proper equation to update the radial
    %location, but recognizing that r^2=x^2+y^2 we can di the following 
    %- note this will be much easier for the problem in your homework so 
    %please do not wory about it just yet:
    
    x=x+sqrt(2*D*dt)*randn(size(x));
    y=y+sqrt(2*D*dt)*randn(size(x));
    r=sqrt(x.^2+y.^2);
    
    %Note the 4 in the radial jump - it is correct and I will explain
    
    %reflect particles that exit the domain - i.e. whose radius is bigger
    %than a
    apple=find(r>a);
    r(apple)=2*a-r(apple);
    x(apple)=1/sqrt(2)*r(apple);
   y(apple)=1/sqrt(2)*r(apple);
    r=sqrt(x.^2+y.^2);
    
    if mod(jj,100)==0
        jj
        plot(z,r,'.')
        pause(0.01)
    end
    
    m1(jj)=1/N*sum(z);
    m2(jj)=1/N*sum(z.^2);
    time(jj)=jj*dt;
end

kappa=m2-m1.^2;
figure(2)
plot(time,kappa)