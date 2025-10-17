function[exectime, data] = Gateway_fnctn(segment, data)

switch segment
    case 1
        temp_umid_msg = ttTryFetch('temp_umid_signal');
        if ~isempty(temp_umid_msg)
            data.temperatura = temp_umid_msg.messaggio_temp;
            data.umidita = temp_umid_msg.messaggio_umid;
            data.timeStamp = temp_umid_msg.timeStamp;
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

    case 3
    if data.temperatura ~= 0
        msg.messaggio.temp = data.temperatura;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'temp_umid_signal';
        ttSendMsg([2 2], msg, 80);
    else
        %disp('Gateway: non posso inoltrare valore temperatura...');
    end
    
    if data.umidita ~= 0
        msg.messaggio.umidT = data.umidita;
        msg.messaggio.time = data.timeStamp;
        msg.type = 'temp_umid_signal';
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

