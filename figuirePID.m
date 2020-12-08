function varargout = figuirePID(varargin)
% FIGUIREPID MATLAB code for figuirePID.fig
%      FIGUIREPID, by itself, creates a new FIGUIREPID or raises the existing
%      singleton*.
%
%      H = FIGUIREPID returns the handle to a new FIGUIREPID or the handle to
%      the existing singleton*.
%
%      FIGUIREPID('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FIGUIREPID.M with the given input arguments.
%
%      FIGUIREPID('Property','Value',...) creates a new FIGUIREPID or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before figuirePID_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to figuirePID_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help figuirePID

% Last Modified by GUIDE v2.5 08-Dec-2020 10:23:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @figuirePID_OpeningFcn, ...
                   'gui_OutputFcn',  @figuirePID_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before figuirePID is made visible.
function figuirePID_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to figuirePID (see VARARGIN)

% Choose default command line output for figuirePID
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes figuirePID wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = figuirePID_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)

% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

analized = struct;

elementSelection = get(handles.uibuttongroup,'SelectedObject');
global strSelection
strSelection= get(elementSelection,'String');
%System Transfer Function Selection
        s = tf('s');
        switch strSelection
            case 'Multiple Equal Poles'
                G= 1/(s+1)
            case 'Fourth Order System'
                G=1/(s+1)/(1 + 0.1*s)/(1 + 0.1^2 * s)/(1+ 0.1^3 *s)
            case 'Right Half Plane Zero'
                G= 1-0.1*s /(s+1)^3 
            case 'Time Delay and Lag'
                G= (1/ (1 + 0.1*s))*exp(-s)
            case 'Time Delay and Double Lag'
                G=(1/ (1 + 0.1*s)^2)*exp(-s)
            case 'Fast and Slow Modes'
                G= (100/(s+10)^2) *((1/s+1) + (0.5/s+0.05))
            case 'Oscillatory System'
                G= 1/(s+1)/(s^2 + 0.2*s + 1)
            case 'Unstable Pole'
                G=1/(s^2 -1)
