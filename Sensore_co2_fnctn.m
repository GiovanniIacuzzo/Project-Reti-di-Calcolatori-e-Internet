function [exectime, data] = Sensore_co2_fnctn(segment, data)
switch segment
    case 1
        % Salva il tempo di INIZIO
        data.t_start = ttCurrentTime;
        
        val_co2 = ttAnalogIn(1);
        data.msg.messaggio = val_co2;
        
        % Log lettura
        disp(['[SCD30] @' num2str(ttCurrentTime) 's -> Letto CO2: ' num2str(val_co2)]);
        
        % Spostato qui: il timestamp deve essere quello di lettura!
        data.msg.type = 'co2_signal';
        data.msg.timeStamp = data.t_start;
        
        exectime = 0.03;
        
    case 2
        % Log invio
        disp(['[SCD30] @' num2str(ttCurrentTime) 's -> Invio CO2 a Gateway...']);
        ttSendMsg([1 4], data.msg, 80);
        
        % --- CALCOLO METRICA: Reaction Time ---
        reaction_time = ttCurrentTime - data.t_start;
        
        % Invio la metrica su Simulink (Canale 2)
        ttAnalogOut(1, reaction_time);
        
        exectime = 0.02;
        
    case 3
        exectime = -1;
end