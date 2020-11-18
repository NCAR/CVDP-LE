; Calculates PDV, PDV' and regressions onto those indices.
;
; Variables used: ts, tas, pr
;
load "$CVDP_SCRIPTS/functions.ncl"

begin
  print("Starting: pdv.ncl")
  CREATE_GRAPHICS  = getenv("CREATE_GRAPHICS")  
  PNG_SCALE        = tofloat(getenv("PNG_SCALE"))
  OUTPUT_TYPE      = getenv("OUTPUT_TYPE") 
  COLORMAP         = getenv("COLORMAP")
  OUTDIR           = getenv("OUTDIR") 
  PNG_SCALE_SUMMARY = tofloat(getenv("PNG_SCALE_SUMMARY"))

  pi=4.*atan(1.0)
  rad=(pi/180.)
  
  nsim = numAsciiRow("namelist_byvar/namelist_ts")

  na = asciiread("namelist_byvar/namelist_ts",(/nsim/),"string")
  names = new(nsim,"string")
  paths = new(nsim,"string")
  syear = new(nsim,"integer",-999)
  eyear = new(nsim,"integer",-999)
  names_EM = new(nsim,"string")
  EM_num = new(nsim,"integer",-999)
  delim = "|"

  do gg = 0,nsim-1
     names(gg) = str_strip(str_get_field(na(gg),1,delim))
     paths(gg) = str_strip(str_get_field(na(gg),2,delim))
     syear(gg) = stringtointeger(str_strip(str_get_field(na(gg),3,delim)))
     eyear(gg) = stringtointeger(str_strip(str_get_field(na(gg),4,delim)))
     temp      = str_split(str_strip(str_get_field(na(gg),5,delim)),"-")
     EM_num(gg)    = toint(temp(0))
     names_EM(gg)  = str_join(temp(1:),"-")
     delete(temp)
  end do
  modname = str_sub_str(names," ","_")
  bc = (/"/","'","(",")"/)
  do ff = 0,dimsizes(modname)-1
     do gg = 0,dimsizes(bc)-1
        modname(ff) = str_sub_str(modname(ff),bc(gg),"_")
     end do
  end do
  nyr = eyear-syear+1
  
  numobs = num(EM_num.eq.0) 
  nEM = max(EM_num)
;-------TAS variable metadata------------------------------------
  nsim_tas = numAsciiRow("namelist_byvar/namelist_trefht")
  na_tas = asciiread("namelist_byvar/namelist_trefht",(/nsim_tas/),"string")
  names_tas = new(nsim_tas,"string")
  paths_tas = new(nsim_tas,"string")
  syear_tas = new(nsim_tas,"integer",-999)
  eyear_tas = new(nsim_tas,"integer",-999)

  do gg = 0,nsim_tas-1
     names_tas(gg) = str_strip(str_get_field(na_tas(gg),1,delim))
     paths_tas(gg) = str_strip(str_get_field(na_tas(gg),2,delim))
     syear_tas(gg) = stringtointeger(str_strip(str_get_field(na_tas(gg),3,delim)))
     eyear_tas(gg) = stringtointeger(str_strip(str_get_field(na_tas(gg),4,delim)))
  end do
  modname_tas = str_sub_str(names_tas," ","_")
  do ff = 0,dimsizes(modname_tas)-1
     do gg = 0,dimsizes(bc)-1
        modname_tas(ff) = str_sub_str(modname_tas(ff),bc(gg),"_")
     end do
  end do
  delete(na_tas)
  nyr_tas = eyear_tas-syear_tas+1  
;---------PR variable metadata------------------------------------------------------------
  nsim_pr = numAsciiRow("namelist_byvar/namelist_prect")
  na_pr = asciiread("namelist_byvar/namelist_prect",(/nsim_pr/),"string")
  names_pr = new(nsim_pr,"string")
  paths_pr = new(nsim_pr,"string")
  syear_pr = new(nsim_pr,"integer",-999)
  eyear_pr = new(nsim_pr,"integer",-999)

  do gg = 0,nsim_pr-1
     names_pr(gg) = str_strip(str_get_field(na_pr(gg),1,delim))
     paths_pr(gg) = str_strip(str_get_field(na_pr(gg),2,delim))
     syear_pr(gg) = stringtointeger(str_strip(str_get_field(na_pr(gg),3,delim)))
     eyear_pr(gg) = stringtointeger(str_strip(str_get_field(na_pr(gg),4,delim)))
  end do
  modname_pr = str_sub_str(names_pr," ","_")
  do ff = 0,dimsizes(modname_pr)-1
     do gg = 0,dimsizes(bc)-1
        modname_pr(ff) = str_sub_str(modname_pr(ff),bc(gg),"_")
     end do
  end do
  delete(na_pr)
  nyr_pr = eyear_pr-syear_pr+1  

  iopt = 1    ; spectra settings, iopt = 1 results in input timeseries being detrended
  val1 = .95
  val2 = .99
  pct = 0.1   
