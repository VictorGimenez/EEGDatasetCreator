%cada um dos 33 verbos eh apresentado 3 vezes
%uma vez na forma de palavra escrita (1) - A  
%uma vez na forma de audio palavra ouvida (2) - B
%uma vez na forma de imagem da acao (3) - C

%total de eventos (tem 133 no final, mas o conta vai ate 134 devido ao incremento)
% 33*3 + 33(survey) + 1(last survey) = 133
% 33*3 + 33 + 1 = 133

%NO CONTADOR, APARECE 134 NA TELA, PORQUE EXISTE UM INCREMENTO ADICIONAL NO
%LOOP. Mas apenas 133 sao salvos.

%tem sempre um survey depois de 3 apresentacoes do mesmo verbo

%Os arquivos sujeito1_1.mat, etc, sao gerados ao salvar o arquivo EEG do
%EEGlab. Para isso, os aquivos sao abertos no EEGlab e salvos como .mat.


clear all

%nomes voluntarios

%nome = 'SubNumber_1_SubName_pilotosujeito1_RecordDate_29-10-2020_LeftRight_Is_destro_Workspace';
%load sujeito1_1;   %dado de voltagem do trigger salvo no EEG
%arquivo1 = 'pilotosujeito1[2020.10.29-11.54.04].vmrk';
%arquivo2 = 'pilotosujeito1[2020.10.29-11.54.04]novo.vmrk';

%nome = 'SubNumber_1_2_SubName_pilotosujeito1-2_RecordDate_29-10-2020_LeftRight_Is_destro_Workspace';
%load sujeito1_2;
%arquivo1 = 'pilotosujeito1_2[2020.10.29-12.12.09].vmrk';
%arquivo2 = 'pilotosujeito1_2[2020.10.29-12.12.09]novo.vmrk';

%nome = 'SubNumber_3_SubName_Jessica Reis_RecordDate_27-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito3_1;
%arquivo1 = 'Sujeito3-[2020.11.27-12.37.40].vmrk';
%arquivo2 = 'Sujeito3-[2020.11.27-12.37.40]novo.vmrk';

%nome = 'SubNumber_3-2_SubName_Jessica Reis_RecordDate_27-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito3_2;
%arquivo1 = 'Sujeito3_coleta2-[2020.11.27-12.54.19].vmrk';
%arquivo2 = 'Sujeito3_coleta2-[2020.11.27-12.54.19]novo.vmrk';

%Tem um evento adicional no comeco que precisa ser removido no comeco
%nome = 'SubNumber_4_SubName_Denise Wolf_RecordDate_27-11-2020_LeftRight_Is_destra_Workspace';
%load sujeito4_1;
%arquivo1 = 'Sujeito4-[2020.11.27-15.08.28].vmrk';
%arquivo2 = 'Sujeito4-[2020.11.27-15.08.28]novo.vmrk';

%nome = 'SubNumber_4_2_SubName_Denise Wolf_RecordDate_27-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito4_2;
%arquivo1 = 'Sujeito4_coleta2-[2020.11.27-15.25.13].vmrk';
%arquivo2 = 'Sujeito4_coleta2-[2020.11.27-15.25.13]novo.vmrk';

%nome = 'SubNumber_5_SubName_Isadora Martins_RecordDate_30-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito5_1;
%arquivo1 = 'Sujeito5-[2020.11.30-12.14.49].vmrk';
%arquivo2 = 'Sujeito5-[2020.11.30-12.14.49]novo.vmrk';

%nome = 'SubNumber_5-2_SubName_Isadora Martins_RecordDate_30-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito5_2;
%arquivo1 = 'Sujeito5_coleta2-[2020.11.30-12.32.08].vmrk';
%arquivo2 = 'Sujeito5_coleta2-[2020.11.30-12.32.08]novo.vmrk';

%perdendo eventos. Usar divisao = 3;
%nome = 'SubNumber_6_SubName_Leticia_RecordDate_30-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito6_1;
%arquivo1 = 'Sujeito6-[2020.11.30-13.36.33].vmrk';
%arquivo2 = 'Sujeito6-[2020.11.30-13.36.33]novo.vmrk';

%nome = 'SubNumber_6-2_SubName_Leticia_RecordDate_30-11-2020_LeftRight_Is_destra_Workspace';
%load sujeito6_2;
%arquivo1 = 'Sujeito6_coleta2-[2020.11.30-13.51.45].vmrk';
%arquivo2 = 'Sujeito6_coleta2-[2020.11.30-13.51.45]novo.vmrk';

%muito ruido (60hz da tomada?)
%perdeu muitos eventos de trigger no inicio! Olhar com cuidado
%perdendo eventos do inicio (perdeu 15 primeiro estimulos).
%Registrar os eventos de traz pra frente!
%nome = 'SubNumber_7_SubName_Lais_RecordDate_30-11-2020_LeftRight_Is_destros_Workspace';
%load sujeito7_1;
%arquivo1 = 'Sujeito7-[2020.11.30-14.36.14].vmrk';
%arquivo2 = 'Sujeito7-[2020.11.30-14.36.14]novo.vmrk';

%nome = 'SubNumber_7-2_SubName_Lais_RecordDate_30-11-2020_LeftRight_Is_destro_Workspace';
%load sujeito7_2;
%arquivo1 = 'Sujeito7_coleta2-[2020.11.30-14.54.06].vmrk';
%arquivo2 = 'Sujeito7_coleta2-[2020.11.30-14.54.06]novo.vmrk';

