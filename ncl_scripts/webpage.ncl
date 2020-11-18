; Create all CVDP-LE web pages.
;
load "$CVDP_SCRIPTS/functions.ncl"

begin
  print("Starting: webpage.ncl")

  OUTDIR      = getenv("OUTDIR") 
  VERSION     = getenv("VERSION")
  CLIMO_SYEAR = getenv("CLIMO_SYEAR")
  CLIMO_EYEAR = getenv("CLIMO_EYEAR")
  OBS         = getenv("OBS")

  quote = str_get_dq()
;----------------------------------------------------------------------------
;--   Create metrics webpages
;----------------------------------------------------------------------------
  if (isfilepresent2(OUTDIR+"metrics.txt")) then
     txt = new(500,"string")  
     quote = str_get_dq()
  
     txt(0) = "<HTML><HEAD><TITLE>Climate Variability Diagnostics Package</TITLE><STYLE>"
     txt(1) = "body {background-color: WhiteSmoke; font-family: Verdana, Geneva, sans-serif}"
     txt(2) = "img.title {width:990; height:105; align:left}"
     txt(3) = "p.subtitle1 {font-size:15pt; color:gray}"
     txt(4) = "p.subtitle {font-size:20pt; color:black; text-align:center; font-weight:bold}"
     txt(5) = "p.btext {font-size:12pt; text-align:left}"
     txt(6) = "p.btext2 {font-size:9pt; text-align:left}"
     txt(7) = "td {text-align:center; font-size:12pt}"
     txt(8) = "td.s1 {text-align:left; font-size:11pt}"
     txt(9) = "CAPTION {text-align:left; font-size:14pt; font-weight:bold}"
     txt(10) = "</STYLE></HEAD><BODY>"
     txt(11) = "<img class=title src="+quote+"cas_cvdp-le.png"+quote+" alt="+quote+"CVDP-LE logo"+quote+">"
     txt(12)= "<TABLE width='990' border=0 cellpadding=6>"
     txt(13) = "<tr><td width='350'><p class=btext><a href="+quote+"index.html"+quote+">Back to Diagnostics Plots</a></p></td>"
     txt(14) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left><p class=subtitle1>Metrics Table</p>" 
     
     z = asciiread(OUTDIR+"metrics.txt",(/-1/),"string")
     nlines = dimsizes(z)
     txt(24) = "<PRE>"
     do gg = 0,nlines-1
        txt(25+gg) = z(gg)
     end do
     txt(25+nlines) = "</PRE>"
     txt(25+nlines+1) = "<p class=btext><a href="+quote+"namelist_obs"+quote+">Observations Used</a></p>"
     txt(25+nlines+2) = "Created "+systemfunc("date")
     txt(25+nlines+3) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  
     tt = ind(.not.ismissing(txt))
     txt2 = txt(:tt(dimsizes(tt)-1)+1)
     txt2 = where(ismissing(txt2),"",txt2)
     asciiwrite(OUTDIR+"metrics.html",txt2)
     delete([/txt,txt2,tt,z/])
  end if 
  if (isfilepresent2(OUTDIR+"metrics_EM.txt")) then
     txt = new(500,"string")  
     quote = str_get_dq()
  
     txt(0) = "<HTML><HEAD><TITLE>Climate Variability Diagnostics Package</TITLE><STYLE>"
     txt(1) = "body {background-color: WhiteSmoke; font-family: Verdana, Geneva, sans-serif}"
     txt(2) = "img.title {width:990; height:105; align:left}"
     txt(3) = "p.subtitle1 {font-size:15pt; color:gray}"
     txt(4) = "p.subtitle {font-size:20pt; color:black; text-align:center; font-weight:bold}"
     txt(5) = "p.btext {font-size:12pt; text-align:left}"
     txt(6) = "p.btext2 {font-size:9pt; text-align:left}"
     txt(7) = "td {text-align:center; font-size:12pt}"
     txt(8) = "td.s1 {text-align:left; font-size:11pt}"
     txt(9) = "CAPTION {text-align:left; font-size:14pt; font-weight:bold}"
     txt(10) = "</STYLE></HEAD><BODY>"
     txt(11) = "<img class=title src="+quote+"cas_cvdp-le.png"+quote+" alt="+quote+"CVDP-LE logo"+quote+">"
     txt(12)= "<TABLE width='990' border=0 cellpadding=6>"
     txt(13) = "<tr><td width='350'><p class=btext><a href="+quote+"index.html"+quote+">Back to Diagnostics Plots</a></p></td>"
     txt(14) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left><p class=subtitle1>Metrics Table</p>" 
     
     z := asciiread(OUTDIR+"metrics_EM.txt",(/-1/),"string")
     nlines = dimsizes(z)
     txt(24) = "<PRE>"
     do gg = 0,nlines-1
        txt(25+gg) = z(gg)
     end do
     txt(25+nlines) = "</PRE>"
     txt(25+nlines+1) = "<p class=btext><a href="+quote+"namelist_obs"+quote+">Observations Used</a></p>"
     txt(25+nlines+2) = "Created "+systemfunc("date")
     txt(25+nlines+3) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  
     tt = ind(.not.ismissing(txt))
     txt2 = txt(:tt(dimsizes(tt)-1)+1)
     txt2 = where(ismissing(txt2),"",txt2)
     asciiwrite(OUTDIR+"metrics_EM.html",txt2)
     delete([/txt,txt2,tt,z/])
  end if 

  txt := new(500,"string")  
  txt(0) = "<HTML><HEAD><TITLE>Climate Variability Diagnostics Package</TITLE><STYLE>"
  txt(1) = "body {background-color: WhiteSmoke; font-family: Verdana, Geneva, sans-serif}"
  txt(2) = "img.title {width:990; height:105; align:left}"
  txt(3) = "p.subtitle1 {font-size:20pt; color:darkgray}"
  txt(4) = "p.subtitle {font-size:20pt; color:black; text-align:center; font-weight:bold}"
  txt(5) = "p.btext {font-size:12pt; text-align:left}"
  txt(6) = "p.btext2 {font-size:9pt; text-align:left}"
  txt(7) = "td {text-align:center; font-size:12pt}"
  txt(8) = "td.s1 {text-align:left; font-size:11pt}"
  txt(9) = "td.tablehdr {text-align:center; font-size:17pt}"
  txt(10) = "CAPTION {text-align:left; font-size:14pt; font-weight:bold}"
  txt(11) = "</STYLE></HEAD><BODY>"
  txt(12) = "<img class="+quote+"img-fluid"+quote+" src="+quote+"cas_cvdp-le.png"+quote+" alt="+quote+"CVDP-LE logo"+quote+">"
  txt(13)= "<TABLE width='990' border=0 cellpadding=6>"
  txt(14) = "<tr><td width='30'><p class=btext>Go to:</p></td><td class=s1 width='380'><a href="+quote+"http://dx.doi.org/10.5065/h7c7-f961"+quote+">User's Guide</a><br><a href="+quote+"index.html"+quote+">Diagnostics Plots</a><br><hr>"

  txt(27) = "<p class=btext><a href="+quote+"namelist_obs"+quote+">Observations Used</a></p>"
  txt(28) = "<p class=btext><a href="+quote+"metrics.txt"+quote+">Individual Metrics (ascii table)</a></p>"
  txt(29) = "<p class=btext><a href="+quote+"metrics_EM.txt"+quote+">Ensemble Metrics (ascii table)</a></p>"
  txt(30) = "Created "+systemfunc("date")
  txt(31) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"

  sort_txt2 = (/"Namelist (default)","Namelist (Alphabetically)","ENSO TAS","ENSO PSL","El Ni&ntilde;o Hovm&ouml;ller","La Ni&ntilde;a Hovm&ouml;ller","AMV' Low Pass","PDV'","NAO","PNA","SAM","SST std dev","PR std dev","Mean Score"/)

  imcreate = False
  if (isfilepresent2(OUTDIR+"metrics.table_1.gif")) then  ; create sorted individual run metrics table pages
     imcreate = True
     sort_txt = (/"<a href="+quote+"metrics.table_0.html"+quote+">Namelist (default)</a> | ","<a href="+quote+"metrics.table_1.html"+quote+">Namelist (Alphabetically)</a> | ","<a href="+quote+"metrics.table_2.html"+quote+">ENSO TAS</a> | ","<a href="+quote+"metrics.table_3.html"+quote+">ENSO PSL</a> | ", \
                  "<a href="+quote+"metrics.table_4.html"+quote+">El Ni&ntilde;o Hovm&ouml;ller</a><br>","<a href="+quote+"metrics.table_5.html"+quote+">La Ni&ntilde;a Hovm&ouml;ller</a> | ","<a href="+quote+"metrics.table_6.html"+quote+">AMV' Low-Pass</a> | ","<a href="+quote+"metrics.table_7.html"+quote+">PDV'</a> | ", \
                  "<a href="+quote+"metrics.table_8.html"+quote+">NAO</a> | ","<a href="+quote+"metrics.table_9.html"+quote+">PNA</a> | ","<a href="+quote+"metrics.table_10.html"+quote+">SAM</a> | ","<a href="+quote+"metrics.table_11.html"+quote+">SST std dev</a> | ", \
                  "<a href="+quote+"metrics.table_12.html"+quote+">PR std dev</a> | ","<a href="+quote+"metrics.table_13.html"+quote+">Mean Score</a>"/)

     sort_txtA = (/"<a href="+quote+"metrics.table_14.html"+quote+">Namelist (default)</a> | ","<a href="+quote+"metrics.table_15.html"+quote+">Namelist (Alphabetically)</a> | ","<a href="+quote+"metrics.table_16.html"+quote+">ENSO TAS</a> | ","<a href="+quote+"metrics.table_17.html"+quote+">ENSO PSL</a> | ", \
                  "<a href="+quote+"metrics.table_18.html"+quote+">El Ni&ntilde;o Hovm&ouml;ller</a><br>","<a href="+quote+"metrics.table_19.html"+quote+">La Ni&ntilde;a Hovm&ouml;ller</a> | ","<a href="+quote+"metrics.table_20.html"+quote+">AMV' Low-Pass</a> | ","<a href="+quote+"metrics.table_21.html"+quote+">PDV'</a> | ", \
                  "<a href="+quote+"metrics.table_22.html"+quote+">NAO</a> | ","<a href="+quote+"metrics.table_23.html"+quote+">PNA</a> | ","<a href="+quote+"metrics.table_24.html"+quote+">SAM</a> | ","<a href="+quote+"metrics.table_25.html"+quote+">SST std dev</a> | ", \
                  "<a href="+quote+"metrics.table_26.html"+quote+">PR std dev</a> | ","<a href="+quote+"metrics.table_27.html"+quote+">Mean Score</a>"/)

     strarr = new(14,string)
     strarr = " | "
     strarr(13) = " "
     do gg = 0,13    ; Individual Pattern Correlation

           txt(15) = "Metrics Graphics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Correlations</a> | <a href="+quote+"metrics.ensemble.rms.html"+quote+">RMS</a><br>"
           txt(16) = "Ensemble Metrics Tables: <a href="+quote+"metrics.table_"+gg+"E.html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_"+(gg+14)+"E.html"+quote+">RMS</a><br>"
           txt(17) = "Individual Metrics Tables: <b>Correlations</b> | <a href="+quote+"metrics.table_"+(gg+14)+".html"+quote+">RMS</a></td>"   
           txt(18) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
           sort_txtT = sort_txt
           sort_txtT(gg) = "<b>"+sort_txt2(gg)+"</b>"+strarr(gg)
           txt(24) = "<p class=subtitle1><b>Pattern Correlation Metrics (Individual)</b></p>"
           txt(25) = "<TABLE width='900' border=0 cellpadding=16><tr><td width=50><b>Sort By:</b></td><td>"+str_concat(sort_txtT)+"</td></tr></table>" 
           txt(26) = "<img width=980 src="+quote+"metrics.table_"+gg+".gif"+quote+" />"
           tt = ind(.not.ismissing(txt))
           txt2 = txt(:tt(dimsizes(tt)-1)+1)
           txt2 = where(ismissing(txt2),"",txt2)
           asciiwrite(OUTDIR+"metrics.table_"+gg+".html",txt2)
           delete([/txt2,tt,sort_txtT/])
     end do

     
     do gg = 0,13    ; Individual RMS
           txt(15) = "Metrics Graphics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Correlations</a> | <a href="+quote+"metrics.ensemble.rms.html"+quote+">RMS</a><br>"
           txt(16) = "Ensemble Metrics Tables: <a href="+quote+"metrics.table_"+gg+"E.html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_"+(gg+14)+"E.html"+quote+">RMS</a><br>"
           txt(17) = "Individual Metrics Tables: <a href="+quote+"metrics.table_"+(gg)+".html"+quote+">Correlations</a> | <b>RMS</b></td>"   
           txt(18) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
           sort_txtT = sort_txtA
           sort_txtT(gg) = "<b>"+sort_txt2(gg)+"</b>"+strarr(gg)
           txt(24) = "<p class=subtitle1><b>RMS Metrics (Individual)</b></p>"
           txt(25) = "<TABLE width='900' border=0 cellpadding=16><tr><td width=50><b>Sort By:</b></td><td>"+str_concat(sort_txtT)+"</td></tr></table>"
           txt(26) = "<img width=980 src="+quote+"metrics.table_"+(gg+14)+".gif"+quote+" />"
           tt = ind(.not.ismissing(txt))
           txt2 = txt(:tt(dimsizes(tt)-1)+1)
           txt2 = where(ismissing(txt2),"",txt2)
           asciiwrite(OUTDIR+"metrics.table_"+(gg+14)+".html",txt2)
           delete([/txt2,tt/])
     end do
  end if
  if (isfilepresent2(OUTDIR+"metrics.table_1E.gif")) then  ; create sorted ensemble metrics table pages
     sort_txt = (/"<a href="+quote+"metrics.table_0E.html"+quote+">Namelist (default)</a> | ","<a href="+quote+"metrics.table_1E.html"+quote+">Namelist (Alphabetically)</a> | ","<a href="+quote+"metrics.table_2E.html"+quote+">ENSO TAS</a> | ","<a href="+quote+"metrics.table_3E.html"+quote+">ENSO PSL</a> | ", \
                  "<a href="+quote+"metrics.table_4E.html"+quote+">El Ni&ntilde;o Hovm&ouml;ller</a><br>","<a href="+quote+"metrics.table_5E.html"+quote+">La Ni&ntilde;a Hovm&ouml;ller</a> | ","<a href="+quote+"metrics.table_6E.html"+quote+">AMV' Low-Pass</a> | ","<a href="+quote+"metrics.table_7E.html"+quote+">PDV'</a> | ", \
                  "<a href="+quote+"metrics.table_8E.html"+quote+">NAO</a> | ","<a href="+quote+"metrics.table_9E.html"+quote+">PNA</a> | ","<a href="+quote+"metrics.table_10E.html"+quote+">SAM</a> | ","<a href="+quote+"metrics.table_11E.html"+quote+">SST std dev</a> | ", \
                  "<a href="+quote+"metrics.table_12E.html"+quote+">PR std dev</a> | ","<a href="+quote+"metrics.table_13E.html"+quote+">Mean Score</a>"/)
     sort_txtA = (/"<a href="+quote+"metrics.table_14E.html"+quote+">Namelist (default)</a> | ","<a href="+quote+"metrics.table_15E.html"+quote+">Namelist (Alphabetically)</a> | ","<a href="+quote+"metrics.table_16E.html"+quote+">ENSO TAS</a> | ","<a href="+quote+"metrics.table_17E.html"+quote+">ENSO PSL</a> | ", \
                  "<a href="+quote+"metrics.table_18E.html"+quote+">El Ni&ntilde;o Hovm&ouml;ller</a><br>","<a href="+quote+"metrics.table_19E.html"+quote+">La Ni&ntilde;a Hovm&ouml;ller</a> | ","<a href="+quote+"metrics.table_20E.html"+quote+">AMV' Low-Pass</a> | ","<a href="+quote+"metrics.table_21E.html"+quote+">PDV'</a> | ", \
                  "<a href="+quote+"metrics.table_22E.html"+quote+">NAO</a> | ","<a href="+quote+"metrics.table_23E.html"+quote+">PNA</a> | ","<a href="+quote+"metrics.table_24E.html"+quote+">SAM</a> | ","<a href="+quote+"metrics.table_25E.html"+quote+">SST std dev</a> | ", \
                  "<a href="+quote+"metrics.table_26E.html"+quote+">PR std dev</a> | ","<a href="+quote+"metrics.table_27E.html"+quote+">Mean Score</a>"/)

     strarr = new(14,string)
     strarr = " | "
     strarr(13) = " "

     do gg = 0,13     ; Ensemble Mean Pattern Correlation Table
        txt(15) = "Metrics Graphics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Correlations</a> | <a href="+quote+"metrics.ensemble.rms.html"+quote+">RMS</a><br>"
        txt(16) = "Ensemble Metrics Tables: <b>Correlations</b> | <a href="+quote+"metrics.table_"+(gg+14)+"E.html"+quote+">RMS</a><br>"
        if (imcreate) then
           txt(17) = "Individual Metrics Tables: <a href="+quote+"metrics.table_"+(gg)+".html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_"+(gg+14)+".html"+quote+">RMS</a></td>"
        else
           txt(17) = "<a href="+quote+"metrics.html"+quote+">Individual Metrics Table</a></td>" 
        end if
        txt(18) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
        sort_txtT = sort_txt
        sort_txtT(gg) = "<b>"+sort_txt2(gg)+"</b>"+strarr(gg)
        txt(24) = "<p class=subtitle1><b>Pattern Correlation Metrics (Ensembles)</b></p>"
        txt(25) = "<TABLE width='900' border=0 cellpadding=16><tr><td width=50><b>Sort By:</b></td><td>"+str_concat(sort_txtT)+"</td></tr></table>" 
        txt(26) = "<img width=980 src="+quote+"metrics.table_"+gg+"E.gif"+quote+" />"
        tt = ind(.not.ismissing(txt))
        txt2 = txt(:tt(dimsizes(tt)-1)+1)
        txt2 = where(ismissing(txt2),"",txt2)
        asciiwrite(OUTDIR+"metrics.table_"+gg+"E.html",txt2)
        delete([/txt2,tt,sort_txtT/])
     end do

     
     do gg = 0,13    ; Ensemble Mean RMS
        txt(15) = "Metrics Graphics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Correlations</a> | <a href="+quote+"metrics.ensemble.rms.html"+quote+">RMS</a><br>"
        txt(16) = "Ensemble Metrics Tables: <a href="+quote+"metrics.table_"+gg+"E.html"+quote+">Correlations</a> | <b>RMS</b><br>"
        if (imcreate) then
           txt(17) = "Individual Metrics Tables: <a href="+quote+"metrics.table_"+(gg)+".html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_"+(gg+14)+".html"+quote+">RMS</a></td>"   
        else
           txt(17) = "<a href="+quote+"metrics.html"+quote+">Individual Metrics Table</a></td>" 
        end if
        txt(18) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
        sort_txtT = sort_txtA
        sort_txtT(gg) = "<b>"+sort_txt2(gg)+"</b>"+strarr(gg)
        txt(24) = "<p class=subtitle1><b>RMS Metrics (Ensembles)</b></p>"
        txt(25) = "<TABLE width='900' border=0 cellpadding=16><tr><td width=50><b>Sort By:</b></td><td>"+str_concat(sort_txtT)+"</td></tr></table>"
        txt(26) = "<img width=980 src="+quote+"metrics.table_"+(gg+14)+"E.gif"+quote+" />"
        tt = ind(.not.ismissing(txt))
        txt2 = txt(:tt(dimsizes(tt)-1)+1)
        txt2 = where(ismissing(txt2),"",txt2)
        asciiwrite(OUTDIR+"metrics.table_"+(gg+14)+"E.html",txt2)
        delete([/txt2,tt/])
     end do

     if (imcreate) then
        txt(17) = "Individual Metrics Tables: <a href="+quote+"metrics.table_0.html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_14.html"+quote+">RMS</a></td>"
     else
        txt(17) = "<a href="+quote+"metrics.html"+quote+">Individual Metrics Table</a></td>"
     end if
     txt(15) = "Metrics Graphics: <b>Correlations</b> | <a href="+quote+"metrics.ensemble.rms.html"+quote+">RMS</a><br>"
     txt(16) = "Ensemble Metrics Tables: <a href="+quote+"metrics.table_0E.html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_14E.html"+quote+">RMS</a><br>"
     txt(18) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
     txt(24) = "<p class=subtitle1><b>Pattern Correlation Graphics</b></p>"
     txt(25) = ""
     txt(26) = "<img width=980 src="+quote+"ensemble_metrics_pc.gif"+quote+" />"
     tt = ind(.not.ismissing(txt))
     txt2 = txt(:tt(dimsizes(tt)-1)+1)
     txt2 = where(ismissing(txt2),"",txt2)
     asciiwrite(OUTDIR+"metrics.ensemble.pc.html",txt2)

     txt(15) = "Metrics Graphics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Correlation</a> | <b>RMS</b><br>"
     txt(16) = "Ensemble Metrics Tables: <a href="+quote+"metrics.table_0E.html"+quote+">Correlations</a> | <a href="+quote+"metrics.table_14E.html"+quote+">RMS</a><br>"
     txt(18) = "<td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
     txt(24) = "<p class=subtitle1><b>RMS Graphics</b></p>"
     txt(25) = ""
     txt(26) = "<img width=980 src="+quote+"ensemble_metrics_rms.gif"+quote+" />"
     tt = ind(.not.ismissing(txt))
     txt2 = txt(:tt(dimsizes(tt)-1)+1)
     txt2 = where(ismissing(txt2),"",txt2)
     asciiwrite(OUTDIR+"metrics.ensemble.rms.html",txt2)
     delete([/txt,strarr,tt,txt2/])
  end if 
;-----------------------------------------------------------------------------------
; Create index.html and index2.html
;
  txt := new(10000,"string")
  
  txt(0) = "<html><head><title>Climate Variability Diagnostics Package for Large Ensembles</title>"
  txt(1) = "<link rel="+quote+"stylesheet"+quote+" href="+quote+"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"+quote+" integrity="+quote+"sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"+quote+" crossorigin="+quote+"anonymous"+quote+">"
  txt(2) = "<script src="+quote+"https://code.jquery.com/jquery-3.3.1.slim.min.js"+quote+" integrity="+quote+"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"+quote+" crossorigin="+quote+"anonymous"+quote+"></script>"
  txt(3) = "<script src="+quote+"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"+quote+" integrity="+quote+"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"+quote+" crossorigin="+quote+"anonymous"+quote+"></script>"
  txt(4) = "<script src="+quote+"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"+quote+" integrity="+quote+"sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"+quote+" crossorigin="+quote+"anonymous"+quote+"></script>"

  txt(11) = "<STYLE>body {background-color: WhiteSmoke; font-family: Verdana, Geneva, sans-serif}"
  txt(12) = "img.title {width:990; height:105; align:left}"
  txt(13) = "p.subtitle {font-size:20pt; color:black; text-align:center; font-weight:bold}"
  txt(14) = "p.btext {font-size:11pt; text-align:left}"
  txt(15) = "font.s1 {font-size:13.5pt; text-align:left}"
  txt(17) = "td {text-align:center; font-size:12pt}"
  txt(18) = "td.s1 {text-align:left; font-size:11pt}"
  txt(19) = "td.s2 {border-bottom: 4px double darkgray}"
  txt(20) = "CAPTION {text-align:left; font-size:14pt; font-weight:bold}"
  txt(21) = "</style></head>"

  txt(30) = "<body>"
  txt(31) = "<div class="+quote+"container"+quote+">"
	 txt(32) = "<div class="+quote+"row"+quote+">"
		txt(33) = "<img class="+quote+"img-fluid"+quote+" src="+quote+"cas_cvdp-le.png"+quote+" alt="+quote+"CVDP-LE logo"+quote+">"
  txt(34) = "</div>"

  txt(40) = "<div class="+quote+"row"+quote+">"
		txt(41) = "<div class="+quote+"col"+quote+">"
		txt(42) = "<table class="+quote+"table my-0"+quote+">"
		txt(43) = "<tr>"
		txt(44) = "<td class="+quote+"text-left"+quote+">"
		txt(45) = "<ul class="+quote+"list-inline my-0"+quote+">"
		txt(46) = "<li class="+quote+"list-inline-item"+quote+"><a href="+quote+"http://dx.doi.org/10.5065/h7c7-f961"+quote+">User's Guide</a></li><br>"
  
  if (isfilepresent2(OUTDIR+"metrics.ensemble.pc.html")) then   ; both metrics.ensemble.pc.html and metrics.table_0E.html should be present
     atxt = "<li class="+quote+"list-inline-item"+quote+">Metrics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Graphics</a> | <a href="+quote+"metrics.table_0E.html"+quote+">Ensemble Tables</a> | "
  else
     if (isfilepresent2(OUTDIR+"metrics_EM.html")) then
        atxt = "<li class="+quote+"list-inline-item"+quote+">Metrics: <a href="+quote+"metrics_EM.html"+quote+">Ensemble Table</a> | "
     else
        atxt = ""
     end if
  end if
  if (isfilepresent2(OUTDIR+"metrics.table_0.html")) then
     btxt = "<a href="+quote+"metrics.table_0.html"+quote+">Individual Tables</a></li><br>"
  else
     if (isfilepresent2(OUTDIR+"metrics.html")) then
        btxt = "<a href="+quote+"metrics.html"+quote+">Individual Table</a></li><br>"
     else
        btxt = ""
     end if
  end if
  if (atxt.eq."".and.btxt.eq."") then
     txt(48) = "Metrics Unavailable<br>"
  else
     txt(48) = atxt+btxt
  end if