;-------------------------------------------------------------------------------
  d = addfile("$NCARG_ROOT/lib/ncarg/data/cdf/landsea.nc","r")   ; mask out land (this is redundant for data that is already masked)

  do gg = 0,numobs-1    ; compute PDV and PDV for observations
     fnt = getenv("OUTDIR")+modname(gg)+".cvdp_data.pdv."+syear(gg)+"-"+eyear(gg)+".nc"
     fnt2 = getenv("OUTDIR")+modname(gg)+".cvdp_data."+syear(gg)+"-"+eyear(gg)+".nc"
     f_test := read_cvdp_le_data(fnt,fnt2,"pdv_pattern_mon")
     if (.not.isatt(f_test,"is_all_missing")) then
        continue
     end if
     arr = data_read_in(paths(gg),"TS",syear(gg),eyear(gg))    ; read in data, orient lats/lons correctly, set time coordinate variable up
     if (isatt(arr,"is_all_missing")) then
        delete(arr)
        continue
     end if 
     arr = where(arr.le.-1.8,-1.8,arr)    ; set all values below -1.8 to -1.8
     arr = mask(arr,conform(arr,landsea_mask(d->LSMASK,arr&lat,arr&lon),(/1,2/)).ge.1,False)

     arr = rmMonAnnCycTLL(arr) 

     coswgt    := cos(rad*arr&lat)
     coswgt!0   = "lat"
     coswgt&lat = arr&lat

     do ii = 0,dimsizes(arr&time)-1
        arr(ii,:,:) = (/ arr(ii,:,:) - wgt_areaave(arr(ii,{-60:70},:),coswgt({-60.:70.}),1.0,0) /)
     end do
     delete(coswgt)
     arr_CW = SqrtCosWeight(arr(time|:,lat|:,lon|:))
  
     evecv = eofunc(arr_CW({lat|20:70},{lon|110:260},time|:),2,75)
     pcts = eofunc_ts_n(arr_CW(:,{20:70},{110:260}),evecv,False,0)
     pc1 = dim_standardize(pcts(0,:),0)
     pc1!0 = "time"
     pc1&time = arr&time
     pc1@units = "1"
     finarr = regCoef_n(pc1,arr,0,0)
     copy_VarMeta(arr(0,:,:),finarr)
     sig_pcv = eofunc_north2(evecv@pcvar,dimsizes(pc1),False)
     if (sig_pcv(0)) then    ; if True then significant
        finarr@pcvar = tofloat(sprintf("%4.1f", evecv@pcvar(0)))+"%*"
     else
        finarr@pcvar = tofloat(sprintf("%4.1f", evecv@pcvar(0)))+"%"
     end if
     delete([/pcts,evecv,arr_CW,arr/])
     if (.not.ismissing(finarr({57},{220}))) then
        if (finarr({57},{220}).lt.0) then   ; arbitrary attempt to make all plots have the same sign..
           finarr = finarr*-1.
           pc1 = pc1*-1.
        end if
     end if

     plot_flag := check_years_match(syear(gg),syear_tas(gg),eyear(gg),eyear_tas(gg))
     if (plot_flag.eq.0) then   ; no separate check needed if pdv_tas_regression_mon is already there, as needs to be done at same time as creation of pdv
        tas := data_read_in(paths_tas(gg),"TREFHT",syear_tas(gg),eyear_tas(gg))
        tas = mask(tas,conform(tas,landsea_mask(d->LSMASK,tas&lat,tas&lon),(/1,2/)).eq.0,False)
        if (.not.isatt(tas,"is_all_missing")) then
           tas = rmMonAnnCycTLL(tas) 
           fintas = (/ regCoef_n(pc1,tas,0,0) /)
           copy_VarMeta(tas(0,:,:),fintas)
           fnt_tas = getenv("OUTDIR")+modname_tas(gg)+".cvdp_data.pdv.tas."+syear_tas(gg)+"-"+eyear_tas(gg)+".nc"
           if (isfilepresent2(fnt_tas)) then
               z_arr = addfile(fnt_tas,"w")
            else
               z_arr = addfile(fnt_tas,"c")
            end if
            set_global_ncfile_attributes(z_arr,names_tas(gg),syear_tas(gg),eyear_tas(gg),getenv("VERSION"))
            z_arr->pdv_tas_regression_mon = set_varAtts(fintas,"tas regression onto PDV timeseries (monthly)","","")
            delete([/z_arr,fintas,fnt_tas/])
        end if
        delete(tas)
     end if
     plot_flag := check_years_match(syear(gg),syear_pr(gg),eyear(gg),eyear_pr(gg))
     if (plot_flag.eq.0) then   ; no separate check needed if pdv_pr_regression_mon is already there, as needs to be done at same time as creation of pdv
        pr := data_read_in(paths_pr(gg),"PRECT",syear_pr(gg),eyear_pr(gg))
        if (.not.isatt(pr,"is_all_missing")) then
           pr = rmMonAnnCycTLL(pr) 
           finpr = (/ regCoef_n(pc1,pr,0,0) /)
           copy_VarMeta(pr(0,:,:),finpr)
           fnt_pr = getenv("OUTDIR")+modname_pr(gg)+".cvdp_data.pdv.pr."+syear_pr(gg)+"-"+eyear_pr(gg)+".nc"
           if (isfilepresent2(fnt_pr)) then
               z_arr = addfile(fnt_pr,"w")
            else
               z_arr = addfile(fnt_pr,"c")
            end if
            set_global_ncfile_attributes(z_arr,names_pr(gg),syear_pr(gg),eyear_pr(gg),getenv("VERSION"))
            z_arr->pdv_pr_regression_mon = set_varAtts(finpr,"pr regression onto PDV timeseries (monthly)","","")
            delete([/z_arr,finpr,fnt_pr/])
        end if
        delete(pr)
     end if

     jave = (7*nyr(gg))/100
     jave = where(jave.eq.0,1,jave)
     z = addfile(fnt,"c")
     set_global_ncfile_attributes(z,names(gg),syear(gg),eyear(gg),getenv("VERSION"))
     z->pdv_pattern_mon = set_varAtts(finarr,"PDV regression pattern (monthly)","","")   ; flip longitudes back to running from 0:360.
     z->pdv_timeseries_mon = set_varAtts(pc1,"PDV timeseries (monthly)","","")
     if (.not.any(ismissing(pc1))) then
        splt1 := create_power_spectra(pc1,iopt,jave,pct,val1,val2)
        z->pdv_spectra = set_varAtts(splt1,"PDV (monthly) power spectra, Markov spectrum and confidence curves","","") 
     end if
     delete([/z,finarr,pc1/])
  end do

  do gg = 1,nEM   ; operate on each ensemble mean
     nens = num(EM_num.eq.gg) ; determines how many model simulations in each ensemble
     cntr_ens := ind(EM_num.eq.gg)   ; cntr_ens(hh) are the indices where each ensemble member of an ensemble reside 
     do hh = 0,nens-1   ; compute PDV for model simulations
        modname_mod = modname(cntr_ens(hh))
        syear_mod = syear(cntr_ens(hh))
        eyear_mod = eyear(cntr_ens(hh))
        names_mod = names(cntr_ens(hh))
        names_EM_mod = names_EM(cntr_ens(hh))
        paths_mod = paths(cntr_ens(hh))
        data_flag = False
 
        fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
        fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
        f_test := read_cvdp_le_data(fnt,fnt2,"pdv_pattern_mon")
        if (.not.isatt(f_test,"is_all_missing")) then
           data_flag = True    ; data is present, but need raw data to compute EM
        else
           data_flag = False   
        end if
        arr = data_read_in(paths_mod,"TS",syear_mod,eyear_mod)    ; read in data, orient lats/lons correctly, set time coordinate variable up
        if (isatt(arr,"is_all_missing")) then
           delete(arr)
           continue
        end if

        arr = where(arr.le.-1.8,-1.8,arr)    ; set all values below -1.8 to -1.8
        arr = mask(arr,conform(arr,landsea_mask(d->LSMASK,arr&lat,arr&lon),(/1,2/)).ge.1,False)

        arr = rmMonAnnCycTLL(arr) 
        if (.not.isvar("arr_EM")) then    ; create an array to house all members, to be used to calculate EM
           arr_EM = arr
           arr_EM = 0.
           cntr_EM = 0
        end if
        arr_EM = (/ arr_EM+arr /)
        cntr_EM = cntr_EM+1

        if (data_flag) then
           delete(arr)
           continue    ; data added to EM, have already computed PDV, so continue to next loop iteration
        end if

        coswgt    := cos(rad*arr&lat)
        coswgt!0   = "lat"
        coswgt&lat = arr&lat

        do ii = 0,dimsizes(arr&time)-1
           arr(ii,:,:) = (/ arr(ii,:,:) - wgt_areaave(arr(ii,{-60:70},:),coswgt({-60.:70.}),1.0,0) /)
        end do
        delete(coswgt)
        arr_CW = SqrtCosWeight(arr(time|:,lat|:,lon|:))
  
        evecv = eofunc(arr_CW({lat|20:70},{lon|110:260},time|:),2,75)
        pcts = eofunc_ts_n(arr_CW(:,{20:70},{110:260}),evecv,False,0)
        pc1 = dim_standardize(pcts(0,:),0)
        pc1!0 = "time"
        pc1&time = arr&time
        pc1@units = "1"
        finarr = regCoef_n(pc1,arr,0,0)
        copy_VarMeta(arr(0,:,:),finarr)
        sig_pcv = eofunc_north2(evecv@pcvar,dimsizes(pc1),False)
        if (sig_pcv(0)) then    ; if True then significant
           finarr@pcvar = tofloat(sprintf("%4.1f", evecv@pcvar(0)))+"%*"
        else
           finarr@pcvar = tofloat(sprintf("%4.1f", evecv@pcvar(0)))+"%"
        end if
        delete([/pcts,evecv,arr_CW,arr/])
        if (.not.ismissing(finarr({57},{220}))) then
           if (finarr({57},{220}).lt.0) then   ; arbitrary attempt to make all plots have the same sign..
              finarr = finarr*-1.
              pc1 = pc1*-1.
           end if
        end if

        plot_flag := check_years_match(syear(cntr_ens(hh)),syear_tas(cntr_ens(hh)),eyear(cntr_ens(hh)),eyear_tas(cntr_ens(hh)))
        if (plot_flag.eq.0) then   ; no separate check needed if pdv_tas_regression_mon is already there, as needs to be done at same time as creation of pdv
           tas := data_read_in(paths_tas(cntr_ens(hh)),"TREFHT",syear_tas(cntr_ens(hh)),eyear_tas(cntr_ens(hh)))
           tas = mask(tas,conform(tas,landsea_mask(d->LSMASK,tas&lat,tas&lon),(/1,2/)).eq.0,False)
           if (.not.isatt(tas,"is_all_missing")) then
              tas = rmMonAnnCycTLL(tas) 
              if (.not.isvar("tas_EM")) then    ; create an array to house all members, to be used to calculate EM
                 tas_EM = tas
                 tas_EM = 0.
                 cntr_tas_EM = 0
              end if
              tas_EM = (/ tas_EM+tas /)
              cntr_tas_EM = cntr_tas_EM+1
              fintas = (/ regCoef_n(pc1,tas,0,0) /)
              copy_VarMeta(tas(0,:,:),fintas)
              fnt_tas = getenv("OUTDIR")+modname_tas(cntr_ens(hh))+".cvdp_data.pdv.tas."+syear_tas(cntr_ens(hh))+"-"+eyear_tas(cntr_ens(hh))+".nc"
              if (isfilepresent2(fnt_tas)) then
                 z_arr = addfile(fnt_tas,"w")
              else
                 z_arr = addfile(fnt_tas,"c")
              end if
              set_global_ncfile_attributes(z_arr,names_tas(cntr_ens(hh)),syear_tas(cntr_ens(hh)),eyear_tas(cntr_ens(hh)),getenv("VERSION"))
              z_arr->pdv_tas_regression_mon = set_varAtts(fintas,"tas regression onto PDV timeseries (monthly)","","")
              delete([/z_arr,fintas,fnt_tas/])
           end if
           delete(tas)
        end if
        plot_flag := check_years_match(syear(cntr_ens(hh)),syear_pr(cntr_ens(hh)),eyear(cntr_ens(hh)),eyear_pr(cntr_ens(hh)))
        if (plot_flag.eq.0) then   ; no separate check needed if pdv_pr_regression_mon is already there, as needs to be done at same time as creation of pdv
           pr := data_read_in(paths_pr(cntr_ens(hh)),"PRECT",syear_pr(cntr_ens(hh)),eyear_pr(cntr_ens(hh)))
           if (.not.isatt(pr,"is_all_missing")) then
              pr = rmMonAnnCycTLL(pr) 
              if (.not.isvar("pr_EM")) then    ; create an array to house all members, to be used to calculate EM
                 pr_EM = pr
                 pr_EM = 0.
                 cntr_pr_EM = 0
              end if
              pr_EM = (/ pr_EM+pr /)
              cntr_pr_EM = cntr_pr_EM+1

              finpr = (/ regCoef_n(pc1,pr,0,0) /)
              copy_VarMeta(pr(0,:,:),finpr)
              fnt_pr = getenv("OUTDIR")+modname_pr(cntr_ens(hh))+".cvdp_data.pdv.pr."+syear_pr(cntr_ens(hh))+"-"+eyear_pr(cntr_ens(hh))+".nc"
              if (isfilepresent2(fnt_pr)) then
                 z_arr = addfile(fnt_pr,"w")
              else
                 z_arr = addfile(fnt_pr,"c")
              end if
              set_global_ncfile_attributes(z_arr,names_pr(cntr_ens(hh)),syear_pr(cntr_ens(hh)),eyear_pr(cntr_ens(hh)),getenv("VERSION"))
              z_arr->pdv_pr_regression_mon = set_varAtts(finpr,"pr regression onto PDV timeseries (monthly)","","")
              delete([/z_arr,finpr,fnt_pr/])
           end if
           delete(pr)
        end if

        jave = (7*(eyear_mod-syear_mod+1))/100
        jave = where(jave.eq.0,1,jave)
        z = addfile(fnt,"c")
        set_global_ncfile_attributes(z,names_mod,syear_mod,eyear_mod,getenv("VERSION"))
        z->pdv_pattern_mon = set_varAtts(finarr,"PDV regression pattern (monthly)","","")   ; flip longitudes back to running from 0:360.
        z->pdv_timeseries_mon = set_varAtts(pc1,"PDV timeseries (monthly)","","")
        if (.not.any(ismissing(pc1))) then
           splt1 := create_power_spectra(pc1,iopt,jave,pct,val1,val2)
           z->pdv_spectra = set_varAtts(splt1,"PDV (monthly) power spectra, Markov spectrum and confidence curves","","") 
        end if
        delete([/z,finarr,pc1/])
     end do
     if (isvar("arr_EM")) then
        arr_EM = (/ arr_EM/cntr_EM /)
     end if
     if (isvar("tas_EM")) then
        tas_EM = (/ tas_EM/cntr_tas_EM /)
     end if
     if (isvar("pr_EM")) then
        pr_EM = (/ pr_EM/cntr_pr_EM /)
     end if

     do hh = 0,nens-1    ; do same exact loop again, but this time subtract the ensemble mean at each timestep.
        if (.not.isvar("cntr_EM").or.cntr_EM.le.1) then
           continue
        end if
        modname_mod = modname(cntr_ens(hh))
        syear_mod = syear(cntr_ens(hh))
        eyear_mod = eyear(cntr_ens(hh))
        names_mod = names(cntr_ens(hh))
        names_EM_mod = names_EM(cntr_ens(hh))
        paths_mod = paths(cntr_ens(hh))
 
        fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
        fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
        f_test := read_cvdp_le_data(fnt,fnt2,"pdv_prime_pattern_mon")
        if (.not.isatt(f_test,"is_all_missing")) then
           continue
        end if

        arr = data_read_in(paths_mod,"TS",syear_mod,eyear_mod)    ; read in data, orient lats/lons correctly, set time coordinate variable up
        if (isatt(arr,"is_all_missing")) then
           delete(arr)
           continue
        end if 
        arr = where(arr.le.-1.8,-1.8,arr)    ; set all values below -1.8 to -1.8
        arr = mask(arr,conform(arr,landsea_mask(d->LSMASK,arr&lat,arr&lon),(/1,2/)).ge.1,False)

        arr = rmMonAnnCycTLL(arr) 

        arr = (/ arr - arr_EM /)   ; subtract the ensemble mean at each grid point at each timestep

        coswgt    := cos(rad*arr&lat)
        coswgt!0   = "lat"
        coswgt&lat = arr&lat
        do ii = 0,dimsizes(arr&time)-1
           arr(ii,:,:) = (/ arr(ii,:,:) - wgt_areaave(arr(ii,{-60:70},:),coswgt({-60.:70.}),1.0,0) /)
        end do
        delete(coswgt)
        arr_CW = SqrtCosWeight(arr(time|:,lat|:,lon|:))
  
        evecv = eofunc(arr_CW({lat|20:70},{lon|110:260},time|:),2,75)
        pcts = eofunc_ts_n(arr_CW(:,{20:70},{110:260}),evecv,False,0)
        pc1 = dim_standardize(pcts(0,:),0)
        pc1!0 = "time"
        pc1&time = arr&time
        pc1@units = "1"
        finarr = regCoef_n(pc1,arr,0,0)
        copy_VarMeta(arr(0,:,:),finarr)
        sig_pcv = eofunc_north2(evecv@pcvar,dimsizes(pc1),False)
        if (sig_pcv(0)) then    ; if True then significant
           finarr@pcvar = tofloat(sprintf("%4.1f", evecv@pcvar(0)))+"%*"
        else
           finarr@pcvar = tofloat(sprintf("%4.1f", evecv@pcvar(0)))+"%"
        end if
        delete([/pcts,evecv,arr_CW,arr/])
        if (.not.ismissing(finarr({57},{220}))) then
           if (finarr({57},{220}).lt.0) then   ; arbitrary attempt to make all plots have the same sign..
              finarr = finarr*-1.
              pc1 = pc1*-1.
           end if
        end if

        plot_flag := check_years_match(syear(cntr_ens(hh)),syear_tas(cntr_ens(hh)),eyear(cntr_ens(hh)),eyear_tas(cntr_ens(hh)))
        if (plot_flag.eq.0) then   ; no separate check needed if pdv_tas_regression_mon is already there, as needs to be done at same time as creation of pdv
           tas := data_read_in(paths_tas(cntr_ens(hh)),"TREFHT",syear_tas(cntr_ens(hh)),eyear_tas(cntr_ens(hh)))
           tas = mask(tas,conform(tas,landsea_mask(d->LSMASK,tas&lat,tas&lon),(/1,2/)).eq.0,False)
           if (.not.isatt(tas,"is_all_missing").and.isvar("tas_EM")) then
              tas = rmMonAnnCycTLL(tas) 
              tas = (/ tas - tas_EM /)   ; subtract the ensemble mean at each grid point at each timestep
              fintas = (/ regCoef_n(pc1,tas,0,0) /)
              copy_VarMeta(tas(0,:,:),fintas)
              fnt_tas = getenv("OUTDIR")+modname_tas(cntr_ens(hh))+".cvdp_data.pdv.tas."+syear_tas(cntr_ens(hh))+"-"+eyear_tas(cntr_ens(hh))+".nc"
              if (isfilepresent2(fnt_tas)) then
                 z_arr = addfile(fnt_tas,"w")
              else
                 z_arr = addfile(fnt_tas,"c")
              end if
              set_global_ncfile_attributes(z_arr,names_tas(cntr_ens(hh)),syear_tas(cntr_ens(hh)),eyear_tas(cntr_ens(hh)),getenv("VERSION"))
              z_arr->pdv_prime_tas_regression_mon = set_varAtts(fintas,"tas prime regression onto PDV prime timeseries (monthly)","","")
              delete([/z_arr,fintas,fnt_tas/])
           end if
           delete(tas)
        end if
        plot_flag := check_years_match(syear(cntr_ens(hh)),syear_pr(cntr_ens(hh)),eyear(cntr_ens(hh)),eyear_pr(cntr_ens(hh)))
        if (plot_flag.eq.0) then   ; no separate check needed if pdv_pr_regression_mon is already there, as needs to be done at same time as creation of pdv
           pr := data_read_in(paths_pr(cntr_ens(hh)),"PRECT",syear_pr(cntr_ens(hh)),eyear_pr(cntr_ens(hh)))
           if (.not.isatt(pr,"is_all_missing").and.isvar("pr_EM")) then
              pr = rmMonAnnCycTLL(pr) 
              pr = (/ pr - pr_EM /)   ; subtract the ensemble mean at each grid point at each timestep

              finpr = (/ regCoef_n(pc1,pr,0,0) /)
              copy_VarMeta(pr(0,:,:),finpr)
              fnt_pr = getenv("OUTDIR")+modname_pr(cntr_ens(hh))+".cvdp_data.pdv.pr."+syear_pr(cntr_ens(hh))+"-"+eyear_pr(cntr_ens(hh))+".nc"
              if (isfilepresent2(fnt_pr)) then
                 z_arr = addfile(fnt_pr,"w")
              else
                 z_arr = addfile(fnt_pr,"c")
              end if
              set_global_ncfile_attributes(z_arr,names_pr(cntr_ens(hh)),syear_pr(cntr_ens(hh)),eyear_pr(cntr_ens(hh)),getenv("VERSION"))
              z_arr->pdv_prime_pr_regression_mon = set_varAtts(finpr,"pr regression onto PDV low-pass timeseries (monthly)","","")
              delete([/z_arr,finpr,fnt_pr/])
           end if
           delete(pr)
        end if

        jave = (7*(eyear_mod-syear_mod+1))/100
        jave = where(jave.eq.0,1,jave)
        if (isfilepresent2(fnt)) then
           z = addfile(fnt,"w")
        else
           z = addfile(fnt,"c")
        end if
        set_global_ncfile_attributes(z,names_mod,syear_mod,eyear_mod,getenv("VERSION"))
        z->pdv_prime_pattern_mon = set_varAtts(finarr,"PDV' regression pattern (monthly)","","")   ; flip longitudes back to running from 0:360.
        z->pdv_prime_timeseries_mon = set_varAtts(pc1,"PDV' timeseries (monthly)","C","")
        if (.not.any(ismissing(pc1))) then
           splt1 := create_power_spectra(pc1,iopt,jave,pct,val1,val2)
           z->pdv_prime_spectra = set_varAtts(splt1,"PDV' (monthly) power spectra, Markov spectrum and confidence curves","","") 
        end if
        delete([/z,finarr,pc1/])
     end do
     if (isvar("arr_EM")) then
        delete([/arr_EM,cntr_EM/])
     end if
     if (isvar("tas_EM")) then
        delete([/tas_EM,cntr_tas_EM/])
     end if
     if (isvar("pr_EM")) then
        delete([/pr_EM,cntr_pr_EM/])
     end if
  end do
  if (CREATE_GRAPHICS.eq."False") then
     print("Finished: pdv.ncl")
     exit
  end if 
