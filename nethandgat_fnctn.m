function[exectime, data] = nethandgat_fnctn(segment, data)

temp = ttGetMsg(1);
%disp('Gateway: messaggio ricevuto...');
%disp('Contenuto di temp:');
%disp(['Tipo: ' temp.type]);
%disp(['Messaggio: ' temp.messaggio]);

ttTryPost(temp.type, temp);

ttCreateJob('Task_Gateway');


exectime = -1;
