function crc = long_div_v2_crc(msg,poly)

bits = [msg,zeros(1,length(poly)-1)];
Nx = [ones(1,length(poly)-1),zeros(1,length(msg))];

[~,r1] = gfdeconv(fliplr(bits),fliplr(poly));
[~,r2] = gfdeconv(fliplr(Nx),fliplr(poly));

r1f = [r1,zeros(1,length(poly)-1-length(r1))];
r2f = [r2,zeros(1,length(poly)-1-length(r2))];

crc = gfadd(gfadd(r1f,r2f),ones(1,length(poly)-1));

end