function[exectime, data] = Controllore_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('temp_signal');
        
        if ~isempty(temp_msg)
            data.time = temp_msg.time;
            ReactionTime = ttCurrentTime - data.time;
            disp(['Reaction Time temp-umid: ' num2str(ReactionTime)]);
            data.temperatura = temp_msg.temp;
            % disp(['Controllore: valore temperatura ricevuto: ' num2str(data.temperatura)]);
        else
            %disp('Controllore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;

    case 2
        temp_msg = ttTryFetch('umid_signal');
        
        if ~isempty(temp_msg)
            data.time = temp_msg.time;
            ReactionTime = ttCurrentTime - data.time;
            disp(['Reaction Time temp-umid: ' num2str(ReactionTime)]);
            data.umidita = temp_msg.umidita;
            % disp(['Controllore: valore umidita ricevuto: ' num2str(data.umidita)]);
        else
            %disp('Controllore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;

    case 3
        temp_msg = ttTryFetch('co2_signal');

        if ~isempty(temp_msg)
            data.time = temp_msg.time;
            ReactionTime = ttCurrentTime - data.time;
            disp(['Reaction Time (terreno): ' num2str(ReactionTime)]);
            data.co2 = temp_msg.co2;
            %disp(['Controllore: valore co2 ricevuto: ' num2str(data.co2)]);
        else
            %disp('Controllore: non ho ricevuto nessun valore...');
        end

        exectime = 0.02;

    case 4
        ttAnalogOut(1, data.temperatura);
        ttAnalogOut(2, data.umidita);
        ttAnalogOut(3, data.co2);

        data.potenza = ttAnalogIn(1);
        
        msg.timeStamp = ttCurrentTime;
        msg.messaggio.temperatura = data.temperatura;
        msg.messaggio.umidita = data.umidita;
        msg.messaggio.co2 = data.co2;

        msg.messaggio.potenza = data.potenza;
        msg.type = 'control_signal';
        ttSendMsg(4, msg, 80);

        exectime = -1;
end