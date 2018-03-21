%Sea Radio-Wave Propagation Loss

PL_target = [-100.201575143161]; %126.6910;

ht = 227;
hr = 2;
freq = 1910; %1910; %MHz
lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132;
d = d_init;

FSPL = 20*log10(d*10^-3)+ 20*log10(freq)+32.44; % f(MHz)  & d(km)
PL_0 = FSPL;
PL_1 = 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2);
PL_boat = 10;
PL_earth = 0;
alpha = 5;
PL_sea_path = PL_0 + PL_1 + PL_boat + PL_earth + alpha;

R = 6.378*(10^6);
d_losh = (sqrt(2*(R)*(ht))+sqrt(2*(R)*(hr)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        PL_res = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
    
    PL_res(d) = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
 %   PL_res = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign
        %value_sign = new_sign;
        
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = 20*log10(d*10^-3)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = 20*log10(d)+ 20*log10(freq)+32.44 + 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2) + PL_boat + PL_earth + alpha;
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end
range_SRWPL = d/(10^3);
FSPL = 20*log10(d*10^-3)+ 20*log10(freq)+32.44; % f(MHz)  & d(km)
PL_0 = FSPL;
PL_1 = 10*log10(4*sin((2*pi*hr*ht)/(lambda*d))^2);
PL_boat = 10;
PL_earth = 0;
alpha = 5;
PL_sea_path = PL_0 + PL_1 + PL_boat + PL_earth + alpha;

%%
%3-Ray Path Loss

PL_target = 500; %117.7529;

ht = 30;
hr = 2;
he = 30.5;
freq = 1910; %1910; %MHz
lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132; %d in meters
d = d_init;

d_break = (4*hr*ht)/lambda;

if (d < d_break || d == d_break)
    
    L3_ray = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

elseif (d > d_break)
   
    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
    L3_ray = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
end

d_losh = (sqrt(2*(6.378*(10^6))*(ht)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        
        if (d < d_break || d == d_break)
    
            PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

        elseif (d > d_break)
   
            delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
            PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
        end
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
    
    %For graphing
    if (d < d_break || d == d_break)

        PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

    elseif (d > d_break)

        delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
        PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
    end
   

%     if (d < d_break || d == d_break)
% 
%         PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
% 
%     elseif (d > d_break)
% 
%         delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
%         PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
%     end

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign       
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                
                if (d < d_break || d == d_break)

                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

                elseif (d > d_break)

                    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
                end
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                if (d < d_break || d == d_break)

                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

                elseif (d > d_break)

                    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
                    PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
                end
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end

range_3ray = d;

if (d < d_break || d == d_break)
    
    L3_ray = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

elseif (d > d_break)
   
    delta = 2*sin((2*pi*hr*ht)/(lambda*d)) *2*sin((2*pi*(he-hr)*(he-ht))/(lambda*d));
    L3_ray = -10*log10(((lambda/(4*pi*d))^2)*(2*(1+delta))^2);    
end


%%
%2-Ray Path Loss

PL_target = 200; %117.7529;

ht = 30;
hr = 2;

freq = 1910; %1910; %MHz
lambda = physconst('LightSpeed')/(freq*10^6);
d_init = 0.001; %11.132; %d in meters
d = d_init;


L2_ray =-10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

d_losh = (sqrt(2*(6.378*(10^6))*(ht)));

fin_flag = 0;

while (fin_flag == 0)
    
    if d == d_init
        
        PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
        
        value_check = PL_res - PL_target;
        value_sign = sign(value_check);
        
        d = 1;
       
    end
       
    %For graphing
%     PL_res(d) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
   
    PL_res = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

    value_check = PL_res - PL_target;
    new_sign = sign(value_check);
    
    if new_sign == value_sign       
        d = d+1;
    else
        if d ==1
            narrow_d = d_init:(d_init/10):d;
            
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                
                PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
            
            
        else
            
            narrow_d = (d-1):0.01:d;
            
            loop_max = numel(narrow_d);
            for ind = 1:loop_max
                d = narrow_d(ind);
                PL_res(ind) = -10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);
            end
            
            [~,i] = min(abs(PL_res-PL_target));
            d = narrow_d(i);
            
            fin_flag = 1;
        
        end        
    end
    
    if d == round(d_losh)
        fin_flag = 1;
    end
end

range_2ray = d;

L2_ray =-10*log10(((lambda/(4*pi*d))^2)*(2*sin((2*pi*hr*ht)/(lambda*d)))^2);

