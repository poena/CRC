function crc = long_div_v1_crc(msg,poly)

bits = msg;
bits(1:32) = 1-bits(1:32);    %head zero
bits = [bits,ones(1,32)];   %tail zero

[~,r] = gfdeconv(fliplr(bits),fliplr(poly));

crc = [r,zeros(1,length(poly)-1-length(r))];

end