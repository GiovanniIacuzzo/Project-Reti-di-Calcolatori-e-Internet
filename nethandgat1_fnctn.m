function[exectime, data] = nethandgat1_fnctn(segment, data)

temp = ttGetMsg(2);

ttTryPost(temp.type, temp);

ttCreateJob('Task_Gateway2');

exectime = -1;