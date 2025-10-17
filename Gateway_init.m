function Gateway_init

ttInitKernel('prioFP');

ttCreateMailbox('temp_umid_signal', 10);
ttCreateMailbox('co2_signal', 10);
ttCreateMailbox('control_signal', 10);

% creazione gateway
nome_g1 = 'Task_Gateway';
deadline = 0.010;
funzione1 = 'Gateway_fnctn';

% creazione del Task
ttCreateTask(nome_g1, deadline, funzione1);

prio = 1;
ttSetPriority(prio, nome_g1);

% creazione del network handler
nome_nh = 'nw_handlergat';
funzione_nh = 'nethandgat_fnctn';

ttCreateHandler(nome_nh, 1, funzione_nh);
ttAttachNetworkHandler(1, nome_nh);

% Log Gateway
ttCreateLog(nome_g1, 1, 'GatewayResponseTime', 2000);
ttCreateLog(nome_g1, 2, 'GatewayReleaseLatency', 2000);
ttCreateLog(nome_g1, 3, 'GatewayStartLatency', 2000);
ttCreateLog(nome_g1, 4, 'GatewayExecutionTime', 2000);

% creazione gateway
nome_g2 = 'Task_Gateway2';
funzione2 = 'Gateway2_fnctn';

% creazione del Task
ttCreateTask(nome_g2, deadline, funzione2);

ttSetPriority(prio, nome_g2);

% creazione del network handler
nome_nh1 = 'nw_handlergat1';
funzione_nh1 = 'nethandgat1_fnctn';

ttCreateHandler(nome_nh1, 1, funzione_nh1);
ttAttachNetworkHandler(2, nome_nh1);

% Log Gateway2
ttCreateLog(nome_g2, 1, 'Gateway2ResponseTime', 2000);
ttCreateLog(nome_g2, 2, 'Gateway2ReleaseLatency', 2000);
ttCreateLog(nome_g2, 3, 'Gateway2StartLatency', 2000);
ttCreateLog(nome_g2, 4, 'Gateway2ExecutionTime', 2000);