;===========================================================================================================================================================
  wks_type = OUTPUT_TYPE
  if (wks_type.eq."png") then
     wks_type@wkWidth = 1500*PNG_SCALE
     wks_type@wkHeight = 1500*PNG_SCALE
  end if

  res = True      ; spatial plot resource list
  res@mpProjection = "WinkelTripel"
  res@mpGeophysicalLineColor = "gray42"
  res@mpPerimOn    = False
  res@mpGridLatSpacingF =  90         ; change latitude  line spacing
  res@mpGridLonSpacingF = 180.        ; change longitude line spacing
  res@mpGridLineColor   = "transparent"  ; trick ncl into drawing perimeter
  res@mpGridAndLimbOn   = True        ; turn on lat/lon lines  
  res@mpFillOn = False
  res@mpCenterLonF = 210.
  res@mpOutlineOn = True  
  if (wks_type.eq."png") then
     res@mpGeophysicalLineThicknessF = 2.  
  else
     res@mpGeophysicalLineThicknessF = 1.  
  end if
  res@gsnDraw   = False
  res@gsnFrame  = False
  
  res@cnLineLabelsOn = False
  res@cnFillOn     = True
  res@cnLinesOn    = False

  res@lbLabelBarOn    = False
  res@pmLabelBarWidthF = 0.55
  res@pmLabelBarHeightF = 0.075
  res@lbBoxLineColor = "gray70"
  res@lbLabelFontHeightF = 0.02
  res@lbLabelStride = 1
  res@lbTitleOn = True
  res@lbTitleFontHeightF = res@lbLabelFontHeightF
  res@lbTitlePosition = "Bottom"
  res@cnNoDataLabelOn = False

  res@cnLevelSelectionMode = "ExplicitLevels"
  res@gsnLeftStringOrthogonalPosF = -0.05
  res@gsnLeftStringParallelPosF = .005
  res@gsnRightStringOrthogonalPosF = -0.05
  res@gsnRightStringParallelPosF = 0.96
  res@gsnLeftStringFontHeightF = 0.014
  res@gsnCenterStringFontHeightF = 0.018
  res@gsnRightStringFontHeightF = 0.014
  res@gsnLeftString = ""
  res@gsnCenterString = ""
  res@gsnRightString = ""

  tres = res    ; p-value plot resource list
  copy_VarAtts(retrieve_summary_res(),tres)

  res2 = res       ; spatial differences resource list
  if (COLORMAP.eq.0) then
     res@cnLevels = fspan(-.65,.65,27)
     res2@cnLevels = fspan(-.65,.65,27)
     res@cnFillPalette = "ncl_default"
     res2@cnFillPalette = "ncl_default"
  end if
  if (COLORMAP.eq.1) then
     res@cnLevels = fspan(-.8,.8,17)
     res2@cnLevels = fspan(-.8,.8,17)
     res@cnFillPalette = "BlueDarkRed18"
     res2@cnFillPalette = "BlueDarkRed18"
  end if 

  amres                  = True
  amres@amParallelPosF   = 0.465    ; -0.5 is the left edge of the plot.
  amres@amOrthogonalPosF = -0.425   ; -0.5 is the top edge of the plot.
  amres@amJust           = "BottomRight"

  ares = True   ; % variance explained xy plot for summary plots

  panres = True     ; panel resource list for individual simulations
  panres@gsnMaximize = True  
  panres@gsnPaperOrientation = "portrait"
  panres@gsnPanelLabelBar = True
  panres@gsnPanelYWhiteSpacePercent = 3.0
  panres@pmLabelBarHeightF = 0.05
  panres@pmLabelBarWidthF = 0.65
  panres@pmLabelBarOrthogonalPosF = -0.02
  panres@lbTitleOn = False
  panres@lbBoxLineColor = "gray70"
  panres@txFontHeightF = 0.016
  panres@gsnPanelBottom = 0.05
  panres@lbLabelFontHeightF = 0.013
  panres@lbLabelStride = 1
  panres@lbTitleOn = True
  panres@lbTitleFontHeightF = panres@lbLabelFontHeightF
  panres@lbTitlePosition = "Bottom"
  ncol = floattointeger(sqrt(nsim))
  nrow = (nsim/ncol)+mod(nsim,ncol)

  panres2 = panres   ; summary panel resource list
  panres2@gsnFrame = False
  panres2@gsnMaximize = False
  panres2@gsnPanelLabelBar = False
  panres2@lbTitleOn = False

  csubtitle_color = set_subtitle_colors(max(EM_num))
  nEM = max(EM_num)

  variname = (/"pdv_pattern_mon","pdv_prime_pattern_mon"/)  ; do not alter this order
  variname_obs = (/"pdv_pattern_mon","pdv_pattern_mon"/)   ; For obs, ' metrics are not calculated, but need to use non' obs metrics in ' plots for differences.

  title = (/"PDV","PDV'"/)
  outputname = (/"pdv","pdv.prime"/)

  do dd = 0,dimsizes(variname)-1
     wks = gsn_open_wks(wks_type,getenv("OUTDIR")+"pdv")
     plot_indmem      = new(nsim,"graphic")
     plot_indmem_diff = new(nsim,"graphic")
     plot_summary     = new((nEM*4),"graphic")
     plot_summary_anno = new(nEM*4,"graphic")
     xy_anno = new(nEM*4,"graphic")

     numobs = num(EM_num.eq.0) 
     if (numobs.eq.0) then
        fnt = getenv("OUTDIR")+"obs.cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2 = getenv("OUTDIR")+"obs.cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        cntr = 0
     else
        fnt = getenv("OUTDIR")+modname(0)+".cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2 = getenv("OUTDIR")+modname(0)+".cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        cntr = 1
     end if
     obs0 := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))

     res@gsnCenterStringFontColor = "black"
     res2@gsnCenterStringFontColor = "black"
     res@gsnRightStringParallelPosF = 0.96
     res@gsnRightStringOrthogonalPosF = -0.05
     res@lbLabelBarOn = False
     res2@lbLabelBarOn = False
     tres@lbLabelBarOn = False
     res@gsnLeftString = syear(0)+"-"+eyear(0) 
     res@gsnRightString = obs0@pcvar
     res@gsnCenterString = names(0)    
     plot_indmem(0) = gsn_csm_contour_map(wks,obs0,res)
     cntr_EM = 0
     if (numobs.ge.2) then     ; plot obs #2-
        do ff = 1,numobs-1
           fnt = getenv("OUTDIR")+modname(cntr)+".cvdp_data.pdv."+syear(cntr)+"-"+eyear(cntr)+".nc"
           fnt2 = getenv("OUTDIR")+modname(cntr)+".cvdp_data."+syear(cntr)+"-"+eyear(cntr)+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))
           if (isatt(arr,"is_all_missing")) then 
              cntr = cntr+1
              continue
           end if
           obs0_rg = linint2_Wrap(obs0&lon,obs0&lat,obs0,True,arr&lon,arr&lat,0)
           obs_diff = arr
           obs_diff = (/ arr - obs0_rg /)

           res@gsnLeftString = syear(cntr)+"-"+eyear(cntr) 
           res@gsnRightString = arr@pcvar+"~C~   r="+pattern_correlation(obs0_rg,arr)
           res@gsnCenterString = names(cntr)   
           plot_indmem(cntr) = gsn_csm_contour_map(wks,arr,res)
           res2@gsnLeftString = ""   
           res2@gsnRightString = ""  
           res2@gsnCenterString = names(cntr)+"-"+names(0)

           plot_indmem_diff(cntr) = gsn_csm_contour_map(wks,obs_diff,res2)
           delete([/arr,obs_diff,obs0_rg/])
           cntr = cntr+1
        end do
     end if
     do gg = 1,nEM   ; operate on each ensemble mean
        lbFlag = summary_lb_flag(paths,EM_num,gg,nEM)  ; lbFlag set to True if summary labelbars should be drawn

        nens = num(EM_num.eq.gg) ; determines how many model simulations in each ensemble
        cntr_ens := ind(EM_num.eq.gg)   ; cntr_ens(hh) are the indices where each ensemble member of an ensemble reside 
        do hh = 0,nens-1
           modname_mod = modname(cntr_ens(hh))
           syear_mod = syear(cntr_ens(hh))
           eyear_mod = eyear(cntr_ens(hh))
           names_mod = names(cntr_ens(hh))
           names_EM_mod = names_EM(cntr_ens(hh))

           fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
           fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname(dd))
 
           if (isatt(arr,"is_all_missing")) then
              cntr = cntr+1
              continue
           end if
 
           if (.not.isvar("arr_store")) then  ; create an array to house all members, to be used to calculate EM
              arr_store = new((/nens,dimsizes(arr&lat),dimsizes(arr&lon)/),typeof(arr))
              arr_store!0 = "ensmem"
              arr_store!1 = "lat"
              arr_store&lat = arr&lat
              arr_store!2 = "lon"
              arr_store&lon = arr&lon
              arr_store@nens = 0
              copy_VarAtts(arr,arr_store)
              arr_store_pcvar = new(nens,float)

              syear_em0 = syear_mod
              eyear_em0 = eyear_mod
              showyr = True
           end if
           if (showyr) then
              if (syear_em0.ne.syear_mod.or.eyear_em0.ne.eyear_mod.and.showyr) then
                 showyr = False
              end if
           end if
           res@gsnCenterStringFontColor = csubtitle_color(gg-1)
           res2@gsnCenterStringFontColor = csubtitle_color(gg-1)

           arr_store(hh,:,:) = (/ arr /)
           arr_store@nens = arr_store@nens+1
           arr_store_pcvar(hh) = (/ tofloat(arr@pcvar) /)
           panres@lbTitleString = arr@units

           if (.not.isvar("obs0_rg")) then  
              obs0_rg = linint2_Wrap(obs0&lon,obs0&lat,obs0,True,arr&lon,arr&lat,0)
           end if
           obs_diff = arr
           obs_diff = (/ arr - obs0_rg /)

           res@gsnLeftString = syear_mod+"-"+eyear_mod
           res@gsnRightString = arr@pcvar+"~C~   r="+pattern_correlation(obs0_rg,arr)
           res@gsnCenterString = names_mod
           plot_indmem(cntr) = gsn_csm_contour_map(wks,arr,res)
           res2@gsnLeftString = "" 
           res2@gsnRightString = ""  
           res2@gsnCenterString = names_mod+"-"+names(0)  
           plot_indmem_diff(cntr) = gsn_csm_contour_map(wks,obs_diff,res2)
           delete([/arr,obs_diff/])
           cntr = cntr+1
        end do
        if (.not.isvar("arr_store")) then
           cntr_EM = cntr_EM+4
           continue
        end if

        if (lbFlag) then
           res@lbLabelBarOn = True
           res2@lbLabelBarOn = True
           tres@lbLabelBarOn = True
        end if
        arr_EM = dim_avg_n_Wrap(arr_store,0)

        res@lbTitleString = arr_EM@units   
        res2@lbTitleString = res@lbTitleString 
        res@gsnCenterStringFontColor = "black"
        res2@gsnCenterStringFontColor = "black"

        res@gsnRightStringParallelPosF = 0.96
        res@gsnRightStringOrthogonalPosF = -0.05
        res@gsnLeftString = syear(0)+"-"+eyear(0) 
        res@gsnRightString = obs0@pcvar
        res@gsnCenterString = "Observations ("+names(0)+")"   
        plot_summary(cntr_EM+1) = gsn_csm_contour_map(wks,obs0,res)

        if (showyr) then
           res@gsnLeftString = syear_em0+"-"+eyear_em0 
        else
           res@gsnLeftString = (eyear_em0-syear_em0+1)+"yrs" 
        end if
        delete([/syear_em0,eyear_em0,showyr/])
        res@gsnCenterStringFontColor = csubtitle_color(gg-1)

        stats := boxplot_stat(arr_store_pcvar)
        res@gsnRightStringParallelPosF = 1.015
        res@gsnRightStringOrthogonalPosF = -0.175
        res@gsnRightString = decimalPlaces(stats(0),0,True)+"/"+decimalPlaces(avg(arr_store_pcvar),0,True)+"/"+decimalPlaces(stats(4),0,True)+"%~C~       r="+pattern_correlation(arr_EM({20:},:),obs0_rg({20:},:))
        res@gsnCenterString = names_EM_mod +" ("+arr_store@nens+" Members)"                       
        plot_summary(cntr_EM) = gsn_csm_contour_map(wks,arr_EM,res)
        ares@gsLineColor = res@gsnCenterStringFontColor
        if (isatt(obs0,"pcvar")) then
           ares@obsval = obs0@pcvar
        end if
        plot_summary_anno(cntr_EM) = add_xy_plot(wks,arr_store_pcvar,ares)
        xy_anno(cntr_EM) = gsn_add_annotation(plot_summary(cntr_EM),plot_summary_anno(cntr_EM),amres)
        res@gsnRightStringParallelPosF = 0.96
        res@gsnRightStringOrthogonalPosF = -0.05

        obs_diff = arr_EM
        obs_diff = (/ arr_EM - obs0_rg /)
        res2@gsnLeftString = ""
        res2@gsnCenterString = names_EM_mod+" - Observations"    ;+names(0)  
        res2@gsnRightString = ""  
        plot_summary(cntr_EM+2) = gsn_csm_contour_map(wks,obs_diff,res2)

        p_val = calculate_pval(obs0_rg,arr_store)
        tres@gsnRightString = calculate_area_in_range(p_val,10,90)+"%"
        plot_summary(cntr_EM+3) = gsn_csm_contour_map(wks,p_val,tres)

        fno = getenv("OUTDIR")+str_sub_str(names_EM_mod," ","_")+"_EM.cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
        if (isfilepresent2(fno)) then
           z = addfile(fno,"w")
        else
           z = addfile(fno,"c")
           set_global_ncfile_attributes(z,names_EM_mod,syear_mod,eyear_mod,getenv("VERSION"))
        end if
        z->$(/variname(dd)+"_em"/)$ = set_varAtts(arr_EM,arr_EM@long_name+" Ensemble Mean","","")
        z->$(/variname(dd)+"_em_diffobs"/)$ = set_varAtts(obs_diff,obs_diff@long_name+" Ensemble Mean difference from observations","","")           
        z->$(/variname(dd)+"_pval"/)$ = set_varAtts(p_val,arr_EM@long_name+" p-val statistic","%","")  
        delete([/p_val,arr_store,arr_store_pcvar,obs0_rg,obs_diff,arr_EM,z/])
        cntr_EM = cntr_EM+4
     end do
     panres@txString = title(dd)+" (Monthly)"
     gsn_panel2(wks,plot_indmem,(/nrow,ncol/),panres)

     panres@txString = title(dd)+" Differences (Monthly)"
     gsn_panel2(wks,plot_indmem_diff,(/nrow,ncol/),panres)

     panres2@txString = "Ensemble Summary: "+title(dd)+" (Monthly)"
     gsn_panel2(wks,plot_summary,(/nEM,4/),panres2)
     frame(wks)
     delete(wks)

     if (wks_type.eq."png") then
        system("mv "+OUTDIR+"pdv.000001.png "+OUTDIR+outputname(dd)+".indmem.png")
        system("mv "+OUTDIR+"pdv.000002.png "+OUTDIR+outputname(dd)+".indmemdiff.png")
        system("mv "+OUTDIR+"pdv.000003.png "+OUTDIR+outputname(dd)+".summary.png")
        if (PNG_SCALE_SUMMARY.ne.100) then
           system("convert -resize "+PNG_SCALE_SUMMARY+"% "+OUTDIR+outputname(dd)+".summary.png "+OUTDIR+outputname(dd)+".summary.png")
        end if
     else
        system("psplit "+OUTDIR+"pdv.ps "+OUTDIR+"pdv")
        system("mv "+OUTDIR+"pdv0001.ps "+OUTDIR+outputname(dd)+".indmem.ps")
        system("mv "+OUTDIR+"pdv0002.ps "+OUTDIR+outputname(dd)+".indmemdiff.ps")
        system("mv "+OUTDIR+"pdv0003.ps "+OUTDIR+outputname(dd)+".summary.ps")
        system("rm "+OUTDIR+"pdv.ps")
     end if
  end do
