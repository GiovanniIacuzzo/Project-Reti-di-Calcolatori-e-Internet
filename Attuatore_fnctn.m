function [exectime, data] = Attuatore_fnctn(segment, data)
% Variabili per calcolo metriche
persistent total_bits start_time last_arrival_time

if isempty(total_bits)
    total_bits = 0;
    start_time = 0.0;
    last_arrival_time = 0.0;
end

switch segment
    case 1
        % Tentativo di lettura del pacchetto di comando
        cmd_msg = ttTryFetch('cmd_signal');
        
        if ~isempty(cmd_msg)
            current_time = ttCurrentTime;
            
            % --- 1. CALCOLO RESPONSE TIME (End-to-End Latency) ---
            if isfield(cmd_msg, 'timeStamp') && cmd_msg.timeStamp > 0
                response_time = current_time - cmd_msg.timeStamp;
            else
                response_time = 0;
            end
            
            % --- 2. CALCOLO THROUGHPUT ---
            % Stimiamo la dimensione del pacchetto di comando (es. 100 bit)
            pkt_size = 100; 
            total_bits = total_bits + pkt_size;
            
            % Se è il primo pacchetto, avviamo il timer
            if start_time == 0
                start_time = current_time;
            end
            
            duration = current_time - start_time;
            if duration > 0.001 % Evitiamo divisione per zero all'inizio
                throughput = total_bits / duration;
            else
                throughput = 0;
            end
            
            % --- 3. CALCOLO JITTER (Variazione Inter-arrivo) ---
            if last_arrival_time > 0
                inter_arrival = current_time - last_arrival_time;
                % Qui calcoliamo il jitter istantaneo (differenza tra arrivi)
                % Per il jitter statistico servirebbe la deviazione standard,
                % ma questo dà già un'idea della stabilità.
                jitter = inter_arrival; 
            else
                jitter = 0;
            end
            last_arrival_time = current_time;

            % --- OUTPUT SU SIMULINK ---
            % 1-4: Dati Fisici
            ttAnalogOut(1, cmd_msg.temp_orig);
            ttAnalogOut(2, cmd_msg.umid_orig);
            ttAnalogOut(3, cmd_msg.co2_orig);
            ttAnalogOut(4, cmd_msg.potenza_target);
            
            ttAnalogOut(5, response_time); % Latenza totale
            ttAnalogOut(6, throughput);    % bps
            
            % Log periodico (ogni 2 secondi circa)
            if mod(round(current_time), 2) == 0
               disp(['[METRICS] Latency: ' num2str(response_time*1000) 'ms | TP: ' num2str(throughput) ' bps']);
            end
            
        else
            % Mailbox vuota
        end
        exectime = 0.005; 
        
    case 2
        exectime = -1; 
end