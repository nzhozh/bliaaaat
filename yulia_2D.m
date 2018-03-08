ya programmiiiiist
load('C:\Users\natalia\Downloads\plPLspl_plPLfpl_stim.mat')
EEG1 = pop_loadset('C:\Users\natalia\Downloads\aleskerova1.set');
fpath_chanlocs='C:\matl\eeglab12_0_2_5b\plugins\dipfit2.2\standard_BESA\standard-10-5-cap385.elp';
EEG1 = pop_chanedit(EEG1, 'lookup', fpath_chanlocs);
chan_locs = EEG1.chanlocs;
data=data{2}; %ïóòü ê TF äàííûì (ôàçîâîÍÅñâÿç)
%ROI_freqs_chans_times={{8:13,{{'Pz'}},{0:500}},{4:7, {{'Fp1','Fp2','Fpz'}}, {0:500}}}; %äëÿ êàæäîé ÷àñòîòû ñâîè êàíàëû è âðåìÿ
%ROI_freqs_chans_times={{8:13,{{'O2','O1'},{'P3','P4'}},{1300:1400, 900:1000, 800:900,700:800,500:700, 400:600, 300:500, 100:400}}};
ROI_freqs_chans_times={{8:13,{0:100, -300:0, 0:300, 100:400, 300:500, 400:600, 500:700, 600:800, 700:900, 800:1000, 900:1100, 1000:1200, 1100:1300, 1200:1400}}};
%lastname=[1:7, 10:14, 16:25, 27:33,35:36, 38:51];
    chel=mean(data,4); %òåïåðü ýòî òèïà 1 ÷åë
    for r = 1:length(ROI_freqs_chans_times)
        [h,ind]=ismember(ROI_freqs_chans_times{r}{1},freqs_tf); 
        fr=mean(chel(ind,:,:,:,:),1); 
        for z = 1:length(ROI_freqs_chans_times{r}{2})
            [h,ind]=ismember(ROI_freqs_chans_times{r}{2}{z},times_tf);
            ind(ind==0)=[];
            times=mean(fr(:,ind,:,:,:),2); 
            b=strcat(num2str(ROI_freqs_chans_times{r}{1}(1)),'-',num2str(ROI_freqs_chans_times{r}{1}(end)),'_',num2str(ROI_freqs_chans_times{r}{2}{z}(1)),'-',num2str(ROI_freqs_chans_times{r}{2}{z}(end)));
            correlations=squeeze(times); %èç-çà òîãî, ÷òî ïðè óñðåäíåíèè ïî ÷àñòîòå äàííûå íå ïîòåðÿëè îäíîãî èçìåðåíèÿ, óáèðàåì åãî òàê
            figure
            topoplot(correlations(:,1),chan_locs(2:28)); %correlations(:,1) - slow
            title(b)
        end
    end


%dim_names 'freqs_tf'    'times_tf'    'chan_names'    'lastnames'    'condition_names'
