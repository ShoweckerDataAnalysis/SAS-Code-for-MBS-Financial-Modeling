

data Project_1_MBS;
format 
Beg_Bal dollar15.2 
Default dollar15.2 
Net_Bal dollar15.2 
Payment dollar15.2 
Interest_Pay dollar15.2 
Principle dollar15.2 
Ending_Bal dollar15.2 
Reserve dollar15.2 

Avail_Cash_A dollar15.2 
Beg_Bal_A dollar15.2 
Sched_Pay_A dollar15.2 
Act_Pay_A dollar15.2 
Interest_A dollar15.2 
Principle_A dollar15.2 
End_Bal_A dollar15.2

Avail_Cash_B dollar15.2 
Beg_Bal_B dollar15.2 
End_Bal_B dollar15.2 
Sched_Pay_B dollar15.2 
Act_Pay_B dollar15.2 
Interest_B dollar15.2 
Principle_B dollar15.2 

Avail_Cash_C dollar15.2 
Beg_Bal_C dollar15.2 
End_Bal_C dollar15.2 
Sched_Pay_C dollar15.2 
Act_Pay_C dollar15.2 
Interest_C dollar15.2 
Principle_C dollar15.2;



Reserve = 0;

do Month = 1 to 360;


if Month = 1 then Beg_Bal = 52000000;
else Beg_Bal = Ending_Bal;

Default = Beg_Bal * 0.0025;

Net_Bal = Beg_Bal - Default;

Payment = PMT(0.005, 360 - Month +1, Net_Bal, 0);

Interest_Pay = Net_Bal * 0.005;

Principle = Payment - Interest_Pay;

Ending_Bal = Net_Bal - Principle;

/*Pool A*/
Avail_Cash_A = Payment + Reserve;

if Month = 1 then Beg_Bal_A = 25000000;
else Beg_Bal_A = End_Bal_A;

Sched_Pay_A = pmt(0.004166667, 360 - Month + 1, Beg_Bal_A, 0);

if Avail_Cash_A > Sched_Pay_A then Act_Pay_A = Sched_Pay_A;
else Act_Pay_A = Avail_Cash_A;

Interest_A = Beg_Bal_A * 0.004166667;
Principle_A = Act_Pay_A - Interest_A;
End_Bal_A = Beg_Bal_A - Principle_A;

/*Pool B*/
Avail_Cash_B = Avail_Cash_A - Act_Pay_A;

if Month = 1 then Beg_Bal_B = 20000000;
else Beg_Bal_B = End_Bal_B;

Sched_Pay_B = pmt(0.005833333, 360 - Month + 1, Beg_Bal_B, 0);

if Avail_Cash_B > Sched_Pay_B then Act_Pay_B = Sched_Pay_B;
else Act_Pay_B = Avail_Cash_B;

Interest_B = Beg_Bal_B * 0.005833333;
Principle_B = Act_Pay_B - Interest_B;
End_Bal_B = Beg_Bal_B - Principle_B;

/*Pool C*/
Avail_Cash_C = Avail_Cash_B - Act_Pay_B;

if Month = 1 then Beg_Bal_C = 4000000;
else Beg_Bal_C = End_Bal_C;

Sched_Pay_C = pmt(0.0075, 360 - Month + 1, Beg_Bal_C, 0);

if Avail_Cash_C > Sched_Pay_C then Act_Pay_C = Sched_Pay_C;
else Act_Pay_C = Avail_Cash_C;

Interest_C = Beg_Bal_C * 0.0075;
Principle_C = Act_Pay_C - Interest_C;
End_Bal_C = Beg_Bal_C - Principle_C;

Reserve = Avail_Cash_C - Act_Pay_C;

output;
end;

run;

title "Full Project 1 data - MBS";
proc print data = Project_1_MBS;run;