;----------PDV TAS/SST Regression Plots----------------------------------------------------------------------------------------------------------------
  res3 = True   ; res3 = tas regression resources for overlays    
  res3@gsnDraw      = False
  res3@gsnFrame     = False
  res3@cnLevelSelectionMode = "ExplicitLevels"
  res3@cnLevels = res@cnLevels
  res3@cnFillPalette = res@cnFillPalette

  res3@cnLineLabelsOn = False
  res3@cnFillOn        = True
  res3@cnLinesOn       = False
  res3@cnFillMode = "AreaFill"
  res3@lbLabelBarOn    = False
  res3@cnInfoLabelOn = False
  res3@gsnRightString = ""
  res3@gsnLeftString = "" 
  res3@gsnCenterString = ""   
  res3@gsnAddCyclic = True
  res3@cnNoDataLabelOn = False

  res4 = res3   ; res4 = tas regression differences resources for overlays
  res4@cnLevels := res2@cnLevels
  res4@cnFillPalette := res2@cnFillPalette

  tres2 = res3    ; p-value plot resource list for SST's
  copy_VarAtts(retrieve_summary_res(),tres2)
  delete(tres2@cnMissingValFillColor)
  tres2@gsnCenterString = ""
  tres2@gsnRightStringOrthogonalPosF = -0.10
  tres2@gsnRightStringParallelPosF = 0.99

  variname = (/"pdv_pattern_mon","pdv_prime_pattern_mon"/)
  variname_obs = (/"pdv_pattern_mon","pdv_pattern_mon"/); For obs, ' metrics are not calculated, but need to use non' obs metrics in ' plots for differences.
  variname_tas = (/"pdv_tas_regression_mon","pdv_prime_tas_regression_mon"/)
  variname_tas_obs = (/"pdv_tas_regression_mon","pdv_tas_regression_mon"/)
  title = (/"PDV","PDV'"/)
  outputname = (/"pdv.tassstreg","pdv.prime.tassstreg"/)

  do dd = 0,dimsizes(variname)-1
     wks = gsn_open_wks(wks_type,getenv("OUTDIR")+"pdv")
     plot_indmem      = new(nsim,"graphic")
     plot_indmem_diff = new(nsim,"graphic")
     plot_summary     = new((nEM*4),"graphic")
     plot_indmem_ov      = new(nsim,"graphic")
     plot_indmem_diff_ov = new(nsim,"graphic")
     plot_summary_ov     = new((nEM*4),"graphic")

     numobs = num(EM_num.eq.0) 
     if (numobs.eq.0) then
        fnt = getenv("OUTDIR")+"obs.cvdp_data.pdv.tas."+syear_tas(0)+"-"+eyear_tas(0)+".nc"
        fnt2 = getenv("OUTDIR")+"obs.cvdp_data."+syear_tas(0)+"-"+eyear_tas(0)+".nc"
        obs0 := read_cvdp_le_data(fnt,fnt2,variname_tas_obs(dd))

        fnt = getenv("OUTDIR")+"obs.cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2b = getenv("OUTDIR")+"obs.cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        sst0 := read_cvdp_le_data(fnt,fnt2b,variname_obs(dd))
        cntr = 0
     else
        fnt = getenv("OUTDIR")+modname_tas(0)+".cvdp_data.pdv.tas."+syear_tas(0)+"-"+eyear_tas(0)+".nc"
        fnt2 = getenv("OUTDIR")+modname_tas(0)+".cvdp_data."+syear_tas(0)+"-"+eyear_tas(0)+".nc"
        obs0 := read_cvdp_le_data(fnt,fnt2,variname_tas_obs(dd))

        fnt = getenv("OUTDIR")+modname(0)+".cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2b = getenv("OUTDIR")+modname(0)+".cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        sst0 := read_cvdp_le_data(fnt,fnt2b,variname_obs(dd))
        cntr = 1
     end if
     obs0 = where(landsea_mask(d->LSMASK,obs0&lat,obs0&lon).eq.0,obs0@_FillValue,obs0)

     res@gsnCenterStringFontColor = "black"
     res2@gsnCenterStringFontColor = "black"
     res@gsnRightStringParallelPosF = 0.96
     res@gsnRightStringOrthogonalPosF = -0.05
     res@lbLabelBarOn = False
     res2@lbLabelBarOn = False
     tres@lbLabelBarOn = False
     res@gsnLeftString = syear(0)+"-"+eyear(0) 
     res@gsnRightString = ""  
     res@gsnCenterString = names(0)+"/"+names_tas(0)  
     plot_indmem(0) = gsn_csm_contour_map(wks,obs0,res)
     plot_indmem_ov(0) = gsn_csm_contour(wks,sst0,res3)
     overlay(plot_indmem(0),plot_indmem_ov(0))
     cntr_EM = 0
     if (numobs.ge.2) then     ; plot obs #2-
        do ff = 1,numobs-1
           fnt = getenv("OUTDIR")+modname_tas(cntr)+".cvdp_data.pdv.tas."+syear_tas(cntr)+"-"+eyear_tas(cntr)+".nc"
           fnt2 = getenv("OUTDIR")+modname_tas(cntr)+".cvdp_data."+syear_tas(cntr)+"-"+eyear_tas(cntr)+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname_tas_obs(dd))
           arr = where(landsea_mask(d->LSMASK,arr&lat,arr&lon).eq.0,arr@_FillValue,arr)
           fnt = getenv("OUTDIR")+modname(cntr)+".cvdp_data.pdv."+syear(cntr)+"-"+eyear(cntr)+".nc"
           fnt2 = getenv("OUTDIR")+modname(cntr)+".cvdp_data."+syear(cntr)+"-"+eyear(cntr)+".nc"
           sst := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))

           if (isatt(arr,"is_all_missing")) then 
              cntr = cntr+1
              continue
           end if
           obs0_rg = linint2_Wrap(obs0&lon,obs0&lat,obs0,True,arr&lon,arr&lat,0)
           obs_diff = arr
           obs_diff = (/ arr - obs0_rg /)
           sst0_rg = linint2_Wrap(sst0&lon,sst0&lat,sst0,True,sst&lon,sst&lat,0)
           sst_diff = sst
           sst_diff = (/ sst - sst0_rg /)

           res@gsnLeftString = syear(cntr)+"-"+eyear(cntr) 
           res@gsnRightString = "r="+pattern_correlation(sst0_rg,sst)+"/"+pattern_correlation(obs0_rg,arr)
           res@gsnCenterString = names(cntr)+"/"+names_tas(cntr)     
           plot_indmem(cntr) = gsn_csm_contour_map(wks,arr,res)
           plot_indmem_ov(cntr) = gsn_csm_contour(wks,sst,res3)
           overlay(plot_indmem(cntr),plot_indmem_ov(cntr))
           res2@gsnLeftString = ""  
           res2@gsnRightString = ""  
           res2@gsnCenterString = names(cntr)+"/"+names_tas(cntr)+" -~C~"+names(0)+"/"+names_tas(0)
           plot_indmem_diff(cntr) = gsn_csm_contour_map(wks,obs_diff,res2)
           plot_indmem_diff_ov(cntr) = gsn_csm_contour(wks,sst_diff,res4)
           overlay(plot_indmem_diff(cntr),plot_indmem_diff_ov(cntr))
           delete([/arr,sst,obs_diff,obs0_rg,sst0_rg,sst_diff/])
           cntr = cntr+1
        end do
     end if
     do gg = 1,nEM   ; operate on each ensemble mean
        lbFlag = summary_lb_flag(paths,EM_num,gg,nEM)  ; lbFlag set to True if summary labelbars should be drawn

        nens = num(EM_num.eq.gg) ; determines how many model simulations in each ensemble
        cntr_ens := ind(EM_num.eq.gg)   ; cntr_ens(hh) are the indices where each ensemble member of an ensemble reside 
        do hh = 0,nens-1
           modname_mod = modname_tas(cntr_ens(hh))
           syear_mod = syear_tas(cntr_ens(hh))
           eyear_mod = eyear_tas(cntr_ens(hh))
           names_mod = names_tas(cntr_ens(hh))
           names_EM_mod = names_EM(cntr_ens(hh))
           modname_mod_sst = modname(cntr_ens(hh))
           syear_mod_sst = syear(cntr_ens(hh))
           eyear_mod_sst = eyear(cntr_ens(hh))
           names_mod_sst = names(cntr_ens(hh))
           fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv.tas."+syear_mod+"-"+eyear_mod+".nc"
           fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname_tas(dd))

           if (isatt(arr,"is_all_missing")) then
              cntr = cntr+1
              continue
           end if
           arr = where(landsea_mask(d->LSMASK,arr&lat,arr&lon).eq.0,arr@_FillValue,arr)
           fnt = getenv("OUTDIR")+modname_mod_sst+".cvdp_data.pdv."+syear_mod_sst+"-"+eyear_mod_sst+".nc"
           fnt2 = getenv("OUTDIR")+modname_mod_sst+".cvdp_data."+syear_mod_sst+"-"+eyear_mod_sst+".nc"
           sst := read_cvdp_le_data(fnt,fnt2,variname(dd))

           if (.not.isvar("arr_store")) then  ; create an array to house all members, to be used to calculate EM
              arr_store = new((/nens,dimsizes(arr&lat),dimsizes(arr&lon)/),typeof(arr))
              arr_store!0 = "ensmem"
              arr_store!1 = "lat"
              arr_store&lat = arr&lat
              arr_store!2 = "lon"
              arr_store&lon = arr&lon
              arr_store@nens = 0
              copy_VarAtts(arr,arr_store)

              arr_store_sst = new((/nens,dimsizes(sst&lat),dimsizes(sst&lon)/),typeof(sst))
              arr_store_sst!0 = "ensmem"
              arr_store_sst!1 = "lat"
              arr_store_sst&lat = sst&lat
              arr_store_sst!2 = "lon"
              arr_store_sst&lon = sst&lon
              arr_store_sst@nens = 0
              copy_VarAtts(sst,arr_store_sst)

              syear_em0 = syear_mod
              eyear_em0 = eyear_mod
              showyr = True
           end if
           if (showyr) then
              if (syear_em0.ne.syear_mod.or.eyear_em0.ne.eyear_mod.and.showyr) then
                 showyr = False
              end if
           end if
           res@gsnCenterStringFontColor = csubtitle_color(gg-1)
           res2@gsnCenterStringFontColor = csubtitle_color(gg-1)

           arr_store(hh,:,:) = (/ arr /)
           arr_store@nens = arr_store@nens+1
           arr_store_sst(hh,:,:) = (/ sst /)
           arr_store_sst@nens = arr_store_sst@nens+1
           panres@lbTitleString = arr@units

           if (.not.isvar("obs0_rg")) then  
              obs0_rg = linint2_Wrap(obs0&lon,obs0&lat,obs0,True,arr&lon,arr&lat,0)
           end if
           obs_diff = arr
           obs_diff = (/ arr - obs0_rg /)
           if (.not.isvar("sst0_rg")) then  
              sst0_rg = linint2_Wrap(sst0&lon,sst0&lat,sst0,True,sst&lon,sst&lat,0)
           end if
           sst_diff = sst
           sst_diff = (/ sst - sst0_rg /)
           res@gsnLeftString = syear_mod+"-"+eyear_mod
           res@gsnRightString = "r="+pattern_correlation(sst0_rg,sst)+"/"+pattern_correlation(obs0_rg,arr)
           res@gsnCenterString = names_mod
           plot_indmem(cntr) = gsn_csm_contour_map(wks,arr,res)
           plot_indmem_ov(cntr) = gsn_csm_contour(wks,sst,res3)
           overlay(plot_indmem(cntr),plot_indmem_ov(cntr))
           res2@gsnLeftString = "" 
           res2@gsnRightString = ""  
           res2@gsnCenterString = names_mod+"-"+names(0)+"/"+names_tas(0)  
           plot_indmem_diff(cntr) = gsn_csm_contour_map(wks,obs_diff,res2)
           plot_indmem_diff_ov(cntr) = gsn_csm_contour(wks,sst_diff,res4)
           overlay(plot_indmem_diff(cntr),plot_indmem_diff_ov(cntr))
           delete([/arr,sst,obs_diff,sst_diff/])
           cntr = cntr+1
        end do
        if (.not.isvar("arr_store")) then
           cntr_EM = cntr_EM+4
           continue
        end if

        if (lbFlag) then
           res@lbLabelBarOn = True
           res2@lbLabelBarOn = True
           tres@lbLabelBarOn = True
        end if
        arr_EM = dim_avg_n_Wrap(arr_store,0)
        sst_EM = dim_avg_n_Wrap(arr_store_sst,0)

        res@lbTitleString = arr_EM@units   
        res2@lbTitleString = res@lbTitleString 
        res@gsnCenterStringFontColor = "black"
        res2@gsnCenterStringFontColor = "black"

        res@gsnLeftString = syear(0)+"-"+eyear(0) 
        res@gsnRightString = ""  
        res@gsnCenterString = "Observations ("+names(0)+"/"+names_tas(0)+")"      
        plot_summary(cntr_EM+1) = gsn_csm_contour_map(wks,obs0,res)
        plot_summary_ov(cntr_EM+1) = gsn_csm_contour(wks,sst0,res3)
        overlay(plot_summary(cntr_EM+1),plot_summary_ov(cntr_EM+1))

        if (showyr) then
           res@gsnLeftString = syear_em0+"-"+eyear_em0 
        else
           res@gsnLeftString = (eyear_em0-syear_em0+1)+"yrs" 
        end if
        delete([/syear_em0,eyear_em0,showyr/])

        res@gsnCenterStringFontColor = csubtitle_color(gg-1)
        res@gsnRightString = "r="+pattern_correlation(sst0_rg,sst_EM)+"/"+pattern_correlation(obs0_rg,arr_EM)
        res@gsnCenterString = names_EM_mod +" ("+arr_store_sst@nens+"/"+arr_store@nens+" Members)"                       
        plot_summary(cntr_EM) = gsn_csm_contour_map(wks,arr_EM,res)
        plot_summary_ov(cntr_EM) = gsn_csm_contour(wks,sst_EM,res3)
        overlay(plot_summary(cntr_EM),plot_summary_ov(cntr_EM))
        obs_diff = arr_EM
        obs_diff = (/ arr_EM - obs0_rg /)
        sst_diff = sst_EM
        sst_diff = (/ sst_EM - sst0_rg /)
        res2@gsnLeftString = ""
        res2@gsnCenterString = names_EM_mod+" - Observations" 
        res2@gsnRightString = ""  
        plot_summary(cntr_EM+2) = gsn_csm_contour_map(wks,obs_diff,res2)
        plot_summary_ov(cntr_EM+2) = gsn_csm_contour(wks,sst_diff,res4)
        overlay(plot_summary(cntr_EM+2),plot_summary_ov(cntr_EM+2))
        p_val = calculate_pval(obs0_rg,arr_store)
        tres@gsnRightString = calculate_area_in_range(p_val,10,90)+"% (TAS)"
        p_val2 = calculate_pval(sst0_rg,arr_store_sst)
        tres2@gsnRightString = calculate_area_in_range(p_val2,10,90)+"% (SST)"
        plot_summary(cntr_EM+3) = gsn_csm_contour_map(wks,p_val,tres)
        plot_summary_ov(cntr_EM+3) = gsn_csm_contour(wks,p_val2,tres2)
        overlay(plot_summary(cntr_EM+3),plot_summary_ov(cntr_EM+3))

        fno = getenv("OUTDIR")+str_sub_str(names_EM_mod," ","_")+"_EM.cvdp_data.pdv.tas."+syear_mod+"-"+eyear_mod+".nc"
        if (isfilepresent2(fno)) then
           z = addfile(fno,"w")
        else
           z = addfile(fno,"c")
           set_global_ncfile_attributes(z,names_EM_mod,syear_mod,eyear_mod,getenv("VERSION"))
        end if
        z->$(/variname_tas(dd)+"_em"/)$ = set_varAtts(arr_EM,arr_EM@long_name+" Ensemble Mean","","")
        z->$(/variname_tas(dd)+"_em_diffobs"/)$ = set_varAtts(obs_diff,obs_diff@long_name+" Ensemble Mean difference from observations","","")           
        z->$(/variname_tas(dd)+"_pval"/)$ = set_varAtts(p_val,arr_EM@long_name+" p-val statistic","%","")   
        delete(z)

        fno = getenv("OUTDIR")+str_sub_str(names_EM_mod," ","_")+"_EM.cvdp_data.pdv."+syear_mod_sst+"-"+eyear_mod_sst+".nc"
        if (isfilepresent2(fno)) then
           z = addfile(fno,"w")
        else
           z = addfile(fno,"c")
           set_global_ncfile_attributes(z,names_EM_mod,syear_mod_sst,eyear_mod_sst,getenv("VERSION"))
        end if
        z->$(/variname(dd)+"_em"/)$         = set_varAtts(sst_EM,sst_EM@long_name+" Ensemble Mean","","")
        z->$(/variname(dd)+"_em_diffobs"/)$ = set_varAtts(sst_diff,sst_diff@long_name+" Ensemble Mean difference from observations","","")           
        z->$(/variname(dd)+"_pval"/)$       = set_varAtts(p_val2,sst_EM@long_name+" p-val statistic","%","")   

        delete([/p_val,p_val2,arr_store,arr_store_sst,obs0_rg,sst0_rg,obs_diff,arr_EM,sst_EM,sst_diff/])
        cntr_EM = cntr_EM+4
     end do
     panres@txString = title(dd)+" SST/TAS Regressions (Monthly)"
     gsn_panel2(wks,plot_indmem,(/nrow,ncol/),panres)

     panres@txString = title(dd)+" SST/TAS Regressions Differences (Monthly)"
     gsn_panel2(wks,plot_indmem_diff,(/nrow,ncol/),panres)

     panres2@txString = "Ensemble Summary: "+title(dd)+" SST/TAS Regressions (Monthly)"
     gsn_panel2(wks,plot_summary,(/nEM,4/),panres2)
     frame(wks)
     delete(wks)

     if (wks_type.eq."png") then
        system("mv "+OUTDIR+"pdv.000001.png "+OUTDIR+outputname(dd)+".indmem.png")
        system("mv "+OUTDIR+"pdv.000002.png "+OUTDIR+outputname(dd)+".indmemdiff.png")
        system("mv "+OUTDIR+"pdv.000003.png "+OUTDIR+outputname(dd)+".summary.png")
        if (PNG_SCALE_SUMMARY.ne.100) then
           system("convert -resize "+PNG_SCALE_SUMMARY+"% "+OUTDIR+outputname(dd)+".summary.png "+OUTDIR+outputname(dd)+".summary.png")
        end if
     else
        system("psplit "+OUTDIR+"pdv.ps "+OUTDIR+"pdv")
        system("mv "+OUTDIR+"pdv0001.ps "+OUTDIR+outputname(dd)+".indmem.ps")
        system("mv "+OUTDIR+"pdv0002.ps "+OUTDIR+outputname(dd)+".indmemdiff.ps")
        system("mv "+OUTDIR+"pdv0003.ps "+OUTDIR+outputname(dd)+".summary.ps")
        system("rm "+OUTDIR+"pdv.ps")
     end if
  end do
