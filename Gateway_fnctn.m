function [exectime, data] = Gateway_fnctn(segment, data)
% Variabili persistenti per logica e metriche
persistent last_temp last_umid last_co2 
persistent total_bits start_time
persistent ts_env ts_co2 % Timestamp originari dei sensori

% Inizializzazione
if isempty(last_temp)
    disp('[Gateway1] Inizializzazione variabili.');
    last_temp = 0.0;
    last_umid = 0.0;
    last_co2 = 0.0;
    
    % Metriche
    total_bits = 0;
    start_time = ttCurrentTime;
    
    % Timestamp (inizializzati a current per evitare errori al primo giro)
    ts_env = ttCurrentTime;
    ts_co2 = ttCurrentTime;
end

switch segment
    case 1
        % Tentativo ricezione pacchetto Ambientale
        msg_env = ttTryFetch('env_signal');
        if ~isempty(msg_env)
            last_temp = msg_env.temp;
            last_umid = msg_env.umid;
            
            % Aggiorniamo il timestamp di origine (se presente)
            if isfield(msg_env, 'timeStamp')
                ts_env = msg_env.timeStamp;
            else
                ts_env = ttCurrentTime;
            end
            
            % Aggiornamento Metriche (80 bit stimati)
            total_bits = total_bits + 80;
            
            disp(['[Gateway1] @' num2str(ttCurrentTime) 's -> RICEVUTO Temp: ' num2str(last_temp) ' Umid: ' num2str(last_umid)]);
        end
        exectime = 0.001;
        
    case 2
        % Tentativo ricezione pacchetto CO2
        msg_co2 = ttTryFetch('co2_signal');
        if ~isempty(msg_co2)
            last_co2 = msg_co2.messaggio;
            
            % Aggiorniamo timestamp origine
            if isfield(msg_co2, 'timeStamp')
                ts_co2 = msg_co2.timeStamp;
            else
                ts_co2 = ttCurrentTime;
            end
            
            % Aggiornamento Metriche
            total_bits = total_bits + 80;
            
            disp(['[Gateway1] @' num2str(ttCurrentTime) 's -> RICEVUTO CO2: ' num2str(last_co2)]);
        end
        exectime = 0.001;
        
    case 3
        % Costruzione pacchetto di stato COMPLETO
        packet_out.temp = last_temp;
        packet_out.umid = last_umid;
        packet_out.co2 = last_co2;
        
        % --- PROPAGAZIONE TIMESTAMP (PER LATENZA END-TO-END) ---
        % Prendiamo il timestamp più "vecchio" tra i dati disponibili.
        % Questo rappresenta l'età del dato più obsoleto che stiamo usando per il controllo.
        packet_out.timeStamp = min(ts_env, ts_co2);
        
        packet_out.type = 'state_vector';
        
        % --- CALCOLO E OUTPUT THROUGHPUT ---
        elapsed = ttCurrentTime - start_time;
        if elapsed > 0
            gw_throughput = total_bits / elapsed;
        else
            gw_throughput = 0;
        end
        % Invio Throughput su Simulink (Canale 1) per salvarlo
        ttAnalogOut(1, gw_throughput);
        
        % Log invio
        disp(['[Gateway1] -> INOLTRO al Controllore. TP: ' num2str(gw_throughput) ' bps']);
        
        % Invio sulla Rete 2 al Nodo 2 (Controllore)
        ttSendMsg([2 2], packet_out, 120); 
        
        exectime = -1; 
end