clc; close all;

% 1. RECUPERO OGGETTO OUT
if ~exist('out', 'var')
    error('ERRORE CRITICO: La variabile "out" non esiste nel Workspace. Esegui la simulazione!');
else
    disp('Oggetto "out" trovato. Inizio estrazione dati...');
    out_data = out; 
end

% 2. RECUPERO TEMPO MAX (Con fallback)
try
    T_max = out_data.tout(end);
catch
    disp('Warning: out.tout non accessibile. Uso tempo simulazione stimato = 100s');
    T_max = 100; 
end

%% 3. ESTRAZIONE DATI
% --- LATENZA ---
try
    raw = out_data.Latenza_Finale;
    y_lat = raw(:,end); 
    t_lat = linspace(0, T_max, length(y_lat))'; 
    disp(['-> Latenza trovata: ' num2str(length(y_lat)) ' campioni.']);
catch
    y_lat = []; t_lat = []; disp('-> Dati Latenza NON trovati.');
end

% --- THROUGHPUT FINALE ---
try
    raw = out_data.TP_Finale;
    y_tp = raw(:,end);
    t_tp = linspace(0, T_max, length(y_tp))'; 
    disp(['-> TP Finale trovato: ' num2str(length(y_tp)) ' campioni.']);
catch
    y_tp = []; t_tp = []; disp('-> Dati TP Finale NON trovati.');
end

% --- THROUGHPUT GATEWAY 1 ---
try
    raw = out_data.TP_Gateway1;
    y_g1 = raw(:,end);
    t_g1 = linspace(0, T_max, length(y_g1))'; 
    disp(['-> TP GW1 trovato: ' num2str(length(y_g1)) ' campioni.']);
catch
    y_g1 = []; t_g1 = []; disp('-> Dati TP GW1 NON trovati.');
end

% --- THROUGHPUT GATEWAY 2 ---
try
    raw = out_data.TP_Gateway2;
    y_g2 = raw(:,end);
    t_g2 = linspace(0, T_max, length(y_g2))'; 
    disp(['-> TP GW2 trovato: ' num2str(length(y_g2)) ' campioni.']);
catch
    y_g2 = []; t_g2 = []; disp('-> Dati TP GW2 NON trovati.');
end

% --- SENSORE SHT31 ---
try
    raw = out_data.RT_SHT31_Latenza_Dati; 
    y_sht = raw(:,end);
    t_sht = linspace(0, T_max, length(y_sht))'; 
    disp(['-> SHT31 trovato: ' num2str(length(y_sht)) ' campioni.']);
catch
    y_sht = []; t_sht = []; disp('-> Dati SHT31 NON trovati.');
end

% --- SENSORE SCD30 ---
try
    raw = out_data.RT_SCD30_Latenza_Dati1;
    y_scd = raw(:,end);
    t_scd = linspace(0, T_max, length(y_scd))'; 
    disp(['-> SCD30 trovato: ' num2str(length(y_scd)) ' campioni.']);
catch
    y_scd = []; t_scd = []; disp('-> Dati SCD30 NON trovati.');
end

%% 3-BIS. PULIZIA DEI PICCHI INIZIALI
% Manteniamo comunque questa pulizia per avere i CSV puliti
disp('Pulizia artefatti iniziali (Spikes a t=0)...');
n_cut = 100; 
if length(y_tp) > n_cut; y_tp(1:n_cut) = 0; end
if length(y_g1) > n_cut; y_g1(1:n_cut) = 0; end
if length(y_g2) > n_cut; y_g2(1:n_cut) = 0; end


%% 4. GRAFICI
hFig = figure('Name', 'Analisi Prestazioni Rete', 'Color', 'w', 'Position', [100, 100, 1000, 800]);