;--------PDV PR Regression Plots----------------------------------------------------------------------------------------------------
  if (COLORMAP.eq.0) then
     res@cnLevels := (/-5,-4,-3,-2,-1,-.75,-.5,-.25,-.1,0,.1,.25,.5,.75,1,2,3,4,5/)     
     res@cnFillPalette := "MPL_BrBG"  
  end if
  if (COLORMAP.eq.1) then
     res@cnLevels := (/-3,-2,-1,-.5,-.1,0,.1,.5,1,2,3/)     
     res@cnFillPalette := "BrownBlue12"     
  end if 
  res2@cnLevels := res@cnLevels
  res2@cnFillPalette := res@cnFillPalette
  res@cnMissingValFillColor = "gray90"
  res2@cnMissingValFillColor = "gray90"

  variname = (/"pdv_pr_regression_mon","pdv_prime_pr_regression_mon"/)
  variname_obs = (/"pdv_pr_regression_mon","pdv_pr_regression_mon"/); For obs, ' metrics are not calculated, but need to use non' obs metrics in ' plots for differences.
  title = (/"PDV","PDV'"/)
  outputname = (/"pdv.prreg","pdv.prime.prreg"/)

  do dd = 0,dimsizes(variname)-1

     wks = gsn_open_wks(wks_type,getenv("OUTDIR")+"pdv")
     plot_indmem      = new(nsim,"graphic")
     plot_indmem_diff = new(nsim,"graphic")
     plot_summary     = new((nEM*4),"graphic")

     numobs = num(EM_num.eq.0) 
     if (numobs.eq.0) then
        fnt = getenv("OUTDIR")+"obs.cvdp_data.pdv.pr."+syear_pr(0)+"-"+eyear_pr(0)+".nc"
        fnt2 = getenv("OUTDIR")+"obs.cvdp_data."+syear_pr(0)+"-"+eyear_pr(0)+".nc"
        cntr = 0
     else
        fnt = getenv("OUTDIR")+modname_pr(0)+".cvdp_data.pdv.pr."+syear_pr(0)+"-"+eyear_pr(0)+".nc"
        fnt2 = getenv("OUTDIR")+modname_pr(0)+".cvdp_data."+syear_pr(0)+"-"+eyear_pr(0)+".nc"
        cntr = 1
     end if
     obs0 := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))

     res@gsnRightStringOrthogonalPosF = -0.05
     res@gsnCenterStringFontColor = "black"
     res2@gsnCenterStringFontColor = "black"
     res@lbLabelBarOn = False
     res2@lbLabelBarOn = False
     tres@lbLabelBarOn = False
     res@gsnLeftString = syear_pr(0)+"-"+eyear_pr(0) 
     res@gsnRightString = ""  
     res@gsnCenterString = names_pr(0)    
     plot_indmem(0) = gsn_csm_contour_map(wks,obs0,res)
     cntr_EM = 0
     if (numobs.ge.2) then     ; plot obs #2-
        do ff = 1,numobs-1
           fnt = getenv("OUTDIR")+modname_pr(cntr)+".cvdp_data.pdv.pr."+syear_pr(cntr)+"-"+eyear_pr(cntr)+".nc"
           fnt2 = getenv("OUTDIR")+modname_pr(cntr)+".cvdp_data."+syear_pr(cntr)+"-"+eyear_pr(cntr)+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))
           if (isatt(arr,"is_all_missing")) then 
              cntr = cntr+1
              continue
           end if
           obs0_rg = linint2_Wrap(obs0&lon,obs0&lat,obs0,True,arr&lon,arr&lat,0)
           obs_diff = arr
           obs_diff = (/ arr - obs0_rg /)

           res@gsnLeftString = syear_pr(cntr)+"-"+eyear_pr(cntr) 
           res@gsnRightString = "r="+pattern_correlation(obs0_rg,arr)
           res@gsnCenterString = names_pr(cntr) 
           plot_indmem(cntr) = gsn_csm_contour_map(wks,arr,res)
           res2@gsnLeftString = ""   
           res2@gsnRightString = ""  
           res2@gsnCenterString = names_pr(cntr)+"-"+names_pr(0)
           plot_indmem_diff(cntr) = gsn_csm_contour_map(wks,obs_diff,res2)
           delete([/arr,obs_diff,obs0_rg/])
           cntr = cntr+1
        end do
     end if
     do gg = 1,nEM   ; operate on each ensemble mean
        lbFlag = summary_lb_flag(paths,EM_num,gg,nEM)  ; lbFlag set to True if summary labelbars should be drawn

        nens = num(EM_num.eq.gg) ; determines how many model simulations in each ensemble
        cntr_ens := ind(EM_num.eq.gg)   ; cntr_ens(hh) are the indices where each ensemble member of an ensemble reside 
        do hh = 0,nens-1
           modname_mod = modname_pr(cntr_ens(hh))
           syear_mod = syear_pr(cntr_ens(hh))
           eyear_mod = eyear_pr(cntr_ens(hh))
           names_mod = names_pr(cntr_ens(hh))
           names_EM_mod = names_EM(cntr_ens(hh))

           fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv.pr."+syear_mod+"-"+eyear_mod+".nc"
           fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname(dd))

           if (isatt(arr,"is_all_missing")) then
              cntr = cntr+1
              continue
           end if

           if (.not.isvar("arr_store")) then  ; create an array to house all members, to be used to calculate EM
              arr_store = new((/nens,dimsizes(arr&lat),dimsizes(arr&lon)/),typeof(arr))
              arr_store!0 = "ensmem"
              arr_store!1 = "lat"
              arr_store&lat = arr&lat
              arr_store!2 = "lon"
              arr_store&lon = arr&lon
              arr_store@nens = 0
              copy_VarAtts(arr,arr_store)

              syear_em0 = syear_mod
              eyear_em0 = eyear_mod
              showyr = True
           end if
           if (showyr) then
              if (syear_em0.ne.syear_mod.or.eyear_em0.ne.eyear_mod.and.showyr) then
                 showyr = False
              end if
           end if
           res@gsnCenterStringFontColor = csubtitle_color(gg-1)
           res2@gsnCenterStringFontColor = csubtitle_color(gg-1)

           arr_store(hh,:,:) = (/ arr /)
           arr_store@nens = arr_store@nens+1
           panres@lbTitleString = arr@units

           if (.not.isvar("obs0_rg")) then  
              obs0_rg = linint2_Wrap(obs0&lon,obs0&lat,obs0,True,arr&lon,arr&lat,0)
           end if
           obs_diff = arr
           obs_diff = (/ arr - obs0_rg /)

           res@gsnLeftString = syear_mod+"-"+eyear_mod
           res@gsnRightString = "r="+pattern_correlation(obs0_rg,arr)
           res@gsnCenterString = names_mod
           plot_indmem(cntr) = gsn_csm_contour_map(wks,arr,res)
           res2@gsnLeftString = "" 
           res2@gsnRightString = ""  
           res2@gsnCenterString = names_mod+"-"+names_pr(0)  
           plot_indmem_diff(cntr) = gsn_csm_contour_map(wks,obs_diff,res2)
           delete([/arr,obs_diff/])
           cntr = cntr+1
        end do
        if (.not.isvar("arr_store")) then
           cntr_EM = cntr_EM+4
           continue
        end if

        if (lbFlag) then
           res@lbLabelBarOn = True
           res2@lbLabelBarOn = True
           tres@lbLabelBarOn = True
        end if
        arr_EM = dim_avg_n_Wrap(arr_store,0)

        res@gsnCenterStringFontColor = "black"
        res2@gsnCenterStringFontColor = "black"

        res@lbTitleString = arr_EM@units   
        res2@lbTitleString = res@lbTitleString 
        res@gsnLeftString = syear_pr(0)+"-"+eyear_pr(0) 
        res@gsnRightString = ""  
        res@gsnCenterString = "Observations ("+names_pr(0)+")"    
        plot_summary(cntr_EM+1) = gsn_csm_contour_map(wks,obs0,res)

        if (showyr) then
           res@gsnLeftString = syear_em0+"-"+eyear_em0 
        else
           res@gsnLeftString = (eyear_em0-syear_em0+1)+"yrs" 
        end if
        delete([/syear_em0,eyear_em0,showyr/])
        res@gsnCenterStringFontColor = csubtitle_color(gg-1)
        res@gsnRightString = "r="+pattern_correlation(obs0_rg,arr_EM)
        res@gsnCenterString = names_EM_mod +" ("+arr_store@nens+" Members)"                       
        plot_summary(cntr_EM) = gsn_csm_contour_map(wks,arr_EM,res)
        obs_diff = arr_EM
        obs_diff = (/ arr_EM - obs0_rg /)
        res2@gsnLeftString = ""
        res2@gsnCenterString = names_EM_mod+" - Observations" 
        res2@gsnRightString = ""  
        plot_summary(cntr_EM+2) = gsn_csm_contour_map(wks,obs_diff,res2)

        p_val = calculate_pval(obs0_rg,arr_store)
        tres@gsnRightString = calculate_area_in_range(p_val,10,90)+"%"
        plot_summary(cntr_EM+3) = gsn_csm_contour_map(wks,p_val,tres)

        fno = getenv("OUTDIR")+str_sub_str(names_EM_mod," ","_")+"_EM.cvdp_data.pdv.pr."+syear_mod+"-"+eyear_mod+".nc"
        if (isfilepresent2(fno)) then
           z = addfile(fno,"w")
        else
           z = addfile(fno,"c")
           set_global_ncfile_attributes(z,names_EM_mod,syear_mod,eyear_mod,getenv("VERSION"))
        end if
        z->$(/variname(dd)+"_em"/)$ = set_varAtts(arr_EM,arr_EM@long_name+" Ensemble Mean","","")
        z->$(/variname(dd)+"_em_diffobs"/)$ = set_varAtts(obs_diff,obs_diff@long_name+" Ensemble Mean difference from observations","","")           
        z->$(/variname(dd)+"_pval"/)$ = set_varAtts(p_val,arr_EM@long_name+" p-val statistic","%","")   
        delete([/p_val,arr_store,obs0_rg,obs_diff,arr_EM,z/])
        cntr_EM = cntr_EM+4
     end do
     panres@txString = title(dd)+" PR Regressions (Monthly)"
     gsn_panel2(wks,plot_indmem,(/nrow,ncol/),panres)

     panres@txString = title(dd)+" PR Regressions Differences (Monthly)"
     gsn_panel2(wks,plot_indmem_diff,(/nrow,ncol/),panres)

     panres2@txString = "Ensemble Summary: "+title(dd)+" PR Regressions (Monthly)"
     gsn_panel2(wks,plot_summary,(/nEM,4/),panres2)
     frame(wks)
     delete(wks)

     if (wks_type.eq."png") then
        system("mv "+OUTDIR+"pdv.000001.png "+OUTDIR+outputname(dd)+".indmem.png")
        system("mv "+OUTDIR+"pdv.000002.png "+OUTDIR+outputname(dd)+".indmemdiff.png")
        system("mv "+OUTDIR+"pdv.000003.png "+OUTDIR+outputname(dd)+".summary.png")
        if (PNG_SCALE_SUMMARY.ne.100) then
           system("convert -resize "+PNG_SCALE_SUMMARY+"% "+OUTDIR+outputname(dd)+".summary.png "+OUTDIR+outputname(dd)+".summary.png")
        end if
     else
        system("psplit "+OUTDIR+"pdv.ps "+OUTDIR+"pdv")
        system("mv "+OUTDIR+"pdv0001.ps "+OUTDIR+outputname(dd)+".indmem.ps")
        system("mv "+OUTDIR+"pdv0002.ps "+OUTDIR+outputname(dd)+".indmemdiff.ps")
        system("mv "+OUTDIR+"pdv0003.ps "+OUTDIR+outputname(dd)+".summary.ps")
        system("rm "+OUTDIR+"pdv.ps")
     end if
  end do
  delete([/panres,panres2/])