%perdeu muitos eventos de trigger no inicio! Olhar com cuidado
%perdendo eventos do inicio (perdeu 9 primeiro estimulos).
%Registrar os eventos de traz pra frente!
% nome = 'SubNumber_9_SubName_Danieli Gregorio_RecordDate_09-12-2020_LeftRight_Is_Destro_Workspace';
% load sujeito9_1;
% arquivo1 = 'sujeito 9 record-[2020.12.09-14.07.15].vmrk';
% arquivo2 = 'sujeito 9 record-[2020.12.09-14.07.15]novo.vmrk';

%nome = 'SubNumber_9-2_SubName_Danieli Gregorio_RecordDate_09-12-2020_LeftRight_Is_Destro_Workspace';
%load sujeito9_2;
%arquivo1 = 'sujeito 9-2 record-[2020.12.09-14.23.39].vmrk';
%arquivo2 = 'sujeito 9-2 record-[2020.12.09-14.23.39]novo.vmrk';

% nome = 'SubNumber_sujeito 11 1_SubName_Nicolas Reis_RecordDate_10-01-2021_LeftRight_Is_destro_Workspace';
% load sujeito11_1;
% arquivo1 = 'sujeito 11 record-[2021.01.10-23.18.21].vmrk';
% arquivo2 = 'sujeito 11 record-[2021.01.10-23.18.21]novo.vmrk';

nome = 'SubNumber_sujeito 11 2_SubName_Nicolas Reis_RecordDate_10-01-2021_LeftRight_Is_destro_Workspace';
load sujeito11_2;
arquivo1 = 'sujeito 11 2 record-[2021.01.10-23.35.51].vmrk';
arquivo2 = 'sujeito 11 2 record-[2021.01.10-23.35.51]novo.vmrk';

%Perdeu estimulos
% nome = 'SubNumber_sujeito 10 2_SubName_Sasha Rodrigues_RecordDate_10-01-2021_LeftRight_Is_destro_Workspace';
% load sujeito10_2;
% arquivo1 = 'sujeito 10 2record-[2021.01.10-22.37.38].vmrk';
% arquivo2 = 'sujeito 10 2record-[2021.01.10-22.37.38]novo.vmrk';


load(nome);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Crio uma rotina que pega a sequencia de estimulos apresentada
%e salvo na variavel estimulo
%numero do verbo (1 a 33) seguido do tipo de estimulo (palavra-A,audio-B,imagem-C)
%Survey entre estimulos = S
%Last Survey  = LS

conta1 = 1;
for p1 = 1 : length(Pic_order)
    for p2 = 1 : 3
        if Sub_trial_order(p1,p2) ==1
            tipo = 'A';
        end
        if Sub_trial_order(p1,p2) ==2
            tipo = 'B';
        end
        if Sub_trial_order(p1,p2) ==3
            tipo = 'C';
        end            
        estimulo(conta1) = {strcat(num2str(Pic_order(p1)),tipo)};
        
        conta1 = conta1 + 1;
    end
        tipo = 'S';
        estimulo(conta1) = {strcat(num2str(Pic_order(p1)),tipo)};        
        conta1 = conta1 + 1;
end
        tipo = 'LS';
        estimulo(conta1) = {strcat(tipo)};        


%Pre-processo e filtro o sinal do trigger para capturar eventos de trigger
tempo = EEG.times(1:end-1);

dt = 1e-3*2*(tempo(2)-tempo(1));
Ny = 1/dt;
[b,a] = butter(2,[0.1/Ny,50/Ny]);
EEG_filtrado = filter(b,a,EEG.data(17,:));

%sumo com valores positivos
EEG_filtrado(EEG_filtrado>0) = 0;
dado = diff(EEG_filtrado); %calcula diferencial para pegar mudancas

eventos = 0;
conta = 1;
refratario = 0;
divisao = 3;


kappa = 0.01;
for p = 2:length(tempo)-1
    refratario = refratario - kappa*refratario;
    %acho picos
    if dado(p)<=dado(p-1) && dado(p)>=dado(p+1) && dado(p) < min(dado)/divisao ...
            && refratario < 1;
        eventos(conta) = p;
        conta = conta + 1
        refratario = 10;
    end
    
end

%eventos(1) = [];

%SALVO EVENTOS EM UM ARQUIVO DE TEXTO NO FORMATO vmrk do Brain Vision 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Gravo dados no arquivo vmrk%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid1 = fopen(arquivo1,'r');
fid2 = fopen(arquivo2,'w'); %new net file

tline = fgetl(fid1);
fprintf(fid2,strcat(tline,'\n'));    

%go through until the [Marker Infos]
while (~strcmp(tline,'[Marker Infos]'))
        tline = fgetl(fid1);
        fprintf(fid2,strcat(tline,'\n'));    
end

%quando  nao perde evento
for p = 1 :length(eventos) 
    linha = strcat('Mk',num2str(p),'=Stimulus,',estimulo{p},',',num2str(eventos(p)),',1,0');
    fprintf(fid2,strcat(linha,'\n'));    
end

fclose(fid1);
fclose(fid2);

figure
plot(EEG.times,EEG.data(17,:))
hold on
plot(EEG.times(eventos),EEG.data(17,eventos),'o')
