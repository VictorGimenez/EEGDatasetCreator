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


%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Abro datasets originais

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all

%16 canais por EEG
load alcoolicos_EEG.mat;
tempo = EEG.times*1e-3; %s
dado_alcoolico = EEG.data;
trials_alcoolico = length(dado_alcoolico(1,1,:));

load naoalcoolicos_EEG.mat;              
dado_naoalcoolico = EEG.data;
trials_naoalcoolico = length(dado_naoalcoolico(1,1,:));

%Parametros para calculo FFT

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

conta = 1;
for p2 = 1:trials_alcoolico
    for p1 = 1:16
    dado_alcoolico_final(:,conta) = dado_alcoolico(p1,:,p2);
    label_alcoolico_final(:,conta) = 1; 
    %calcular fft aqui
    Y = fft(dado_alcoolico_final(:,conta));
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    dado_alcoolico_fft_final(:,conta) = P1(indice_fft); 
    
    conta = conta + 1;
    end
end

conta = 1;
for p2 = 1:trials_naoalcoolico
    for p1 = 1:16
    dado_naoalcoolico_final(:,conta) = dado_naoalcoolico(p1,:,p2);
    label_naoalcoolico_final(:,conta) = 0; 
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

%embaralho os indices para criar o dataset com as trials randomizadas
indices = randperm(length(dataset(1,:)));

%3072 pontos no tempo x 25040 trials
dataset2 = dataset(:,indices);
%300 pontos de frequencia x 25040 trials
dataset2_fft = dataset_fft(:,indices);
%25040 trials: 1 = alcoolico, 0 = nao alcoolico
label_dataset2 = label_dataset(:,indices);

save dataset_EEG_fabio dataset2 dataset2_fft label_dataset2


