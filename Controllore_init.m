function Controllore_init

ttInitKernel('prioFP');

ttCreateMailbox('temp_umid_signal', 10);
ttCreateMailbox('co2_signal', 10);

ttSetKernelParameter('energyconsumption', 0.04);

nome_c = 'Task_Controllore';
deadline = 0.010;
funzione = 'Controllore_fnctn';

%Creazione del Task controllore
ttCreateTask(nome_c, deadline, funzione);

prio = 1;
ttSetPriority(prio, nome_c);

nome_hd = 'nw_handlerControllore';
funzione_hd = 'nethandlerControllore_fnctn';

ttCreateHandler(nome_hd, 1, funzione_hd);
ttAttachNetworkHandler(nome_hd);

ttCreateLog(nome_c, 1, 'ControlloreResponseTime', 2000);
ttCreateLog(nome_c, 2, 'ControlloreReleaseLatency', 2000);
ttCreateLog(nome_c, 3, 'ControlloreStartLatency', 2000);
ttCreateLog(nome_c, 4, 'ControlloreExecutionTime', 2000);
