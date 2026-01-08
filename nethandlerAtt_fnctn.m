function [exectime, data] = nethandlerAtt_fnctn(segment, data)
% Legge dalla rete (interfaccia 1, l'unica collegata)
temp = ttGetMsg;

% DEBUG CRITICO
disp('--------------------------------------------------');
disp(['[ATTUATORE-HW] INTERRUPT RICEVUTO! Tipo: ' temp.type]);

if strcmp(temp.type, 'cmd_signal')
    ttTryPost('cmd_signal', temp);
    ttCreateJob('Task_Attuatore');
    disp('   > Task Attuatore SVEGLIATO.');
else
    disp('   > Messaggio ignorato (tipo errato).');
end
disp('--------------------------------------------------');

exectime = -1;