% I choose 2 images from each class to output the top 10 visual words

top10VisualWords_imagesPaths = cell(18, 1);

top10VisualWords_imagesPaths{1} = 'bamboo_forest/sun_ahvoexxajvyzqlfh.jpg';
top10VisualWords_imagesPaths{2} = 'bamboo_forest/sun_albruxfzycpyizpq.jpg';

top10VisualWords_imagesPaths{3} = 'basilica/sun_bmzglrkivnzzcqvv.jpg';
top10VisualWords_imagesPaths{4} = 'basilica/sun_bnzkvcighfnqzeyy.jpg';

top10VisualWords_imagesPaths{5} = 'dam/sun_dcgxshrgjxqzomuk.jpg';
top10VisualWords_imagesPaths{6} = 'dam/sun_dhntdkoimhmptspp.jpg';

top10VisualWords_imagesPaths{7} = 'desert/sun_airvjjkruobbrzse.jpg';
top10VisualWords_imagesPaths{8} = 'desert/sun_bbcfpwlpolnutyju.jpg';

top10VisualWords_imagesPaths{9} = 'kitchen/sun_aaytdlcupysxijma.jpg';
top10VisualWords_imagesPaths{10} = 'kitchen/sun_abykmfxuvnluzbye.jpg';

top10VisualWords_imagesPaths{11} = 'railroad/sun_apfcirzsuetfcjvy.jpg';
top10VisualWords_imagesPaths{12} = 'railroad/sun_aqyhtcpjsptrgdil.jpg';

top10VisualWords_imagesPaths{13} = 'sky/sun_ahjvxttzdkxkjqtx.jpg';
top10VisualWords_imagesPaths{14} = 'sky/sun_arusorretziylkqf.jpg';

top10VisualWords_imagesPaths{15} = 'supermarket/sun_anmpdotwmccmnrtr.jpg';
top10VisualWords_imagesPaths{16} = 'supermarket/sun_arhtwpxvfhwcvbmh.jpg';

top10VisualWords_imagesPaths{17} = 'theater/sun_ahrmyxmmkewfrqmz.jpg';
top10VisualWords_imagesPaths{18} = 'theater/sun_aimzolancvqmygtr.jpg';

save('top10VisualWords_imagesPaths.mat', 'top10VisualWords_imagesPaths');