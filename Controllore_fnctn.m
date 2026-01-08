function [exectime, data] = Controllore_fnctn(segment, data)
switch segment
    case 1
        % DEBUG: Ingresso nel task
        % disp(['[CONTROLLORE] @' num2str(ttCurrentTime) 's -> Task avviato (Seg 1)']);
        
        % 1. Ricezione Pacchetto Unico dal Gateway 1
        msg = ttTryFetch('state_vector');
        
        if ~isempty(msg)
            % Salviamo i dati nella struttura locale
            data.temp = msg.temp;
            data.umid = msg.umid;
            data.co2 = msg.co2;
            
            % IMPORTANTE: Salviamo il timestamp originale del sensore!
            if isfield(msg, 'timeStamp')
                data.sourceTime = msg.timeStamp;
            else
                data.sourceTime = ttCurrentTime; % Fallback se manca
            end
            
            % DEBUG: Conferma ricezione dati
            disp(['[CONTROLLORE] Dati ricevuti: Temp=' num2str(data.temp) ' | Umid=' num2str(data.umid) ' | CO2=' num2str(data.co2)]);
            
            % 2. Invio dati a SIMULINK (per il Fuzzy)
            ttAnalogOut(1, data.temp);
            ttAnalogOut(2, data.umid);
            ttAnalogOut(3, data.co2);
        else
            % Se la mailbox è vuota
            % disp('[CONTROLLORE] !!! ATTENZIONE: Mailbox vuota !!!');
            data.temp = 0; 
            data.umid = 0;
            data.co2 = 0;
            data.sourceTime = 0;
        end
        exectime = 0.02;
        
    case 2
        % 3. Lettura Potenza calcolata da SIMULINK (Fuzzy Logic)
        potenza_calcolata = ttAnalogIn(1);
        
        % DEBUG: Lettura valore calcolato
        disp(['[CONTROLLORE] Letto da SIMULINK -> Potenza: ' num2str(potenza_calcolata)]);
        
        % 4. Creazione Pacchetto di Controllo per l'Attuatore
        cmd_msg.temp_orig = data.temp;
        cmd_msg.umid_orig = data.umid;
        cmd_msg.co2_orig = data.co2;
        cmd_msg.potenza_target = potenza_calcolata;
        
        % --- PUNTO CRITICO PER LA LATENZA ---
        % Invece di resettare il tempo con ttCurrentTime, passiamo quello originale!
        if data.sourceTime > 0
            cmd_msg.timeStamp = data.sourceTime;
        else
            cmd_msg.timeStamp = ttCurrentTime;
        end
        
        cmd_msg.type = 'cmd_signal'; 
        
        % 5. Invio al Gateway 2 (Nodo 3)
        % disp('[CONTROLLORE] Invio pacchetto comando al Gateway 2...');
        ttSendMsg(3, cmd_msg, 100); 
        
        exectime = -1;
end