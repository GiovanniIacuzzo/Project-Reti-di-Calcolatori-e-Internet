function [exectime, data] = nethandgat_fnctn(segment, data)
% Specifichiamo (1) perché leggiamo dalla Rete 1 (Wireless Sensori)
temp = ttGetMsg(1);

% Logica esistente...
ttTryPost(temp.type, temp);
ttCreateJob('Task_Gateway'); 
exectime = -1;