;---Timeseries plotting section--------------------------------------------------------------------------------------------
  xyres = True    ; individual obs/model line plot resource list
  xyres@gsnDraw = False
  xyres@gsnFrame = False
  xyres@gsnYRefLine = 0.0
  xyres@gsnYRefLineColor = "gray42"
     
  if (wks_type.eq."png") then
     xyres@xyLineThicknessF = 4.
  else
     xyres@xyLineThicknessF = 2.
  end if
  xyres@xyLineColor = "royalblue"
  xyres@tiYAxisString = ""
  xyres@tmXBLabelFontHeightF = 0.015
  xyres@tmYLLabelFontHeightF = 0.015
  xyres@gsnLeftStringFontHeightF = 0.0175     
  xyres@gsnCenterStringFontHeightF = 0.0135     
  xyres@gsnRightStringFontHeightF = xyres@gsnCenterStringFontHeightF  
  xyres@gsnLeftStringOrthogonalPosF = 0.025
  xyres@gsnCenterStringOrthogonalPosF = -1.0
  xyres@gsnCenterStringParallelPosF = 0.05
  xyres@gsnRightStringOrthogonalPosF = xyres@gsnLeftStringOrthogonalPosF
  xyres@vpHeightF = 0.25
  xyres@vpWidthF = 0.7
  xyres@gsnLeftString = ""     
  xyres@gsnCenterString = ""
  xyres@gsnRightString = ""
     
  xyres2 = xyres     ; for observational line overlays in individual panels
  xyres2@xyLineColor = "gray60"
  xyres2@xyCurveDrawOrder = "PreDraw"

  xyres_sum = xyres
  xyres_sum@xyLineColor        = "dodgerblue2"
  xyres_sum@gsnCenterStringFontColor = "black"

  xyres2_sum = xyres2   ; for observational line overlays in ensemble panels

  if (wks_type.eq."png") then
     xyres_sum@xyLineThicknessF = 16.
     xyres2_sum@xyLineThicknessF = 16.
  else
     xyres_sum@xyLineThicknessF = 3.
     xyres2_sum@xyLineThicknessF = 3.
  end if

  xyres2A = xyres2   ; for observational line overlays in ensemble mean summary
  xyres2A@xyLineThicknessF = xyres_sum@xyLineThicknessF

  xyres_sumA = xyres   ; for summary ensemble mean line plot
  xyres_sumA@xyLineThicknessF = xyres_sum@xyLineThicknessF  

  xyres3_sum = xyres_sum   ; resource list for shaded 2 std dev range
  xyres3_sum@gsnXYFillColors = (/30/356.,144/256.,1.,0.25/)  ;"dodgerblue"
  xyres3_sum@xyLineColors        := (/"transparent","transparent"/)       
  xyres3_sum@xyDashPattern      = 0
  xyres3_sum@xyLineColor = "transparent"
  xyres3_sum@gsnRightStringFontColor = "black"

  xyres3b_sum = xyres3_sum   ; resource list for shaded 1 std dev range
  xyres3b_sum@gsnXYFillColors = (/30/356.,144/256.,1.,0.5/)  ;"dodgerblue"

  panres3 = True  ; panel resource list for individual member plots
  panres3@gsnMaximize = True  
  panres3@gsnPaperOrientation = "portrait"
  panres3@gsnMainPanelFontHeightF = 0.014
  panres3@gsnPanelBottom = 0.05
  panres3@gsnPanelYWhiteSpacePercent = 2.5

  panres4 = panres3  ; panel resource list for ensemble plots
  panres4@gsnMainPanelFontHeightF = 0.014
  panres4@gsnMaximize = False
  panres4@gsnFrame = False
  panres4@gsnPanelTop = 0.94
  panres4@gsnPanelXWhiteSpacePercent = 3.0
  panres4@gsnPanelYWhiteSpacePercent = 3.0

  txres = True
  txres@txFontHeightF = 0.010
  txres@txFontColor = xyres2@xyLineColor

  ncolE = floattointeger(sqrt(nEM+1))   ; +1 for the summary plot
  nrowE = ((nEM+1)/ncolE)+mod(nEM+1,ncolE)

  variname       := (/"pdv_timeseries_mon","pdv_prime_timeseries_mon"/)
  variname_obs   := (/"pdv_timeseries_mon","pdv_timeseries_mon"/)
  variname_title := (/"PDV","PDV'"/)
  variname_title := variname_title+" Timeseries"

  do dd = 0,dimsizes(variname)-1
     wks = gsn_open_wks(wks_type,getenv("OUTDIR")+"pdv.timeseries")
     plot_indmem      := new(nsim,"graphic")   ; for individual obs/models
     plot_obs_overlay := new(nsim,"graphic")   ; for obs overlaid onto individual models
     plot_summary     := new(nEM,"graphic")    ; for ensemble plots  to show the 2 std dev range
     plot_summary1    := new(nEM,"graphic")    ; for ensemble plots to show the 1 std dev range
     plot_summary2    := new(nEM,"graphic")    ; for ensemble plots to show the ensemble mean
     plot_summary_obs_overlay := new(nEM,"graphic")  ; for ensemble plots to show overlaid obs
     plot_sum         := new(nEM,"graphic")    ; for individual panel in ensemble plots showing each ensemble mean
     plot_sum2        := new(nEM,"graphic")    ; for individual panel in ensemble plots showing each ensemble 10-90% range     

     XMinF := new(1,double)    ; used for summary timeseries plot showing all ensemble means
     XMaxF := new(1,double)
     YMinF := new(1,double)
     YMaxF := new(1,double)

     numobs = num(EM_num.eq.0) 
     if (numobs.eq.0) then
        fnt = getenv("OUTDIR")+"obs.cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2 = getenv("OUTDIR")+"obs.cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        cntr = 0
     else
        fnt = getenv("OUTDIR")+modname(0)+".cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2 = getenv("OUTDIR")+modname(0)+".cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        cntr = 1
     end if
     obs0 := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))

     if (isatt(obs0,"is_all_missing")) then 
        obs0New = new((eyear(0)-syear(0)+1)*12,float)
        copy_VarAtts(obs0,obs0New)
        obs0 := obs0New
        delete(obs0New)
     end if
     obs0!0 = "time"
     obs0&time = fspan(syear(0),eyear(0)+.91667,nyr(0)*12)
     xyres@gsnLeftStringFontColor = "black"
     xyres2@gsnLeftStringFontColor = "black"
     if (isatt(xyres,"trYMinF")) then
        delete([/xyres@trYMinF,xyres@trYMaxF/])
     end if
     xyres@trXMinF = syear(0)-.5
     xyres@trXMaxF = eyear(0)+1.5
     tttt := dtrend_msg(ispan(0,dimsizes(obs0&time)-1,1),obs0,False,True)   
     xyres@gsnLeftString = names(0)
     obs_val := decimalPlaces(tttt@slope*dimsizes(obs0&time),2,True)+" "+nyr(0)+"yr~S~-1~N~"  ;+obs0@units +" "+nyr(0)+"yr~S~-1~N~"
     xyres@gsnRightString = obs_val
     plot_indmem(0) = gsn_csm_xy(wks,obs0&time,obs0,xyres)
     xyres2A@gsnLeftString = "Ensemble Mean Summary"
     plot_obs := gsn_csm_xy(wks,obs0&time,obs0,xyres2A)
     cntr_EM = 0
     if (numobs.ge.2) then     ; plot obs #2-
        do ff = 1,numobs-1
           fnt = getenv("OUTDIR")+modname(cntr)+".cvdp_data.pdv."+syear(cntr)+"-"+eyear(cntr)+".nc"
           fnt2 = getenv("OUTDIR")+modname(cntr)+".cvdp_data."+syear(cntr)+"-"+eyear(cntr)+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))
           arr!0 = "time"
           arr&time = fspan(syear(cntr),eyear(cntr)+.91667,nyr(cntr)*12)
           if (isatt(arr,"is_all_missing")) then 
              cntr = cntr+1
              continue
           end if
           xyres@trXMinF = syear(cntr)-.5
           xyres@trXMaxF = eyear(cntr)+0.5
           xyres@trYMinF = min((/min(obs0),min(arr)/))-dim_stddev(arr)/2.
           xyres@trYMaxF = max((/max(obs0),max(arr)/))+dim_stddev(arr)/2.
           tttt := dtrend_msg(ispan(0,dimsizes(arr&time)-1,1),arr,False,True)   
           xyres@gsnLeftString = names(cntr)
           xyres@gsnRightString = decimalPlaces(tttt@slope*dimsizes(arr&time),2,True)+" "+nyr(cntr)+"yr~S~-1~N~"
           plot_indmem(cntr) = gsn_csm_xy(wks,arr&time,arr,xyres)
           plot_obs_overlay(cntr) = gsn_csm_xy(wks,obs0&time,obs0,xyres2)
           overlay(plot_indmem(cntr),plot_obs_overlay(cntr))
           delete([/arr,tttt/])
           cntr = cntr+1
        end do
     end if
     do gg = 1,nEM   ; operate on each ensemble mean
        nens = num(EM_num.eq.gg) ; determines how many model simulations in each ensemble
        cntr_ens := ind(EM_num.eq.gg)   ; cntr_ens(hh) are the indices where each ensemble member of an ensemble reside 

        do hh = 0,nens-1
           modname_mod = modname(cntr_ens(hh))
           syear_mod = syear(cntr_ens(hh))
           eyear_mod = eyear(cntr_ens(hh))
           names_mod = names(cntr_ens(hh))
           names_EM_mod = names_EM(cntr_ens(hh))

           fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
           fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname(dd))
           if (isatt(arr,"is_all_missing")) then 
              cntr = cntr+1
              continue
           end if
           time_save := arr&time ; for ensemble mean time write out below
           arr!0 = "time"
           arr&time = fspan(syear_mod,eyear_mod+.91667,(eyear_mod-syear_mod+1)*12)
           if (.not.isvar("arr_store")) then  ; create an array to house all members, to be used to calculate EM
              arr_store := new((/nens,dimsizes(arr&time)/),typeof(arr))
              arr_store!0 = "ensmem"
              arr_store!1 = "time"
              arr_store&time = arr&time
              arr_store@nens = 0
              copy_VarAtts(arr,arr_store)

              syear_em0 = syear_mod
              eyear_em0 = eyear_mod
              showyr = True
           end if
           if (showyr) then
              if (syear_em0.ne.syear_mod.or.eyear_em0.ne.eyear_mod.and.showyr) then
                 showyr = False
              end if
           end if
           arr_store(hh,:) = (/ arr /)
           arr_store@nens = arr_store@nens+1
           xyres@gsnLeftStringFontColor = csubtitle_color(gg-1)
           xyres2@gsnLeftStringFontColor = csubtitle_color(gg-1)
           xyres@trXMinF = syear_mod-.5
           xyres@trXMaxF = eyear_mod+0.5
           xyres@trYMinF = min((/min(obs0),min(arr)/))-dim_stddev(arr)/2.
           xyres@trYMaxF = max((/max(obs0),max(arr)/))+dim_stddev(arr)/2.
           tttt := dtrend_msg(ispan(0,dimsizes(arr&time)-1,1),arr,False,True)   
           xyres@gsnLeftString = names_mod
           xyres@gsnRightString = decimalPlaces(tttt@slope*dimsizes(arr&time),2,True)+" "+nyr(cntr)+"yr~S~-1~N~"
           plot_indmem(cntr) = gsn_csm_xy(wks,arr&time,arr,xyres)
           plot_obs_overlay(cntr) = gsn_csm_xy(wks,obs0&time,obs0,xyres2)
           overlay(plot_indmem(cntr),plot_obs_overlay(cntr))
           delete([/arr,tttt/])
           cntr = cntr+1
        end do
        if (.not.isvar("arr_store")) then
           cntr_EM = cntr_EM+1
           continue
        end if
        arr_EM := dim_avg_n_Wrap(arr_store,0)
        arr_range1 := define_arr_range_array(arr_EM,1)
        arr_range2 := define_arr_range_array(arr_EM,2)
        do zz = 0,dimsizes(arr_EM)-1
           ds := boxplot_stat(arr_store(:,zz))
           arr_range1(0,zz) = (/ ds(1) /)
           arr_range1(1,zz) = (/ ds(3) /)
           arr_range2(0,zz) = (/ ds(0) /)
           arr_range2(1,zz) = (/ ds(4) /)
        end do

        xyres3_sum@trXMinF := min(arr_EM&time)-.5
        xyres3_sum@trXMaxF := max(arr_EM&time)+0.5
        xyres3_sum@trYMinF = (/ min((/min(arr_EM),min(obs0),min(arr_range2)/))-dim_stddev(arr_EM)/2. /)
        xyres3_sum@trYMaxF = (/ max((/max(arr_EM),max(obs0),max(arr_range2)/))+dim_stddev(arr_EM)/2. /)

        XMinF = tofloat(min((/XMinF,min(arr_EM&time)/)))
        XMaxF = tofloat(max((/XMaxF,max(arr_EM&time)/)))
        YMinF = tofloat(min((/YMinF,min(arr_EM),min(obs0)/)))
        YMaxF = tofloat(max((/YMaxF,max(arr_EM),max(obs0)/)))

        ssss := dtrend_msg(ispan(0,dimsizes(arr_store&time)-1,1),arr_store,False,True)
        tttt := dtrend_msg(ispan(0,dimsizes(arr_EM&time)-1,1),arr_EM,False,True)  
        xyres3_sum@gsnXYFillColors = (/30/356.,144/256.,1.,0.25/)  ;"dodgerblue"
        xyres3b_sum@gsnXYFillColors = (/30/356.,144/256.,1.,0.5/)  ;"dodgerblue"
        if (all(ismissing(arr_range2(0,:)))) then  ; necessary as gsnXYFillColors causes NCL to fail when data all missing
           delete(xyres3_sum@gsnXYFillColors)
           delete(xyres3b_sum@gsnXYFillColors)
        end if
        xyres_sum@gsnLeftString = names_EM_mod +" ("+arr_store@nens+" Members)"   
        xyres_sum@gsnLeftStringFontColor = csubtitle_color(gg-1)
        xyres_sumA@xyLineColor = csubtitle_color(gg-1)
        xyres_sum@gsnCenterString = calculate_percent_in_range(obs0,arr_range2)+"%"
        ss_slope := ssss@slope
        ss_slope@_FillValue = arr_store@_FillValue
        stats := boxplot_stat(ss_slope)
        xyres3_sum@gsnRightString = decimalPlaces(stats(0)*dimsizes(arr_EM),2,True)+"/"+decimalPlaces(tttt@slope*dimsizes(arr_EM),2,True)+"/"+decimalPlaces(stats(4)*dimsizes(arr_EM),2,True)+" "+arr_EM@units+" "+(dimsizes(arr_EM)/12)+"yr~S~-1~N~"
        plot_summary(cntr_EM) = gsn_csm_xy(wks,arr_range2&time,arr_range2,xyres3_sum)
        plot_summary1(cntr_EM) = gsn_csm_xy(wks,arr_range1&time,arr_range1,xyres3b_sum)
        plot_summary2(cntr_EM) = gsn_csm_xy(wks,arr_EM&time,arr_EM,xyres_sum)
        plot_summary_obs_overlay(cntr_EM) = gsn_csm_xy(wks,obs0&time,obs0,xyres2_sum)
        plot_sum(cntr_EM) = gsn_csm_xy(wks,arr_EM&time,arr_EM,xyres_sumA)
        overlay(plot_summary(cntr_EM),plot_summary1(cntr_EM))
        overlay(plot_summary(cntr_EM),plot_summary_obs_overlay(cntr_EM))
        overlay(plot_summary(cntr_EM),plot_summary2(cntr_EM))

        arr_EM&time = time_save
        arr_range1&time = time_save
        arr_range2&time = time_save

        fout = getenv("OUTDIR")+str_sub_str(names_EM_mod," ","_")+"_EM.cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
        if (isfilepresent2(fout)) then
           z = addfile(fout,"w")
        else
           z = addfile(fout,"c")
           set_global_ncfile_attributes(z,names_EM_mod,syear_mod,eyear_mod,getenv("VERSION"))
        end if
        z->$(/variname(dd)+"_em"/)$ = set_varAtts(arr_EM,arr_EM@long_name+" Ensemble Mean","","")
        z->$(/variname(dd)+"_2575range"/)$ = set_varAtts(arr_range1,arr_EM@long_name+" 25/75% range","","")
        z->$(/variname(dd)+"_1090range"/)$ = set_varAtts(arr_range2,arr_EM@long_name+" 10/90% range","","")
        delete([/arr_EM,z,tttt,ssss,arr_store,time_save/])
        cntr_EM = cntr_EM+1
     end do
     panres3@txString = variname_title(dd)+" (Monthly)"
     gsn_panel2(wks,plot_indmem,(/nrow,ncol/),panres3)

     YMinF = YMinF - ((YMaxF - YMinF)*.05)
     YMaxF = YMaxF + ((YMaxF - YMinF)*.05)
     plot_final := new(nEM+1,graphic)
     plot_final(:nEM-1) = plot_summary
     ii_ind := id_firstvalid_ind(plot_sum)
     if (.not.ismissing(ii_ind)) then
        if (.not.ismissing(plot_obs)) then
           overlay(plot_sum(ii_ind),plot_obs)
        end if
        do ii = ii_ind,nEM-1 
           if (.not.ismissing(plot_sum(ii)).and.ii.ne.ii_ind) then
              overlay(plot_sum(ii_ind),plot_sum(ii))
           end if
        end do     
        setvalues plot_sum(ii_ind)
           "trXMinF" : XMinF-0.5
           "trXMaxF" : XMaxF+0.5
           "trYMinF" : YMinF
           "trYMaxF" : YMaxF
        end setvalues
        plot_final(nEM)    = plot_sum(ii_ind)
     end if
     panres4@gsnPanelMainPosYF = set_panel_title_YF(nEM+1,xyres)
     panres4@gsnPanelMainString = "Ensemble Summary: "+variname_title(dd)+" (Monthly)"
     gsn_panel2(wks,plot_final,(/nrowE,ncolE/),panres4)
     if (numobs.ne.0) then  
        gsn_text_ndc(wks,names(0)+" "+syear(0)+"-"+eyear(0)+" trend = "+obs_val,0.5,panres4@gsnPanelMainPosYF-.025,txres)
     end if
     frame(wks)
     delete(wks)

     if (wks_type.eq."png") then
        system("mv "+OUTDIR+"pdv.timeseries.000001.png "+OUTDIR+variname(dd)+".indmem.png")
        system("mv "+OUTDIR+"pdv.timeseries.000002.png "+OUTDIR+variname(dd)+".summary.png")
        if (PNG_SCALE_SUMMARY.ne.100) then
           system("convert -resize "+PNG_SCALE_SUMMARY+"% "+OUTDIR+variname(dd)+".summary.png "+OUTDIR+variname(dd)+".summary.png")
        end if
     else
        system("psplit "+OUTDIR+"pdv.timeseries.ps "+OUTDIR+"pdv.timeseries")
        system("mv "+OUTDIR+"pdv.timeseries0001.ps "+OUTDIR+variname(dd)+".indmem.ps")
        system("mv "+OUTDIR+"pdv.timeseries0002.ps "+OUTDIR+variname(dd)+".summary.ps")
        system("rm "+OUTDIR+"pdv.timeseries.ps")
     end if
  end do
