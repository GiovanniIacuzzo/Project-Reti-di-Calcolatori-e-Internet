function [exectime, data] = Gateway2_fnctn(segment, data)
persistent total_bits start_time

if isempty(total_bits)
    total_bits = 0;
    start_time = ttCurrentTime;
end

switch segment
    case 1
        % Preleva il pacchetto di comando
        cmd_msg = ttTryFetch('cmd_signal');
        
        if ~isempty(cmd_msg)
            data.packet = cmd_msg;
            
            % Aggiornamento Metriche (Pacchetto comando ~100 bit)
            total_bits = total_bits + 100;
            
            % Log ricezione
            disp(['[Gateway2] @' num2str(ttCurrentTime) 's -> RICEVUTO CMD.']); 
        else
            data.packet = [];
        end
        exectime = 0.01;
        
    case 2
        % Inoltra il pacchetto all'Attuatore
        if ~isempty(data.packet)
            
            % --- CALCOLO THROUGHPUT ---
            elapsed = ttCurrentTime - start_time;
            if elapsed > 0
                gw2_throughput = total_bits / elapsed;
            else
                gw2_throughput = 0;
            end
            % Invio su Simulink (Canale 1)
            ttAnalogOut(1, gw2_throughput);
            
            disp(['[Gateway2] -> INOLTRO Wireless. TP: ' num2str(gw2_throughput) ' bps']);
            
            % Invio sulla Rete 3 (Wireless Attuatore)
            ttSendMsg([3 1], data.packet, 100); 
        end
        exectime = -1;
end