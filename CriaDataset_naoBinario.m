%Vou criar um dataset no formato do MNIST
%para uso da rede do Nielsen

%Dataset Original:

%alcoolicos (16 canais,3072 instantes,785 trials)
%nao alcoolicos (16 canais,3072 instantes,780 trials)

%Dataset1
%tirar media dos 16 canais. Formato final (alcoolicos e nao alcoolicos)
%dataset1 = (3072 instantes, 785 trials * 2)
%label = (1570); alcoolicos (1) nao alcoolicos (0)

%Dataset2
%Considerar cada um dos 16 canais como uma trial diferente. 
%Formato final (alcoolicos e nao alcoolicos)
%dataset2 = (3072 instantes, 785 trials * 2 * 16)
%label = (25120); alcoolicos (1) nao alcoolicos (0)

%Dataset3
%Considerar o Dataset2, mas convertendo para dominio da frequencia (fft)
%Considerando potencias das frequencias de 0 a 50Hz. 
%Formato final (alcoolicos e nao alcoolicos)
%dataset2 = (300 potencias, 785 trials * 2 * 16)
%label = (25120); alcoolicos (1) nao alcoolicos (0)

%Usar a funcao shuffle para embaralhar as epochs de alcoolico e nao
%alcoolico.
%indice=linspace(1,length(dado));
%indice=shuffle(a);
%depois eh so usar o vetor indice para criar um novo vetor de dados
%dado = dado(indice);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%PARA CRIAR UM HASH DE VALORES USE: rainfallMap = containers.Map(k, v)
% EEG.event(1:end).latency
% Navegar em cada época:
% B28(:,:) = EEG.data(1,1:3072,1)

% LABELS:
% (0) - Alcoolico visual verbal           (A)
% (1) - Alcoolico auditorio               (B)
% (2) - Alcoolico visual descritivo       (C)
% (3) - Nao alcoolico visual verbal       (A)
% (4) - Nao alcoolico auditorio           (B) 
% (5) - Nao alcoolico visual descritivo   (C)
%POSTERIORMENTE
%(0) - Alcoolico visual verbal           (A) 
%(1) - Alcoolico auditorio               (B)
%(2) - Alcoolico visual descritivo       (C)
%(3) - Alcoolico pergunta                (S)
%(4) - Alcoolico ultima pergunta         (LS) 
%(5) - Nao alcoolico visual verbal       (A)
%(6) - Nao alcoolico auditorio           (B)
%(7) - Nao alcoolico visual descritivo   (C) 
%(8) - Nao alcoolico pergunta            (S) 
%(9) - Nao alcoolico ultima pergunta     (LS)

%FORMATO DO DATASET:
%EEG.data(1:16,1:end,1:785) => Alcoolicos
%EEG.data(1,1:end,1) => 28B (1)  3072 x 1
%EEG.data(1,1:end,2) => 25B (1)  3072 x 1 
%EEG.data(1,1:end,3) => 16B (1)  3072 x 1
% ...
%EEG.data(15,1:end,785) => 18A   ....
%EEG.data(16,1:end,785) => 9A    ....
%Final => 12560 x 3072

%EEG.data(1:16,1:end,1:780) => Nao Alcoolicos
%EEG.data(1,1:end,1) => 28B   3072 x 1
%EEG.data(1,1:end,2) => 25B   3072 x 1 
%EEG.data(1,1:end,3) => 16B   3072 x 1
% ...
%EEG.data(15,1:end,780) => 18A   ....
%EEG.data(16,1:end,780) => 9A    ....
%Final => 12480 x 3072   =>  25040 x 3072   (Sem FFT) 
%      => 12480 x  300   =>  25040 x  300   (Com FFT)  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Abro datasets originais

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

%16 canais por EEG
load alcoolicos_EEG.mat;
tempo = EEG.times*1e-3; %s
dado_alcoolico = EEG.data;
eventos_alcoolico = EEG.event.type;
%%%%%%%%%%%%%% \/ \/ %%%%%%%%%%%%%%
%%%%%%%%%%%%%% \/ \/ Parte Victor

for i=1:785
    rotulos_alcoolico{i} = EEG.event(i).type;
end
%%%%%%%%%%%%%% /\/\ %%%%%%%%%%%%%%
trials_alcoolico = length(dado_alcoolico(1,1,:));

load naoalcoolicos_EEG.mat;              
dado_naoalcoolico = EEG.data;
eventos_naoalcoolico = EEG.event.type;

%%%%%%%%%%%%%% \/ \/ %%%%%%%%%%%%%%
%%%%%%%%%%%%%% \/ \/ Parte Victor
for i=1:780
    rotulos_naoalcoolico{i} = EEG.event(i).type;
end
%%%%%%%%%%%%%% /\/\ %%%%%%%%%%%%%%
trials_naoalcoolico = length(dado_naoalcoolico(1,1,:));

%%%%%%%%%%%%%% \/ \/ %%%%%%%%%%%%%%
%%%%%%%%%%%%%% \/ \/ Parte Victor
rotulos_alcoolico = string(rotulos_alcoolico);
rotulos_naoalcoolico = string(rotulos_naoalcoolico);

