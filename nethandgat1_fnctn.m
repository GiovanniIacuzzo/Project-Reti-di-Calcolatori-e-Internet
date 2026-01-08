function [exectime, data] = nethandgat1_fnctn(segment, data)
% Specifichiamo (2) perché leggiamo dalla Rete 2 (Wireless Controllore)
temp = ttGetMsg(2); 

disp(['[GATEWAY-HW] Msg su Rete 2. Tipo: ' temp.type]);

if strcmp(temp.type, 'cmd_signal')
    ttTryPost('cmd_signal', temp);
    ttCreateJob('Task_Gateway2');
else
    disp('Msg ignorato.');
end

exectime = -1;