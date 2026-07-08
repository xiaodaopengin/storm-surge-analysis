function regions = region_config()
% region_config  地域定義（name, [lonmin lonmax latmin latmax], is_global）
    regions = {
        'GLOBAL', [-180 180 -90 90], true;
        'NI',     [ 30 110  -45 35], false;
        'WNP',    [100 180   0 60],  false;
        'NA',     [-100 -5   0 60],  false;
        'AUS',    [90 160  -60  0],  false
        };
end

function proj = select_projection(lims)
% select_projection  投影法を返す（常に eckert4 固定）
    proj = 'eckert4';
end