rotulos_alcoolico = regexprep(rotulos_alcoolico,'[\d"]','');
rotulos_naoalcoolico = regexprep(rotulos_naoalcoolico,'[\d"]','');
%%%%%%%%%%%%%% /\/\ %%%%%%%%%%%%%%

% Parametros para calculo FFT

dt = diff(tempo(1:2)); %s

T = dt;             % Sampling period (s)      
Fs = 1/T;            % Sampling frequency (Hz)            
L = length(tempo);             % Length of signal
t = tempo;        % Time vector

%frequencia maxima do dado
fmax = 50; %hz
f = Fs*(0:(L/2))/L; %vetor frequencias dado
indice_fft = find(f<fmax); %indice de frequencias menores que fmax


%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Criacao Dataset2 e Dataset2_fft

%16 canais por EEG
load alcoolicos_EEG.mat;
tempo = EEG.times;
dado_alcoolico = EEG.data;
trials_alcoolico = length(dado_alcoolico(1,1,:));

load naoalcoolicos_EEG.mat;              
dado_naoalcoolico = EEG.data;
trials_naoalcoolico = length(dado_naoalcoolico(1,1,:));

conta = 1;  %12561
for p2 = 1:trials_alcoolico  %785
    for p1 = 1:16
    dado_alcoolico_final(:,conta) = dado_alcoolico(p1,:,p2);
    
    %%%%%%%%%%%%%% \/ \/ %%%%%%%%%%%%%%
    %%%%%%%%%%%%%% \/ \/ Parte Victor
    if rotulos_alcoolico(p2) == "A"
        label_alcoolico_final(:,conta) = 0; 
    elseif rotulos_alcoolico(p2) == "B"
        label_alcoolico_final(:,conta) = 1;
    elseif rotulos_alcoolico(p2) == "C"
        label_alcoolico_final(:,conta) = 2;
    end
    %%%%%%%%%%%%%% /\ /\ %%%%%%%%%%%%%%    
    
    % Para atribuir 1 = alcoolico    
%     label_alcoolico_final(:,conta) = 1; 
    
    %calcular fft aqui
    Y = fft(dado_alcoolico_final(:,conta));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    dado_alcoolico_fft_final(:,conta) = P1(indice_fft); 
    
    conta = conta + 1;
    end
end

conta = 1; %12481
for p2 = 1:trials_naoalcoolico  %780
    for p1 = 1:16
    dado_naoalcoolico_final(:,conta) = dado_naoalcoolico(p1,:,p2);
    
    %%%%%%%%%%%%%% \/ \/ %%%%%%%%%%%%%%
    %%%%%%%%%%%%%% \/ \/ Parte Victor
    if rotulos_naoalcoolico(p2) == "A"
        %label_naoalcoolico_final(:,conta) = 2; 
        label_naoalcoolico_final(:,conta) = 3; 
    elseif rotulos_naoalcoolico(p2) == "B"
        %label_naoalcoolico_final(:,conta) = 3;
        label_naoalcoolico_final(:,conta) = 4;
    elseif rotulos_naoalcoolico(p2) == "C"
        label_naoalcoolico_final(:,conta) = 5;
    end
    %%%%%%%%%%%%%% /\ /\ %%%%%%%%%%%%%%
    
    % Para atribuir 0 = nao alcoolico        
%     label_naoalcoolico_final(:,conta) = 0; 
    %calcular fft aqui
    Y = fft(dado_naoalcoolico_final(:,conta));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    dado_naoalcoolico_fft_final(:,conta) = P1(indice_fft); 

    conta = conta + 1;
    end
end

dataset = [dado_alcoolico_final dado_naoalcoolico_final];
dataset_fft = [dado_alcoolico_fft_final dado_naoalcoolico_fft_final];
label_dataset = [label_alcoolico_final label_naoalcoolico_final];

% dataset_t = transpose(dataset);
% dataset_fft_t = transpose(dataset_fft);
% label_dataset_t = transpose(label_dataset);

%embaralho os indices para criar o dataset com as trials randomizadas
indices = randperm(length(dataset(1,:)));  %Usar no Octave

%3072 pontos no tempo x 25040 trials
dataset2 = dataset(:,indices);   %Versão Fábio
%300 pontos de frequencia x 25040 trials
dataset2_fft = dataset_fft(:,indices);  %Versão Fábio 
%25040 trials: 1 = alcoolico, 0 = nao alcoolico
label_dataset2 = label_dataset(:,indices);  %Versão Fábio

dataset2 = transpose(dataset2);
dataset2_fft = transpose(dataset2_fft);
label_dataset2 = transpose(label_dataset2);

save dataset_EEG_fabio dataset2 dataset2_fft label_dataset2

csvwrite('datasetEEG_extended_with6.csv',dataset2)
csvwrite('datasetEEG_fft_extended_with6.csv',dataset2_fft)
csvwrite('datasetEEG_label_extended_with6.csv',label_dataset2)
