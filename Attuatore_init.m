function Attuatore_init

ttInitKernel('prioFP');

ttCreateMailbox('control_signal', 10);
ttCreateMailbox('temp_signal', 10);
ttCreateMailbox('umid_signal', 10);
ttCreateMailbox('co2_signal', 10);
ttCreateMailbox('p_signal', 10);

nome_c = 'Task_Attuatore';
deadline = 10;
funzione_c = 'Attuatore_fnctn';

ttCreateTask(nome_c, deadline, funzione_c);

prio = 1;
ttSetPriority(prio, nome_c);

nome_hd = 'nw_handlerAttuatore';
funzione_hd = 'nethandlerAtt_fnctn';

ttCreateHandler(nome_hd, 1, funzione_hd);
ttAttachNetworkHandler(nome_hd);

ttCreateLog(nome_c, 1, 'AttuatoreResponseTime', 2000);
ttCreateLog(nome_c, 2, 'AttuatoreReleaseLatency', 2000);
ttCreateLog(nome_c, 3, 'AttuatoreStartLatency', 2000);
ttCreateLog(nome_c, 4, 'AttuatoreExecutionTime', 2000);