;  if (isfilepresent2(OUTDIR+"metrics.ensemble.pc.html")) then
;     txt(48) = "<li class="+quote+"list-inline-item"+quote+">Metrics: <a href="+quote+"metrics.ensemble.pc.html"+quote+">Graphics</a> | <a href="+quote+"metrics.table_0E.html"+quote+">Ensemble Tables</a> | <a href="+quote+"metrics.table_0.html"+quote+">Individual Tables</a></li><br>"
;  else
;     if (isfilepresent2(OUTDIR+"metrics.txt")) then
;        txt(48) = "<li class="+quote+"list-inline-item"+quote+">Metrics: <a href="+quote+"metrics.txt"+quote+">Individual</a> |  <a href="+quote+"metrics_EM.txt"+quote+">Ensemble</a></li><br>"
;     end if
;  end if
		txt(49) = "<li class="+quote+"list-inline-item"+quote+">Namelists: <a href="+quote+"namelist_obs.html"+quote+">Input</a> | <a href="+quote+"namelist_msftmz.html"+quote+">Derived</a></li>"
		txt(67) = "<li class="+quote+"list-inline-item"+quote+">Created: "+systemfunc("date")+"<br>CVDP-LE Version "+VERSION+"</li>"
  txt(68) = "<li class="+quote+"list-inline-item"+quote+"><b>Ensemble Summary</b> | <a href="+quote+"index2.html"+quote+">Individual Members</a></li>"
		txt(70) = "</ul></td>"
		txt(83) = "</tr>"
		txt(84) = "</table>"
		txt(85) = "</div>"
		txt(86) = "<div class="+quote+"col align-self-center"+quote+">"
		txt(87) = "<h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2>"
		txt(88) = "</div>"
	 txt(89) = "</div>"

  txt(100) = "<div class="+quote+"row"+quote+">"
  txt(101) = "<div class="+quote+"col"+quote+">"
  txt(102) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(103) = "<h3 class="+quote+"display-6"+quote+">Climatological Averages</h3>"

  txt(110) = "<tr class="+quote+"d-flex"+quote+">"
  txt(111) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"
  txt(112) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_djf.summary.png","DJF")+"</td>"
  txt(113) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_jfm.summary.png","JFM")+"</td>"
  txt(114) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_mam.summary.png","MAM")+"</td>"
  txt(115) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_jja.summary.png","JJA")+"</td>"
  txt(116) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_jas.summary.png","JAS")+"</td>"
  txt(117) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_son.summary.png","SON")+"</td>"
  txt(118) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialmean_ann.summary.png","ANN")+"</td>"
  txt(119) = "</tr>"

  txt(120) = "<tr class="+quote+"d-flex"+quote+">"
  txt(121) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"
  txt(122) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_djf.summary.png","DJF")+"</td>"
  txt(123) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_jfm.summary.png","JFM")+"</td>"
  txt(124) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_mam.summary.png","MAM")+"</td>"
  txt(125) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_jja.summary.png","JJA")+"</td>"
  txt(126) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_jas.summary.png","JAS")+"</td>"
  txt(127) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_son.summary.png","SON")+"</td>"
  txt(128) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialmean_ann.summary.png","ANN")+"</td>"
  txt(129) = "</tr>"

  txt(130) = "<tr class="+quote+"d-flex"+quote+">"
  txt(131) = "<td class="+quote+"col"+quote+"><b>PSL</b></td>"
  txt(132) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_djf.summary.png","DJF")+"</td>"
  txt(133) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_jfm.summary.png","JFM")+"</td>"
  txt(134) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_mam.summary.png","MAM")+"</td>"
  txt(135) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_jja.summary.png","JJA")+"</td>"
  txt(136) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_jas.summary.png","JAS")+"</td>"
  txt(137) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_son.summary.png","SON")+"</td>"
  txt(138) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialmean_ann.summary.png","ANN")+"</td>"
  txt(139) = "</tr>"

  txt(140) = "<tr class="+quote+"d-flex"+quote+">"
  txt(141) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"
  txt(142) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_djf.summary.png","DJF")+"</td>"
  txt(143) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_jfm.summary.png","JFM")+"</td>"
  txt(144) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_mam.summary.png","MAM")+"</td>"
  txt(145) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_jja.summary.png","JJA")+"</td>"
  txt(146) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_jas.summary.png","JAS")+"</td>"
  txt(147) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_son.summary.png","SON")+"</td>"
  txt(148) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialmean_ann.summary.png","ANN")+"</td>"
  txt(149) = "</tr>"


  txt(160) = "<tr class="+quote+"d-flex"+quote+">"
  txt(161) = "<td class="+quote+"col"+quote+"><b>SIC NH</b></td>"
  txt(162) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_djf.summary.png","DJF")+"</td>"
  txt(163) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_jfm.summary.png","JFM")+"</td>"
  txt(164) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_mam.summary.png","MAM")+"</td>"
  txt(165) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_jja.summary.png","JJA")+"</td>"
  txt(166) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_jas.summary.png","JAS")+"</td>"
  txt(167) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_son.summary.png","SON")+"</td>"
  txt(168) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialmean_ann.summary.png","ANN")+"</td>"
  txt(169) = "</tr>"

  txt(170) = "<tr class="+quote+"d-flex"+quote+">"
  txt(171) = "<td class="+quote+"col"+quote+"><b>SIC SH</b></td>"
  txt(172) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_djf.summary.png","DJF")+"</td>"
  txt(173) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_jfm.summary.png","JFM")+"</td>"
  txt(174) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_mam.summary.png","MAM")+"</td>"
  txt(175) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_jja.summary.png","JJA")+"</td>"
  txt(176) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_jas.summary.png","JAS")+"</td>"
  txt(177) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_son.summary.png","SON")+"</td>"
  txt(178) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialmean_ann.summary.png","ANN")+"</td>"
  txt(179) = "</tr></table></div></div>"

  txt(300) = "<div class="+quote+"row"+quote+">"
  txt(301) = "<div class="+quote+"col"+quote+">"
  txt(302) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(303) = "<h3 class="+quote+"display-6"+quote+">Standard Deviations</h3>"

  txt(310) = "<tr class="+quote+"d-flex"+quote+">"
  txt(311) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"
  txt(312) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_djf.summary.png","DJF")+"</td>"
  txt(313) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_jfm.summary.png","JFM")+"</td>"
  txt(314) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_mam.summary.png","MAM")+"</td>"
  txt(315) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_jja.summary.png","JJA")+"</td>"
  txt(316) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_jas.summary.png","JAS")+"</td>"
  txt(317) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_son.summary.png","SON")+"</td>"
  txt(318) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_spatialstddev_ann.summary.png","ANN")+"</td>"
  txt(319) = "</tr>"

  txt(320) = "<tr class="+quote+"d-flex"+quote+">"
  txt(321) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"
  txt(322) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_djf.summary.png","DJF")+"</td>"
  txt(323) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_jfm.summary.png","JFM")+"</td>" 
  txt(324) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_mam.summary.png","MAM")+"</td>"
  txt(325) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_jja.summary.png","JJA")+"</td>"
  txt(326) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_jas.summary.png","JAS")+"</td>"
  txt(327) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_son.summary.png","SON")+"</td>"
  txt(328) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_spatialstddev_ann.summary.png","ANN")+"</td>"
  txt(329) = "</tr>"

  txt(330) = "<tr class="+quote+"d-flex"+quote+">"
  txt(331) = "<td class="+quote+"col"+quote+"><b>PSL</b></td>"
  txt(332) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_djf.summary.png","DJF")+"</td>"
  txt(333) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_jfm.summary.png","JFM")+"</td>"
  txt(334) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_mam.summary.png","MAM")+"</td>"
  txt(335) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_jja.summary.png","JJA")+"</td>"
  txt(336) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_jas.summary.png","JAS")+"</td>"
  txt(337) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_son.summary.png","SON")+"</td>"
  txt(338) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_spatialstddev_ann.summary.png","ANN")+"</td>"
  txt(339) = "</tr>"

  txt(340) = "<tr class="+quote+"d-flex"+quote+">"
  txt(341) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"
  txt(342) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_djf.summary.png","DJF")+"</td>"
  txt(343) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_jfm.summary.png","JFM")+"</td>"
  txt(344) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_mam.summary.png","MAM")+"</td>"
  txt(345) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_jja.summary.png","JJA")+"</td>"
  txt(346) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_jas.summary.png","JAS")+"</td>"
  txt(347) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_son.summary.png","SON")+"</td>"
  txt(348) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_spatialstddev_ann.summary.png","ANN")+"</td>"
  txt(349) = "</tr>"

  txt(360) = "<tr class="+quote+"d-flex"+quote+">"
  txt(361) = "<td class="+quote+"col"+quote+"><b>SIC NH</b></td>"
  txt(362) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_djf.summary.png","DJF")+"</td>"
  txt(363) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_jfm.summary.png","JFM")+"</td>"
  txt(364) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_mam.summary.png","MAM")+"</td>"
  txt(365) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_jja.summary.png","JJA")+"</td>"
  txt(366) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_jas.summary.png","JAS")+"</td>"
  txt(367) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_son.summary.png","SON")+"</td>"
  txt(368) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_spatialstddev_ann.summary.png","ANN")+"</td>"
  txt(369) = "</tr>"

  txt(370) = "<tr class="+quote+"d-flex"+quote+">"
  txt(371) = "<td class="+quote+"col"+quote+"><b>SIC SH</b></td>"
  txt(372) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_djf.summary.png","DJF")+"</td>"
  txt(373) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_jfm.summary.png","JFM")+"</td>"
  txt(374) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_mam.summary.png","MAM")+"</td>"
  txt(375) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_jja.summary.png","JJA")+"</td>"
  txt(376) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_jas.summary.png","JAS")+"</td>"
  txt(377) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_son.summary.png","SON")+"</td>"
  txt(378) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_spatialstddev_ann.summary.png","ANN")+"</td>"
  txt(379) = "</tr></table></div></div>"



  txt(500) = "<div class="+quote+"row"+quote+">"
  txt(501) = "<div class="+quote+"col"+quote+">"
  txt(502) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(503) = "<h3 class="+quote+"display-6"+quote+">Global Trend Maps</h3>"

  txt(510) = "<tr class="+quote+"d-flex"+quote+">"
  txt(511) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"
  txt(512) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_djf.summary.png","DJF")+"</td>"
  txt(513) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_jfm.summary.png","JFM")+"</td>"
  txt(514) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_mam.summary.png","MAM")+"</td>"
  txt(515) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_jja.summary.png","JJA")+"</td>"
  txt(516) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_jas.summary.png","JAS")+"</td>"
  txt(517) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_son.summary.png","SON")+"</td>"
  txt(518) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_trends_ann.summary.png","ANN")+"</td>"
  txt(519) = "</tr>"

  txt(520) = "<tr class="+quote+"d-flex"+quote+">"
  txt(521) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"
  txt(522) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_djf.summary.png","DJF")+"</td>"
  txt(523) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_jfm.summary.png","JFM")+"</td>"
  txt(524) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_mam.summary.png","MAM")+"</td>"
  txt(525) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_jja.summary.png","JJA")+"</td>"
  txt(526) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_jas.summary.png","JAS")+"</td>"
  txt(527) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_son.summary.png","SON")+"</td>"
  txt(528) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_trends_ann.summary.png","ANN")+"</td>"
  txt(529) = "</tr>"

  txt(530) = "<tr class="+quote+"d-flex"+quote+">"
  txt(531) = "<td class="+quote+"col"+quote+"><b>PSL</b></td>"
  txt(532) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_djf.summary.png","DJF")+"</td>"
  txt(533) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_jfm.summary.png","JFM")+"</td>"
  txt(534) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_mam.summary.png","MAM")+"</td>"
  txt(535) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_jja.summary.png","JJA")+"</td>"
  txt(536) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_jas.summary.png","JAS")+"</td>"
  txt(537) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_son.summary.png","SON")+"</td>"
  txt(538) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"psl_trends_ann.summary.png","ANN")+"</td>"
  txt(539) = "</tr>"

  txt(540) = "<tr class="+quote+"d-flex"+quote+">"
  txt(541) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"
  txt(542) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_djf.summary.png","DJF")+"</td>"
  txt(543) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_jfm.summary.png","JFM")+"</td>"
  txt(544) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_mam.summary.png","MAM")+"</td>"
  txt(545) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_jja.summary.png","JJA")+"</td>"
  txt(546) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_jas.summary.png","JAS")+"</td>"
  txt(547) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_son.summary.png","SON")+"</td>"
  txt(548) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_trends_ann.summary.png","ANN")+"</td>"
  txt(549) = "</tr>"

  txt(560) = "<tr class="+quote+"d-flex"+quote+">"
  txt(561) = "<td class="+quote+"col"+quote+"><b>SIC NH</b></td>"
  txt(562) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_djf.summary.png","DJF")+"</td>"
  txt(563) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_jfm.summary.png","JFM")+"</td>"
  txt(564) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_mam.summary.png","MAM")+"</td>"
  txt(565) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_jja.summary.png","JJA")+"</td>"
  txt(566) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_jas.summary.png","JAS")+"</td>"
  txt(567) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_son.summary.png","SON")+"</td>"
  txt(568) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_nh_trends_ann.summary.png","ANN")+"</td>"
  txt(569) = "</tr>"

  txt(570) = "<tr class="+quote+"d-flex"+quote+">"
  txt(571) = "<td class="+quote+"col"+quote+"><b>SIC SH</b></td>"
  txt(572) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_djf.summary.png","DJF")+"</td>"
  txt(573) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_jfm.summary.png","JFM")+"</td>"
  txt(574) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_mam.summary.png","MAM")+"</td>"
  txt(575) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_jja.summary.png","JJA")+"</td>"
  txt(576) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_jas.summary.png","JAS")+"</td>"
  txt(577) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_son.summary.png","SON")+"</td>"
  txt(578) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"siconc_sh_trends_ann.summary.png","ANN")+"</td>"
  txt(579) = "</tr></table></div></div>"

  txt(1000) = "<div class="+quote+"row"+quote+">"
  txt(1001) = "<div class="+quote+"col"+quote+">"
  txt(1002) = "<table class="+quote+"table table-bordered"+quote+">"
  txt(1003) = "<h3 class="+quote+"display-6"+quote+">Coupled Modes of Variability</h3>"
  txt(1004) = "<tr>"
  txt(1005) = "<td rowspan=7><b>ENSO</b></td>"
  
  txt(1010) = "<td rowspan=4>Spatial Composites</td>"
  txt(1011) = "<td>El Ni&ntilde;o - La Ni&ntilde;a<br>SST/TAS/PSL<br>"
  txt(1012) = table_link_setup(OUTDIR,"nino34.spatialcomp.summary.jja0.png","JJA<sup>0</sup>")+" "
  txt(1013) = table_link_setup(OUTDIR,"nino34.spatialcomp.summary.son0.png","SON<sup>0</sup>")+" "
  txt(1014) = table_link_setup(OUTDIR,"nino34.spatialcomp.summary.djf1.png","DJF<sup>1</sup>")+" "
  txt(1015) = table_link_setup(OUTDIR,"nino34.spatialcomp.summary.mam1.png","MAM<sup>1</sup>")+"</td>"
  txt(1020) = "<td>El Ni&ntilde;o - La Ni&ntilde;a<br>PR<br>"
  txt(1021) = table_link_setup(OUTDIR,"nino34.spatialcomp.pr.summary.jja0.png","JJA<sup>0</sup>")+" "
  txt(1022) = table_link_setup(OUTDIR,"nino34.spatialcomp.pr.summary.son0.png","SON<sup>0</sup>")+" "
  txt(1023) = table_link_setup(OUTDIR,"nino34.spatialcomp.pr.summary.djf1.png","DJF<sup>1</sup>")+" "
  txt(1024) = table_link_setup(OUTDIR,"nino34.spatialcomp.pr.summary.mam1.png","MAM<sup>1</sup>")+"</td></tr>"

  txt(1031) = "<td>El Ni&ntilde;o SST/TAS/PSL<br>"
  txt(1032) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.summary.jja0.png","JJA<sup>0</sup>")+" "
  txt(1033) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.summary.son0.png","SON<sup>0</sup>")+" "
  txt(1034) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.summary.djf1.png","DJF<sup>1</sup>")+" "
  txt(1035) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.summary.mam1.png","MAM<sup>1</sup>")+"</td>"
  txt(1040) = "<td>El Ni&ntilde;o PR<br>"
  txt(1041) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.pr.summary.jja0.png","JJA<sup>0</sup>")+" "
  txt(1042) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.pr.summary.son0.png","SON<sup>0</sup>")+" "
  txt(1043) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.pr.summary.djf1.png","DJF<sup>1</sup>")+" "
  txt(1044) = table_link_setup(OUTDIR,"nino34.spatialcomp.elnino.pr.summary.mam1.png","MAM<sup>1</sup>")+"</td></tr>"

  txt(1051) = "<td>La Ni&ntilde;a SST/TAS/PSL<br>"
  txt(1052) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.summary.jja0.png","JJA<sup>0</sup>")+" "
  txt(1053) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.summary.son0.png","SON<sup>0</sup>")+" "
  txt(1054) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.summary.djf1.png","DJF<sup>1</sup>")+" "
  txt(1055) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.summary.mam1.png","MAM<sup>1</sup>")+"</td>"
  txt(1060) = "<td>La Ni&ntilde;a PR<br>"
  txt(1061) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.pr.summary.jja0.png","JJA<sup>0</sup>")+" "
  txt(1062) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.pr.summary.son0.png","SON<sup>0</sup>")+" "
  txt(1063) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.pr.summary.djf1.png","DJF<sup>1</sup>")+" "
  txt(1064) = table_link_setup(OUTDIR,"nino34.spatialcomp.lanina.pr.summary.mam1.png","MAM<sup>1</sup>")+"</td></tr>"

  txt(1100) = "<tr>"
  txt(1101) = "<td>"+table_link_setup(OUTDIR,"nino34.hov.elnino.summary.png","El Ni&ntilde;o Hovm&ouml;ller")+"</td>"
  txt(1102) = "<td>"+table_link_setup(OUTDIR,"nino34.hov.lanina.summary.png","La Ni&ntilde;a Hovm&ouml;ller")+"</td></tr>"

  txt(1150) = "<tr><td rowspan=3>Ni&ntilde;o3.4</td>"
  txt(1151) = "<td>"+table_link_setup(OUTDIR,"nino34.timeseries.summary.png","Timeseries")+"</td>"
  txt(1152) = "<td>"+table_link_setup(OUTDIR,"nino34.monstddev.summary.png","Monthly Std. Dev.")+"</td>"
  txt(1153) = "<tr><td>"+table_link_setup(OUTDIR,"nino34.powspec.summary.png","Power Spectra")+"</td>"
  txt(1154) = "<td>"+table_link_setup(OUTDIR,"nino34.wavelet.summary.png","Wavelet")+"</td></tr>"
  txt(1155) = "<tr><td>"+table_link_setup(OUTDIR,"nino34.autocor.summary.png","Autocorrelation")+"</td>"
  txt(1156) = "<td>"+table_link_setup(OUTDIR,"nino34_runstddev.timeseries.summary.png","Running Standard Deviation")+"</td></tr>"

  txt(1200) = "<tr><td rowspan=2><b>AMV</b></td>"
  txt(1201) = "<td>Regr: "
  txt(1202) = table_link_setup(OUTDIR,"amv.summary.png","SST")+" "
  txt(1203) = table_link_setup(OUTDIR,"amv.tassstreg.summary.png","TAS")+" "
  txt(1204) = table_link_setup(OUTDIR,"amv.prreg.summary.png","PR")+"</td>"
  txt(1210) = "<td>"+table_link_setup(OUTDIR,"amv_timeseries_mon.summary.png","Timeseries")+"</td>"
  txt(1220) = "<td rowspan=2>"+table_link_setup(OUTDIR,"amv.powspec.summary.png","Power Spectra")+"</td></tr>"


  txt(1251) = "<tr><td>Regr LP: "
  txt(1252) = table_link_setup(OUTDIR,"amv.lp.summary.png","SST")+" "
  txt(1253) = table_link_setup(OUTDIR,"amv.lp.tassstreg.summary.png","TAS")+" "
  txt(1254) = table_link_setup(OUTDIR,"amv.lp.prreg.summary.png","PR")+"</td>"
  txt(1260) = "<td>"+table_link_setup(OUTDIR,"amv_timeseries_lowpass_mon.summary.png","Timeseries")+"</td></tr>"

  txt(1300) = "<tr><td rowspan=2><b>AMV'</b></td>"
  txt(1301) = "<td>Regr: "
  txt(1302) = table_link_setup(OUTDIR,"amv.prime.summary.png","SST")+" "
  txt(1303) = table_link_setup(OUTDIR,"amv.prime.tassstreg.summary.png","TAS")+" "
  txt(1304) = table_link_setup(OUTDIR,"amv.prime.prreg.summary.png","PR")+"</td>"
  txt(1305) = "<td>"+table_link_setup(OUTDIR,"amv_prime_timeseries_mon.summary.png","Timeseries")+"</td>"
  txt(1316) = "<td rowspan=2>"+table_link_setup(OUTDIR,"amv.prime.powspec.summary.png","Power Spectra")+"</td></tr>"

  txt(1327) = "<tr><td>Regr LP: "
  txt(1328) = table_link_setup(OUTDIR,"amv.lp.prime.summary.png","SST")+" "
  txt(1329) = table_link_setup(OUTDIR,"amv.lp.prime.tassstreg.summary.png","TAS")+" "
  txt(1330) = table_link_setup(OUTDIR,"amv.lp.prime.prreg.summary.png","PR")+"</td>"
  txt(1335) = "<td>"+table_link_setup(OUTDIR,"amv_prime_timeseries_lowpass_mon.summary.png","Timeseries")+"</td></tr>"


  txt(1400) = "<tr><td><b>PDV</b></td>"
  txt(1401) = "<td>Regr: "
  txt(1402) = table_link_setup(OUTDIR,"pdv.summary.png","SST")+" "
  txt(1403) = table_link_setup(OUTDIR,"pdv.tassstreg.summary.png","TAS")+" "
  txt(1404) = table_link_setup(OUTDIR,"pdv.prreg.summary.png","PR")+"</td>"
  txt(1405) = "<td>"+table_link_setup(OUTDIR,"pdv_timeseries_mon.summary.png","Timeseries")+"</td>"
  txt(1406) = "<td>"+table_link_setup(OUTDIR,"pdv.powspec.summary.png","Power Spectra")+"</td></tr>"
  txt(1450) = "<tr><td><b>PDV'</b></td>"
  txt(1451) = "<td>Regr: "
  txt(1452) = table_link_setup(OUTDIR,"pdv.prime.summary.png","SST")+" "
  txt(1453) = table_link_setup(OUTDIR,"pdv.prime.tassstreg.summary.png","TAS")+" "
  txt(1454) = table_link_setup(OUTDIR,"pdv.prime.prreg.summary.png","PR")+"</td>"
  txt(1455) = "<td>"+table_link_setup(OUTDIR,"pdv_prime_timeseries_mon.summary.png","Timeseries")+"</td>"
  txt(1456) = "<td>"+table_link_setup(OUTDIR,"pdv.prime.powspec.summary.png","Power Spectra")+"</td></tr>"
  txt(1457) = "</td></tr>"

  txt(1490) = "<tr><td rowspan=3><b>AMOC</b></td>"
  txt(1491) = "<td>"+table_link_setup(OUTDIR,"amoc.mean.ann.summary.png","Means")+"</td>"
  txt(1492) = "<td>"+table_link_setup(OUTDIR,"amoc.stddev.ann.summary.png","Standard Deviations")+"</td>"
  txt(1493) = "<td>"+table_link_setup(OUTDIR,"amoc.pattern.ann.summary.png","Patterns")+"</td></tr>"
  txt(1494) = "<tr><td>"+table_link_setup(OUTDIR,"amoc.timeseries.ann.summary.png","Timeseries")+"</td>"
  txt(1495) = "<td colspan=2>"+table_link_setup(OUTDIR,"amoc.tassstreg.ann.summary.png","SST/TAS Regressions")+"</td></tr>"
  txt(1496) = "<tr><td>"+table_link_setup(OUTDIR,"amoc.powspec.summary.png","Spectra")+"</td>"
  txt(1497) = "<td colspan=2>"+table_link_setup(OUTDIR,"amoc_amv.leadlag.ann.summary.png","AMV/AMOC Lag Correlations")+"</td></tr>"
  txt(1498) = "</table></div></div>"


  txt(1580) = "<div class="+quote+"row"+quote+">"
  txt(1581) = "<div class="+quote+"col"+quote+">"
  txt(1582) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(1583) = "<h3 class="+quote+"display-6"+quote+">Atmospheric Modes of Variability</h3>"

  txt(1591) = "<tr><td rowspan=2><b>SO</b></td>"
  txt(1592) = "<td>Patterns</td>"
  txt(1593) = "<td>"+table_link_setup(OUTDIR,"so_pattern_djf.summary.png","DJF")+"</td>"
  txt(1594) = "<td>"+table_link_setup(OUTDIR,"so_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1595) = "<td>"+table_link_setup(OUTDIR,"so_pattern_mam.summary.png","MAM")+"</td>"
  txt(1596) = "<td>"+table_link_setup(OUTDIR,"so_pattern_jja.summary.png","JJA")+"</td>"
  txt(1597) = "<td>"+table_link_setup(OUTDIR,"so_pattern_jas.summary.png","JAS")+"</td>"
  txt(1598) = "<td>"+table_link_setup(OUTDIR,"so_pattern_son.summary.png","SON")+"</td>"
  txt(1599) = "<td>"+table_link_setup(OUTDIR,"so_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1600) = "<td>Timeseries</td>"
  txt(1603) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1604) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1605) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1606) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1607) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1608) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_son.summary.png","SON")+"</td>"
  txt(1609) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1611) = "<tr><td rowspan=2><b>NAM</b></td>"
  txt(1612) = "<td>Patterns</td>"
  txt(1613) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_djf.summary.png","DJF")+"</td>"
  txt(1614) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1615) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_mam.summary.png","MAM")+"</td>"
  txt(1616) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_jja.summary.png","JJA")+"</td>"
  txt(1617) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_jas.summary.png","JAS")+"</td>"
  txt(1618) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_son.summary.png","SON")+"</td>"
  txt(1619) = "<td>"+table_link_setup(OUTDIR,"nam_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1620) = "<td>Timeseries</td>"
  txt(1623) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1624) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1625) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1626) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1627) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1628) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_son.summary.png","SON")+"</td>"
  txt(1629) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1631) = "<tr><td rowspan=2><b>NAO</b></td>"
  txt(1632) = "<td>Patterns</td>"
  txt(1633) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_djf.summary.png","DJF")+"</td>"
  txt(1634) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1635) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_mam.summary.png","MAM")+"</td>"
  txt(1636) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_jja.summary.png","JJA")+"</td>"
  txt(1637) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_jas.summary.png","JAS")+"</td>"
  txt(1638) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_son.summary.png","SON")+"</td>"
  txt(1639) = "<td>"+table_link_setup(OUTDIR,"nao_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1640) = "<td>Timeseries</td>"
  txt(1643) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1644) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1645) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1646) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1647) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1648) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_son.summary.png","SON")+"</td>"
  txt(1649) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1651) = "<tr><td rowspan=2><b>SAM</b></td>"
  txt(1652) = "<td>Patterns</td>"
  txt(1653) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_djf.summary.png","DJF")+"</td>"
  txt(1654) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1655) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_mam.summary.png","MAM")+"</td>"
  txt(1656) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_jja.summary.png","JJA")+"</td>"
  txt(1657) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_jas.summary.png","JAS")+"</td>"
  txt(1658) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_son.summary.png","SON")+"</td>"
  txt(1659) = "<td>"+table_link_setup(OUTDIR,"sam_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1660) = "<td>Timeseries</td>"
  txt(1663) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1664) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1665) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1666) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1667) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1668) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_son.summary.png","SON")+"</td>"
  txt(1669) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1671) = "<tr><td rowspan=2><b>PNA</b></td>"
  txt(1672) = "<td>Patterns</td>"
  txt(1673) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_djf.summary.png","DJF")+"</td>"
  txt(1674) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1675) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_mam.summary.png","MAM")+"</td>"
  txt(1676) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_jja.summary.png","JJA")+"</td>"
  txt(1677) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_jas.summary.png","JAS")+"</td>"
  txt(1678) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_son.summary.png","SON")+"</td>"
  txt(1679) = "<td>"+table_link_setup(OUTDIR,"pna_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1680) = "<td>Timeseries</td>"
  txt(1683) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1684) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1685) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1686) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1687) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1688) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_son.summary.png","SON")+"</td>"
  txt(1689) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1701) = "<tr><td rowspan=2><b>NPO</b></td>"
  txt(1702) = "<td>Patterns</td>"
  txt(1703) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_djf.summary.png","DJF")+"</td>"
  txt(1704) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1705) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_mam.summary.png","MAM")+"</td>"
  txt(1706) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_jja.summary.png","JJA")+"</td>"
  txt(1707) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_jas.summary.png","JAS")+"</td>"
  txt(1708) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_son.summary.png","SON")+"</td>"
  txt(1709) = "<td>"+table_link_setup(OUTDIR,"npo_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1710) = "<td>Timeseries</td>"
  txt(1713) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1714) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1715) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1716) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1717) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1718) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_son.summary.png","SON")+"</td>"
  txt(1719) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1721) = "<tr><td rowspan=2><b>PSA1</b></td>"
  txt(1722) = "<td>Patterns</td>"
  txt(1723) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_djf.summary.png","DJF")+"</td>"
  txt(1724) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1725) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_mam.summary.png","MAM")+"</td>"
  txt(1726) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_jja.summary.png","JJA")+"</td>"
  txt(1727) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_jas.summary.png","JAS")+"</td>"
  txt(1728) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_son.summary.png","SON")+"</td>"
  txt(1729) = "<td>"+table_link_setup(OUTDIR,"psa1_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1730) = "<td>Timeseries</td>"
  txt(1733) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1734) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1735) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1736) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1737) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1738) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_son.summary.png","SON")+"</td>"
  txt(1739) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_ann.summary.png","ANN")+"</td></tr>"

  txt(1741) = "<tr><td rowspan=2><b>PSA2</b></td>"
  txt(1742) = "<td>Patterns</td>"
  txt(1743) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_djf.summary.png","DJF")+"</td>"
  txt(1744) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_jfm.summary.png","JFM")+"</td>"
  txt(1745) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_mam.summary.png","MAM")+"</td>"
  txt(1746) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_jja.summary.png","JJA")+"</td>"
  txt(1747) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_jas.summary.png","JAS")+"</td>"
  txt(1748) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_son.summary.png","SON")+"</td>"
  txt(1749) = "<td>"+table_link_setup(OUTDIR,"psa2_pattern_ann.summary.png","ANN")+"</td></tr>"
  txt(1750) = "<td>Timeseries</td>"
  txt(1753) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_djf.summary.png","DJF")+"</td>"
  txt(1754) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_jfm.summary.png","JFM")+"</td>"
  txt(1755) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_mam.summary.png","MAM")+"</td>"
  txt(1756) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_jja.summary.png","JJA")+"</td>"
  txt(1757) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_jas.summary.png","JAS")+"</td>"
  txt(1758) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_son.summary.png","SON")+"</td>"
  txt(1759) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_ann.summary.png","ANN")+"</td></tr>"
  txt(3500) = "</table>"


  txt(3600) = "<div class="+quote+"row"+quote+">"
  txt(3601) = "<div class="+quote+"col"+quote+">"
  txt(3602) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(3603) = "<h3 class="+quote+"display-6"+quote+">Global Timeseries</h3>"

  txt(3610) = "<tr class="+quote+"d-flex"+quote+">"
  txt(3611) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"
  txt(3612) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_djf.summary.png","DJF")+"</td>"
  txt(3613) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_jfm.summary.png","JFM")+"</td>"
  txt(3614) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_mam.summary.png","MAM")+"</td>"
  txt(3615) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_jja.summary.png","JJA")+"</td>"
  txt(3616) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_jas.summary.png","JAS")+"</td>"
  txt(3617) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_son.summary.png","SON")+"</td>"
  txt(3618) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_ann.summary.png","ANN")+"</td>"
  txt(3619) = "</tr>"

  txt(3620) = "<tr class="+quote+"d-flex"+quote+">"
  txt(3621) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"
  txt(3622) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_djf.summary.png","DJF")+"</td>"
  txt(3623) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_jfm.summary.png","JFM")+"</td>"
  txt(3624) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_mam.summary.png","MAM")+"</td>"
  txt(3625) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_jja.summary.png","JJA")+"</td>"
  txt(3626) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_jas.summary.png","JAS")+"</td>"
  txt(3627) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_son.summary.png","SON")+"</td>"
  txt(3628) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_ann.summary.png","ANN")+"</td>"
  txt(3629) = "</tr>"

  txt(3640) = "<tr class="+quote+"d-flex"+quote+">"
  txt(3641) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"
  txt(3642) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_djf.summary.png","DJF")+"</td>"
  txt(3643) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_jfm.summary.png","JFM")+"</td>"
  txt(3644) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_mam.summary.png","MAM")+"</td>"
  txt(3645) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_jja.summary.png","JJA")+"</td>"
  txt(3646) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_jas.summary.png","JAS")+"</td>"
  txt(3647) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_son.summary.png","SON")+"</td>"
  txt(3648) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_ann.summary.png","ANN")+"</td>"
  txt(3649) = "</tr>"
  txt(3650) = "<tr class="+quote+"d-flex"+quote+">"
  txt(3651) = "<td class="+quote+"col"+quote+"><b>PR<br>(land-only)</b></td>"
  txt(3652) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_djf.summary.png","DJF")+"</td>"
  txt(3653) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_jfm.summary.png","JFM")+"</td>"
  txt(3654) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_mam.summary.png","MAM")+"</td>"
  txt(3655) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_jja.summary.png","JJA")+"</td>"
  txt(3656) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_jas.summary.png","JAS")+"</td>"
  txt(3657) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_son.summary.png","SON")+"</td>"
  txt(3658) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_ann.summary.png","ANN")+"</td>"
  txt(3659) = "</tr>"
  txt(3677) = "</tr></table></div></div>"

  txt(4000) = "<div class="+quote+"row"+quote+">"
  txt(4001) = "<div class="+quote+"col"+quote+">"
  txt(4002) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(4003) = "<h3 class="+quote+"display-6"+quote+">Regional Timeseries</h3>"
  txt(4004) = "<tr class="+quote+"d-flex"+quote+">"
  txt(4005) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"atlantic_meridional_mode.timeseries.summary.png","Atlantic SST Meridional Mode")+"</td>"
  txt(4006) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"atlantic_nino.timeseries.summary.png","Atlantic Ni&ntilde;o SST")+"</td>"
  txt(4007) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_atlantic.timeseries.summary.png","North Atlantic SST")+"</td>"
  txt(4008) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_tropical_atlantic.timeseries.summary.png","Tropical North Atlantic SST")+"</td>"
  txt(4009) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"south_tropical_atlantic.timeseries.summary.png","Tropical South Atlantic SST")+"</td></tr>"
  txt(4010) = "<tr class="+quote+"d-flex"+quote+"><td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino12.timeseries.summary.png","ni&ntilde;o1+2 SST")+"</td>"
  txt(4017) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino3.timeseries.summary.png","ni&ntilde;o3 SST")+"</td>"
  txt(4018) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino34.timeseries.summary.png","ni&ntilde;o3.4 SST")+"</td>"
  txt(4019) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino4.timeseries.summary.png","ni&ntilde;o4 SST")+"</td></tr>"
  txt(4020) = "<tr class="+quote+"d-flex"+quote+"><td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_pacific_index_ndjfm.summary.png","North Pacific PSL Index (NPI)")+"</td>"
  txt(4021) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_pacific_meridional_mode.timeseries.summary.png","North Pacific SST Meridional Mode")+"</td>"
  txt(4022) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"south_pacific_meridional_mode.timeseries.summary.png","South Pacific SST Meridional Mode")+"</td></tr>"
  txt(4023) = "<tr class="+quote+"d-flex"+quote+"><td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"indian_ocean_dipole.timeseries.summary.png","Indian Ocean SST Dipole")+"</td>"
  txt(4024) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tropical_indian_ocean.timeseries.summary.png","Tropical Indian Ocean SST")+"</td>"
  txt(4025) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"southern_ocean.timeseries.summary.png","Southern Ocean SST")+"</td></tr>"
  txt(4026) = "</table></div></div>"

  txt(4100) = "<div class="+quote+"row"+quote+">"
  txt(4101) = "<div class="+quote+"col"+quote+">"
  txt(4102) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(4103) = "<h3 class="+quote+"display-6"+quote+">Sea Ice Extent Timeseries</h3>"
  txt(4105) = "<tr><td rowspan=2><b>NH</b></td>"
  txt(4106) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_djf.summary.png","DJF")+"</td>"
  txt(4107) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_jfm.summary.png","JFM")+"</td>"
  txt(4108) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_mam.summary.png","MAM")+"</td>"
  txt(4109) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_jja.summary.png","JJA")+"</td>"
  txt(4110) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_jas.summary.png","JAS")+"</td>"
  txt(4111) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_son.summary.png","SON")+"</td>"
  txt(4112) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_ann.summary.png","ANN")+"</td></tr>"
  txt(4116) = "<tr><td>"+table_link_setup(OUTDIR,"siconc_nh_extent_feb.summary.png","Feb")+"</td>"
  txt(4117) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_mar.summary.png","Mar")+"</td>"
  txt(4118) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_sep.summary.png","Sep")+"</td>"
  txt(4119) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_oct.summary.png","Oct")+"</td>"
  txt(4120) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_mon.summary.png","Monthly")+"</td>"
  txt(4121) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_anom_mon.summary.png","Monthly Anomalies")+"</td>"
  txt(4122) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent.climo.summary.png","Climatology")+"</td></tr>"
  txt(4125) = "<tr><td rowspan=2><b>SH</b></td>"
  txt(4126) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_djf.summary.png","DJF")+"</td>"
  txt(4127) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_jfm.summary.png","JFM")+"</td>"
  txt(4128) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_mam.summary.png","MAM")+"</td>"
  txt(4129) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_jja.summary.png","JJA")+"</td>"
  txt(4130) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_jas.summary.png","JAS")+"</td>"
  txt(4131) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_son.summary.png","SON")+"</td>"
  txt(4132) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_ann.summary.png","ANN")+"</td></tr>"
  txt(4136) = "<tr><td>"+table_link_setup(OUTDIR,"siconc_sh_extent_feb.summary.png","Feb")+"</td>"
  txt(4137) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_mar.summary.png","Mar")+"</td>"
  txt(4138) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_sep.summary.png","Sep")+"</td>"
  txt(4139) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_oct.summary.png","Oct")+"</td>"
  txt(4140) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_mon.summary.png","Monthly")+"</td>"
  txt(4141) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_anom_mon.summary.png","Monthly Anomalies")+"</td>"
  txt(4142) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent.climo.summary.png","Climatology")+"</td></tr>"
  txt(4143) = "</table></div></div>"


  txt(4200) = "</div></body></html>"

  
  tt = ind(.not.ismissing(txt))
  txt2 = txt(:tt(dimsizes(tt)-1)+1)
  tt2 = ind(.not.ismissing(txt2))
  txt3 = txt2(tt2)
  asciiwrite(OUTDIR+"index.html",txt3)
