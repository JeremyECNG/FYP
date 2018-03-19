
ht = 200;
hr = 3;
freq = 1910; %1910; %MHz
lambda = physconst('LightSpeed')/(freq*10^6);
d = 6*10^3:1000:42*10^3;



max = numel(d);
for ind = 1:max
    
PL_1(ind) = 4*sin((2*pi*hr*ht)/(lambda*d(ind)))^2;
FSPL(ind) = 20*log10(d(ind)*10^-3)+ 20*log10(freq)+32.44; % f(MHz)  & d(km)

PL(ind) = FSPL(ind) + 10*log10(PL_1(ind));


end

semilogy(d,PL)