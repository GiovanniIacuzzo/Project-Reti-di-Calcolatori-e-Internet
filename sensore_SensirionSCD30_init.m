function sensore_SensirionSCD30_init

ttInitKernel('prioFP');

ttCreateMailbox('power_signal', 10);
ttSetKernelParameter('energyconsumption', 0.010);

% creazione del task sensore
nome_s = 'Task_Sensore_Co2';
startTime = 0.0;
periodo = 1;
funzione = 'Sensore_co2_fnctn';

% task periodico
ttCreatePeriodicTask(nome_s, startTime, periodo, funzione);

prio = 1;
ttSetPriority(prio, nome_s);

nome_s1 = 'Task_Potenza';
deadline = 0.010;
funzione1 = 'Potenza_fnctn';

% creazione del Task
ttCreateTask(nome_s1, deadline, funzione1);

prio = 2;
ttSetPriority(prio, nome_s1);

% creazione del network handler
nome_nh = 'nw_handlersens';
funzione_nh = 'nethandsens_fnctn';

ttCreateHandler(nome_nh, 1, funzione_nh);
ttAttachNetworkHandler(1, nome_nh);

% Log Sensore Temperatura
ttCreateLog(nome_s, 1, 'TemperaturaResponseTime', 2000);
ttCreateLog(nome_s, 2, 'TemperaturaReleaseLatency', 2000);
ttCreateLog(nome_s, 3, 'TemperaturaStartLatency', 2000);
ttCreateLog(nome_s, 4, 'TemperaturaExecutionTime', 2000);