;----------------------------------------------------------------------------
  txt := new(30000,"string")
  
  txt(0) = "<html><head><title>Climate Variability Diagnostics Package</title>"
  txt(1) = "<link rel="+quote+"stylesheet"+quote+" href="+quote+"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"+quote+" integrity="+quote+"sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO"+quote+" crossorigin="+quote+"anonymous"+quote+">"
  txt(2) = "<script src="+quote+"https://code.jquery.com/jquery-3.3.1.slim.min.js"+quote+" integrity="+quote+"sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"+quote+" crossorigin="+quote+"anonymous"+quote+"></script>"
  txt(3) = "<script src="+quote+"https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"+quote+" integrity="+quote+"sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"+quote+" crossorigin="+quote+"anonymous"+quote+"></script>"
  txt(4) = "<script src="+quote+"https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"+quote+" integrity="+quote+"sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"+quote+" crossorigin="+quote+"anonymous"+quote+"></script>"

  txt(11) = "<STYLE>body {background-color: WhiteSmoke; font-family: Verdana, Geneva, sans-serif}"
  txt(12) = "img.title {width:990; height:105; align:left}"
  txt(13) = "p.subtitle {font-size:20pt; color:black; text-align:center; font-weight:bold}"
  txt(14) = "p.btext {font-size:11pt; text-align:left}"
  txt(15) = "font.s1 {font-size:13.5pt; text-align:left}"
  txt(17) = "td {text-align:center; font-size:12pt}"
  txt(18) = "td.s1 {text-align:left; font-size:11pt}"
  txt(19) = "td.s2 {border-bottom: 4px double darkgray}"
  txt(20) = "CAPTION {text-align:left; font-size:14pt; font-weight:bold}"
  txt(21) = "</style></head>"

  txt(30) = "<body>"
  txt(31) = "<div class="+quote+"container"+quote+">"
	 txt(32) = "<div class="+quote+"row"+quote+">"
		txt(33) = "<img class="+quote+"img-fluid"+quote+" src="+quote+"cas_cvdp-le.png"+quote+" alt="+quote+"CVDP-LE logo"+quote+">"
  txt(34) = "</div>"

  txt(40) = "<div class="+quote+"row"+quote+">"
		txt(41) = "<div class="+quote+"col"+quote+">"
		txt(42) = "<table class="+quote+"table my-0"+quote+">"
		txt(43) = "<tr>"
		txt(44) = "<td class="+quote+"text-left"+quote+">"
		txt(45) = "<ul class="+quote+"list-inline my-0"+quote+">"
		txt(46) = "<li class="+quote+"list-inline-item"+quote+"><a href="+quote+"http://dx.doi.org/10.5065/h7c7-f961"+quote+">User's Guide</a></li><br>"
  txt(48) = atxt+btxt
		txt(49) = "<li class="+quote+"list-inline-item"+quote+">Namelists: <a href="+quote+"namelist_obs.html"+quote+">Input</a> | <a href="+quote+"namelist_msftmz.html"+quote+">Derived</a></li>"		
		txt(67) = "<li class="+quote+"list-inline-item"+quote+">Created: "+systemfunc("date")+"<br>CVDP-LE Version "+VERSION+"</li>"
  txt(68) = "<li class="+quote+"list-inline-item"+quote+"><a href="+quote+"index.html"+quote+">Ensemble Summary</a> | <b>Individual Members</b></li>"
		txt(69) = "</ul></td>"
		txt(83) = "</tr>"
		txt(84) = "</table>"
		txt(85) = "</div>"
		txt(86) = "<div class="+quote+"col align-self-center"+quote+">"
		txt(87) = "<h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2>"
		txt(88) = "</div>"
	 txt(89) = "</div>"

  txt(100) = "<div class="+quote+"row"+quote+">"
  txt(101) = "<div class="+quote+"col"+quote+">"
  txt(102) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(103) = "<h3 class="+quote+"display-6"+quote+">Climatological Averages</h3>"
  txt(104) = "<tr class="+quote+"d-flex"+quote+">"
  txt(105) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"

  txt(110) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_djf.indmem.png")) then
     txt(111) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_djf"+quote+">DJF</a>" 
     txt(112) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_djf"+quote+">"
     txt(113) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(114) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_djf.indmem.png","Indiv")+"</li>"
     txt(115) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_djf.indmemdiff.png","Bias")+"</li>"
     txt(117) = "</ul></div></td>"
  else
     txt(117) = "DJF</td>"
  end if

  txt(120) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_jfm.indmem.png")) then
     txt(121) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_jfm"+quote+">JFM</a>" 
     txt(122) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_jfm"+quote+">"
     txt(123) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(124) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_jfm.indmem.png","Indiv")+"</li>"
     txt(125) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_jfm.indmemdiff.png","Bias")+"</li>"
     txt(127) = "</ul></div></td>"
  else
     txt(127) = "JFM</td>"
  end if

  txt(130) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_mam.indmem.png")) then
     txt(131) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_mam"+quote+">MAM</a>" 
     txt(132) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_mam"+quote+">"
     txt(133) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(134) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_mam.indmem.png","Indiv")+"</li>"
     txt(135) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_mam.indmemdiff.png","Bias")+"</li>"
     txt(137) = "</ul></div></td>"
  else
     txt(137) = "MAM</td>"
  end if

  txt(140) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_jja.indmem.png")) then
     txt(141) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_jja"+quote+">JJA</a>" 
     txt(142) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_jja"+quote+">"
     txt(143) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(144) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_jja.indmem.png","Indiv")+"</li>"
     txt(145) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_jja.indmemdiff.png","Bias")+"</li>"
     txt(147) = "</ul></div></td>"
  else
     txt(147) = "JJA</td>"
  end if

  txt(150) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_jas.indmem.png")) then
     txt(151) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_jas"+quote+">JAS</a>" 
     txt(152) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_jas"+quote+">"
     txt(153) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(154) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_jas.indmem.png","Indiv")+"</li>"
     txt(155) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_jas.indmemdiff.png","Bias")+"</li>"
     txt(157) = "</ul></div></td>"
  else
     txt(157) = "JAS</td>"
  end if

  txt(160) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_son.indmem.png")) then
     txt(161) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_son"+quote+">SON</a>" 
     txt(162) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_son"+quote+">"
     txt(163) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(164) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_son.indmem.png","Indiv")+"</li>"
     txt(165) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_son.indmemdiff.png","Bias")+"</li>"
     txt(167) = "</ul></div></td>"
  else
     txt(167) = "SON</td>"
  end if

  txt(170) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialmean_ann.indmem.png")) then
     txt(171) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_mean_ann"+quote+">ANN</a>" 
     txt(172) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_mean_ann"+quote+">"
     txt(173) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(174) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_ann.indmem.png","Indiv")+"</li>"
     txt(175) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialmean_ann.indmemdiff.png","Bias")+"</li>"
     txt(177) = "</ul></div></td>"
  else
     txt(177) = "ANN</td>"
  end if
  txt(178) = "</tr>"

  txt(204) = "<tr class="+quote+"d-flex"+quote+">"
  txt(205) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"

  txt(210) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_djf.indmem.png")) then
     txt(211) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_djf"+quote+">DJF</a>" 
     txt(212) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_djf"+quote+">"
     txt(213) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(214) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_djf.indmem.png","Indiv")+"</li>"
     txt(215) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_djf.indmemdiff.png","Bias")+"</li>"
     txt(217) = "</ul></div></td>"
  else
     txt(217) = "DJF</td>"
  end if

  txt(220) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_jfm.indmem.png")) then
     txt(221) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_jfm"+quote+">JFM</a>" 
     txt(222) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_jfm"+quote+">"
     txt(223) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(224) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_jfm.indmem.png","Indiv")+"</li>"
     txt(225) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_jfm.indmemdiff.png","Bias")+"</li>"
     txt(227) = "</ul></div></td>"
  else
     txt(227) = "JFM</td>"
  end if

  txt(230) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_mam.indmem.png")) then
     txt(231) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_mam"+quote+">MAM</a>" 
     txt(232) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_mam"+quote+">"
     txt(233) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(234) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_mam.indmem.png","Indiv")+"</li>"
     txt(235) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_mam.indmemdiff.png","Bias")+"</li>"
     txt(237) = "</ul></div></td>"
  else
     txt(237) = "MAM</td>"
  end if

  txt(240) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_jja.indmem.png")) then
     txt(241) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_jja"+quote+">JJA</a>" 
     txt(242) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_jja"+quote+">"
     txt(243) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(244) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_jja.indmem.png","Indiv")+"</li>"
     txt(245) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_jja.indmemdiff.png","Bias")+"</li>"
     txt(247) = "</ul></div></td>"
  else
     txt(247) = "JJA</td>"
  end if

  txt(250) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_jas.indmem.png")) then
     txt(251) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_jas"+quote+">JAS</a>" 
     txt(252) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_jas"+quote+">"
     txt(253) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(254) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_jas.indmem.png","Indiv")+"</li>"
     txt(255) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_jas.indmemdiff.png","Bias")+"</li>"
     txt(257) = "</ul></div></td>"
  else
     txt(257) = "JAS</td>"
  end if

  txt(260) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_son.indmem.png")) then
     txt(261) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_son"+quote+">SON</a>" 
     txt(262) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_son"+quote+">"
     txt(263) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(264) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_son.indmem.png","Indiv")+"</li>"
     txt(265) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_son.indmemdiff.png","Bias")+"</li>"
     txt(267) = "</ul></div></td>"
  else
     txt(267) = "SON</td>"
  end if

  txt(270) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialmean_ann.indmem.png")) then
     txt(271) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_mean_ann"+quote+">ANN</a>" 
     txt(272) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_mean_ann"+quote+">"
     txt(273) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(274) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_ann.indmem.png","Indiv")+"</li>"
     txt(275) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialmean_ann.indmemdiff.png","Bias")+"</li>"
     txt(277) = "</ul></div></td>"
  else
     txt(277) = "ANN</td>"
  end if
  txt(278) = "</tr>"

  txt(304) = "<tr class="+quote+"d-flex"+quote+">"
  txt(305) = "<td class="+quote+"col"+quote+"><b>PSL</b></td>"

  txt(310) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_djf.indmem.png")) then
     txt(311) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_djf"+quote+">DJF</a>" 
     txt(312) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_djf"+quote+">"
     txt(313) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(314) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_djf.indmem.png","Indiv")+"</li>"
     txt(315) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_djf.indmemdiff.png","Bias")+"</li>"
     txt(317) = "</ul></div></td>"
  else
     txt(317) = "DJF</td>"
  end if

  txt(320) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_jfm.indmem.png")) then
     txt(321) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_jfm"+quote+">JFM</a>" 
     txt(322) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_jfm"+quote+">"
     txt(323) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(324) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_jfm.indmem.png","Indiv")+"</li>"
     txt(325) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_jfm.indmemdiff.png","Bias")+"</li>"
     txt(327) = "</ul></div></td>"
  else
     txt(327) = "JFM</td>"
  end if

  txt(330) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_mam.indmem.png")) then
     txt(331) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_mam"+quote+">MAM</a>" 
     txt(332) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_mam"+quote+">"
     txt(333) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(334) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_mam.indmem.png","Indiv")+"</li>"
     txt(335) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_mam.indmemdiff.png","Bias")+"</li>"
     txt(337) = "</ul></div></td>"
  else
     txt(337) = "MAM</td>"
  end if

  txt(340) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_jja.indmem.png")) then
     txt(341) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_jja"+quote+">JJA</a>" 
     txt(342) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_jja"+quote+">"
     txt(343) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(344) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_jja.indmem.png","Indiv")+"</li>"
     txt(345) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_jja.indmemdiff.png","Bias")+"</li>"
     txt(347) = "</ul></div></td>"
  else
     txt(347) = "JJA</td>"
  end if

  txt(350) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_jas.indmem.png")) then
     txt(351) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_jas"+quote+">JAS</a>" 
     txt(352) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_jas"+quote+">"
     txt(353) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(354) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_jas.indmem.png","Indiv")+"</li>"
     txt(355) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_jas.indmemdiff.png","Bias")+"</li>"
     txt(357) = "</ul></div></td>"
  else
     txt(357) = "JAS</td>"
  end if

  txt(360) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_son.indmem.png")) then
     txt(361) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_son"+quote+">SON</a>" 
     txt(362) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_son"+quote+">"
     txt(363) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(364) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_son.indmem.png","Indiv")+"</li>"
     txt(365) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_son.indmemdiff.png","Bias")+"</li>"
     txt(367) = "</ul></div></td>"
  else
     txt(367) = "SON</td>"
  end if

  txt(370) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialmean_ann.indmem.png")) then
     txt(371) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_mean_ann"+quote+">ANN</a>" 
     txt(372) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_mean_ann"+quote+">"
     txt(373) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(374) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_ann.indmem.png","Indiv")+"</li>"
     txt(375) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialmean_ann.indmemdiff.png","Bias")+"</li>"
     txt(377) = "</ul></div></td>"
  else
     txt(377) = "ANN</td>"
  end if
  txt(378) = "</tr>"

  txt(404) = "<tr class="+quote+"d-flex"+quote+">"
  txt(405) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"

  txt(410) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_djf.indmem.png")) then
     txt(411) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_djf"+quote+">DJF</a>" 
     txt(412) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_djf"+quote+">"
     txt(413) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(414) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_djf.indmem.png","Indiv")+"</li>"
     txt(415) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_djf.indmemdiff.png","Bias")+"</li>"
     txt(417) = "</ul></div></td>"
  else
     txt(417) = "DJF</td>"
  end if

  txt(420) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_jfm.indmem.png")) then
     txt(421) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_jfm"+quote+">JFM</a>" 
     txt(422) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_jfm"+quote+">"
     txt(423) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(424) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_jfm.indmem.png","Indiv")+"</li>"
     txt(425) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_jfm.indmemdiff.png","Bias")+"</li>"
     txt(427) = "</ul></div></td>"
  else
     txt(427) = "JFM</td>"
  end if

  txt(430) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_mam.indmem.png")) then
     txt(431) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_mam"+quote+">MAM</a>" 
     txt(432) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_mam"+quote+">"
     txt(433) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(434) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_mam.indmem.png","Indiv")+"</li>"
     txt(435) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_mam.indmemdiff.png","Bias")+"</li>"
     txt(437) = "</ul></div></td>"
  else
     txt(437) = "MAM</td>"
  end if

  txt(440) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_jja.indmem.png")) then
     txt(441) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_jja"+quote+">JJA</a>" 
     txt(442) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_jja"+quote+">"
     txt(443) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(444) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_jja.indmem.png","Indiv")+"</li>"
     txt(445) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_jja.indmemdiff.png","Bias")+"</li>"
     txt(447) = "</ul></div></td>"
  else
     txt(447) = "JJA</td>"
  end if

  txt(450) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_jas.indmem.png")) then
     txt(451) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_jas"+quote+">JAS</a>" 
     txt(452) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_jas"+quote+">"
     txt(453) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(454) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_jas.indmem.png","Indiv")+"</li>"
     txt(455) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_jas.indmemdiff.png","Bias")+"</li>"
     txt(457) = "</ul></div></td>"
  else
     txt(457) = "JAS</td>"
  end if
  txt(460) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_son.indmem.png")) then
     txt(461) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_son"+quote+">SON</a>" 
     txt(462) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_son"+quote+">"
     txt(463) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(464) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_son.indmem.png","Indiv")+"</li>"
     txt(465) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_son.indmemdiff.png","Bias")+"</li>"
     txt(467) = "</ul></div></td>"
  else
     txt(467) = "SON</td>"
  end if

  txt(470) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialmean_ann.indmem.png")) then
     txt(471) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_mean_ann"+quote+">ANN</a>" 
     txt(472) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_mean_ann"+quote+">"
     txt(473) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(474) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_ann.indmem.png","Indiv")+"</li>"
     txt(475) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialmean_ann.indmemdiff.png","Bias")+"</li>"
     txt(477) = "</ul></div></td>"
  else
     txt(477) = "ANN</td>"
  end if
  txt(478) = "</tr>"


  txt(507) = "<tr class="+quote+"d-flex"+quote+">"
  txt(508) = "<td class="+quote+"col"+quote+"><b>SIC NH</b></td>"

  txt(510) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_djf.indmem.png")) then
     txt(511) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_djf"+quote+">DJF</a>" 
     txt(512) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_djf"+quote+">"
     txt(513) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(514) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_djf.indmem.png","Indiv")+"</li>"
     txt(515) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_djf.indmemdiff.png","Bias")+"</li>"
     txt(517) = "</ul></div></td>"
  else
     txt(517) = "DJF</td>"
  end if

  txt(520) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_jfm.indmem.png")) then
     txt(521) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_jfm"+quote+">JFM</a>" 
     txt(522) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_jfm"+quote+">"
     txt(523) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(524) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_jfm.indmem.png","Indiv")+"</li>"
     txt(525) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_jfm.indmemdiff.png","Bias")+"</li>"
     txt(527) = "</ul></div></td>"
  else
     txt(527) = "JFM</td>"
  end if

  txt(530) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_mam.indmem.png")) then
     txt(531) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_mam"+quote+">MAM</a>" 
     txt(532) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_mam"+quote+">"
     txt(533) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(534) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_mam.indmem.png","Indiv")+"</li>"
     txt(535) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_mam.indmemdiff.png","Bias")+"</li>"
     txt(537) = "</ul></div></td>"
  else
     txt(537) = "MAM</td>"
  end if

  txt(540) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_jja.indmem.png")) then
     txt(541) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_jja"+quote+">JJA</a>" 
     txt(542) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_jja"+quote+">"
     txt(543) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(544) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_jja.indmem.png","Indiv")+"</li>"
     txt(545) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_jja.indmemdiff.png","Bias")+"</li>"
     txt(547) = "</ul></div></td>"
  else
     txt(547) = "JJA</td>"
  end if

  txt(550) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_jas.indmem.png")) then
     txt(551) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_jas"+quote+">JAS</a>" 
     txt(552) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_jas"+quote+">"
     txt(553) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(554) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_jas.indmem.png","Indiv")+"</li>"
     txt(555) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_jas.indmemdiff.png","Bias")+"</li>"
     txt(557) = "</ul></div></td>"
  else
     txt(557) = "JAS</td>"
  end if

  txt(560) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_son.indmem.png")) then
     txt(561) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_son"+quote+">SON</a>" 
     txt(562) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_son"+quote+">"
     txt(563) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(564) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_son.indmem.png","Indiv")+"</li>"
     txt(565) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_son.indmemdiff.png","Bias")+"</li>"
     txt(567) = "</ul></div></td>"
  else
     txt(567) = "SON</td>"
  end if

  txt(570) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialmean_ann.indmem.png")) then
     txt(571) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_mean_ann"+quote+">ANN</a>" 
     txt(572) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_mean_ann"+quote+">"
     txt(573) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(574) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_ann.indmem.png","Indiv")+"</li>"
     txt(575) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialmean_ann.indmemdiff.png","Bias")+"</li>"
     txt(577) = "</ul></div></td>"
  else
     txt(577) = "ANN</td>"
  end if
  txt(578) = "</tr>"

  txt(604) = "<tr class="+quote+"d-flex"+quote+">"
  txt(605) = "<td class="+quote+"col"+quote+"><b>SIC SH</b></td>"

  txt(610) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_djf.indmem.png")) then
     txt(611) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_djf"+quote+">DJF</a>" 
     txt(612) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_djf"+quote+">"
     txt(613) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(614) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_djf.indmem.png","Indiv")+"</li>"
     txt(615) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_djf.indmemdiff.png","Bias")+"</li>"
     txt(617) = "</ul></div></td>"
  else
     txt(617) = "DJF</td>"
  end if

  txt(620) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_jfm.indmem.png")) then
     txt(621) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_jfm"+quote+">JFM</a>" 
     txt(622) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_jfm"+quote+">"
     txt(623) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(624) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_jfm.indmem.png","Indiv")+"</li>"
     txt(625) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_jfm.indmemdiff.png","Bias")+"</li>"
     txt(627) = "</ul></div></td>"
  else
     txt(627) = "JFM</td>"
  end if

  txt(630) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_mam.indmem.png")) then
     txt(631) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_mam"+quote+">MAM</a>" 
     txt(632) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_mam"+quote+">"
     txt(633) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(634) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_mam.indmem.png","Indiv")+"</li>"
     txt(635) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_mam.indmemdiff.png","Bias")+"</li>"
     txt(637) = "</ul></div></td>"
  else
     txt(637) = "MAM</td>"
  end if

  txt(640) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_jja.indmem.png")) then
     txt(641) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_jja"+quote+">JJA</a>" 
     txt(642) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_jja"+quote+">"
     txt(643) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(644) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_jja.indmem.png","Indiv")+"</li>"
     txt(645) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_jja.indmemdiff.png","Bias")+"</li>"
     txt(647) = "</ul></div></td>"
  else
     txt(647) = "JJA</td>"
  end if

  txt(650) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_jas.indmem.png")) then
     txt(651) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_jas"+quote+">JAS</a>" 
     txt(652) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_jas"+quote+">"
     txt(653) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(654) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_jas.indmem.png","Indiv")+"</li>"
     txt(655) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_jas.indmemdiff.png","Bias")+"</li>"
     txt(657) = "</ul></div></td>"
  else
     txt(657) = "JAS</td>"
  end if

  txt(660) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_son.indmem.png")) then
     txt(661) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_son"+quote+">SON</a>" 
     txt(662) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_son"+quote+">"
     txt(663) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(664) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_son.indmem.png","Indiv")+"</li>"
     txt(665) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_son.indmemdiff.png","Bias")+"</li>"
     txt(667) = "</ul></div></td>"
  else
     txt(667) = "SON</td>"
  end if

  txt(670) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialmean_ann.indmem.png")) then
     txt(671) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_mean_ann"+quote+">ANN</a>" 
     txt(672) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_mean_ann"+quote+">"
     txt(673) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(674) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_ann.indmem.png","Indiv")+"</li>"
     txt(675) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialmean_ann.indmemdiff.png","Bias")+"</li>"
     txt(677) = "</ul></div></td>"
  else
     txt(677) = "ANN</td>"
  end if
  txt(678) = "</tr>"
  txt(680) = "</table></div></div>"

  txt(1100) = "<div class="+quote+"row"+quote+">"
  txt(1101) = "<div class="+quote+"col"+quote+">"
  txt(1102) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(1103) = "<h3 class="+quote+"display-6"+quote+">Standard Deviations</h3>"
  txt(1104) = "<tr class="+quote+"d-flex"+quote+">"
  txt(1105) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"

  txt(1110) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_djf.indmem.png")) then
     txt(1111) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_djf"+quote+">DJF</a>" 
     txt(1112) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_djf"+quote+">"
     txt(1113) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1114) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_djf.indmem.png","Indiv")+"</li>"
     txt(1115) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_djf.indmemdiff.png","Bias")+"</li>"
     txt(1117) = "</ul></div></td>"
  else
     txt(1117) = "DJF</td>"
  end if

  txt(1120) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_jfm.indmem.png")) then
     txt(1121) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_jfm"+quote+">JFM</a>" 
     txt(1122) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_jfm"+quote+">"
     txt(1123) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1124) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_jfm.indmem.png","Indiv")+"</li>"
     txt(1125) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_jfm.indmemdiff.png","Bias")+"</li>"
     txt(1127) = "</ul></div></td>"
  else
     txt(1127) = "JFM</td>"
  end if

  txt(1130) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_mam.indmem.png")) then
     txt(1131) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_mam"+quote+">MAM</a>" 
     txt(1132) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_mam"+quote+">"
     txt(1133) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1134) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_mam.indmem.png","Indiv")+"</li>"
     txt(1135) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_mam.indmemdiff.png","Bias")+"</li>"
     txt(1137) = "</ul></div></td>"
  else
     txt(1137) = "MAM</td>"
  end if

  txt(1140) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_jja.indmem.png")) then
     txt(1141) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_jja"+quote+">JJA</a>" 
     txt(1142) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_jja"+quote+">"
     txt(1143) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1144) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_jja.indmem.png","Indiv")+"</li>"
     txt(1145) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_jja.indmemdiff.png","Bias")+"</li>"
     txt(1147) = "</ul></div></td>"
  else
     txt(1147) = "JJA</td>"
  end if

  txt(1150) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_jas.indmem.png")) then
     txt(1151) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_jas"+quote+">JAS</a>" 
     txt(1152) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_jas"+quote+">"
     txt(1153) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1154) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_jas.indmem.png","Indiv")+"</li>"
     txt(1155) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_jas.indmemdiff.png","Bias")+"</li>"
     txt(1157) = "</ul></div></td>"
  else
     txt(1157) = "JAS</td>"
  end if

  txt(1160) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_son.indmem.png")) then
     txt(1161) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_son"+quote+">SON</a>" 
     txt(1162) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_son"+quote+">"
     txt(1163) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1164) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_son.indmem.png","Indiv")+"</li>"
     txt(1165) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_son.indmemdiff.png","Bias")+"</li>"
     txt(1167) = "</ul></div></td>"
  else
     txt(1167) = "SON</td>"
  end if

  txt(1170) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_spatialstddev_ann.indmem.png")) then
     txt(1171) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_stddev_ann"+quote+">ANN</a>" 
     txt(1172) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_stddev_ann"+quote+">"
     txt(1173) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1174) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_ann.indmem.png","Indiv")+"</li>"
     txt(1175) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_spatialstddev_ann.indmemdiff.png","Bias")+"</li>"
     txt(1177) = "</ul></div></td>"
  else
     txt(1177) = "ANN</td>"
  end if
  txt(1178) = "</tr>"


  txt(1204) = "<tr class="+quote+"d-flex"+quote+">"
  txt(1205) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"

  txt(1210) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_djf.indmem.png")) then
     txt(1211) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_djf"+quote+">DJF</a>" 
     txt(1212) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_djf"+quote+">"
     txt(1213) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1214) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_djf.indmem.png","Indiv")+"</li>"
     txt(1215) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_djf.indmemdiff.png","Bias")+"</li>"
     txt(1217) = "</ul></div></td>"
  else
     txt(1217) = "DJF</td>"
  end if

  txt(1220) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_jfm.indmem.png")) then
     txt(1221) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_jfm"+quote+">JFM</a>" 
     txt(1222) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_jfm"+quote+">"
     txt(1223) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1224) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_jfm.indmem.png","Indiv")+"</li>"
     txt(1225) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_jfm.indmemdiff.png","Bias")+"</li>"
     txt(1227) = "</ul></div></td>"
  else
     txt(1227) = "JFM</td>"
  end if

  txt(1230) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_mam.indmem.png")) then
     txt(1231) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_mam"+quote+">MAM</a>" 
     txt(1232) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_mam"+quote+">"
     txt(1233) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1234) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_mam.indmem.png","Indiv")+"</li>"
     txt(1235) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_mam.indmemdiff.png","Bias")+"</li>"
     txt(1237) = "</ul></div></td>"
  else
     txt(1237) = "MAM</td>"
  end if

  txt(1240) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_jja.indmem.png")) then
     txt(1241) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_jja"+quote+">JJA</a>" 
     txt(1242) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_jja"+quote+">"
     txt(1243) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1244) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_jja.indmem.png","Indiv")+"</li>"
     txt(1245) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_jja.indmemdiff.png","Bias")+"</li>"
     txt(1247) = "</ul></div></td>"
  else
     txt(1247) = "JJA</td>"
  end if

  txt(1250) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_jas.indmem.png")) then
     txt(1251) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_jas"+quote+">JAS</a>" 
     txt(1252) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_jas"+quote+">"
     txt(1253) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1254) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_jas.indmem.png","Indiv")+"</li>"
     txt(1255) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_jas.indmemdiff.png","Bias")+"</li>"
     txt(1257) = "</ul></div></td>"
  else
     txt(1257) = "JAS</td>"
  end if

  txt(1260) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_son.indmem.png")) then
     txt(1261) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_son"+quote+">SON</a>" 
     txt(1262) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_son"+quote+">"
     txt(1263) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1264) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_son.indmem.png","Indiv")+"</li>"
     txt(1265) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_son.indmemdiff.png","Bias")+"</li>"
     txt(1267) = "</ul></div></td>"
  else
     txt(1267) = "SON</td>"
  end if

  txt(1270) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_spatialstddev_ann.indmem.png")) then
     txt(1271) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_stddev_ann"+quote+">ANN</a>" 
     txt(1272) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_stddev_ann"+quote+">"
     txt(1273) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1274) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_ann.indmem.png","Indiv")+"</li>"
     txt(1275) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_spatialstddev_ann.indmemdiff.png","Bias")+"</li>"
     txt(1277) = "</ul></div></td>"
  else
     txt(1277) = "ANN</td>"
  end if
  txt(1278) = "</tr>"

  txt(1304) = "<tr class="+quote+"d-flex"+quote+">"
  txt(1305) = "<td class="+quote+"col"+quote+"><b>PSL</b></td>"

  txt(1310) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_djf.indmem.png")) then
     txt(1311) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_djf"+quote+">DJF</a>" 
     txt(1312) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_djf"+quote+">"
     txt(1313) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1314) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_djf.indmem.png","Indiv")+"</li>"
     txt(1315) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_djf.indmemdiff.png","Bias")+"</li>"
     txt(1317) = "</ul></div></td>"
  else
     txt(1317) = "DJF</td>"
  end if

  txt(1320) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_jfm.indmem.png")) then
     txt(1321) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_jfm"+quote+">JFM</a>" 
     txt(1322) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_jfm"+quote+">"
     txt(1323) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1324) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_jfm.indmem.png","Indiv")+"</li>"
     txt(1325) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_jfm.indmemdiff.png","Bias")+"</li>"
     txt(1327) = "</ul></div></td>"
  else
     txt(1327) = "JFM</td>"
  end if

  txt(1330) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_mam.indmem.png")) then
     txt(1331) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_mam"+quote+">MAM</a>" 
     txt(1332) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_mam"+quote+">"
     txt(1333) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1334) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_mam.indmem.png","Indiv")+"</li>"
     txt(1335) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_mam.indmemdiff.png","Bias")+"</li>"
     txt(1337) = "</ul></div></td>"
  else
     txt(1337) = "MAM</td>"
  end if

  txt(1340) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_jja.indmem.png")) then
     txt(1341) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_jja"+quote+">JJA</a>" 
     txt(1342) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_jja"+quote+">"
     txt(1343) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1344) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_jja.indmem.png","Indiv")+"</li>"
     txt(1345) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_jja.indmemdiff.png","Bias")+"</li>"
     txt(1347) = "</ul></div></td>"
  else
     txt(1347) = "JJA</td>"
  end if

  txt(1350) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_jas.indmem.png")) then
     txt(1351) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_jas"+quote+">JAS</a>" 
     txt(1352) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_jas"+quote+">"
     txt(1353) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1354) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_jas.indmem.png","Indiv")+"</li>"
     txt(1355) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_jas.indmemdiff.png","Bias")+"</li>"
     txt(1357) = "</ul></div></td>"
  else
     txt(1357) = "JAS</td>"
  end if

  txt(1360) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_son.indmem.png")) then
     txt(1361) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_son"+quote+">SON</a>" 
     txt(1362) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_son"+quote+">"
     txt(1363) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1364) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_son.indmem.png","Indiv")+"</li>"
     txt(1365) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_son.indmemdiff.png","Bias")+"</li>"
     txt(1367) = "</ul></div></td>"
  else
     txt(1367) = "SON</td>"
  end if

  txt(1370) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_spatialstddev_ann.indmem.png")) then
     txt(1371) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_stddev_ann"+quote+">ANN</a>" 
     txt(1372) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_stddev_ann"+quote+">"
     txt(1373) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1374) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_ann.indmem.png","Indiv")+"</li>"
     txt(1375) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_spatialstddev_ann.indmemdiff.png","Bias")+"</li>"
     txt(1377) = "</ul></div></td>"
  else
     txt(1377) = "ANN</td>"
  end if
  txt(1378) = "</tr>"

  txt(1404) = "<tr class="+quote+"d-flex"+quote+">"
  txt(1405) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"

  txt(1410) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_djf.indmem.png")) then
     txt(1411) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_djf"+quote+">DJF</a>" 
     txt(1412) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_djf"+quote+">"
     txt(1413) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1414) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_djf.indmem.png","Indiv")+"</li>"
     txt(1415) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_djf.indmemdiff.png","Bias")+"</li>"
     txt(1417) = "</ul></div></td>"
  else
     txt(1417) = "DJF</td>"
  end if

  txt(1420) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_jfm.indmem.png")) then
     txt(1421) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_jfm"+quote+">JFM</a>" 
     txt(1422) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_jfm"+quote+">"
     txt(1423) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1424) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_jfm.indmem.png","Indiv")+"</li>"
     txt(1425) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_jfm.indmemdiff.png","Bias")+"</li>"
     txt(1427) = "</ul></div></td>"
  else
     txt(1427) = "JFM</td>"
  end if

  txt(1430) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_mam.indmem.png")) then
     txt(1431) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_mam"+quote+">MAM</a>" 
     txt(1432) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_mam"+quote+">"
     txt(1433) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1434) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_mam.indmem.png","Indiv")+"</li>"
     txt(1435) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_mam.indmemdiff.png","Bias")+"</li>"
     txt(1437) = "</ul></div></td>"
  else
     txt(1437) = "MAM</td>"
  end if

  txt(1440) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_jja.indmem.png")) then
     txt(1441) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_jja"+quote+">JJA</a>" 
     txt(1442) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_jja"+quote+">"
     txt(1443) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1444) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_jja.indmem.png","Indiv")+"</li>"
     txt(1445) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_jja.indmemdiff.png","Bias")+"</li>"
     txt(1447) = "</ul></div></td>"
  else
     txt(1447) = "JJA</td>"
  end if

  txt(1450) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_jas.indmem.png")) then
     txt(1451) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_jas"+quote+">JAS</a>" 
     txt(1452) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_jas"+quote+">"
     txt(1453) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1454) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_jas.indmem.png","Indiv")+"</li>"
     txt(1455) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_jas.indmemdiff.png","Bias")+"</li>"
     txt(1457) = "</ul></div></td>"
  else
     txt(1457) = "JAS</td>"
  end if

  txt(1460) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_son.indmem.png")) then
     txt(1461) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_son"+quote+">SON</a>" 
     txt(1462) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_son"+quote+">"
     txt(1463) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1464) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_son.indmem.png","Indiv")+"</li>"
     txt(1465) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_son.indmemdiff.png","Bias")+"</li>"
     txt(1467) = "</ul></div></td>"
  else
     txt(1467) = "SON</td>"
  end if

  txt(1470) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_spatialstddev_ann.indmem.png")) then
     txt(1471) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_stddev_ann"+quote+">ANN</a>" 
     txt(1472) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_stddev_ann"+quote+">"
     txt(1473) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1474) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_ann.indmem.png","Indiv")+"</li>"
     txt(1475) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_spatialstddev_ann.indmemdiff.png","Bias")+"</li>"
     txt(1477) = "</ul></div></td>"
  else
     txt(1477) = "ANN</td>"
  end if
  txt(1478) = "</tr>"

  txt(1508) = "<tr class="+quote+"d-flex"+quote+">"
  txt(1509) = "<td class="+quote+"col"+quote+"><b>SIC NH</b></td>"

  txt(1510) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_djf.indmem.png")) then
     txt(1511) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_djf"+quote+">DJF</a>" 
     txt(1512) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_djf"+quote+">"
     txt(1513) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1514) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_djf.indmem.png","Indiv")+"</li>"
     txt(1515) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_djf.indmemdiff.png","Bias")+"</li>"
     txt(1517) = "</ul></div></td>"
  else
     txt(1517) = "DJF</td>"
  end if

  txt(1520) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_jfm.indmem.png")) then
     txt(1521) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_jfm"+quote+">JFM</a>" 
     txt(1522) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_jfm"+quote+">"
     txt(1523) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1524) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_jfm.indmem.png","Indiv")+"</li>"
     txt(1525) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_jfm.indmemdiff.png","Bias")+"</li>"
     txt(1527) = "</ul></div></td>"
  else
     txt(1527) = "JFM</td>"
  end if

  txt(1530) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_mam.indmem.png")) then
     txt(1531) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_mam"+quote+">MAM</a>" 
     txt(1532) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_mam"+quote+">"
     txt(1533) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1534) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_mam.indmem.png","Indiv")+"</li>"
     txt(1535) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_mam.indmemdiff.png","Bias")+"</li>"
     txt(1537) = "</ul></div></td>"
  else
     txt(1537) = "MAM</td>"
  end if

  txt(1540) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_jja.indmem.png")) then
     txt(1541) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_jja"+quote+">JJA</a>" 
     txt(1542) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_jja"+quote+">"
     txt(1543) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1544) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_jja.indmem.png","Indiv")+"</li>"
     txt(1545) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_jja.indmemdiff.png","Bias")+"</li>"
     txt(1547) = "</ul></div></td>"
  else
     txt(1547) = "JJA</td>"
  end if

  txt(1550) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_jas.indmem.png")) then
     txt(1551) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_jas"+quote+">JAS</a>" 
     txt(1552) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_jas"+quote+">"
     txt(1553) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1554) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_jas.indmem.png","Indiv")+"</li>"
     txt(1555) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_jas.indmemdiff.png","Bias")+"</li>"
     txt(1557) = "</ul></div></td>"
  else
     txt(1557) = "JAS</td>"
  end if

  txt(1560) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_son.indmem.png")) then
     txt(1561) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_son"+quote+">SON</a>" 
     txt(1562) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_son"+quote+">"
     txt(1563) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1564) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_son.indmem.png","Indiv")+"</li>"
     txt(1565) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_son.indmemdiff.png","Bias")+"</li>"
     txt(1567) = "</ul></div></td>"
  else
     txt(1567) = "SON</td>"
  end if

  txt(1570) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_spatialstddev_ann.indmem.png")) then
     txt(1571) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_stddev_ann"+quote+">ANN</a>" 
     txt(1572) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_stddev_ann"+quote+">"
     txt(1573) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1574) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_ann.indmem.png","Indiv")+"</li>"
     txt(1575) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_spatialstddev_ann.indmemdiff.png","Bias")+"</li>"
     txt(1577) = "</ul></div></td>"
  else
     txt(1577) = "ANN</td>"
  end if
  txt(1578) = "</tr>"

  txt(1604) = "<tr class="+quote+"d-flex"+quote+">"
  txt(1605) = "<td class="+quote+"col"+quote+"><b>SIC SH</b></td>"

  txt(1610) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_djf.indmem.png")) then
     txt(1611) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_djf"+quote+">DJF</a>" 
     txt(1612) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_djf"+quote+">"
     txt(1613) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1614) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_djf.indmem.png","Indiv")+"</li>"
     txt(1615) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_djf.indmemdiff.png","Bias")+"</li>"
     txt(1617) = "</ul></div></td>"
  else
     txt(1617) = "DJF</td>"
  end if

  txt(1620) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_jfm.indmem.png")) then
     txt(1621) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_jfm"+quote+">JFM</a>" 
     txt(1622) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_jfm"+quote+">"
     txt(1623) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1624) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_jfm.indmem.png","Indiv")+"</li>"
     txt(1625) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_jfm.indmemdiff.png","Bias")+"</li>"
     txt(1627) = "</ul></div></td>"
  else
     txt(1627) = "JFM</td>"
  end if

  txt(1630) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_mam.indmem.png")) then
     txt(1631) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_mam"+quote+">MAM</a>" 
     txt(1632) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_mam"+quote+">"
     txt(1633) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1634) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_mam.indmem.png","Indiv")+"</li>"
     txt(1635) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_mam.indmemdiff.png","Bias")+"</li>"
     txt(1637) = "</ul></div></td>"
  else
     txt(1637) = "MAM</td>"
  end if

  txt(1640) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_jja.indmem.png")) then
     txt(1641) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_jja"+quote+">JJA</a>" 
     txt(1642) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_jja"+quote+">"
     txt(1643) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1644) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_jja.indmem.png","Indiv")+"</li>"
     txt(1645) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_jja.indmemdiff.png","Bias")+"</li>"
     txt(1647) = "</ul></div></td>"
  else
     txt(1647) = "JJA</td>"
  end if

  txt(1650) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_jas.indmem.png")) then
     txt(1651) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_jas"+quote+">JAS</a>" 
     txt(1652) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_jas"+quote+">"
     txt(1653) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1654) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_jas.indmem.png","Indiv")+"</li>"
     txt(1655) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_jas.indmemdiff.png","Bias")+"</li>"
     txt(1657) = "</ul></div></td>"
  else
     txt(1657) = "JAS</td>"
  end if

  txt(1660) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_son.indmem.png")) then
     txt(1661) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_son"+quote+">SON</a>" 
     txt(1662) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_son"+quote+">"
     txt(1663) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1664) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_son.indmem.png","Indiv")+"</li>"
     txt(1665) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_son.indmemdiff.png","Bias")+"</li>"
     txt(1667) = "</ul></div></td>"
  else
     txt(1667) = "SON</td>"
  end if

  txt(1670) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_spatialstddev_ann.indmem.png")) then
     txt(1671) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_stddev_ann"+quote+">ANN</a>" 
     txt(1672) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_stddev_ann"+quote+">"
     txt(1673) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(1674) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_ann.indmem.png","Indiv")+"</li>"
     txt(1675) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_spatialstddev_ann.indmemdiff.png","Bias")+"</li>"
     txt(1677) = "</ul></div></td>"
  else
     txt(1677) = "ANN</td>"
  end if
  txt(1678) = "</tr>"
  txt(1680) = "</table></div></div>"


  txt(2100) = "<div class="+quote+"row"+quote+">"
  txt(2101) = "<div class="+quote+"col"+quote+">"
  txt(2102) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(2103) = "<h3 class="+quote+"display-6"+quote+">Global Trend Maps</h3>"
  txt(2104) = "<tr class="+quote+"d-flex"+quote+">"
  txt(2105) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"

  txt(2110) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_djf.indmem.png")) then
     txt(2111) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_djf"+quote+">DJF</a>" 
     txt(2112) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_djf"+quote+">"
     txt(2113) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2114) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_djf.indmem.png","Indiv")+"</li>"
     txt(2115) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_djf.indmemdiff.png","Bias")+"</li>"
     txt(2117) = "</ul></div></td>"
  else
     txt(2117) = "DJF</td>"
  end if

  txt(2120) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_jfm.indmem.png")) then
     txt(2121) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_jfm"+quote+">JFM</a>" 
     txt(2122) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_jfm"+quote+">"
     txt(2123) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2124) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_jfm.indmem.png","Indiv")+"</li>"
     txt(2125) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_jfm.indmemdiff.png","Bias")+"</li>"
     txt(2127) = "</ul></div></td>"
  else
     txt(2127) = "JFM</td>"
  end if

  txt(2130) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_mam.indmem.png")) then
     txt(2131) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_mam"+quote+">MAM</a>" 
     txt(2132) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_mam"+quote+">"
     txt(2133) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2134) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_mam.indmem.png","Indiv")+"</li>"
     txt(2135) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_mam.indmemdiff.png","Bias")+"</li>"
     txt(2137) = "</ul></div></td>"
  else
     txt(2137) = "MAM</td>"
  end if

  txt(2140) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_jja.indmem.png")) then
     txt(2141) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_jja"+quote+">JJA</a>" 
     txt(2142) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_jja"+quote+">"
     txt(2143) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2144) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_jja.indmem.png","Indiv")+"</li>"
     txt(2145) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_jja.indmemdiff.png","Bias")+"</li>"
     txt(2147) = "</ul></div></td>"
  else
     txt(2147) = "JJA</td>"
  end if

  txt(2150) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_jas.indmem.png")) then
     txt(2151) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_jas"+quote+">JAS</a>" 
     txt(2152) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_jas"+quote+">"
     txt(2153) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2154) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_jas.indmem.png","Indiv")+"</li>"
     txt(2155) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_jas.indmemdiff.png","Bias")+"</li>"
     txt(2157) = "</ul></div></td>"
  else
     txt(2157) = "JAS</td>"
  end if

  txt(2160) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_son.indmem.png")) then
     txt(2161) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_son"+quote+">SON</a>" 
     txt(2162) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_son"+quote+">"
     txt(2163) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2164) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_son.indmem.png","Indiv")+"</li>"
     txt(2165) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_son.indmemdiff.png","Bias")+"</li>"
     txt(2167) = "</ul></div></td>"
  else
     txt(2167) = "SON</td>"
  end if

  txt(2170) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"sst_trends_ann.indmem.png")) then
     txt(2171) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sst_trends_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sst_trends_ann"+quote+">ANN</a>" 
     txt(2172) = "<div class="+quote+"collapse"+quote+" id="+quote+"sst_trends_ann"+quote+">"
     txt(2173) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2174) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_ann.indmem.png","Indiv")+"</li>"
     txt(2175) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sst_trends_ann.indmemdiff.png","Bias")+"</li>"
     txt(2177) = "</ul></div></td>"
  else
     txt(2177) = "ANN</td>"
  end if
  txt(2178) = "</tr>"

  txt(2204) = "<tr class="+quote+"d-flex"+quote+">"
  txt(2205) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"

  txt(2210) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_djf.indmem.png")) then
     txt(2211) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_djf"+quote+">DJF</a>" 
     txt(2212) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_djf"+quote+">"
     txt(2213) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2214) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_djf.indmem.png","Indiv")+"</li>"
     txt(2215) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_djf.indmemdiff.png","Bias")+"</li>"
     txt(2217) = "</ul></div></td>"
  else
     txt(2217) = "DJF</td>"
  end if

  txt(2220) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_jfm.indmem.png")) then
     txt(2221) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_jfm"+quote+">JFM</a>" 
     txt(2222) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_jfm"+quote+">"
     txt(2223) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2224) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_jfm.indmem.png","Indiv")+"</li>"
     txt(2225) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_jfm.indmemdiff.png","Bias")+"</li>"
     txt(2227) = "</ul></div></td>"
  else
     txt(2227) = "JFM</td>"
  end if

  txt(2230) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_mam.indmem.png")) then
     txt(2231) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_mam"+quote+">MAM</a>" 
     txt(2232) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_mam"+quote+">"
     txt(2233) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2234) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_mam.indmem.png","Indiv")+"</li>"
     txt(2235) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_mam.indmemdiff.png","Bias")+"</li>"
     txt(2237) = "</ul></div></td>"
  else
     txt(2237) = "MAM</td>"
  end if

  txt(2240) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_jja.indmem.png")) then
     txt(2241) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_jja"+quote+">JJA</a>" 
     txt(2242) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_jja"+quote+">"
     txt(2243) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2244) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_jja.indmem.png","Indiv")+"</li>"
     txt(2245) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_jja.indmemdiff.png","Bias")+"</li>"
     txt(2247) = "</ul></div></td>"
  else
     txt(2247) = "JJA</td>"
  end if

  txt(2250) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_jas.indmem.png")) then
     txt(2251) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_jas"+quote+">JAS</a>" 
     txt(2252) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_jas"+quote+">"
     txt(2253) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2254) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_jas.indmem.png","Indiv")+"</li>"
     txt(2255) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_jas.indmemdiff.png","Bias")+"</li>"
     txt(2257) = "</ul></div></td>"
  else
     txt(2257) = "JAS</td>"
  end if

  txt(2260) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_son.indmem.png")) then
     txt(2261) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_son"+quote+">SON</a>" 
     txt(2262) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_son"+quote+">"
     txt(2263) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2264) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_son.indmem.png","Indiv")+"</li>"
     txt(2265) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_son.indmemdiff.png","Bias")+"</li>"
     txt(2267) = "</ul></div></td>"
  else
     txt(2267) = "SON</td>"
  end if

  txt(2270) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"tas_trends_ann.indmem.png")) then
     txt(2271) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#tas_trends_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"tas_trends_ann"+quote+">ANN</a>" 
     txt(2272) = "<div class="+quote+"collapse"+quote+" id="+quote+"tas_trends_ann"+quote+">"
     txt(2273) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2274) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_ann.indmem.png","Indiv")+"</li>"
     txt(2275) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"tas_trends_ann.indmemdiff.png","Bias")+"</li>"
     txt(2277) = "</ul></div></td>"
  else
     txt(2277) = "ANN</td>"
  end if
  txt(2278) = "</tr>"

  txt(2304) = "<tr class="+quote+"d-flex"+quote+">"
  txt(2305) = "<td class="+quote+"col"+quote+"><b>PSL</b></td>"

  txt(2310) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_djf.indmem.png")) then
     txt(2311) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_djf"+quote+">DJF</a>" 
     txt(2312) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_djf"+quote+">"
     txt(2313) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2314) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_djf.indmem.png","Indiv")+"</li>"
     txt(2315) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_djf.indmemdiff.png","Bias")+"</li>"
     txt(2317) = "</ul></div></td>"
  else
     txt(2317) = "DJF</td>"
  end if

  txt(2320) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_jfm.indmem.png")) then
     txt(2321) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_jfm"+quote+">JFM</a>" 
     txt(2322) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_jfm"+quote+">"
     txt(2323) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2324) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_jfm.indmem.png","Indiv")+"</li>"
     txt(2325) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_jfm.indmemdiff.png","Bias")+"</li>"
     txt(2327) = "</ul></div></td>"
  else
     txt(2327) = "JFM</td>"
  end if

  txt(2330) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_mam.indmem.png")) then
     txt(2331) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_mam"+quote+">MAM</a>" 
     txt(2332) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_mam"+quote+">"
     txt(2333) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2334) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_mam.indmem.png","Indiv")+"</li>"
     txt(2335) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_mam.indmemdiff.png","Bias")+"</li>"
     txt(2337) = "</ul></div></td>"
  else
     txt(2337) = "MAM</td>"
  end if

  txt(2340) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_jja.indmem.png")) then
     txt(2341) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_jja"+quote+">JJA</a>" 
     txt(2342) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_jja"+quote+">"
     txt(2343) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2344) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_jja.indmem.png","Indiv")+"</li>"
     txt(2345) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_jja.indmemdiff.png","Bias")+"</li>"
     txt(2347) = "</ul></div></td>"
  else
     txt(2347) = "JJA</td>"
  end if

  txt(2350) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_jas.indmem.png")) then
     txt(2351) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_jas"+quote+">JAS</a>" 
     txt(2352) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_jas"+quote+">"
     txt(2353) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2354) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_jas.indmem.png","Indiv")+"</li>"
     txt(2355) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_jas.indmemdiff.png","Bias")+"</li>"
     txt(2357) = "</ul></div></td>"
  else
     txt(2357) = "JAS</td>"
  end if

  txt(2360) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_son.indmem.png")) then
     txt(2361) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_son"+quote+">SON</a>" 
     txt(2362) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_son"+quote+">"
     txt(2363) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2364) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_son.indmem.png","Indiv")+"</li>"
     txt(2365) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_son.indmemdiff.png","Bias")+"</li>"
     txt(2367) = "</ul></div></td>"
  else
     txt(2367) = "SON</td>"
  end if

  txt(2370) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"psl_trends_ann.indmem.png")) then
     txt(2371) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psl_trends_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psl_trends_ann"+quote+">ANN</a>" 
     txt(2372) = "<div class="+quote+"collapse"+quote+" id="+quote+"psl_trends_ann"+quote+">"
     txt(2373) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2374) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_ann.indmem.png","Indiv")+"</li>"
     txt(2375) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psl_trends_ann.indmemdiff.png","Bias")+"</li>"
     txt(2377) = "</ul></div></td>"
  else
     txt(2377) = "ANN</td>"
  end if
  txt(2378) = "</tr>"

  txt(2404) = "<tr class="+quote+"d-flex"+quote+">"
  txt(2405) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"

  txt(2410) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_djf.indmem.png")) then
     txt(2411) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_djf"+quote+">DJF</a>" 
     txt(2412) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_djf"+quote+">"
     txt(2413) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2414) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_djf.indmem.png","Indiv")+"</li>"
     txt(2415) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_djf.indmemdiff.png","Bias")+"</li>"
     txt(2417) = "</ul></div></td>"
  else
     txt(2417) = "DJF</td>"
  end if

  txt(2420) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_jfm.indmem.png")) then
     txt(2421) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_jfm"+quote+">JFM</a>" 
     txt(2422) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_jfm"+quote+">"
     txt(2423) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2424) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_jfm.indmem.png","Indiv")+"</li>"
     txt(2425) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_jfm.indmemdiff.png","Bias")+"</li>"
     txt(2427) = "</ul></div></td>"
  else
     txt(2427) = "JFM</td>"
  end if

  txt(2430) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_mam.indmem.png")) then
     txt(2431) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_mam"+quote+">MAM</a>" 
     txt(2432) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_mam"+quote+">"
     txt(2433) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2434) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_mam.indmem.png","Indiv")+"</li>"
     txt(2435) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_mam.indmemdiff.png","Bias")+"</li>"
     txt(2437) = "</ul></div></td>"
  else
     txt(2437) = "MAM</td>"
  end if

  txt(2440) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_jja.indmem.png")) then
     txt(2441) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_jja"+quote+">JJA</a>" 
     txt(2442) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_jja"+quote+">"
     txt(2443) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2444) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_jja.indmem.png","Indiv")+"</li>"
     txt(2445) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_jja.indmemdiff.png","Bias")+"</li>"
     txt(2447) = "</ul></div></td>"
  else
     txt(2447) = "JJA</td>"
  end if

  txt(2450) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_jas.indmem.png")) then
     txt(2451) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_jas"+quote+">JAS</a>" 
     txt(2452) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_jas"+quote+">"
     txt(2453) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2454) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_jas.indmem.png","Indiv")+"</li>"
     txt(2455) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_jas.indmemdiff.png","Bias")+"</li>"
     txt(2457) = "</ul></div></td>"
  else
     txt(2457) = "JAS</td>"
  end if



  txt(2460) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_son.indmem.png")) then
     txt(2461) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_son"+quote+">SON</a>" 
     txt(2462) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_son"+quote+">"
     txt(2463) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2464) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_son.indmem.png","Indiv")+"</li>"
     txt(2465) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_son.indmemdiff.png","Bias")+"</li>"
     txt(2467) = "</ul></div></td>"
  else
     txt(2467) = "SON</td>"
  end if

  txt(2470) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"pr_trends_ann.indmem.png")) then
     txt(2471) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pr_trends_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pr_trends_ann"+quote+">ANN</a>" 
     txt(2472) = "<div class="+quote+"collapse"+quote+" id="+quote+"pr_trends_ann"+quote+">"
     txt(2473) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2474) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_ann.indmem.png","Indiv")+"</li>"
     txt(2475) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pr_trends_ann.indmemdiff.png","Bias")+"</li>"
     txt(2477) = "</ul></div></td>"
  else
     txt(2477) = "ANN</td>"
  end if
  txt(2478) = "</tr>"


  txt(2607) = "<tr class="+quote+"d-flex"+quote+">"
  txt(2608) = "<td class="+quote+"col"+quote+"><b>SIC NH</b></td>"

  txt(2610) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_djf.indmem.png")) then
     txt(2611) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_djf"+quote+">DJF</a>" 
     txt(2612) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_djf"+quote+">"
     txt(2613) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2614) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_djf.indmem.png","Indiv")+"</li>"
     txt(2615) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_djf.indmemdiff.png","Bias")+"</li>"
     txt(2617) = "</ul></div></td>"
  else
     txt(2617) = "DJF</td>"
  end if

  txt(2620) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_jfm.indmem.png")) then
     txt(2621) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_jfm"+quote+">JFM</a>" 
     txt(2622) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_jfm"+quote+">"
     txt(2623) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2624) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_jfm.indmem.png","Indiv")+"</li>"
     txt(2625) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_jfm.indmemdiff.png","Bias")+"</li>"
     txt(2627) = "</ul></div></td>"
  else
     txt(2627) = "JFM</td>"
  end if

  txt(2630) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_mam.indmem.png")) then
     txt(2631) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_mam"+quote+">MAM</a>" 
     txt(2632) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_mam"+quote+">"
     txt(2633) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2634) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_mam.indmem.png","Indiv")+"</li>"
     txt(2635) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_mam.indmemdiff.png","Bias")+"</li>"
     txt(2637) = "</ul></div></td>"
  else
     txt(2637) = "MAM</td>"
  end if

  txt(2640) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_jja.indmem.png")) then
     txt(2641) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_jja"+quote+">JJA</a>" 
     txt(2642) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_jja"+quote+">"
     txt(2643) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2644) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_jja.indmem.png","Indiv")+"</li>"
     txt(2645) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_jja.indmemdiff.png","Bias")+"</li>"
     txt(2647) = "</ul></div></td>"
  else
     txt(2647) = "JJA</td>"
  end if

  txt(2650) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_jas.indmem.png")) then
     txt(2651) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_jas"+quote+">JAS</a>" 
     txt(2652) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_jas"+quote+">"
     txt(2653) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2654) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_jas.indmem.png","Indiv")+"</li>"
     txt(2655) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_jas.indmemdiff.png","Bias")+"</li>"
     txt(2657) = "</ul></div></td>"
  else
     txt(2657) = "JAS</td>"
  end if

  txt(2660) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_son.indmem.png")) then
     txt(2661) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_son"+quote+">SON</a>" 
     txt(2662) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_son"+quote+">"
     txt(2663) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2664) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_son.indmem.png","Indiv")+"</li>"
     txt(2665) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_son.indmemdiff.png","Bias")+"</li>"
     txt(2667) = "</ul></div></td>"
  else
     txt(2667) = "SON</td>"
  end if

  txt(2670) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_nh_trends_ann.indmem.png")) then
     txt(2671) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_nh_trends_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_nh_trends_ann"+quote+">ANN</a>" 
     txt(2672) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_nh_trends_ann"+quote+">"
     txt(2673) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2674) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_ann.indmem.png","Indiv")+"</li>"
     txt(2675) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_nh_trends_ann.indmemdiff.png","Bias")+"</li>"
     txt(2677) = "</ul></div></td>"
  else
     txt(2677) = "ANN</td>"
  end if
  txt(2678) = "</tr>"

  txt(2704) = "<tr class="+quote+"d-flex"+quote+">"
  txt(2705) = "<td class="+quote+"col"+quote+"><b>SIC SH</b></td>"

  txt(2710) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_djf.indmem.png")) then
     txt(2711) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_djf"+quote+">DJF</a>" 
     txt(2712) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_djf"+quote+">"
     txt(2713) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2714) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_djf.indmem.png","Indiv")+"</li>"
     txt(2715) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_djf.indmemdiff.png","Bias")+"</li>"
     txt(2717) = "</ul></div></td>"
  else
     txt(2717) = "DJF</td>"
  end if

  txt(2720) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_jfm.indmem.png")) then
     txt(2721) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_jfm"+quote+">JFM</a>" 
     txt(2722) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_jfm"+quote+">"
     txt(2723) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2724) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_jfm.indmem.png","Indiv")+"</li>"
     txt(2725) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_jfm.indmemdiff.png","Bias")+"</li>"
     txt(2727) = "</ul></div></td>"
  else
     txt(2727) = "JFM</td>"
  end if

  txt(2730) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_mam.indmem.png")) then
     txt(2731) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_mam"+quote+">MAM</a>" 
     txt(2732) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_mam"+quote+">"
     txt(2733) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2734) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_mam.indmem.png","Indiv")+"</li>"
     txt(2735) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_mam.indmemdiff.png","Bias")+"</li>"
     txt(2737) = "</ul></div></td>"
  else
     txt(2737) = "MAM</td>"
  end if

  txt(2740) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_jja.indmem.png")) then
     txt(2741) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_jja"+quote+">JJA</a>" 
     txt(2742) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_jja"+quote+">"
     txt(2743) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2744) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_jja.indmem.png","Indiv")+"</li>"
     txt(2745) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_jja.indmemdiff.png","Bias")+"</li>"
     txt(2747) = "</ul></div></td>"
  else
     txt(2747) = "JJA</td>"
  end if

  txt(2750) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_jas.indmem.png")) then
     txt(2751) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_jas"+quote+">JAS</a>" 
     txt(2752) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_jas"+quote+">"
     txt(2753) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2754) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_jas.indmem.png","Indiv")+"</li>"
     txt(2755) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_jas.indmemdiff.png","Bias")+"</li>"
     txt(2757) = "</ul></div></td>"
  else
     txt(2757) = "JAS</td>"
  end if

  txt(2760) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_son.indmem.png")) then
     txt(2761) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_son"+quote+">SON</a>" 
     txt(2762) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_son"+quote+">"
     txt(2763) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2764) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_son.indmem.png","Indiv")+"</li>"
     txt(2765) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_son.indmemdiff.png","Bias")+"</li>"
     txt(2767) = "</ul></div></td>"
  else
     txt(2767) = "SON</td>"
  end if

  txt(2770) = "<td class="+quote+"col"+quote+">"
  if (isfilepresent2(OUTDIR+"siconc_sh_trends_ann.indmem.png")) then
     txt(2771) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#siconc_sh_trends_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"siconc_sh_trends_ann"+quote+">ANN</a>" 
     txt(2772) = "<div class="+quote+"collapse"+quote+" id="+quote+"siconc_sh_trends_ann"+quote+">"
     txt(2773) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(2774) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_ann.indmem.png","Indiv")+"</li>"
     txt(2775) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"siconc_sh_trends_ann.indmemdiff.png","Bias")+"</li>"
     txt(2777) = "</ul></div></td>"
  else
     txt(2777) = "ANN</td>"
  end if
  txt(2778) = "</tr>"
  txt(2780) = "</table></div></div>"






  txt(4100) = "<div class="+quote+"row"+quote+">"
  txt(4101) = "<div class="+quote+"col"+quote+">"
  txt(4102) = "<table class="+quote+"table table-bordered"+quote+">"
  txt(4103) = "<h3 class="+quote+"display-6"+quote+">Coupled Modes of Variability</h3>"
  txt(4104) = "<tr>"
  txt(4105) = "<td rowspan=7><b>ENSO</b></td>"
  
  txt(4190) = "<td rowspan=4>Spatial Composites</td>"
  txt(4191) = "<td>El Ni&ntilde;o - La Ni&ntilde;a<br>SST/TAS/PSL<br>"
  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.indmem.jja0.png")) then
     txt(4201) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_jja0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_jja0"+quote+">JJA<sup>0</sup></a> " 
     txt(4202) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_jja0"+quote+">"
     txt(4203) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4204) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmem.jja0.png","Indiv")+"</li>"
     txt(4205) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmemdiff.jja0.png","Bias")+"</li>"
     txt(4207) = "</ul></div>"
  else
     txt(4207) = "JJA<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.indmem.son0.png")) then
     txt(4211) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_son0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_son0"+quote+">SON<sup>0</sup></a> " 
     txt(4212) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_son0"+quote+">"
     txt(4213) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4214) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmem.son0.png","Indiv")+"</li>"
     txt(4215) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmemdiff.son0.png","Bias")+"</li>"
     txt(4217) = "</ul></div>"
  else
     txt(4217) = " SON<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.indmem.djf1.png")) then
     txt(4221) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_djf1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_djf1"+quote+">DJF<sup>1</sup></a> " 
     txt(4222) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_djf1"+quote+">"
     txt(4223) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4224) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmem.djf1.png","Indiv")+"</li>"
     txt(4225) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmemdiff.djf1.png","Bias")+"</li>"
     txt(4227) = "</ul></div>"
  else
     txt(4227) = " DJF<sup>1</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.indmem.mam1.png")) then
     txt(4231) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nnino34_spatialcomp_mam1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_mam1"+quote+">MAM<sup>1</sup></a> " 
     txt(4232) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_mam1"+quote+">"
     txt(4233) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4234) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmem.mam1.png","Indiv")+"</li>"
     txt(4235) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.indmemdiff.mam1.png","Bias")+"</li>"
     txt(4237) = "</ul></div></td>"
  else
     txt(4237) = " MAM<sup>1</sup></td>"
  end if

  txt(4250) = "<td>El Ni&ntilde;o - La Ni&ntilde;a<br>PR<br>"
  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.pr.indmem.jja0.png")) then
     txt(4251) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_pr_jja0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_pr_jja0"+quote+">JJA<sup>0</sup></a> " 
     txt(4252) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_pr_jja0"+quote+">"
     txt(4253) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4254) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmem.jja0.png","Indiv")+"</li>"
     txt(4255) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmemdiff.jja0.png","Bias")+"</li>"
     txt(4257) = "</ul></div>"
  else
     txt(4257) = "JJA<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.pr.indmem.son0.png")) then
     txt(4261) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_pr_son0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_pr_son0"+quote+">SON<sup>0</sup></a> " 
     txt(4262) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_pr_son0"+quote+">"
     txt(4263) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4264) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmem.son0.png","Indiv")+"</li>"
     txt(4265) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmemdiff.son0.png","Bias")+"</li>"
     txt(4267) = "</ul></div>"
  else
     txt(4267) = " SON<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.pr.indmem.djf1.png")) then
     txt(4271) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_pr_djf1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_pr_djf1"+quote+">DJF<sup>1</sup></a> " 
     txt(4272) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_pr_djf1"+quote+">"
     txt(4273) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4274) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmem.djf1.png","Indiv")+"</li>"
     txt(4275) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmemdiff.djf1.png","Bias")+"</li>"
     txt(4277) = "</ul></div>"
  else
     txt(4277) = " DJF<sup>1</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.pr.indmem.mam1.png")) then
     txt(4281) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_pr_mam1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_pr_mam1"+quote+">MAM<sup>1</sup></a> " 
     txt(4282) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_pr_mam1"+quote+">"
     txt(4283) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4284) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmem.mam1.png","Indiv")+"</li>"
     txt(4285) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.pr.indmemdiff.mam1.png","Bias")+"</li>"
     txt(4287) = "</ul></div></td></tr>"
  else
     txt(4287) = " MAM<sup>1</sup></td></tr>"
  end if

  txt(4291) = "<tr><td>El Ni&ntilde;o SST/TAS/PSL<br>"
  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.indmem.jja0.png")) then
     txt(4301) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_jja0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_jja0"+quote+">JJA<sup>0</sup></a> " 
     txt(4302) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_jja0"+quote+">"
     txt(4303) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4304) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmem.jja0.png","Indiv")+"</li>"
     txt(4305) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmemdiff.jja0.png","Bias")+"</li>"
     txt(4307) = "</ul></div>"
  else
     txt(4307) = "JJA<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.indmem.son0.png")) then
     txt(4311) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_son0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_son0"+quote+">SON<sup>0</sup></a> " 
     txt(4312) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_son0"+quote+">"
     txt(4313) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4314) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmem.son0.png","Indiv")+"</li>"
     txt(4315) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmemdiff.son0.png","Bias")+"</li>"
     txt(4317) = "</ul></div>"
  else
     txt(4317) = " SON<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.indmem.djf1.png")) then
     txt(4321) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_djf1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_djf1"+quote+">DJF<sup>1</sup></a> " 
     txt(4322) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_djf1"+quote+">"
     txt(4323) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4324) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmem.djf1.png","Indiv")+"</li>"
     txt(4325) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmemdiff.djf1.png","Bias")+"</li>"
     txt(4327) = "</ul></div>"
  else
     txt(4327) = " DJF<sup>1</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.indmem.mam1.png")) then
     txt(4331) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_mam1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_mam1"+quote+">MAM<sup>1</sup></a> " 
     txt(4332) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_mam1"+quote+">"
     txt(4333) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4334) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmem.mam1.png","Indiv")+"</li>"
     txt(4335) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.indmemdiff.mam1.png","Bias")+"</li>"
     txt(4337) = "</ul></div></td>"
  else
     txt(4337) = " MAM<sup>1</sup></td>"
  end if

  txt(4350) = "<td>El Ni&ntilde;o PR<br>"
  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.pr.indmem.jja0.png")) then
     txt(4351) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_pr_jja0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_pr_jja0"+quote+">JJA<sup>0</sup></a> " 
     txt(4352) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_pr_jja0"+quote+">"
     txt(4353) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4354) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmem.jja0.png","Indiv")+"</li>"
     txt(4355) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmemdiff.jja0.png","Bias")+"</li>"
     txt(4357) = "</ul></div>"
  else
     txt(4357) = "JJA<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.pr.indmem.son0.png")) then
     txt(4361) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_pr_son0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_pr_son0"+quote+">SON<sup>0</sup></a> " 
     txt(4362) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_pr_son0"+quote+">"
     txt(4363) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4364) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmem.son0.png","Indiv")+"</li>"
     txt(4365) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmemdiff.son0.png","Bias")+"</li>"
     txt(4367) = "</ul></div>"
  else
     txt(4367) = " SON<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.pr.indmem.djf1.png")) then
     txt(4371) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_pr_djf1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_pr_djf1"+quote+">DJF<sup>1</sup></a> " 
     txt(4372) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_pr_djf1"+quote+">"
     txt(4373) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4374) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmem.djf1.png","Indiv")+"</li>"
     txt(4375) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmemdiff.djf1.png","Bias")+"</li>"
     txt(4377) = "</ul></div>"
  else
     txt(4377) = " DJF<sup>1</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.elnino.pr.indmem.mam1.png")) then
     txt(4381) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_elnino_pr_mam1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_elnino_pr_mam1"+quote+">MAM<sup>1</sup></a> " 
     txt(4382) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_elnino_pr_mam1"+quote+">"
     txt(4383) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4384) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmem.mam1.png","Indiv")+"</li>"
     txt(4385) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.elnino.pr.indmemdiff.mam1.png","Bias")+"</li>"
     txt(4387) = "</ul></div></td></tr>"
  else
     txt(4387) = " MAM<sup>1</sup></td></tr>"
  end if


  txt(4391) = "<tr><td>La Ni&ntilde;a SST/TAS/PSL<br>"
  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.indmem.jja0.png")) then
     txt(4401) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_jja0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_jja0"+quote+">JJA<sup>0</sup></a> " 
     txt(4402) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_jja0"+quote+">"
     txt(4403) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4404) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmem.jja0.png","Indiv")+"</li>"
     txt(4405) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmemdiff.jja0.png","Bias")+"</li>"
     txt(4407) = "</ul></div>"
  else
     txt(4407) = "JJA<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.indmem.son0.png")) then
     txt(4411) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_son0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_son0"+quote+">SON<sup>0</sup></a> " 
     txt(4412) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_son0"+quote+">"
     txt(4413) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4414) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmem.son0.png","Indiv")+"</li>"
     txt(4415) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmemdiff.son0.png","Bias")+"</li>"
     txt(4417) = "</ul></div>"
  else
     txt(4417) = " SON<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.indmem.djf1.png")) then
     txt(4421) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_djf1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_djf1"+quote+">DJF<sup>1</sup></a> " 
     txt(4422) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_djf1"+quote+">"
     txt(4423) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4424) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmem.djf1.png","Indiv")+"</li>"
     txt(4425) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmemdiff.djf1.png","Bias")+"</li>"
     txt(4427) = "</ul></div>"
  else
     txt(4427) = " DJF<sup>1</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.indmem.mam1.png")) then
     txt(4431) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_mam1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_mam1"+quote+">MAM<sup>1</sup></a> " 
     txt(4432) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_mam1"+quote+">"
     txt(4433) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4434) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmem.mam1.png","Indiv")+"</li>"
     txt(4435) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.indmemdiff.mam1.png","Bias")+"</li>"
     txt(4437) = "</ul></div></td>"
  else
     txt(4437) = " MAM<sup>1</sup></td>"
  end if

  txt(4450) = "<td>La Ni&ntilde;a PR<br>"
  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.pr.indmem.jja0.png")) then
     txt(4451) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_pr_jja0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_pr_jja0"+quote+">JJA<sup>0</sup></a> " 
     txt(4452) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_pr_jja0"+quote+">"
     txt(4453) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4454) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmem.jja0.png","Indiv")+"</li>"
     txt(4455) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmemdiff.jja0.png","Bias")+"</li>"
     txt(4457) = "</ul></div>"
  else
     txt(4457) = "JJA<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.pr.indmem.son0.png")) then
     txt(4461) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_pr_son0"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_pr_son0"+quote+">SON<sup>0</sup></a> " 
     txt(4462) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_pr_son0"+quote+">"
     txt(4463) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4464) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmem.son0.png","Indiv")+"</li>"
     txt(4465) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmemdiff.son0.png","Bias")+"</li>"
     txt(4467) = "</ul></div>"
  else
     txt(4467) = " SON<sup>0</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.pr.indmem.djf1.png")) then
     txt(4471) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_pr_djf1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_pr_djf1"+quote+">DJF<sup>1</sup></a> " 
     txt(4472) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_pr_djf1"+quote+">"
     txt(4473) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4474) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmem.djf1.png","Indiv")+"</li>"
     txt(4475) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmemdiff.djf1.png","Bias")+"</li>"
     txt(4477) = "</ul></div>"
  else
     txt(4477) = " DJF<sup>1</sup>"
  end if

  if (isfilepresent2(OUTDIR+"nino34.spatialcomp.lanina.pr.indmem.mam1.png")) then
     txt(4481) = " <a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_spatialcomp_lanina_pr_mam1"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_spatialcomp_lanina_pr_mam1"+quote+">MAM<sup>1</sup></a> " 
     txt(4482) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_spatialcomp_lanina_pr_mam1"+quote+">"
     txt(4483) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4484) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmem.mam1.png","Indiv")+"</li>"
     txt(4485) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.spatialcomp.lanina.pr.indmemdiff.mam1.png","Bias")+"</li>"
     txt(4487) = "</ul></div></td></tr>"
  else
     txt(4487) = " MAM<sup>1</sup></td></tr>"
  end if



  txt(4490) = "<tr>"
  txt(4500) = "<td>"
  if (isfilepresent2(OUTDIR+"nino34.hov.elnino.indmem.png")) then
     txt(4501) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_hov_elnino"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_hov_elnino"+quote+">El Ni&ntilde;o Hovm&ouml;ller</a> " 
     txt(4502) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_hov_elnino"+quote+">"
     txt(4503) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4504) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.hov.elnino.indmem.png","Indiv")+"</li>"
     txt(4505) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.hov.elnino.indmemdiff.png","Bias")+"</li>"
     txt(4507) = "</ul></div></td>"
  else
     txt(4507) = "El Ni&ntilde;o Hovm&ouml;ller</td>"
  end if
  txt(4510) = "<td>"
  if (isfilepresent2(OUTDIR+"nino34.hov.lanina.indmem.png")) then
     txt(4511) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_hov_lanina"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_hov_lanina"+quote+">La Ni&ntilde;a Hovm&ouml;ller</a> " 
     txt(4512) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_hov_lanina"+quote+">"
     txt(4513) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4514) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.hov.lanina.indmem.png","Indiv")+"</li>"
     txt(4515) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.hov.lanina.indmemdiff.png","Bias")+"</li>"
     txt(4517) = "</ul></div></td></tr>"
  else
     txt(4517) = "La Ni&ntilde;a Hovm&ouml;ller</td></tr>"
  end if

  txt(4519) = "<tr>"
  txt(4600) = "<td rowspan=3>Ni&ntilde;o3.4</td>"
  txt(4601) = "<td>"+table_link_setup(OUTDIR,"nino34.timeseries.indmem.png","Timeseries")+"</td>"
  txt(4610) = "<td>"+table_link_setup(OUTDIR,"nino34.monstddev.indmem.png","Monthly Std. Dev.")+"</td></tr>"
  txt(4611) = "<tr><td>"+table_link_setup(OUTDIR,"nino34.powspec.indmem.png","Power Spectra")+"</td>"
  txt(4612) = "<td>"
  if (isfilepresent2(OUTDIR+"nino34.wavelet.indmem.png")) then
     txt(4613) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nino34_wavelet"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nino34_wavelet"+quote+">Wavelet</a> " 
     txt(4614) = "<div class="+quote+"collapse"+quote+" id="+quote+"nino34_wavelet"+quote+">"
     txt(4615) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(4616) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.wavelet.indmem.png","Indiv")+"</li>"
     txt(4617) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nino34.wavelet.indmemdiff.png","Bias")+"</li>"
     txt(4618) = "</ul></div>"
  else
     txt(4613) = "Wavelet"
  end if
  txt(4619) = "</td></tr>" 
  txt(4620) = "<tr><td>"+table_link_setup(OUTDIR,"nino34.autocor.indmem.png","Autocorrelation")+"</td>"
  txt(4621) = "<td>"+table_link_setup(OUTDIR,"nino34_runstddev.timeseries.indmem.png","Running Standard Deviation")+"</td></tr>"

  txt(5196) = "<tr>"
  txt(5197) = "<td rowspan=2><b>AMV</b></td>"
  txt(5198) = "<td>Regr: "
  if (isfilepresent2(OUTDIR+"amv.indmem.png")) then
     txt(5199) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amo"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amo"+quote+">SST</a> " 
     txt(5200) = "<div class="+quote+"collapse"+quote+" id="+quote+"amo"+quote+">"
     txt(5201) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5202) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.indmem.png","Indiv")+"</li>"
     txt(5203) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.indmemdiff.png","Bias")+"</li>"
     txt(5205) = "</ul></div>"
  else
     txt(5205) = "SST "
  end if
  if (isfilepresent2(OUTDIR+"amv.tassstreg.indmem.png")) then
     txt(5210) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_tassstreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_tassstreg"+quote+">TAS</a> " 
     txt(5211) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_tassstreg"+quote+">"
     txt(5212) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5213) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.tassstreg.indmem.png","Indiv")+"</li>"
     txt(5214) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.tassstreg.indmemdiff.png","Bias")+"</li>"
     txt(5216) = "</ul></div>"
  else
     txt(5210) = "TAS "
  end if
  if (isfilepresent2(OUTDIR+"amv.prreg.indmem.png")) then
     txt(5220) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_prreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_prreg"+quote+">PR</a> " 
     txt(5221) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_prreg"+quote+">"
     txt(5222) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5223) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prreg.indmem.png","Indiv")+"</li>"
     txt(5224) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prreg.indmemdiff.png","Bias")+"</li>"
     txt(5226) = "</ul></div></td>"
  else
     txt(5220) = "PR</td>"
  end if

  txt(5250) = "<td>"+table_link_setup(OUTDIR,"amv_timeseries_mon.indmem.png","Timeseries")+"</td>"
  txt(5251) = "<td rowspan=2>"+table_link_setup(OUTDIR,"amv.powspec.indmem.png","Power Spectra")+"</td></tr>"

  txt(5268) = "<tr><td>Regr LP: "
  if (isfilepresent2(OUTDIR+"amv.lp.indmem.png")) then
     txt(5269) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_lp"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_lp"+quote+">SST</a> " 
     txt(5270) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_lp"+quote+">"
     txt(5271) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5272) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.indmem.png","Indiv")+"</li>"
     txt(5273) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.indmemdiff.png","Bias")+"</li>"
     txt(5275) = "</ul></div>"
  else
     txt(5275) = "SST "
  end if
  if (isfilepresent2(OUTDIR+"amv.lp.tassstreg.indmem.png")) then
     txt(5280) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_lp_tassstreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_lp_tassstreg"+quote+">TAS</a> " 
     txt(5281) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_lp_tassstreg"+quote+">"
     txt(5282) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5283) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.tassstreg.indmem.png","Indiv")+"</li>"
     txt(5284) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.tassstreg.indmemdiff.png","Bias")+"</li>"
     txt(5286) = "</ul></div>"
  else
     txt(5280) = "TAS "
  end if
  if (isfilepresent2(OUTDIR+"amv.lp.prreg.indmem.png")) then
     txt(5290) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_lp_prreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_lp_prreg"+quote+">PR</a> " 
     txt(5291) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_lp_prreg"+quote+">"
     txt(5292) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5293) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prreg.indmem.png","Indiv")+"</li>"
     txt(5294) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prreg.indmemdiff.png","Bias")+"</li>"
     txt(5296) = "</ul></div></td></tr>"
  else
     txt(5290) = "PR</td>"
  end if
  txt(5296) = "<td>"+table_link_setup(OUTDIR,"amv_timeseries_lowpass_mon.indmem.png","Timeseries")+"</td></tr>"

  txt(5297) = "<tr><td rowspan=2><b>AMV'</b></td>"
  txt(5298) = "<td>Regr: "
  if (isfilepresent2(OUTDIR+"amv.prime.indmem.png")) then
     txt(5299) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_prime"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_prime"+quote+">SST</a> " 
     txt(5300) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_prime"+quote+">"
     txt(5301) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5302) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prime.indmem.png","Indiv")+"</li>"
     txt(5303) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prime.indmemdiff.png","Bias")+"</li>"
     txt(5305) = "</ul></div>"
  else
     txt(5305) = "SST "
  end if
  if (isfilepresent2(OUTDIR+"amv.prime.tassstreg.indmem.png")) then
     txt(5310) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_prime_tassstreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_prime_tassstreg"+quote+">TAS</a> " 
     txt(5311) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_prime_tassstreg"+quote+">"
     txt(5312) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5313) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prime.tassstreg.indmem.png","Indiv")+"</li>"
     txt(5314) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prime.tassstreg.indmemdiff.png","Bias")+"</li>"
     txt(5316) = "</ul></div>"
  else
     txt(5310) = "TAS "
  end if
  if (isfilepresent2(OUTDIR+"amv.prime.prreg.indmem.png")) then
     txt(5320) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_prime_prreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_prime_prreg"+quote+">PR</a> " 
     txt(5321) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_prime_prreg"+quote+">"
     txt(5322) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5323) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prime.prreg.indmem.png","Indiv")+"</li>"
     txt(5324) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.prime.prreg.indmemdiff.png","Bias")+"</li>"
     txt(5326) = "</ul></div></td>"
  else
     txt(5320) = "PR</td>"
  end if

  txt(5350) = "<td>"+table_link_setup(OUTDIR,"amv_prime_timeseries_mon.indmem.png","Timeseries")+"</td>"
  txt(5351) = "<td rowspan=2>"+table_link_setup(OUTDIR,"amv.prime.powspec.indmem.png","Power Spectra")+"</td></tr>"


  txt(5368) = "<tr><td>Regr LP: "
  if (isfilepresent2(OUTDIR+"amv.lp.prime.indmem.png")) then
     txt(5369) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_lp_prime"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_lp_prime"+quote+">SST</a> " 
     txt(5370) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_lp_prime"+quote+">"
     txt(5371) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5372) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prime.indmem.png","Indiv")+"</li>"
     txt(5373) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prime.indmemdiff.png","Bias")+"</li>"
     txt(5375) = "</ul></div>"
  else
     txt(5375) = "SST "
  end if
  if (isfilepresent2(OUTDIR+"amv.lp.prime.tassstreg.indmem.png")) then
     txt(5380) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_lp_prime_tassstreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_lp_prime_tassstreg"+quote+">TAS</a> " 
     txt(5381) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_lp_prime_tassstreg"+quote+">"
     txt(5382) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5383) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prime.tassstreg.indmem.png","Indiv")+"</li>"
     txt(5384) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prime.tassstreg.indmemdiff.png","Bias")+"</li>"
     txt(5386) = "</ul></div>"
  else
     txt(5380) = "TAS "
  end if
  if (isfilepresent2(OUTDIR+"amv.lp.prime.prreg.indmem.png")) then
     txt(5390) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amv_lp_prime_prreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amv_lp_prime_prreg"+quote+">PR</a> " 
     txt(5391) = "<div class="+quote+"collapse"+quote+" id="+quote+"amv_lp_prime_prreg"+quote+">"
     txt(5392) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5393) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prime.prreg.indmem.png","Indiv")+"</li>"
     txt(5394) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amv.lp.prime.prreg.indmemdiff.png","Bias")+"</li>"
     txt(5396) = "</ul></div></td>"
  else
     txt(5390) = "PR</td>"
  end if
  txt(5397) = "<td>"+table_link_setup(OUTDIR,"amv_prime_timeseries_lowpass_mon.indmem.png","Timeseries")+"</td></tr>"


  txt(5496) = "<tr>"
  txt(5497) = "<td><b>PDV</b></td>"
  txt(5498) = "<td>Regr: "
  if (isfilepresent2(OUTDIR+"pdv.indmem.png")) then
     txt(5499) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pdo"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pdo"+quote+">SST</a> " 
     txt(5500) = "<div class="+quote+"collapse"+quote+" id="+quote+"pdo"+quote+">"
     txt(5501) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5502) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.indmem.png","Indiv")+"</li>"
     txt(5503) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.indmemdiff.png","Bias")+"</li>"
     txt(5505) = "</ul></div>"
  else
     txt(5505) = "SST "
  end if
  if (isfilepresent2(OUTDIR+"pdv.tassstreg.indmem.png")) then
     txt(5510) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pdv_tassstreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pdv_tassstreg"+quote+">TAS</a> " 
     txt(5511) = "<div class="+quote+"collapse"+quote+" id="+quote+"pdv_tassstreg"+quote+">"
     txt(5512) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5513) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.tassstreg.indmem.png","Indiv")+"</li>"
     txt(5514) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.tassstreg.indmemdiff.png","Bias")+"</li>"
     txt(5516) = "</ul></div>"
  else
     txt(5510) = "TAS "
  end if
  if (isfilepresent2(OUTDIR+"pdv.prreg.indmem.png")) then
     txt(5520) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pdv_prreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pdv_prreg"+quote+">PR</a> " 
     txt(5521) = "<div class="+quote+"collapse"+quote+" id="+quote+"pdv_prreg"+quote+">"
     txt(5522) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5523) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prreg.indmem.png","Indiv")+"</li>"
     txt(5524) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prreg.indmemdiff.png","Bias")+"</li>"
     txt(5526) = "</ul></div></td>"
  else
     txt(5520) = "PR</td>"
  end if

  txt(5550) = "<td>"+table_link_setup(OUTDIR,"pdv_timeseries_mon.indmem.png","Timeseries")+"</td>"
  txt(5551) = "<td>"+table_link_setup(OUTDIR,"pdv.powspec.indmem.png","Power Spectra")+"</td></tr>"

  txt(5596) = "<tr>"
  txt(5597) = "<td><b>PDV'</b></td>"
  txt(5598) = "<td>Regr: "
  if (isfilepresent2(OUTDIR+"pdv.prime.indmem.png")) then
     txt(5599) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pdv_prime"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pdv_prime"+quote+">SST</a> " 
     txt(5600) = "<div class="+quote+"collapse"+quote+" id="+quote+"pdv_prime"+quote+">"
     txt(5601) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5602) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prime.indmem.png","Indiv")+"</li>"
     txt(5603) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prime.indmemdiff.png","Bias")+"</li>"
     txt(5605) = "</ul></div>"
  else
     txt(5605) = "SST "
  end if
  if (isfilepresent2(OUTDIR+"pdv.prime.tassstreg.indmem.png")) then
     txt(5610) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pdv_prime_tassstreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pdv_prime_tassstreg"+quote+">TAS</a> " 
     txt(5611) = "<div class="+quote+"collapse"+quote+" id="+quote+"pdv_prime_tassstreg"+quote+">"
     txt(5612) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5613) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prime.tassstreg.indmem.png","Indiv")+"</li>"
     txt(5614) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prime.tassstreg.indmemdiff.png","Bias")+"</li>"
     txt(5616) = "</ul></div>"
  else
     txt(5610) = "TAS "
  end if
  if (isfilepresent2(OUTDIR+"pdv.prime.prreg.indmem.png")) then
     txt(5620) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pdv_prime_prreg"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pdv_prime_prreg"+quote+">PR</a> " 
     txt(5621) = "<div class="+quote+"collapse"+quote+" id="+quote+"pdv_prime_prreg"+quote+">"
     txt(5622) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5623) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prime.prreg.indmem.png","Indiv")+"</li>"
     txt(5624) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pdv.prime.prreg.indmemdiff.png","Bias")+"</li>"
     txt(5626) = "</ul></div></td>"
  else
     txt(5620) = "PR</td>"
  end if
  txt(5650) = "<td>"+table_link_setup(OUTDIR,"pdv_prime_timeseries_mon.indmem.png","Timeseries")+"</td>"
  txt(5651) = "<td>"+table_link_setup(OUTDIR,"pdv.prime.powspec.indmem.png","Power Spectra")+"</td></tr>"

  txt(5700) = "<tr><td rowspan=3><b>AMOC</b></td><td>"
  if (isfilepresent2(OUTDIR+"amoc.mean.ann.indmem.png")) then
     txt(5701) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amoc_mean_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amoc_mean_ann"+quote+">Means</a> " 
     txt(5702) = "<div class="+quote+"collapse"+quote+" id="+quote+"amoc_mean_ann"+quote+">"
     txt(5703) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5704) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.mean.ann.indmem.png","Indiv")+"</li>"
     txt(5705) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.mean.ann.indmemdiff.png","Bias")+"</li>"
     txt(5706) = "</ul></div></td>"
  else
     txt(5701) = "Means</td>"
  end if

  txt(5710) = "<td>"
  if (isfilepresent2(OUTDIR+"amoc.stddev.ann.indmem.png")) then
     txt(5711) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amoc_stddev_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amoc_stddev_ann"+quote+">Standard Deviations</a> " 
     txt(5712) = "<div class="+quote+"collapse"+quote+" id="+quote+"amoc_stddev_ann"+quote+">"
     txt(5713) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5714) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.stddev.ann.indmem.png","Indiv")+"</li>"
     txt(5715) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.stddev.ann.indmemdiff.png","Bias")+"</li>"
     txt(5716) = "</ul></div></td>"
  else
     txt(5711) = "Standard Deviations</td>"
  end if

  txt(5720) = "<td>"
  if (isfilepresent2(OUTDIR+"amoc.pattern.ann.indmem.png")) then
     txt(5721) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amoc_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amoc_pattern_ann"+quote+">Patterns</a> " 
     txt(5722) = "<div class="+quote+"collapse"+quote+" id="+quote+"amoc_pattern_ann"+quote+">"
     txt(5723) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5724) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.pattern.ann.indmem.png","Indiv")+"</li>"
     txt(5725) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.pattern.ann.indmemdiff.png","Bias")+"</li>"
     txt(5726) = "</ul></div></td>"
  else
     txt(5721) = "Patterns</td></tr>"
  end if

  txt(5730) = "<tr><td>"+table_link_setup(OUTDIR,"amoc.timeseries.ann.indmem.png","Timeseries")+"</td><td colspan=2>"
  if (isfilepresent2(OUTDIR+"amoc.tassstreg.ann.indmem.png")) then
     txt(5731) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#amoc_tassstreg_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"amoc_tassstreg_ann"+quote+">SST/TAS Regressions</a> " 
     txt(5732) = "<div class="+quote+"collapse"+quote+" id="+quote+"amoc_tassstreg_ann"+quote+">"
     txt(5733) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5734) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.tassstreg.ann.indmem.png","Indiv")+"</li>"
     txt(5735) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"amoc.tassstreg.ann.indmemdiff.png","Bias")+"</li>"
     txt(5736) = "</ul></div></td>"
  else
     txt(5731) = "SST/TAS Regressions</td></tr>"
  end if
  txt(5740) = "<tr><td>"+table_link_setup(OUTDIR,"amoc.powspec.indmem.png","Spectra")+"</td>"
  txt(5741) = "<td colspan=2>"+table_link_setup(OUTDIR,"amoc_amv.leadlag.ann.indmem.png","AMV/AMOC Lag Correlations")+"</td></tr>"
  txt(5799) = "</table></div></div>"


  txt(5800) = "<div class="+quote+"row"+quote+">"
  txt(5801) = "<div class="+quote+"col"+quote+">"
  txt(5802) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(5803) = "<h3 class="+quote+"display-6"+quote+">Atmospheric Modes of Variability</h3>"

  txt(5809) = "<tr><td rowspan=2><b>SO</b></td>"
  txt(5810) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"so_pattern_djf.indmem.png")) then
     txt(5811) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_djf"+quote+">DJF</a>" 
     txt(5812) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_djf"+quote+">"
     txt(5813) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5814) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(5815) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(5817) = "</ul></div></td>"
  else
     txt(5817) = "DJF</td>"
  end if

  txt(5820) = "<td>"
  if (isfilepresent2(OUTDIR+"so_pattern_jfm.indmem.png")) then
     txt(5821) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_jfm"+quote+">JFM</a>" 
     txt(5822) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_jfm"+quote+">"
     txt(5823) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5824) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(5825) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(5827) = "</ul></div></td>"
  else
     txt(5827) = "JFM</td>"
  end if

  txt(5830) = "<td>"
  if (isfilepresent2(OUTDIR+"so_pattern_mam.indmem.png")) then
     txt(5831) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_mam"+quote+">MAM</a>" 
     txt(5832) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_mam"+quote+">"
     txt(5833) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5834) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(5835) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(5837) = "</ul></div></td>"
  else
     txt(5837) = "MAM</td>"
  end if

  txt(5840) = "<td>"
  if (isfilepresent2(OUTDIR+"so_pattern_jja.indmem.png")) then
     txt(5841) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_jja"+quote+">JJA</a>" 
     txt(5842) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_jja"+quote+">"
     txt(5843) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5844) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(5845) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(5847) = "</ul></div></td>"
  else
     txt(5847) = "JJA</td>"
  end if

  txt(5850) = "<td>"
  if (isfilepresent2(OUTDIR+"so_pattern_jas.indmem.png")) then
     txt(5851) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_jas"+quote+">JAS</a>" 
     txt(5852) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_jas"+quote+">"
     txt(5853) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5854) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(5855) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(5857) = "</ul></div></td>"
  else
     txt(5857) = "JAS</td>"
  end if

  txt(5860) = "<td>"
  if (isfilepresent2(OUTDIR+"so_pattern_son.indmem.png")) then
     txt(5861) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_son"+quote+">SON</a>" 
     txt(5862) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_son"+quote+">"
     txt(5863) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5864) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_son.indmem.png","Indiv")+"</li>"
     txt(5865) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(5867) = "</ul></div></td>"
  else
     txt(5867) = "SON</td>"
  end if

  txt(5870) = "<td>"
  if (isfilepresent2(OUTDIR+"so_pattern_ann.indmem.png")) then
     txt(5871) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#so_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"so_pattern_ann"+quote+">ANN</a>" 
     txt(5872) = "<div class="+quote+"collapse"+quote+" id="+quote+"so_pattern_ann"+quote+">"
     txt(5873) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5874) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(5875) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"so_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(5877) = "</ul></div></td></tr>"
  else
     txt(5877) = "ANN</td></tr>"
  end if
  txt(5881) = "<tr><td>Timeseries</td>"
  txt(5882) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(5883) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(5884) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(5885) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(5886) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(5887) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_son.indmem.png","SON")+"</td>"
  txt(5888) = "<td>"+table_link_setup(OUTDIR,"so_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(5909) = "<tr><td rowspan=2><b>NAM</b></td>"
  txt(5910) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_djf.indmem.png")) then
     txt(5911) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_djf"+quote+">DJF</a>" 
     txt(5912) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_djf"+quote+">"
     txt(5913) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5914) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(5915) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(5917) = "</ul></div></td>"
  else
     txt(5917) = "DJF</td>"
  end if

  txt(5920) = "<td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_jfm.indmem.png")) then
     txt(5921) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_jfm"+quote+">JFM</a>" 
     txt(5922) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_jfm"+quote+">"
     txt(5923) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5924) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(5925) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(5927) = "</ul></div></td>"
  else
     txt(5927) = "JFM</td>"
  end if

  txt(5930) = "<td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_mam.indmem.png")) then
     txt(5931) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_mam"+quote+">MAM</a>" 
     txt(5932) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_mam"+quote+">"
     txt(5933) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5934) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(5935) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(5937) = "</ul></div></td>"
  else
     txt(5937) = "MAM</td>"
  end if

  txt(5940) = "<td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_jja.indmem.png")) then
     txt(5941) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_jja"+quote+">JJA</a>" 
     txt(5942) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_jja"+quote+">"
     txt(5943) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5944) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(5945) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(5947) = "</ul></div></td>"
  else
     txt(5947) = "JJA</td>"
  end if

  txt(5950) = "<td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_jas.indmem.png")) then
     txt(5951) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_jas"+quote+">JAS</a>" 
     txt(5952) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_jas"+quote+">"
     txt(5953) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5954) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(5955) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(5957) = "</ul></div></td>"
  else
     txt(5957) = "JAS</td>"
  end if

  txt(5960) = "<td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_son.indmem.png")) then
     txt(5961) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_son"+quote+">SON</a>" 
     txt(5962) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_son"+quote+">"
     txt(5963) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5964) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_son.indmem.png","Indiv")+"</li>"
     txt(5965) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(5967) = "</ul></div></td>"
  else
     txt(5967) = "SON</td>"
  end if

  txt(5970) = "<td>"
  if (isfilepresent2(OUTDIR+"nam_pattern_ann.indmem.png")) then
     txt(5971) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nam_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nam_pattern_ann"+quote+">ANN</a>" 
     txt(5972) = "<div class="+quote+"collapse"+quote+" id="+quote+"nam_pattern_ann"+quote+">"
     txt(5973) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(5974) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(5975) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nam_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(5977) = "</ul></div></td></tr>"
  else
     txt(5977) = "ANN</td></tr>"
  end if
  txt(5981) = "<tr><td>Timeseries</td>"
  txt(5982) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(5983) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(5984) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(5985) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(5986) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(5987) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_son.indmem.png","SON")+"</td>"
  txt(5988) = "<td>"+table_link_setup(OUTDIR,"nam_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(6109) = "<tr><td rowspan=2><b>NAO</b></td>"
  txt(6110) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_djf.indmem.png")) then
     txt(6111) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_djf"+quote+">DJF</a>" 
     txt(6112) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_djf"+quote+">"
     txt(6113) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6114) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(6115) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(6117) = "</ul></div></td>"
  else
     txt(6117) = "DJF</td>"
  end if

  txt(6120) = "<td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_jfm.indmem.png")) then
     txt(6121) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_jfm"+quote+">JFM</a>" 
     txt(6122) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_jfm"+quote+">"
     txt(6123) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6124) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(6125) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(6127) = "</ul></div></td>"
  else
     txt(6127) = "JFM</td>"
  end if

  txt(6130) = "<td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_mam.indmem.png")) then
     txt(6131) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_mam"+quote+">MAM</a>" 
     txt(6132) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_mam"+quote+">"
     txt(6133) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6134) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(6135) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(6137) = "</ul></div></td>"
  else
     txt(6137) = "MAM</td>"
  end if

  txt(6140) = "<td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_jja.indmem.png")) then
     txt(6141) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_jja"+quote+">JJA</a>" 
     txt(6142) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_jja"+quote+">"
     txt(6143) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6144) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(6145) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(6147) = "</ul></div></td>"
  else
     txt(6147) = "JJA</td>"
  end if

  txt(6150) = "<td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_jas.indmem.png")) then
     txt(6151) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_jas"+quote+">JAS</a>" 
     txt(6152) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_jas"+quote+">"
     txt(6153) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6154) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(6155) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(6157) = "</ul></div></td>"
  else
     txt(6157) = "JAS</td>"
  end if

  txt(6160) = "<td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_son.indmem.png")) then
     txt(6161) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_son"+quote+">SON</a>" 
     txt(6162) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_son"+quote+">"
     txt(6163) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6164) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_son.indmem.png","Indiv")+"</li>"
     txt(6165) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(6167) = "</ul></div></td>"
  else
     txt(6167) = "SON</td>"
  end if

  txt(6170) = "<td>"
  if (isfilepresent2(OUTDIR+"nao_pattern_ann.indmem.png")) then
     txt(6171) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#nao_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"nao_pattern_ann"+quote+">ANN</a>" 
     txt(6172) = "<div class="+quote+"collapse"+quote+" id="+quote+"nao_pattern_ann"+quote+">"
     txt(6173) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6174) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(6175) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"nao_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(6177) = "</ul></div></td></tr>"
  else
     txt(6177) = "ANN</td></tr>"
  end if
  txt(6181) = "<tr><td>Timeseries</td>"
  txt(6182) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(6183) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(6184) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(6185) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(6186) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(6187) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_son.indmem.png","SON")+"</td>"
  txt(6188) = "<td>"+table_link_setup(OUTDIR,"nao_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(6309) = "<tr><td rowspan=2><b>SAM</b></td>"
  txt(6310) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_djf.indmem.png")) then
     txt(6311) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_djf"+quote+">DJF</a>" 
     txt(6312) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_djf"+quote+">"
     txt(6313) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6314) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(6315) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(6317) = "</ul></div></td>"
  else
     txt(6317) = "DJF</td>"
  end if

  txt(6320) = "<td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_jfm.indmem.png")) then
     txt(6321) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_jfm"+quote+">JFM</a>" 
     txt(6322) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_jfm"+quote+">"
     txt(6323) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6324) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(6325) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(6327) = "</ul></div></td>"
  else
     txt(6327) = "JFM</td>"
  end if

  txt(6330) = "<td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_mam.indmem.png")) then
     txt(6331) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_mam"+quote+">MAM</a>" 
     txt(6332) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_mam"+quote+">"
     txt(6333) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6334) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(6335) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(6337) = "</ul></div></td>"
  else
     txt(6337) = "MAM</td>"
  end if

  txt(6340) = "<td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_jja.indmem.png")) then
     txt(6341) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_jja"+quote+">JJA</a>" 
     txt(6342) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_jja"+quote+">"
     txt(6343) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6344) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(6345) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(6347) = "</ul></div></td>"
  else
     txt(6347) = "JJA</td>"
  end if

  txt(6350) = "<td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_jas.indmem.png")) then
     txt(6351) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_jas"+quote+">JAS</a>" 
     txt(6352) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_jas"+quote+">"
     txt(6353) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6354) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(6355) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(6357) = "</ul></div></td>"
  else
     txt(6357) = "JAS</td>"
  end if

  txt(6360) = "<td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_son.indmem.png")) then
     txt(6361) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_son"+quote+">SON</a>" 
     txt(6362) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_son"+quote+">"
     txt(6363) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6364) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_son.indmem.png","Indiv")+"</li>"
     txt(6365) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(6367) = "</ul></div></td>"
  else
     txt(6367) = "SON</td>"
  end if

  txt(6370) = "<td>"
  if (isfilepresent2(OUTDIR+"sam_pattern_ann.indmem.png")) then
     txt(6371) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#sam_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"sam_pattern_ann"+quote+">ANN</a>" 
     txt(6372) = "<div class="+quote+"collapse"+quote+" id="+quote+"sam_pattern_ann"+quote+">"
     txt(6373) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6374) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(6375) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"sam_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(6377) = "</ul></div></td></tr>"
  else
     txt(6377) = "ANN</td></tr>"
  end if
  txt(6381) = "<tr><td>Timeseries</td>"
  txt(6382) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(6383) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(6384) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(6385) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(6386) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(6387) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_son.indmem.png","SON")+"</td>"
  txt(6388) = "<td>"+table_link_setup(OUTDIR,"sam_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(6509) = "<tr><td rowspan=2><b>PNA</b></td>"
  txt(6510) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_djf.indmem.png")) then
     txt(6511) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_djf"+quote+">DJF</a>" 
     txt(6512) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_djf"+quote+">"
     txt(6513) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6514) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(6515) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(6517) = "</ul></div></td>"
  else
     txt(6517) = "DJF</td>"
  end if

  txt(6520) = "<td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_jfm.indmem.png")) then
     txt(6521) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_jfm"+quote+">JFM</a>" 
     txt(6522) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_jfm"+quote+">"
     txt(6523) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6524) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(6525) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(6527) = "</ul></div></td>"
  else
     txt(6527) = "JFM</td>"
  end if

  txt(6530) = "<td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_mam.indmem.png")) then
     txt(6531) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_mam"+quote+">MAM</a>" 
     txt(6532) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_mam"+quote+">"
     txt(6533) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6534) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(6535) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(6537) = "</ul></div></td>"
  else
     txt(6537) = "MAM</td>"
  end if

  txt(6540) = "<td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_jja.indmem.png")) then
     txt(6541) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_jja"+quote+">JJA</a>" 
     txt(6542) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_jja"+quote+">"
     txt(6543) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6544) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(6545) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(6547) = "</ul></div></td>"
  else
     txt(6547) = "JJA</td>"
  end if

  txt(6550) = "<td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_jas.indmem.png")) then
     txt(6551) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_jas"+quote+">JAS</a>" 
     txt(6552) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_jas"+quote+">"
     txt(6553) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6554) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(6555) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(6557) = "</ul></div></td>"
  else
     txt(6557) = "JAS</td>"
  end if

  txt(6560) = "<td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_son.indmem.png")) then
     txt(6561) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_son"+quote+">SON</a>" 
     txt(6562) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_son"+quote+">"
     txt(6563) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6564) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_son.indmem.png","Indiv")+"</li>"
     txt(6565) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(6567) = "</ul></div></td>"
  else
     txt(6567) = "SON</td>"
  end if

  txt(6570) = "<td>"
  if (isfilepresent2(OUTDIR+"pna_pattern_ann.indmem.png")) then
     txt(6571) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#pna_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"pna_pattern_ann"+quote+">ANN</a>" 
     txt(6572) = "<div class="+quote+"collapse"+quote+" id="+quote+"pna_pattern_ann"+quote+">"
     txt(6573) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6574) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(6575) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"pna_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(6577) = "</ul></div></td></tr>"
  else
     txt(6577) = "ANN</td></tr>"
  end if
  txt(6581) = "<tr><td>Timeseries</td>"
  txt(6582) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(6583) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(6584) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(6585) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(6586) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(6587) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_son.indmem.png","SON")+"</td>"
  txt(6588) = "<td>"+table_link_setup(OUTDIR,"pna_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(6709) = "<tr><td rowspan=2><b>NPO</b></td>"
  txt(6710) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_djf.indmem.png")) then
     txt(6711) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_djf"+quote+">DJF</a>" 
     txt(6712) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_djf"+quote+">"
     txt(6713) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6714) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(6715) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(6717) = "</ul></div></td>"
  else
     txt(6717) = "DJF</td>"
  end if

  txt(6720) = "<td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_jfm.indmem.png")) then
     txt(6721) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_jfm"+quote+">JFM</a>" 
     txt(6722) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_jfm"+quote+">"
     txt(6723) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6724) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(6725) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(6727) = "</ul></div></td>"
  else
     txt(6727) = "JFM</td>"
  end if

  txt(6730) = "<td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_mam.indmem.png")) then
     txt(6731) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_mam"+quote+">MAM</a>" 
     txt(6732) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_mam"+quote+">"
     txt(6733) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6734) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(6735) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(6737) = "</ul></div></td>"
  else
     txt(6737) = "MAM</td>"
  end if

  txt(6740) = "<td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_jja.indmem.png")) then
     txt(6741) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_jja"+quote+">JJA</a>" 
     txt(6742) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_jja"+quote+">"
     txt(6743) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6744) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(6745) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(6747) = "</ul></div></td>"
  else
     txt(6747) = "JJA</td>"
  end if

  txt(6750) = "<td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_jas.indmem.png")) then
     txt(6751) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_jas"+quote+">JAS</a>" 
     txt(6752) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_jas"+quote+">"
     txt(6753) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6754) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(6755) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(6757) = "</ul></div></td>"
  else
     txt(6757) = "JAS</td>"
  end if

  txt(6760) = "<td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_son.indmem.png")) then
     txt(6761) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_son"+quote+">SON</a>" 
     txt(6762) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_son"+quote+">"
     txt(6763) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6764) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_son.indmem.png","Indiv")+"</li>"
     txt(6765) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(6767) = "</ul></div></td>"
  else
     txt(6767) = "SON</td>"
  end if

  txt(6770) = "<td>"
  if (isfilepresent2(OUTDIR+"npo_pattern_ann.indmem.png")) then
     txt(6771) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#npo_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"npo_pattern_ann"+quote+">ANN</a>" 
     txt(6772) = "<div class="+quote+"collapse"+quote+" id="+quote+"npo_pattern_ann"+quote+">"
     txt(6773) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6774) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(6775) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"npo_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(6777) = "</ul></div></td></tr>"
  else
     txt(6777) = "ANN</td></tr>"
  end if
  txt(6781) = "<tr><td>Timeseries</td>"
  txt(6782) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(6783) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(6784) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(6785) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(6786) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(6787) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_son.indmem.png","SON")+"</td>"
  txt(6788) = "<td>"+table_link_setup(OUTDIR,"npo_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(6909) = "<tr><td rowspan=2><b>PSA1</b></td>"
  txt(6910) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_djf.indmem.png")) then
     txt(6911) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_djf"+quote+">DJF</a>" 
     txt(6912) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_djf"+quote+">"
     txt(6913) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6914) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(6915) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(6917) = "</ul></div></td>"
  else
     txt(6917) = "DJF</td>"
  end if

  txt(6920) = "<td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_jfm.indmem.png")) then
     txt(6921) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_jfm"+quote+">JFM</a>" 
     txt(6922) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_jfm"+quote+">"
     txt(6923) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6924) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(6925) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(6927) = "</ul></div></td>"
  else
     txt(6927) = "JFM</td>"
  end if

  txt(6930) = "<td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_mam.indmem.png")) then
     txt(6931) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_mam"+quote+">MAM</a>" 
     txt(6932) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_mam"+quote+">"
     txt(6933) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6934) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(6935) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(6937) = "</ul></div></td>"
  else
     txt(6937) = "MAM</td>"
  end if

  txt(6940) = "<td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_jja.indmem.png")) then
     txt(6941) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_jja"+quote+">JJA</a>" 
     txt(6942) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_jja"+quote+">"
     txt(6943) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6944) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(6945) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(6947) = "</ul></div></td>"
  else
     txt(6947) = "JJA</td>"
  end if

  txt(6950) = "<td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_jas.indmem.png")) then
     txt(6951) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_jas"+quote+">JAS</a>" 
     txt(6952) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_jas"+quote+">"
     txt(6953) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6954) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(6955) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(6957) = "</ul></div></td>"
  else
     txt(6957) = "JAS</td>"
  end if

  txt(6960) = "<td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_son.indmem.png")) then
     txt(6961) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_son"+quote+">SON</a>" 
     txt(6962) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_son"+quote+">"
     txt(6963) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6964) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_son.indmem.png","Indiv")+"</li>"
     txt(6965) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(6967) = "</ul></div></td>"
  else
     txt(6967) = "SON</td>"
  end if

  txt(6970) = "<td>"
  if (isfilepresent2(OUTDIR+"psa1_pattern_ann.indmem.png")) then
     txt(6971) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa1_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa1_pattern_ann"+quote+">ANN</a>" 
     txt(6972) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa1_pattern_ann"+quote+">"
     txt(6973) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(6974) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(6975) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa1_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(6977) = "</ul></div></td></tr>"
  else
     txt(6977) = "ANN</td></tr>"
  end if
  txt(6981) = "<tr><td>Timeseries</td>"
  txt(6982) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(6983) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(6984) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(6985) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(6986) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(6987) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_son.indmem.png","SON")+"</td>"
  txt(6988) = "<td>"+table_link_setup(OUTDIR,"psa1_timeseries_ann.indmem.png","ANN")+"</td></tr>"

  txt(7109) = "<tr><td rowspan=2><b>PSA2</b></td>"
  txt(7110) = "<td>Patterns</td><td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_djf.indmem.png")) then
     txt(7111) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_djf"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_djf"+quote+">DJF</a>" 
     txt(7112) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_djf"+quote+">"
     txt(7113) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7114) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_djf.indmem.png","Indiv")+"</li>"
     txt(7115) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_djf.indmemdiff.png","Bias")+"</li>"
     txt(7117) = "</ul></div></td>"
  else
     txt(7117) = "DJF</td>"
  end if

  txt(7120) = "<td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_jfm.indmem.png")) then
     txt(7121) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_jfm"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_jfm"+quote+">JFM</a>" 
     txt(7122) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_jfm"+quote+">"
     txt(7123) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7124) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_jfm.indmem.png","Indiv")+"</li>"
     txt(7125) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_jfm.indmemdiff.png","Bias")+"</li>"
     txt(7127) = "</ul></div></td>"
  else
     txt(7127) = "JFM</td>"
  end if

  txt(7130) = "<td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_mam.indmem.png")) then
     txt(7131) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_mam"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_mam"+quote+">MAM</a>" 
     txt(7132) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_mam"+quote+">"
     txt(7133) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7134) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_mam.indmem.png","Indiv")+"</li>"
     txt(7135) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_mam.indmemdiff.png","Bias")+"</li>"
     txt(7137) = "</ul></div></td>"
  else
     txt(7137) = "MAM</td>"
  end if

  txt(7140) = "<td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_jja.indmem.png")) then
     txt(7141) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_jja"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_jja"+quote+">JJA</a>" 
     txt(7142) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_jja"+quote+">"
     txt(7143) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7144) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_jja.indmem.png","Indiv")+"</li>"
     txt(7145) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_jja.indmemdiff.png","Bias")+"</li>"
     txt(7147) = "</ul></div></td>"
  else
     txt(7147) = "JJA</td>"
  end if

  txt(7150) = "<td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_jas.indmem.png")) then
     txt(7151) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_jas"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_jas"+quote+">JAS</a>" 
     txt(7152) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_jas"+quote+">"
     txt(7153) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7154) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_jas.indmem.png","Indiv")+"</li>"
     txt(7155) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_jas.indmemdiff.png","Bias")+"</li>"
     txt(7157) = "</ul></div></td>"
  else
     txt(7157) = "JAS</td>"
  end if

  txt(7160) = "<td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_son.indmem.png")) then
     txt(7161) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_son"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_son"+quote+">SON</a>" 
     txt(7162) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_son"+quote+">"
     txt(7163) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7164) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_son.indmem.png","Indiv")+"</li>"
     txt(7165) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_son.indmemdiff.png","Bias")+"</li>"
     txt(7167) = "</ul></div></td>"
  else
     txt(7167) = "SON</td>"
  end if

  txt(7170) = "<td>"
  if (isfilepresent2(OUTDIR+"psa2_pattern_ann.indmem.png")) then
     txt(7171) = "<a class="+quote+"collapse-link"+quote+" data-toggle="+quote+"collapse"+quote+" href="+quote+"#psa2_pattern_ann"+quote+" role="+quote+"button"+quote+" aria-expanded="+quote+"false"+quote+" aria-controls="+quote+"psa2_pattern_ann"+quote+">ANN</a>" 
     txt(7172) = "<div class="+quote+"collapse"+quote+" id="+quote+"psa2_pattern_ann"+quote+">"
     txt(7173) = "<ul class="+quote+"list-inline my-0"+quote+">"
     txt(7174) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_ann.indmem.png","Indiv")+"</li>"
     txt(7175) = "<li class="+quote+"list-inline-item"+quote+">"+table_link_setup_le(OUTDIR,"psa2_pattern_ann.indmemdiff.png","Bias")+"</li>"
     txt(7177) = "</ul></div></td></tr>"
  else
     txt(7177) = "ANN</td></tr>"
  end if
  txt(7181) = "<tr><td>Timeseries</td>"
  txt(7182) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_djf.indmem.png","DJF")+"</td>"
  txt(7183) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_jfm.indmem.png","JFM")+"</td>"
  txt(7184) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_mam.indmem.png","MAM")+"</td>"
  txt(7185) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_jja.indmem.png","JJA")+"</td>"
  txt(7186) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_jas.indmem.png","JAS")+"</td>"
  txt(7187) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_son.indmem.png","SON")+"</td>"
  txt(7188) = "<td>"+table_link_setup(OUTDIR,"psa2_timeseries_ann.indmem.png","ANN")+"</td></tr>"
  txt(7500) = "</table></div></div>"

  txt(16000) = "<div class="+quote+"row"+quote+">"
  txt(16001) = "<div class="+quote+"col"+quote+">"
  txt(16002) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(16003) = "<h3 class="+quote+"display-6"+quote+">Global Timeseries</h3>"

  txt(16010) = "<tr class="+quote+"d-flex"+quote+">"
  txt(16011) = "<td class="+quote+"col"+quote+"><b>SST</b></td>"
  txt(16012) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_djf.indmem.png","DJF")+"</td>"
  txt(16013) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_jfm.indmem.png","JFM")+"</td>"
  txt(16014) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_mam.indmem.png","MAM")+"</td>"
  txt(16015) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_jja.indmem.png","JJA")+"</td>"
  txt(16016) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_jas.indmem.png","JAS")+"</td>"
  txt(16017) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_son.indmem.png","SON")+"</td>"
  txt(16018) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"sst_global_avg_ann.indmem.png","ANN")+"</td>"
  txt(16019) = "</tr>"

  txt(16020) = "<tr class="+quote+"d-flex"+quote+">"
  txt(16021) = "<td class="+quote+"col"+quote+"><b>TAS</b></td>"
  txt(16022) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_djf.indmem.png","DJF")+"</td>"
  txt(16023) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_jfm.indmem.png","JFM")+"</td>"
  txt(16024) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_mam.indmem.png","MAM")+"</td>"
  txt(16025) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_jja.indmem.png","JJA")+"</td>"
  txt(16026) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_jas.indmem.png","JAS")+"</td>"
  txt(16027) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_son.indmem.png","SON")+"</td>"
  txt(16028) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tas_global_avg_ann.indmem.png","ANN")+"</td>"
  txt(16029) = "</tr>"

  txt(16040) = "<tr class="+quote+"d-flex"+quote+">"
  txt(16041) = "<td class="+quote+"col"+quote+"><b>PR</b></td>"
  txt(16042) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_djf.indmem.png","DJF")+"</td>"
  txt(16043) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_jfm.indmem.png","JFM")+"</td>"
  txt(16044) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_mam.indmem.png","MAM")+"</td>"
  txt(16045) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_jja.indmem.png","JJA")+"</td>"
  txt(16046) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_jas.indmem.png","JAS")+"</td>"
  txt(16047) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_son.indmem.png","SON")+"</td>"
  txt(16048) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_ann.indmem.png","ANN")+"</td>"
  txt(16049) = "</tr>"
  txt(16050) = "<tr class="+quote+"d-flex"+quote+">"
  txt(16051) = "<td class="+quote+"col"+quote+"><b>PR<br>(land-only)</b></td>"
  txt(16052) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_djf.indmem.png","DJF")+"</td>"
  txt(16053) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_jfm.indmem.png","JFM")+"</td>"
  txt(16054) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_mam.indmem.png","MAM")+"</td>"
  txt(16055) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_jja.indmem.png","JJA")+"</td>"
  txt(16056) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_jas.indmem.png","JAS")+"</td>"
  txt(16057) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_son.indmem.png","SON")+"</td>"
  txt(16058) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"pr_global_avg_land_ann.indmem.png","ANN")+"</td>"
  txt(16059) = "</tr>"
  txt(16077) = "</tr></table></div></div>"



  txt(18600) = "<div class="+quote+"row"+quote+">"
  txt(18601) = "<div class="+quote+"col"+quote+">"
  txt(18602) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(18603) = "<h3 class="+quote+"display-6"+quote+">Regional Timeseries</h3>"
  txt(18604) = "<tr class="+quote+"d-flex"+quote+">"
  txt(18605) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"atlantic_meridional_mode.timeseries.indmem.png","Atlantic SST Meridional Mode")+"</td>"
  txt(18606) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"atlantic_nino.timeseries.indmem.png","Atlantic Ni&ntilde;o SST")+"</td>"
  txt(18607) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_atlantic.timeseries.indmem.png","North Atlantic SST")+"</td>"
  txt(18608) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_tropical_atlantic.timeseries.indmem.png","Tropical North Atlantic SST")+"</td>"
  txt(18609) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"south_tropical_atlantic.timeseries.indmem.png","Tropical South Atlantic SST")+"</td></tr>"
  txt(18610) = "<tr class="+quote+"d-flex"+quote+"><td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino12.timeseries.indmem.png","ni&ntilde;o1+2 SST")+"</td>"
  txt(18617) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino3.timeseries.indmem.png","ni&ntilde;o3 SST")+"</td>"
  txt(18618) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino34.timeseries.indmem.png","ni&ntilde;o3.4 SST")+"</td>"
  txt(18619) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"nino4.timeseries.indmem.png","ni&ntilde;o4 SST")+"</td></tr>"
  txt(18620) = "<tr class="+quote+"d-flex"+quote+"><td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_pacific_index_ndjfm.indmem.png","North Pacific PSL Index (NPI)")+"</td>"
  txt(18621) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"north_pacific_meridional_mode.timeseries.indmem.png","North Pacific SST Meridional Mode")+"</td>"
  txt(18622) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"south_pacific_meridional_mode.timeseries.indmem.png","South Pacific SST Meridional Mode")+"</td></tr>"
  txt(18623) = "<tr class="+quote+"d-flex"+quote+"><td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"indian_ocean_dipole.timeseries.indmem.png","Indian Ocean SST Dipole")+"</td>"
  txt(18624) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"tropical_indian_ocean.timeseries.indmem.png","Tropical Indian Ocean SST")+"</td>"
  txt(18625) = "<td class="+quote+"col"+quote+">"+table_link_setup(OUTDIR,"southern_ocean.timeseries.indmem.png","Southern Ocean SST")+"</td></tr>"
  txt(18626) = "</table></div></div>"

  txt(18700) = "<div class="+quote+"row"+quote+">"
  txt(18701) = "<div class="+quote+"col"+quote+">"
  txt(18702) = "<table class="+quote+"table table-striped table-bordered"+quote+">"
  txt(18703) = "<h3 class="+quote+"display-6"+quote+">Sea Ice Extent Timeseries</h3>"
  txt(18705) = "<tr><td rowspan=2><b>NH</b></td>"
  txt(18706) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_djf.indmem.png","DJF")+"</td>"
  txt(18707) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_jfm.indmem.png","JFM")+"</td>"
  txt(18708) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_mam.indmem.png","MAM")+"</td>"
  txt(18709) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_jja.indmem.png","JJA")+"</td>"
  txt(18710) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_jas.indmem.png","JAS")+"</td>"
  txt(18711) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_son.indmem.png","SON")+"</td>"
  txt(18712) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_ann.indmem.png","ANN")+"</td></tr>"
  txt(18716) = "<tr><td>"+table_link_setup(OUTDIR,"siconc_nh_extent_feb.indmem.png","Feb")+"</td>"
  txt(18717) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_mar.indmem.png","Mar")+"</td>"
  txt(18718) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_sep.indmem.png","Sep")+"</td>"
  txt(18719) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_oct.indmem.png","Oct")+"</td>"
  txt(18720) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_mon.indmem.png","Monthly")+"</td>"
  txt(18721) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent_anom_mon.indmem.png","Monthly Anomalies")+"</td>"
  txt(18722) = "<td>"+table_link_setup(OUTDIR,"siconc_nh_extent.climo.indmem.png","Climatology")+"</td></tr>"
  txt(18725) = "<tr><td rowspan=2><b>SH</b></td>"
  txt(18726) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_djf.indmem.png","DJF")+"</td>"
  txt(18727) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_jfm.indmem.png","JFM")+"</td>"
  txt(18728) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_mam.indmem.png","MAM")+"</td>"
  txt(18729) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_jja.indmem.png","JJA")+"</td>"
  txt(18730) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_jas.indmem.png","JAS")+"</td>"
  txt(18731) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_son.indmem.png","SON")+"</td>"
  txt(18732) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_ann.indmem.png","ANN")+"</td></tr>"
  txt(18736) = "<tr><td>"+table_link_setup(OUTDIR,"siconc_sh_extent_feb.indmem.png","Feb")+"</td>"
  txt(18737) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_mar.indmem.png","Mar")+"</td>"
  txt(18738) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_sep.indmem.png","Sep")+"</td>"
  txt(18739) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_oct.indmem.png","Oct")+"</td>"
  txt(18740) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_mon.indmem.png","Monthly")+"</td>"
  txt(18741) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent_anom_mon.indmem.png","Monthly Anomalies")+"</td>"
  txt(18742) = "<td>"+table_link_setup(OUTDIR,"siconc_sh_extent.climo.indmem.png","Climatology")+"</td></tr>"
  txt(18743) = "</table></div></div>"

  txt(19000) = "</div></body></html>"

  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  tt2 := ind(.not.ismissing(txt2))
  txt3 := txt2(tt2)
  asciiwrite(OUTDIR+"index2.html",txt3)
  delete([/txt,tt,tt2,txt2,txt3/])
