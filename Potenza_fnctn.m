function[exectime, data] = Potenza_fnctn(segment, data)

switch segment
    case 1
        temp_msg = ttTryFetch('power_signal');
        if ~isempty(temp_msg)
            data.potenza = temp_msg.messaggio.potenza;
            data.timeStamp = temp_msg.timeStamp;
            exectime = 0.03;
        end
    case 2
        if data.potenza ~= 0
            ttAnalogOut(1, data.potenza);
        end
        exectime = 0.02;
    case 3
        exectime = -1;
end