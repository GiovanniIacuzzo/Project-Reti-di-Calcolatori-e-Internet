function Gateway_init
ttInitKernel('prioFP');

% --- Reti ---
% Rete 1: Sensori (Wireless) -> Riceviamo Env e CO2
ttCreateMailbox('env_signal', 10);
ttCreateMailbox('co2_signal', 10);

% Rete 2: Controllore (Wireless) -> Riceviamo CMD
ttCreateMailbox('cmd_signal', 10);

% --- Task 1: Aggregatore (Verso Controllore) ---
ttCreateTask('Task_Gateway', 0.020, 'Gateway_fnctn');
ttSetPriority(1, 'Task_Gateway');
% Handler Rete 1 (Sensori)
ttCreateHandler('nw_handler_sens', 1, 'nethandgat_fnctn');
ttAttachNetworkHandler(1, 'nw_handler_sens'); 

% --- Task 2: Inoltro (Verso Attuatore) ---
ttCreateTask('Task_Gateway2', 0.020, 'Gateway2_fnctn');
ttSetPriority(2, 'Task_Gateway2');
% Handler Rete 2 (Controllore Wireless)
ttCreateHandler('nw_handler_contr', 1, 'nethandgat1_fnctn'); 
ttAttachNetworkHandler(2, 'nw_handler_contr'); % Ascolta sulla porta 2 (Wireless Controllore)

% Log
ttCreateLog('Task_Gateway', 1, 'Gat1_Resp', 1000);