;----------------------------------------------------------------------------
; Namelist pages
  txt := new(500,"string")  
  
  txt(0) = "<HTML><HEAD><TITLE>Climate Variability Diagnostics Package</TITLE><STYLE>"
  txt(1) = "body {background-color: WhiteSmoke; font-family: Verdana, Geneva, sans-serif}"
  txt(2) = "img.title {width:990; height:105; align:left}"
  txt(3) = "p.subtitle1 {font-size:20pt; color:darkgray}"
  txt(4) = "p.subtitle {font-size:20pt; color:black; text-align:center; font-weight:bold}"
  txt(5) = "p.btext {font-size:12pt; text-align:left}"
  txt(6) = "p.btext2 {font-size:9pt; text-align:left}"
  txt(7) = "p.c {font-size:9pt; text-align:left, white-space:pre}"
  txt(9) = "td.s1 {text-align:left; font-size:11pt}"
  
  txt(20) = "td {text-align:center; font-size:12pt}"
  txt(21) = "td.s1 {text-align:left; font-size:11pt}"
  txt(22) = "td.tablehdr {text-align:center; font-size:17pt}"
  txt(23) = "CAPTION {text-align:left; font-size:14pt; font-weight:bold}"
  txt(24) = "</STYLE></HEAD><BODY>"
  txt(25) = "<img class="+quote+"img-fluid"+quote+" src="+quote+"cas_cvdp-le.png"+quote+" alt="+quote+"CVDP-LE logo"+quote+">"
  txt(26)= "<TABLE width='990' border=0 cellpadding=6>"
  txt(27) = "<tr><td width='30'><p class=btext>Go to:</p></td><td class=s1 width='380'><a href="+quote+"http://dx.doi.org/10.5065/h7c7-f961"+quote+">User's Guide</a><br><a href="+quote+"index.html"+quote+">Diagnostics Plots</a><br><hr>"

  txt(28) = "Input Namelists: <b>Observations</b> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
