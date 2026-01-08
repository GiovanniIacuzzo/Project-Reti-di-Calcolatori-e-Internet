function Controllore_init
ttInitKernel('prioFP');

% Mailbox unica per il vettore di stato dai sensori
ttCreateMailbox('state_vector', 10);

% Parametri energetici
ttSetKernelParameter('energyconsumption', 0.04);

% Creazione Task Controllore
nome_c = 'Task_Controllore';
deadline = 0.020; % Deadline rilassata leggermente
funzione = 'Controllore_fnctn';
ttCreateTask(nome_c, deadline, funzione);
ttSetPriority(1, nome_c);

% Network Handler
nome_hd = 'nw_handlerControllore';
funzione_hd = 'nethandlerControllore_fnctn';
ttCreateHandler(nome_hd, 1, funzione_hd);
ttAttachNetworkHandler(nome_hd); % Attach automatico alla rete connessa

% Log
ttCreateLog(nome_c, 1, 'ControlloreRespTime', 2000);