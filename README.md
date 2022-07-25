# EEGDatasetCreator

Scripts criados para construção de conjuntos de dados de EEG através dos arquivos BrainVision (.eeg, .vhdr, .vmrk) com o auxílio da toolbox EEGLab e atribuição de rótulos para cada ERP.

O arquivo CriaDataset.m foi criado pelo Profº Dr. Fábio Marques Simões de Souza (FMS Souza, 2020) com amostras compostas por sinais contínuos de cada ERP, após, novas versões foram modificadas propriamente para geração de conjuntos de dados específicos. i.e. compostos por mapas topográficos do escalpo cerebral (https://eeglab.org/tutorials/08_Plot_data/Data_Averaging.html), para cada canal de EEG (16 disponíveis) e cada trial (785 para alcoólicos e 780 para não alcoólicos).
