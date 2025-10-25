function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');
        
        if ~isempty(temp_msg)
            data.temperatura = temp_msg.messaggio_temp;
            data.timeStamp = temp_msg.timeStamp;
            %disp(['Gateway: valore temperatura ricevuto: ' num2str(data.temperatura) ]);
            if ttCurrentTime > 60 && ttCurrentTime < 65
                disp('[Gateway](1): pacchetto temperatura');
            end
            if ttCurrentTime > 300 && ttCurrentTime < 305
                disp('[Gateway](2): pacchetto temperatura');
            end
            if ttCurrentTime > 540 && ttCurrentTime < 545
                disp('[Gateway](3): pacchetto temperatura');
            end
        else
            %disp('Gateway: nessun valore temperatra ricevuto...');
        end

        exectime = 0.002;

    case 2
        umid_msg = ttTryFetch('umid_signal');
        
        if ~isempty(umid_msg)
            data.umidita = umid_msg.messaggio_umidita;
            data.timeStamp = umid_msg.timeStamp;
            % disp(['Gateway: valore umidita ricevuto: ' num2str(data.umidita) ]);
            if ttCurrentTime > 60 && ttCurrentTime < 65
                disp('[Gateway](1): pacchetto temperatura');
            end
            if ttCurrentTime > 300 && ttCurrentTime < 305
                disp('[Gateway](2): pacchetto temperatura');
            end
            if ttCurrentTime > 540 && ttCurrentTime < 545
                disp('[Gateway](3): pacchetto temperatura');
            end
        else
            % disp('Gateway: nessun valore umidità ricevuto...');
        end

        exectime = 0.002;
    case 3
        co2_msg = ttTryFetch('co2_signal');
        if ~isempty(co2_msg)
            data.co2 = co2_msg.messaggio;
            data.timeStamp = co2_msg.timeStamp;
            %disp(['Gateway: valore co2 ricevuto: ' num2str(data.co2_msg) ]);
            if ttCurrentTime > 60 && ttCurrentTime < 65
                disp('[Gateway](1): pacchetto temperatura');
            end
            if ttCurrentTime > 300 && ttCurrentTime < 305
                disp('[Gateway](2): pacchetto temperatura');
            end
            if ttCurrentTime > 540 && ttCurrentTime < 545
                disp('[Gateway](3): pacchetto temperatura');
            end
        else
            %disp('Gateway: nessun valore temperatra ricevuto...');
        end

        exectime = 0.002;

    case 4
    if data.temperatura ~= 0
        msg.messaggio.temp = data.temperatura;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'temp_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore temperatura...');
    end
    
    if data.umidita ~= 0
        msg.messaggio.umidita = data.umidita;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'umid_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore umidità...');
    end

    if data.co2 ~= 0
        msg.messaggio.co2 = data.co2;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'co2_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore co2...');
    end

    if ttCurrentTime > 60 && ttCurrentTime < 65
        disp('[Gateway](1): mando al controllore');
    end
    if ttCurrentTime > 300 && ttCurrentTime < 305
        disp('[Gateway](2): mando al controllore');
    end
    if ttCurrentTime > 540 && ttCurrentTime < 545
        disp('[Gateway](3): mando al controllore');
    end

    exectime = -1;
end

