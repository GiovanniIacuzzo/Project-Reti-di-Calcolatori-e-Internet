function[exectime, data] = nethandsens_fnctn(segment, data)

temp = ttGetMsg;
%disp('Gateway: messaggio ricevuto...');
%disp('Contenuto di temp:');
%disp(['Tipo: ' temp.type]);
%disp(['Messaggio: ' temp.messaggio]);

ttTryPost(temp.type, temp);

ttCreateJob('Task_Potenza');


exectime = -1;