;  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><p class=subtitle>"+webtitle+"</p></td></tr></table><hr width=990 align=left>"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Input Namelist: Observations</p>" 
  z := asciiread(OUTDIR+"namelist_obs",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_obs.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <b>Simulations</b><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Input Namelist: Simulations</p>" 
  z := asciiread(OUTDIR+"namelist",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_simulations.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <b>MSFTMZ</b> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: MSFTMZ</p>" 
  z := asciiread(OUTDIR+"namelist_moc",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_msftmz.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <b>PR</b> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: PR</p>" 
  z := asciiread(OUTDIR+"namelist_prect",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_pr.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <b>PSL</b> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: PSL</p>" 
  z := asciiread(OUTDIR+"namelist_psl",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_psl.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><b>SICONC NH</b> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: SICONC NH</p>" 
  z := asciiread(OUTDIR+"namelist_aice_nh",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_siconc_nh.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <b>SICONC SH</b> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: SICONC SH</p>" 
  z := asciiread(OUTDIR+"namelist_aice_sh",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_siconc_sh.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <b>TAS</b> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: TAS</p>" 
  z := asciiread(OUTDIR+"namelist_trefht",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_tas.html",txt2)

  txt(28) = "Input Namelists: <a href="+quote+"namelist_obs.html"+quote+">Observations</a> | <a href="+quote+"namelist_simulations.html"+quote+">Simulations</a><br>"
  txt(29) = "Derived Namelists: <a href="+quote+"namelist_msftmz.html"+quote+">MSFTMZ</a> | <a href="+quote+"namelist_pr.html"+quote+">PR</a> | <a href="+quote+"namelist_psl.html"+quote+">PSL</a> | "
  txt(30) = "<br><a href="+quote+"namelist_siconc_nh.html"+quote+">SICONC NH</a> | <a href="+quote+"namelist_siconc_sh.html"+quote+">SICONC SH</a> | <a href="+quote+"namelist_tas.html"+quote+">TAS</a> |"
  txt(31) = "<a href="+quote+"namelist_ts.html"+quote+">TS</a></td><td><h2 class="+quote+"text-center"+quote+">"+webtitle+"</h2></td></tr></table><hr width=990 align=left>"
  txt(32) = "<p class=subtitle1>Derived Namelist: TS</p>" 
  z := asciiread(OUTDIR+"namelist_ts",(/-1/),"string")
  nlines = dimsizes(z)
  txt(33) = "<p class=c>"
  do gg = 0,nlines-1
     txt(33+gg) = z(gg)+"<br>"
  end do
  txt(34+nlines) = "</p>"
  txt(34+nlines+1) = "Created "+systemfunc("date")
  txt(34+nlines+2) = "<p class=btext2>CVDP-LE Version "+VERSION+"</p></body></html>"
  tt := ind(.not.ismissing(txt))
  txt2 := txt(:tt(dimsizes(tt)-1)+1)
  txt2 = where(ismissing(txt2),"",txt2)
  asciiwrite(OUTDIR+"namelist_ts.html",txt2)

  print("Finished: webpage.ncl")  
end

