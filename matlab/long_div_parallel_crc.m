%abc 
%parallel alghrithm

function crc = long_div_parallel_crc(msg,poly,blen)
if nargin < 3
    blen = 64;
end
%blen = 64;


bits = msg;
tlen = length(bits);
ccnt = floor(tlen/blen);    %block count
rcnt = mod(tlen,blen);      %last block

crc = zeros(1,length(poly)-1);
vbits = zeros(ccnt,tlen+length(poly)-1);
if ccnt > 0   %block part
    %parpool(16);
    %p = gcp('nocreate');
    for i=1:ccnt
            vbits(i,:) = [zeros(1,(i-1)*blen),bits(i*blen-blen+1:i*blen), zeros(1,(ccnt-i)*blen+rcnt+length(poly)-1)];
    end
    
    parfor i=1:ccnt
        %vbits = [bits(i*blen-blen+1:i*blen), zeros(1,(ccnt-i)*blen+rcnt+length(poly)-1)];
        tmp_bits = vbits(i,:);
        tmp_bits = tmp_bits((i-1)*blen+1:end);
        [~,r] = gfdeconv(fliplr(tmp_bits),fliplr(poly));
        rf = [r,zeros(1,length(poly)-1-length(r))];
        crc = gfadd(crc,rf);
    end
    %delete(gcp('nocreate'))
end

if rcnt > 0     %last block
    vbits = [bits(ccnt*blen+1:end), zeros(1,length(poly)-1)];
    [~,r] = gfdeconv(fliplr(vbits),fliplr(poly));
    rf = [r,zeros(1,length(poly)-1-length(r))];
    crc = gfadd(crc,rf);
end

Nx = [ones(1,length(poly)-1),zeros(1,tlen)];

[~,r] = gfdeconv(fliplr(Nx),fliplr(poly));
rf = [r,zeros(1,length(poly)-1-length(r))];
crc = gfadd(crc,rf);
crc = gfadd(crc,ones(1,length(poly)-1));

end