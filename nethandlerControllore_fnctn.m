function[exectime, data] = nethandlerControllore_fnctn(segment, data)

temp = ttGetMsg;
%disp('Controllore: messaggio ricevuto...');
%disp('Contenuto di temp:');
%disp(['Tipo: ' temp.type]);
%disp(['Messaggio: ' temp.messaggio]);

ttTryPost(temp.type, temp.messaggio);

ttCreateJob('Task_Controllore')

exectime = -1;