;---------Power spectra------------------------------------
  pres = True
  pres@vpHeightF = 0.6
  pres@vpWidthF = 0.6
  pres@trYMinF = 0.
  pres@trXMinF = 0.0
  pres@trXMaxF = 0.0832
  pres@tiYAxisString = "Power"              ; yaxis
  pres@gsnFrame      = False
  pres@gsnDraw       = False
  
  pres@tmXBLabelDeltaF = -.8
  pres@tmXTLabelDeltaF = -.8
  pres@pmLegendDisplayMode    = "Never"
  pres@xyDashPatterns      = (/0,0,0,0/)
  pres@xyMonoLineThickness = False
  pres@xyLineColors        = (/"foreground","red","blue","green"/)       
  pres@xyLabelMode = "custom"
  pres@xyLineLabelFontColors = pres@xyLineColors 
  pres@xyExplicitLabels = (/"","",val1*100+"%",val2*100+"%"/)
  if (wks_type.eq."png") then
     pres@xyLineThicknessF = 3.5
  else
     pres@xyLineThicknessF = 1.75
  end if
  pres@tmXTOn = True
  pres@tmYROn = False
  pres@tmXTLabelsOn = True
  pres@tmXUseBottom = False
  pres@tmXTMode   = "Explicit"  
  pres@tmXBMode   = "Explicit"            
  pres@tmXTValues = (/".00167",".00833",".01667",".02778",".0416",".0556",".0832"/)
  pres@tmXTLabels = (/"50","10","5","3","2","1.5","1"/)           
  pres@tmXBValues = (/".0",".01",".02",".03",".042",".056",".083"/)
  pres@tmXBLabels =  pres@tmXBValues
  pres@tmYLMode = "Explicit"
  pres@tmXTLabelFontHeightF = 0.021
  pres@tmXBLabelFontHeightF = 0.021
  pres@tmYLLabelFontHeightF = 0.021
  pres@tiYAxisString = "Power (~S~o~N~C~S~2~N~ / cycles mo~S~-1~N~)"              ; yaxis
  pres@tiXAxisString = "Frequency (cycles mo~S~-1~N~)"
  pres@tiMainString = ""
  pres@txFontHeightF = 0.025
  pres@xyLineLabelFontHeightF = 0.022
  pres@tiXAxisFontHeightF = 0.025
  pres@tiYAxisFontHeightF = 0.025
  pres@tiMainFontHeightF = 0.03
  pres@gsnRightStringOrthogonalPosF = -0.135

  pres_sumA = pres   ; for summary ensemble mean line plot
  pres_sumA@xyCurveDrawOrder = "PreDraw"
  if (wks_type.eq."png") then
     pres_sumA@xyLineThicknessF = 16.
  else
     pres_sumA@xyLineThicknessF = 3.
  end if

  pres2 = pres
  pres2@xyLineColors        := (/"transparent","transparent"/)       
  pres2@xyCurveDrawOrder = "PreDraw"
  pres2@xyDashPattern      = 0
  pres2@gsnXYOpacities = 0.7
  pres2@xyLineColor = "transparent"

  txres = True
  txres@txFontHeightF = 0.010

  panres = True
  panres@gsnMaximize = True  
  panres@gsnPaperOrientation = "portrait"
  panres@gsnMainPanelFontHeightF = 0.013
  panres@gsnPanelBottom = 0.05

  panres2 = panres
  panres2@gsnFrame = False
  panres2@gsnMaximize = False

  csubtitle_color = set_subtitle_colors(max(EM_num))

  variname := (/"pdv_spectra","pdv_prime_spectra"/)
  variname_obs := (/"pdv_spectra","pdv_spectra"/)
  title := (/"PDV","PDV'"/)
  outputname := (/"pdv.powspec","pdv.prime.powspec"/)

  do dd = 0,dimsizes(variname)-1
     wks = gsn_open_wks(wks_type,getenv("OUTDIR")+"pdv.powspec")

     plot_indmem      = new(nsim,"graphic")
     plot_obs_overlay = new(nsim,"graphic")
     plot_summary     = new(nEM,"graphic")    ; for ensemble plots to show the 10-90% range
     plot_summary2     = new(nEM,"graphic")   ; for ensemble plots to show the 25-75% range
     plot_obs_summary = new(nEM,"graphic")    ; for ensemble plots to show the 1st observational dataset
     plot_summary_em  = new(nEM,"graphic")    ; for ensemble plots to show ensemble mean
     plot_sum         := new(nEM,"graphic")    ; for individual panel in ensemble plots showing each ensemble mean

     cntr_EM = 0
     numobs = num(EM_num.eq.0) 
     plot_obs_overlay = new(nsim,"graphic")

     if (numobs.eq.0) then
        fnt = getenv("OUTDIR")+"obs.cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2 = getenv("OUTDIR")+"obs.cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        cntr = 0
     else
        fnt = getenv("OUTDIR")+modname(0)+".cvdp_data.pdv."+syear(0)+"-"+eyear(0)+".nc"
        fnt2 = getenv("OUTDIR")+modname(0)+".cvdp_data."+syear(0)+"-"+eyear(0)+".nc"
        cntr = 1
     end if
     obs0 := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))
     if (isatt(obs0,"is_all_missing")) then
        obs0New = new((/4,11/),float)
        copy_VarAtts(obs0,obs0New)
        obs0 := obs0New
        delete(obs0New)
        obs0!1 = "frequency"
        obs0&frequency = fspan(0,0.1,11)
     end if
     pres@gsnCenterStringFontColor = "black"
     if (wks_type.eq."png") then
        pres@xyLineThicknesses   = (/7.5,2.,1.,1./) 
     else
        pres@xyLineThicknesses   = (/2.5,1.5,1.,1./) 
     end if
     pres@gsnLeftString = ""  
     pres@gsnCenterString = names(0)   
     pres@gsnRightString = syear(0)+"-"+eyear(0)+" "  
     plot_indmem(0) = gsn_csm_xy(wks,obs0&frequency,obs0,pres)

     if (numobs.ge.2) then     ; plot obs #2-
        do ff = 1,numobs-1
           fnt = getenv("OUTDIR")+modname(cntr)+".cvdp_data.pdv."+syear(cntr)+"-"+eyear(cntr)+".nc"
           fnt2 = getenv("OUTDIR")+modname(cntr)+".cvdp_data."+syear(cntr)+"-"+eyear(cntr)+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname_obs(dd))
           if (isatt(arr,"is_all_missing")) then
              cntr = cntr+1
              continue
           end if
           pres@xyLineColors        = (/"foreground","red","blue","green"/)      
           pres@gsnCenterString = names(cntr)   
           pres@gsnRightString = syear(cntr)+"-"+eyear(cntr)+"   " 
           plot_indmem(cntr) = gsn_csm_xy(wks,arr&frequency,arr,pres)
           pres@xyCurveDrawOrder = "PreDraw"
           pres@xyLineColors        = (/"gray70","black","black","black"/)
           plot_obs_overlay(cntr)   = gsn_csm_xy(wks,obs0&frequency,obs0(0,:),pres)
           overlay(plot_indmem(cntr),plot_obs_overlay(cntr))
           delete([/arr,pres@xyCurveDrawOrder/])
           cntr = cntr+1
        end do
     end if

     do gg = 1,nEM   ; operate on each ensemble mean
        nens = num(EM_num.eq.gg) ; determines how many model simulations in each ensemble
        cntr_ens := ind(EM_num.eq.gg)   ; cntr_ens(hh) are the indices where each ensemble member of an ensemble reside 
        do hh = 0,nens-1
           modname_mod = modname(cntr_ens(hh))
           syear_mod = syear(cntr_ens(hh))
           eyear_mod = eyear(cntr_ens(hh))
           names_mod = names(cntr_ens(hh))
           names_EM_mod = names_EM(cntr_ens(hh))

           fnt = getenv("OUTDIR")+modname_mod+".cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
           fnt2 = getenv("OUTDIR")+modname_mod+".cvdp_data."+syear_mod+"-"+eyear_mod+".nc"
           arr := read_cvdp_le_data(fnt,fnt2,variname(dd))
           if (isatt(arr,"is_all_missing")) then
              cntr = cntr+1
              continue
           end if
           if (.not.isvar("arr_store")) then  ; create an array to house all members, to be used to calculate EM
              arr_store = new((/nens,dimsizes(arr&frequency)/),typeof(arr))
              arr_store!0 = "ensmem"
              arr_store!1 = "frequency"
              arr_store&frequency = arr&frequency
              arr_store@nens = 0
              copy_VarAtts(arr,arr_store)

              syear_em0 = syear_mod
              eyear_em0 = eyear_mod
              showyr = True
           end if
           if (showyr) then
              if (syear_em0.ne.syear_mod.or.eyear_em0.ne.eyear_mod.and.showyr) then
                 showyr = False
              end if
           end if
           arr_store(hh,:) = (/ arr(0,:) /) 
           arr_store@nens = arr_store@nens+1
           pres@gsnCenterStringFontColor = csubtitle_color(gg-1)
           pres@xyLineColors        = (/"foreground","red","blue","green"/)      
           pres@gsnCenterString = names_mod   
           pres@gsnRightString = syear_mod+"-"+eyear_mod+"  "
           plot_indmem(cntr) = gsn_csm_xy(wks,arr&frequency,arr,pres)
           pres@xyCurveDrawOrder = "PreDraw"
           pres@xyLineColors        = (/"gray70","black","black","black"/)
           if (dd.eq.0) then
              plot_obs_overlay(cntr)   = gsn_csm_xy(wks,obs0&frequency,obs0(0,:),pres)
              overlay(plot_indmem(cntr),plot_obs_overlay(cntr))
           end if
           delete([/arr,pres@xyCurveDrawOrder/])
           cntr = cntr+1
        end do
        if (.not.isvar("arr_store")) then
           cntr_EM = cntr_EM+1
           continue
        end if
        delete([/pres@xyLineColors,pres@gsnCenterStringFontColor/])

        arr_EM := dim_avg_n_Wrap(arr_store,0)
        arr_range1 := define_arr_range_array(arr_EM,1)
        arr_range2 := define_arr_range_array(arr_EM,2)
        do zz = 0,dimsizes(arr_EM)-1
           ds := boxplot_stat(arr_store(:,zz))
           arr_range1(0,zz) = (/ ds(1) /)
           arr_range1(1,zz) = (/ ds(3) /)
           arr_range2(0,zz) = (/ ds(0) /)
           arr_range2(1,zz) = (/ ds(4) /)
        end do
        pres2@gsnLeftString = ""
        if (showyr) then
           pres2@gsnRightString = syear_em0+"-"+eyear_em0+"   " 
        else
           pres2@gsnRightString = (eyear_em0-syear_em0+1)+"yrs   " 
        end if
        delete([/syear_em0,eyear_em0,showyr/])
        YMaxF = tofloat(max((/max(YMaxF),max(arr_EM),max(obs0(0,:))/)))

        pres2@gsnXYFillColors = (/30/356.,144/256.,1.,0.25/)  ;"dodgerblue"
        if (all(ismissing(arr_range2(0,:)))) then
           delete(pres2@gsnXYFillColors)
        end if
        pres2@gsnCenterStringFontColor = csubtitle_color(gg-1)
        pres2@gsnCenterString = names_EM_mod +" ("+arr_store@nens+" Members)"  
        plot_summary(cntr_EM) = gsn_csm_xy(wks,arr_range2&frequency,arr_range2,pres2)
        pres2@gsnXYFillColors = (/30/356.,144/256.,1.,0.5/)  ;"dodgerblue"
        if (all(ismissing(arr_range1(0,:)))) then
           delete(pres2@gsnXYFillColors)
        end if
        plot_summary2(cntr_EM) = gsn_csm_xy(wks,arr_range1&frequency,arr_range1,pres2)

        pres_sumA@xyLineColors        = (/"dodgerblue4","black","black","black"/)
        plot_summary_em(cntr_EM) = gsn_csm_xy(wks,arr_EM&frequency,arr_EM,pres_sumA)
        pres_sumA@xyLineColors        = (/"gray50","black","black","black"/)
        plot_obs_summary(cntr_EM) = gsn_csm_xy(wks,obs0&frequency,obs0(0,:),pres_sumA)
        pres_sumA@xyLineColors = (/csubtitle_color(gg-1),"black","black","black"/)
        plot_sum(cntr_EM) = gsn_csm_xy(wks,arr_EM&frequency,arr_EM,pres_sumA)

        overlay(plot_summary(cntr_EM),plot_summary2(cntr_EM))
        overlay(plot_summary(cntr_EM),plot_obs_summary(cntr_EM))
        overlay(plot_summary(cntr_EM),plot_summary_em(cntr_EM))
        fout = getenv("OUTDIR")+str_sub_str(names_EM_mod," ","_")+"_EM.cvdp_data.pdv."+syear_mod+"-"+eyear_mod+".nc"
        if (isfilepresent2(fout)) then
           z = addfile(fout,"w")
        else
           z = addfile(fout,"c")
           set_global_ncfile_attributes(z,names_EM_mod,syear_mod,eyear_mod,getenv("VERSION"))
        end if
        z->$(/variname(dd)+"_em"/)$ = set_varAtts(arr_EM,arr_EM@long_name+" Ensemble Mean","","")
        z->$(/variname(dd)+"_2575range"/)$ = set_varAtts(arr_range1,arr_EM@long_name+" 25/75% range","","")
        z->$(/variname(dd)+"_1090range"/)$ = set_varAtts(arr_range2,arr_EM@long_name+" 10/90% range","","")
        delete([/arr_store,arr_EM,arr_range1,arr_range2/])
        cntr_EM = cntr_EM+1
     end do
     panres@txString = title(dd)+" Power Spectra (Monthly)"
     gsn_panel2(wks,plot_indmem,(/nrow,ncol/),panres)


     pres_sumA@xyCurveDrawOrder = "PostDraw"
     pres_sumA@xyLineColors        = (/"gray50","black","black","black"/)
     pres_sumA@gsnCenterString = "Ensemble Mean Summary"
     pres_sumA@gsnRightString = ""
     plot_obs := gsn_csm_xy(wks,obs0&frequency,obs0(0,:),pres_sumA)
     pres_sumA@gsnCenterString = ""
     YMaxF = YMaxF + (YMaxF*.05)
     plot_final := new(nEM+1,graphic)
     plot_final(:nEM-1) = plot_summary
     ii_ind := id_firstvalid_ind(plot_sum)
     if (.not.ismissing(ii_ind)) then
        overlay(plot_sum(ii_ind),plot_obs)
        do ii = ii_ind,nEM-1
           if (.not.ismissing(plot_sum(ii)).and.ii.ne.ii_ind) then
              overlay(plot_sum(ii_ind),plot_sum(ii))
           end if
        end do       
        setvalues plot_sum(ii_ind)
           "trYMaxF" : YMaxF
        end setvalues
        plot_final(nEM)    = plot_sum(ii_ind)
     end if
     panres2@gsnPanelMainPosYF = set_panel_title_YF(nEM+1,pres)
     panres2@gsnPanelMainString = "Ensemble Summary: "+title(dd)+" Power Spectra (Monthly)"
     gsn_panel2(wks,plot_final,(/nrowE,ncolE/),panres2)
     if (numobs.ne.0) then  
        gsn_text_ndc(wks,names(0)+" "+syear(0)+"-"+eyear(0),0.5,panres2@gsnPanelMainPosYF-.02,txres)
     end if
     frame(wks)
     delete([/wks,plot_indmem,plot_summary/])

     if (wks_type.eq."png") then
        system("mv "+OUTDIR+"pdv.powspec.000001.png "+OUTDIR+outputname(dd)+".indmem.png")
        system("mv "+OUTDIR+"pdv.powspec.000002.png "+OUTDIR+outputname(dd)+".summary.png")
        if (PNG_SCALE_SUMMARY.ne.100) then
           system("convert -resize "+PNG_SCALE_SUMMARY+"% "+OUTDIR+outputname(dd)+".summary.png "+OUTDIR+outputname(dd)+".summary.png")
        end if
     else
        system("psplit "+OUTDIR+"pdv.powspec.ps "+OUTDIR+"pdv.powspec")
        system("mv "+OUTDIR+"pdv.powspec0001.ps "+OUTDIR+outputname(dd)+".indmem.ps")
        system("mv "+OUTDIR+"pdv.powspec0002.ps "+OUTDIR+outputname(dd)+".summary.ps")
        system("rm "+OUTDIR+"pdv.powspec.ps")
     end if
  end do
  print("Finished: pdv.ncl")
end  

