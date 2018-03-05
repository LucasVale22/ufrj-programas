vs = 343;
d = 0.2;
fs = 4000;

while(fs <= 32000) 
    beta = vs/(2*d*fs);
    dphi0 = (acos(1-beta)*180)/pi;
    i=1;
    for k = 0:0.1:180
       phi(i) = k; 
       dphimax(i) = min(dphi0,beta/sin((phi(i)*pi)/180)); 
       i = i+1;
    end
    grid on;
    handle = plot(phi(1:100),dphimax(1:100));
    set(handle,'LineWidth',[1.5]);
    xlabel('Azimuth \phi in deg.'), ylabel('Max. error magnitude in deg.');
    title(['Maximum azimuth error magnitude']);
    hold on;
    fs = fs*2;
end


