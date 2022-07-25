# EEGDatasetCreator

Scripts criados para construção de conjuntos de dados de EEG através dos arquivos BrainVision (.eeg, .vhdr, .vmrk) com o auxílio da toolbox EEGLab e atribuição de rótulos para cada ERP.

Os scripts CriaDataset.m e Analise_Dados.m foram criados pelo Profº Dr. Fábio Marques Simões de Souza (FMS Souza, 2020) com o objetivo de gerar conjuntos de dados compostos com amostras de ERP's e o segundo para correção de falhas nos triggers dos arquivos .vmrk para sincronização dos instantes de aparição dos triggers (Aparição do estímulo na tela) com o seu tempo de registro, após, novas versões foram modificadas e geradas propriamente para geração de conjuntos de dados específicos. i.e. compostos por mapas topográficos do escalpo cerebral (https://eeglab.org/tutorials/08_Plot_data/Data_Averaging.html), para cada canal de EEG (dos 16 disponíveis)
