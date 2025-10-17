function[exectime, data] = Sensore_temp_umid_fnctn(segment, data)

switch segment
    case 1
        data.msg.messaggio_temp = ttAnalogIn(1);
        data.msg.messaggio_umidita = ttAnalogIn(2);
        exectime = 0.03;
    case 2
        data.msg.type = 'temp_signal';
        data.msg.timeStamp = ttCurrentTime;
        ttSendMsg(3, data.msg, 80);

        data.msg.type = 'umid_signal';
        ttSendMsg(3, data.msg, 80);
        exectime = 0.02;
    case 3
        exectime = -1;
end