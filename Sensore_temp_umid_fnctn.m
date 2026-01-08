function [exectime, data] = Sensore_temp_umid_fnctn(segment, data)
switch segment
    case 1
        % Salva il tempo esatto di INIZIO operazione (Wake up)
        data.t_start = ttCurrentTime;
        
        % Lettura sensori
        temp = ttAnalogIn(1);
        umid = ttAnalogIn(2);
        
        % Log lettura
        disp(['[SHT31] @' num2str(ttCurrentTime) 's -> Letto Temp: ' num2str(temp) ' | Umid: ' num2str(umid)]);
        
        % Preparazione pacchetto unico
        data.msg.temp = temp;
        data.msg.umid = umid;
        data.msg.type = 'env_signal'; 
        
        % IMPORTANTE: Il timestamp è quello di lettura (adesso), non di invio
        data.msg.timeStamp = data.t_start;
        
        exectime = 0.03;
        
    case 2
        % Invio messaggio
        disp(['[SHT31] @' num2str(ttCurrentTime) 's -> Invio pacchetto a Gateway (Nodo 4)...']);
        ttSendMsg(4, data.msg, 80); 
        
        % --- CALCOLO METRICA: Reaction Time ---
        % Tempo attuale (fine invio) - Tempo inizio (wake up)
        reaction_time = ttCurrentTime - data.t_start;
        
        % Invio la metrica su Simulink (Canale 3) per salvarla
        ttAnalogOut(1, reaction_time);
        
        exectime = 0.02;
        
    case 3
        exectime = -1;
end