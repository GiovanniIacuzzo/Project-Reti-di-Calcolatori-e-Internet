function Attuatore_init
ttInitKernel('prioFP');

% Una sola mailbox per il pacchetto di comando combinato
ttCreateMailbox('cmd_signal', 10);

% Creazione Task Attuatore
nome_c = 'Task_Attuatore';
deadline = 0.010;
funzione_c = 'Attuatore_fnctn';
ttCreateTask(nome_c, deadline, funzione_c);
prio = 1;
ttSetPriority(prio, nome_c);

% Network Handler
nome_hd = 'nw_handlerAttuatore';
funzione_hd = 'nethandlerAtt_fnctn';
ttCreateHandler(nome_hd, 1, funzione_hd);

ttAttachNetworkHandler(3, 'nw_handlerAttuatore');

% Log
ttCreateLog(nome_c, 1, 'AttuatoreResponseTime', 2000);