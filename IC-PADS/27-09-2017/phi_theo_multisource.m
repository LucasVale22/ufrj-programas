function [phi, phi2, ind2, dt, dt2] = phi_theo_multisource (v, t90, sentido, dist_source_mic, dist_source_source, heigth_mic, T, mic_ver)
% Parameters corresponding to teste_20km
sound_speed = 343;

t=0;
ind2=0:0.1:T;
for t2=0:0.1:T
    t=t+1;
    l(t) = ((t2 - t90)*v/3.6); % Distance in METERS. Scaling factor of 1/3.6 to convert km/h -> m/s
    d = 0.2;
    d1 = sqrt( l(t)^2 + (heigth_mic)^2 + (dist_source_mic)^2 );
    d2 = sqrt( (l(t) )^2 + (heigth_mic + d)^2 + (dist_source_mic)^2 );
    delta(t) = d2 - d1;
    d3 = sqrt( (l(t)- dist_source_source)^2 + (heigth_mic)^2 + (dist_source_mic)^2 );
    d4 = sqrt( (l(t)- dist_source_source)^2 + (heigth_mic + d)^2+(dist_source_mic)^2 );
    delta(t) = d2 - d1;
    delta2(t) = d4 - d3;
    
    if sentido == '0° -> 180°' & mic_ver ~= 4
        delta(t) = -delta(t);
        delta2(t) = -delta2(t); 
    end
     
    dt(t) = delta(t)/sound_speed;
    dt2(t) = delta2(t)/sound_speed;
    phi(t) = acos( delta(t)/d ) * 180/pi;
    phi2(t) = acos( delta2(t)/d ) * 180/pi;
end

end

