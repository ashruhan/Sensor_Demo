%% Setting up DDS requirments to publish frames;

dp = DDS.DomainParticipant(...
    'DocBox_Library::dim15_MDPnP_Profile', 0);
dp.addWriter('VideoMat', 'VideoMat_TOPIC');

assignin('base','VideoMat',VideoMat());
%% Setting up the video Stream
vid = imaq.VideoDevice('linuxvideo', 1);
set(vid, 'ReturnedDataType','uint8')

%% Setting up timer 

ValRead=timer('Period',.08, 'ExecutionMode', 'fixedSpacing', 'BusyMode', 'queue');
ValRead.TimerFcn = {@VideoDDS_TX,vid,dp};
start(ValRead);
releaseCam