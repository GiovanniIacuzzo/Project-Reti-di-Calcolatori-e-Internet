function[exectime, data] = nethandlerAtt_fnctn(segment, data)

temp = ttGetMsg;

ttTryPost(temp.type, temp.messaggio);

ttCreateJob('Task_Attuatore');

exectime = -1;