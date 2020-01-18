%msg = randi([0 1],120,1);

msg_base = 'BED723476B8FB3145EFB3559';
msg_b2 = reshape(msg_base,2,[])';
msg_b3 = dec2bin(hex2dec(msg_b2));

msg_b4 =  (reshape(fliplr(msg_b3)',1,[]));
msg = repmat(bin2dec(msg_b4'),126,1)';


%msg = zeros(32,1);

%poly:100000100110000010001110110110111;0x04C11DB7
poly = [1 0 0 0 0 0 1 0 0 1 1 0 0 0 0 0 1 0 0 0 1 1 1 0 1 1 0 1 1 0 1 1 1];

gen    = comm.CRCGenerator([32 26 23 22 16 12 11 10 8 7 5 4 2 1 0],'InitialConditions',ones(1,32),'FinalXOR',ones(1,32));
detect = comm.CRCDetector([32 26 23 22 16 12 11 10 8 7 5 4 2 1 0],'InitialConditions',ones(1,32),'FinalXOR',ones(1,32));
%'z^32 + z^26 + z^23 + z^22 + z^16 + z^12 + z^11 + z^10 + z^8 + z^7 + z^5 + z^4 + z^2 + z + 1'
%gen = crc.generator('Polynomial', '[32 26 23 22 16 12 11 10 8 7 5 4 2 1 0]', 'InitialState', '0xFFFF','ReflectInput', false, 'ReflectRemainder', false,'FinalXOR', '0x0000');
%codeword = step(gen,msg);

%crc32 = dec2hex(bin2dec(dec2bin(codeword(end-32:end))'))
%codeword(end) = not(codeword(end));
%[~,err] = step(detect,codeword)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rand('seed',1);
%msg = randi([0 1],1,164);

%CRC4 = z^4 + z^3 + z^2 + z + 1'
%poly = [1 1 1 1 1];
tic;
crc32 = long_div_v2_crc(msg,poly);
dec2hex(bin2dec(dec2bin(crc32)'))
toc;

tic;
crc32 = long_div_v1_crc(msg,poly);
dec2hex(bin2dec(dec2bin(crc32)'))
toc;

tic;
crc32 = long_div_parallel_crc(msg,poly);
dec2hex(bin2dec(dec2bin(crc32)'))
toc;