%             otherwise
%                 G=[]
        end
        % Genetic Algorithm

        %time step
        dt = 0.001;

        %Genetic Algorithm Paremeters
            
        %Population Size of each Iteration
        PopSize = 50;
        options = optimoptions(@ga,'PopulationSize',PopSize,'TolFun',1e-3,'useparallel',true);

        %{
        PID genetic algorithm
        x(1) = Kp
        x(2) = Ti
        x(3)= Td
        x(4)=N
        %}         
        %lower bounds lb 
        lb_PID=[0.001 0.1 0.1 5];
        %upper bounds ub 
        ub_PID=[10 500 50 20];
        [x_PID,IAE] = ga(@(K)pidtest(G,dt,K),4,[],[],[],[],lb_PID,ub_PID,[],options);
        
        K = x_PID(1) + x_PID(2)/s + (x_PID(3)*s)/(1 + s*(x_PID(3)/x_PID(4)));
        
        Loop_PID = series(K,G);
        ClosedLoop_PID = feedback(Loop_PID,1);
        S_PID=stepinfo(ClosedLoop_PID);
        analized.pid = ga_info_to_struct(IAE,x_PID,S_PID,'pid');
        
        Disturb_PID = feedback(G,K);
        S_PID_Dist=stepinfo(Disturb_PID);
        analized.pid_dist =  ga_info_to_struct(IAE,x_PID,S_PID_Dist,'pid');

        
        %{
        I-PD genetic algorithm
        x(1) = Kp
        x(2) = Ti
        x(3)= Td
        x(4)= N
        %}         
        %lower bounds lb 
        lb_PID=[0.001 0.1 0.1 5];
        %upper bounds ub 
        ub_PID=[10 500 50 20];
        [x_IPD,IAE] = ga(@(K)ipdtest(G,dt,K),4,[],[],[],[],lb_PID,ub_PID,[],options);
        
        K1 = x_IPD(1)/(s*x_IPD(2));
        K2 = x_IPD(1)*(1+(s*x_IPD(2)))/(1 + s*(x_IPD(3)/x_IPD(4)));
        
        ClosedLoop1_IPD = feedback(G,K2);
        Loop_IPD = series(K1,ClosedLoop1_IPD);
        ClosedLoop_IPD = feedback(Loop_IPD,1);
        S_IPD=stepinfo(ClosedLoop_IPD); 
        analized.ipd = ga_info_to_struct(IAE,x_IPD,S_IPD,'i_pd');
        
        Disturb_IPD = feedback(G,(K1+K2));
        S_IPD_Dist=stepinfo(Disturb_IPD);
        analized.ipd_dist =  ga_info_to_struct(IAE,x_IPD,S_IPD_Dist,'i_pd');

        %{
        PI-D genetic algorithm
        x(1) = Kp
        x(2) = Ti
        x(3)= Td
        x(4)= N
        %}         
        %lower bounds lb 
        lb_PID=[0.001 0.1 0.1 5];
        %upper bounds ub 
        ub_PID=[10 500 50 20];
        [x_DPI,IAE] = ga(@(K)ipdtest(G,dt,K),4,[],[],[],[],lb_PID,ub_PID,[],options);
        
        K1 = x_DPI(1);
        K2 = x_DPI(1)/(s*x_DPI(2));
        K3 = x_DPI(1)*(1+((s*x_DPI(3))/(1+(x_DPI(3)*s/x_DPI(4)))));
        ClosedLoop_DPI = (G*(K1+K2))/(1+G*(K2+K3));
        S_DPI=stepinfo(ClosedLoop_DPI); 
        analized.dpi = ga_info_to_struct(IAE,x_DPI,S_DPI,'pi_d');
        
        Disturb_DPI = feedback(G,K2+K3);
        S_DPI_Dist=stepinfo(Disturb_DPI); 
        analized.dpi_dist =  ga_info_to_struct(IAE,x_DPI,S_DPI_Dist,'pi_d');

        

        %{
        PIDA genetic algorithm
        x(1) = Kp
        x(2) = Ti
        x(3)= Td
        x(4)=N
        x(5)=Ta
        x(6)=alfa
        %}
                    
        %lower bounds lb 
        lb_PIDA=[0.001 0.1 0.1 5 0.1 5];
        %upper bounds ub 
        ub_PIDA=[10 500 50 20 50 20];
        
        [x_PIDA,IAE] = ga(@(K)pidatest(G,dt,K),6,[],[],[],[],lb_PIDA,ub_PIDA,[],options);
        
        K = x_PIDA(1) + x_PIDA(2)/s + (x_PIDA(3)*s)/(1 + s*(x_PIDA(3)/x_PIDA(4))) + (x_PIDA(5)*s^2)/((1 + s*x_PIDA(5)/x_PIDA(6))^2); 
       
        Loop_PIDA = series(K,G);
        ClosedLoop_PIDA = feedback(Loop_PIDA,1);
        S_PIDA=stepinfo(ClosedLoop_PIDA);     
        analized.pida = ga_info_to_struct(IAE,x_PIDA,S_PIDA,'pida');
        
        
        Disturb_PIDA = feedback(G,K);
        S_PIDA_Dist=stepinfo(Disturb_PIDA);
        analized.pida_dist = ga_info_to_struct(IAE,x_PIDA,S_PIDA_Dist,'pida');
       
        
        %reference traking
        if S_PID.SettlingTime < S_PIDA.SettlingTime
            t_sim = 0:dt:(S_PIDA.SettlingTime * 2); 
        else
            t_sim = 0:dt:(S_PID.SettlingTime * 2);
        end
        t_sim =0:dt:3;
        subplot(2,2,[1,2]);
        plot(t_sim,step(ClosedLoop_PID,t_sim),'r-',t_sim,step(ClosedLoop_IPD,t_sim),'b-',t_sim,step(ClosedLoop_DPI,t_sim),'k-',t_sim,step(ClosedLoop_PIDA,t_sim),'m-');
        legend('PID','I-PD','PD-I','PIDA');
        title('reference tracking');
        xlabel('time');
        ylabel('amplitude');
        grid on;
        
        %disturbance rejection
        if S_PID_Dist.SettlingTime < S_PIDA_Dist.SettlingTime
            t_sim = 0:dt:(S_PIDA_Dist.SettlingTime * 2); 
        else
            t_sim = 0:dt:(S_PID_Dist.SettlingTime * 2);
        end
        t_sim =0:dt:3;
        subplot(2,2,[3,4]);
        plot(t_sim,step(Disturb_PID,t_sim),'r-',t_sim,step(Disturb_IPD,t_sim),'b-',t_sim,step(Disturb_DPI,t_sim),'k-',t_sim,step(Disturb_PIDA,t_sim),'m-');
        legend('PID','I-PD','PD-I','PIDA');
        title('disturbance rejection');
        xlabel('time');
        ylabel('amplitude');
        grid on;

        % export to Excel
        print_excel(analized,strSelection);