% --- PLOT LATENZA ---
subplot(3,1,1);
if ~isempty(y_lat)
    plot(t_lat, y_lat*1000, 'b-', 'LineWidth', 1.0); 
    title('End-to-End Response Time (Latenza)');
    xlabel('Tempo (s)'); ylabel('Latenza (ms)'); grid on;
    xlim([0 T_max]);
    
    valid_lat = y_lat(y_lat > 0);
    if ~isempty(valid_lat)
        legend(['Media: ' num2str(mean(valid_lat)*1000, '%.2f') ' ms'], 'Location', 'northwest');
    end
else
    text(0.5, 0.5, 'DATI LATENZA MANCANTI', 'HorizontalAlignment', 'center', 'Color', 'r');
end

% --- PLOT THROUGHPUT COMPARATO (CON ZOOM DRASTICO) ---
subplot(3,1,2);
hold on;
if ~isempty(y_g1), plot(t_g1, y_g1, 'g--', 'LineWidth', 1); end
if ~isempty(y_g2), plot(t_g2, y_g2, 'm--', 'LineWidth', 1); end
if ~isempty(y_tp), plot(t_tp, y_tp, 'r-', 'LineWidth', 1.5); end
hold off;
title('Confronto Throughput (Bitrate)');
xlabel('Tempo (s)'); ylabel('bps'); grid on;
xlim([0 T_max]);

% --- FIX DRASTICO: LIMITE ASSE Y A 10 ---
ylim([0 10]); 
% ----------------------------------------

legend_str = {};
if ~isempty(y_g1), legend_str{end+1} = 'Gateway 1 (Sensori)'; end
if ~isempty(y_g2), legend_str{end+1} = 'Gateway 2 (Cmd)'; end
if ~isempty(y_tp), legend_str{end+1} = 'Attuatore (Rx)'; end
if ~isempty(legend_str), legend(legend_str, 'Location', 'best'); end

% --- PLOT SENSORI ---
subplot(3,1,3);
hold on;
if ~isempty(y_sht), plot(t_sht, y_sht*1000, 'b', 'LineWidth', 1.5); end
if ~isempty(y_scd), plot(t_scd, y_scd*1000, 'k--', 'LineWidth', 1.5); end
hold off;
title('Reaction Time Sensori (Processing Delay)');
xlabel('Tempo (s)'); ylabel('ms'); grid on;
xlim([0 T_max]);
ylim([0 50]); 

if ~isempty(y_sht) || ~isempty(y_scd)
    legend('SHT31 (Temp/Umid)', 'SCD30 (CO2)');
else
    text(0.5, 0.5, 'DATI SENSORI MANCANTI', 'HorizontalAlignment', 'center', 'Color', 'r');
end

%% 5. SALVATAGGIO CSV
disp('Generazione CSV...');
if ~isempty(y_lat)
    T = table(t_lat, y_lat, 'VariableNames', {'Time_s', 'Latency_s'});
    writetable(T, 'Metriche_Latenza.csv');
end
if ~isempty(y_tp)
    T = table(t_tp, y_tp, 'VariableNames', {'Time_s', 'Throughput_bps'});
    writetable(T, 'Metriche_Throughput.csv');
end

%% 6. SALVATAGGIO IMMAGINI
disp('Salvataggio grafici nella cartella "img"...');

folder_name = 'img';
if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end

png_path = fullfile(folder_name, 'Performance_Report.png');
fig_path = fullfile(folder_name, 'Performance_Report.fig');

if isvalid(hFig)
    try
        saveas(hFig, png_path);
        disp(['-> Grafico PNG salvato in: ' png_path]);
    catch ME
        warning(['Errore salvataggio PNG: ' ME.message]);
    end
    
    pause(2); 
    
    try
        savefig(hFig, fig_path);
        disp(['-> File FIG salvato in: ' fig_path]);
    catch ME
        warning(['Errore salvataggio FIG: ' ME.message]);
    end
else
    error('La figura è stata chiusa prima del salvataggio!');
end

disp('--- OPERAZIONE COMPLETATA ---');