function [t_teo,phi_teo,dt] = theo_phi(v,sentido,qtdeCarros,x1,fs,t90)


N_sampx = length(x1);  %numero total de amostras do sinal reamostrado

tempoTotal = N_sampx/fs;


transicao(1)=0;
transicao(qtdeCarros+1)=tempoTotal;
if qtdeCarros > 1
    for i = 2:qtdeCarros
        transicao(i) = (t90(i-1)+t90(i))/2;
    end
end

t=0;
t_teo = transicao(1):0.01:transicao(qtdeCarros+1);
phi_teo=zeros(length(t_teo),1);

for i=1:qtdeCarros     
    
    for passo = transicao(i):0.01:transicao(i+1)
        t=t+1;
        l(t)=((passo-t90(i))*v*10/36);
        d=0.2;
        d1=sqrt(l(t)^2+(1.26)^2+(4.3)^2);
        d2=sqrt((l(t)+d)^2+(1.26)^2+(4.3)^2);
        delta(t)=d2-d1;
        if sentido == '0° -> 180°'
           delta(t) = -delta(t); 
        end
        
        dt=delta(t)/343;
        
        phi_teo(t)=acos(delta(t)/0.2)/pi*180;
    end
    
    transicao(i+1)=transicao(i+1)+0.01;
    
end

end