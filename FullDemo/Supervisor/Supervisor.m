%% Get it
GuiOutline
%% Setting up Readers 
dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);

%Digital Voltage stream
dp.addReader('DIMT_NumericObsVal','DIMT_NumericObsValTopic');
dp.Subscribers(1).Readers(1).ReadTake = ReadMethodType.TAKE; 

%% Setting up timer 
RXRead1 = timer('Period',.001, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
RXRead1.TimerFcn = {@VideoSens, dp};

%Digital Voltage stream sampling @ 2KHz
RXRead2 = timer('Period',.001, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
RXRead2.TimerFcn = {@NuObsSens, dp};

% Start Timers
start(RXRead1);
start(RXRead2);
