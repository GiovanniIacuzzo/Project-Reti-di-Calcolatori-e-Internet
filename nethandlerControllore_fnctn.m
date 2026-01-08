function [exectime, data] = nethandlerControllore_fnctn(segment, data)
% Riceve il pacchetto dalla Rete 2 (Wired)
packet = ttGetMsg;

% Posta il messaggio nella mailbox corrispondente al 'type'
% Nel nostro caso il type sarà 'state_vector' inviato dal Gateway 1
ttTryPost(packet.type, packet);

% Attiva il task
ttCreateJob('Task_Controllore');

exectime = -1;