function[exectime, data] = Gateway2_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('control_signal');
        if ttCurrentTime > 60 && ttCurrentTime < 65
            disp('[Gateway](1): ricevuto controllore');
        end
        if ttCurrentTime > 300 && ttCurrentTime < 305
            disp('[Gateway](2): ricevuto controllore');
        end
        if ttCurrentTime > 540 && ttCurrentTime < 545
            disp('[Gateway](3): ricevuto controllore');
        end
        temp_msg.type = 'control_signal';
        data.timeStamp = temp_msg.timeStamp;
        
        data.temperatura = temp_msg.messaggio.temperatura;
        data.umidita = temp_msg.messaggio.umidita;
        data.co2 = temp_msg.messaggio.co2;
        data.potenza = temp_msg.messaggio.potenza;

        exectime = 0.03;
    
    case 2
        if data.temperatura ~= 0
            msg.messaggio = data.temperatura;
            msg.type = 'temp_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end

        if data.umidita ~= 0
            msg.messaggio = data.umidita;
            msg.type = 'umid_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end
       
        if data.co2 ~= 0
            msg.messaggio = data.co2;
            msg.type = 'co2_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end
        
        if data.potenza ~= 0
            msg.messaggio = data.potenza;
            msg.type = 'p_signal';
            ttSendMsg([3 1], msg, 80);
        else
            disp('errore');
        end

        if ttCurrentTime > 60 && ttCurrentTime < 65
            disp('[Gateway](1): mando attuatore');
        end
        if ttCurrentTime > 300 && ttCurrentTime < 305
            disp('[Gateway](2): mando attuatore');
        end
        if ttCurrentTime > 540 && ttCurrentTime < 545
            disp('[Gateway](3): mando attuatore');
        end

        exectime = -1;
end