; CVDP-LE driver script. To run the CVDP-LE at the command line type: ncl driver.ncl
; To run the CVDP-LE at the command line, put it in background mode, and write the terminal output
; to a file named file.out, type: ncl driver.ncl >&! file.out &
; 
;============================================================================================
  outdir            = "/project/cas/asphilli/CVDP-LE/Comparison/"   ; location of output files   (must end in a "/")
                                                                  ; It is recommended that a new or empty directory be pointed to here 
                                                                  ; as existing files in outdir can get removed.

  namelists_only       = "False"             ; Set to True to only create the variable namelists. Useful
                                             ; upon running the package for the first time to verify that the correct
                                             ; files are being selected by the package. (See files in namelist_byvar/ directory)
                                             ; Set to False to run the entire package. 
                                             
  obs                  = "True"              ; True = analyze and plot observations (specified in namelist_obs), False = do not. 
  create_graphics      = "True"              ; True = create graphics from calculation results, False = only perform calculations and create netCDF files. 
;- - - - - - - - - - - - - - - - - -   
  colormap          = 0                      ; 0 = default colormaps, 1 = colormaps better for color blindness

  output_type       = "png"                  ; png = create png files, ps = create ps files as well as png files (for web viewing).  
  
  png_scale         = 3.0                    ; Set the output .png size. Value between .1->5.  Any value > 1 (< 1) increases (decreases) png size. 
                                             ; When output_type = "png" a value of 1 will result in a png sized 1500 (H) x 1500 (W) before automatic cropping of white space
                                             ; When output_type = "ps"  a value of 1 will result in a png density setting of 144 before automatic cropping of white space
  webpage_title     = "MMLEA 1950-2099"      ; Set webpage title   
  
  tar_output        = "False"                ; True = tar up all output in outdir and remove individual files, False = do not                                      
                                             ; Note: ALL files in outdir will be tarred up and then removed from the outdir directory. 
;---Advanced Options----------------------------------------------------------------------                                             
  zp = "ncl_scripts/"    ; directory path of CVDP NCL scripts. (must end in a "/")
                         ; Examples: "ncl_scripts/" if all code is local, or on CGD or CISL systems: "~asphilli/CESM-diagnostics/CVDP-LE/Release/v1.0.0/ncl_scripts/"
                         ; Regardless of this setting the following files should be in one directory: namelist, driver.ncl, and namelist_obs. 
                         ; If pointing to code in ~asphilli make sure the driver script version #s match between this script and the script in ~asphilli.  

  ncl_exec = "ncl"       ; This can be changed to a different path if a different version of NCL needs to be used, such as "/different/path/to/bin/ncl"                           
                         
  run_style = "parallel"   ; parallel = allow simple python-based parallelization to occur. (Default)  
                           ;            X number of CVDP-LE NCL scripts (set via max_num_tasks) will be called at once. Terminal output will be harder to follow.
                           ; serial = call CVDP-LE NCL scripts serially. (Default)    
                         
  max_num_tasks = 5      ; if run_parallel = "parallel", how many CVDP NCL scripts can be called at once? (If unsure set to 3)     
  
  modular =  "False"       ; True = Run only those CVDP scripts specified in modular_list.
                         ; False = Run all CVDP scripts (Default)

  modular_list = "tas.trends_timeseries"   ;  modular_list = "pdo, tas.mean_stddev, sst.mean_stddev, psl.mean_stddev, siconc.mean_stddev, pr.mean_stddev, clt.mean_stddev, sst.indices,amo"  ; When modular = "True" list the CVDP scripts that will be run. 
                                           ; Example: modular_list = "amoc,amo,pr.trends_timeseries"
                                           ; For a list of available scripts see complete_list at line 72. 

  machine_casesen = "True"   ; True = Your filesystem is case sensitive  (Default)
                             ; False = Your filesystem is case insensitive  
;========END USER MODIFICATIONS===========================================================
  version = "1.0.0"

  print("Started: CVDP-LE ("+systemfunc("date")+")")

  complete_list = "amv,sst.indices,siconc.trends_timeseries,psl.trends_timeseries,pdv,pr.trends_timeseries,"+\
                  "siconc.mean_stddev,soi,nam,nao,sam_psa,pna_npo,amoc,tas.trends_timeseries,"+\
                  "sst.mean_stddev,psl.mean_stddev,pr.mean_stddev,sst.trends_timeseries,tas.mean_stddev"


  loadscript(zp+"functions.ncl")
  if (.not.isfilepresent2(outdir)) then
     system("mkdir -p "+outdir)
  end if

  pngsumscale = 100   ; scale down size of summary images
  if (png_scale.ge.2) then
     pngsumscale = 75
  end if

  envvar_str = "   export OUTDIR="+outdir+";   export OBS="+obs+";   "+\
         "export CREATE_GRAPHICS="+create_graphics+";   export VERSION="+version+";   export PNG_SCALE="+png_scale+";   "+\
         "export OUTPUT_TYPE="+output_type+";   export MACHINE="+machine_casesen+";   "+\
         "export COLORMAP="+colormap+";   export CVDP_SCRIPTS="+zp+";   export PNG_SCALE_SUMMARY="+pngsumscale+";   "+\
         "export MAX_TASKS="+max_num_tasks+";"  
  ncl_exec = ncl_exec+" -n -Q" 

  system(envvar_str + " "+str_sub_str(ncl_exec," -Q","")+" "+zp+"namelist.ncl")     ; create variable namelists
  if (namelists_only.eq."True") then
     print("Variable namelists have been created. Examine files in namelist_byvar/ directory to verify CVDP-LE file selection.")
     print("Finished: CVDP-LE ("+systemfunc("date")+")")
     exit
  end if 

  if (modular.eq."True") then
     if (modular_list.ne."") then
        modular_list = str_sub_str(modular_list," ","")   ; remove spaces if present
        modular_list = str_sub_str(modular_list,",",".ncl,")   ; add .ncl in to end of each script name
        modular_list = modular_list+".ncl"                     ; add .ncl in to last script name
        if (run_style.eq."serial") then
           modular_list = str_sub_str(modular_list,","," "+ncl_exec+" "+zp)
           modular_list = str_sub_str(modular_list,".ncl",".ncl;")
           system(envvar_str+" "+ncl_exec+" "+zp+modular_list) 
        else
           modular_list = str_sub_str(modular_list,","," "+zp)
           system(envvar_str+" python "+zp+"runTasks.py "+zp+modular_list)
        end if
     end if
  else
     complete_list = str_sub_str(complete_list,",",".ncl,")   ; add .ncl in to end of each script name
     complete_list = complete_list+".ncl"                     ; add .ncl in to last script name
     if (run_style.eq."serial") then
        complete_list = str_sub_str(complete_list,","," "+ncl_exec+" "+zp)
        complete_list = str_sub_str(complete_list,".ncl",".ncl;")
        system(envvar_str+" "+ncl_exec+" "+zp+complete_list)   
     else
        complete_list = str_sub_str(complete_list,","," "+zp)
        system(envvar_str+" python "+zp+"runTasks.py "+zp+complete_list)		   
     end if
  end if

  system(envvar_str + " "+ncl_exec+" "+zp+"metrics.ncl")
  system(envvar_str + " "+ncl_exec+" "+zp+"ncfiles.append.ncl")
;--------------------------------------------
; Create webpages, finalize images and begin cleanup
;
  if (create_graphics.eq."True") then
     print("Creating webpages and finalizing images")
     image_finalize(outdir,output_type,max_num_tasks,zp,toint(144*png_scale))    ; trim whitespace, convert to .png (if necessary) and apply watermarks to images

     quote = str_get_dq()
     system("cp namelist_byvar/* "+outdir)
     system("cp namelist "+outdir)
     if (obs.eq."True") then
        system("cp namelist_obs "+outdir)
     end if
     system("   export OUTDIR="+outdir+";   export VERSION="+version+";   "+\
            "export OBS="+obs+";   export CVDP_SCRIPTS="+zp+"; "+ncl_exec+" 'webtitle="+quote+webpage_title+quote+"' "+zp+"webpage.ncl")

     system("cp "+zp+"cas_cvdp-le.png "+outdir)
  else
     system("rm "+outdir+"*.gif")   ; remove metric graphics as images not requested
  end if
;--------------------------------------------
; Create tar file of output (if requested)
;
  if (tar_output.eq."True") then
     if (isfilepresent2(outdir+"cvdp.tar")) then
        system("rm "+outdir+"cvdp.tar")
     end if
     system("cd "+outdir+"; tar -cf cvdp.tar *")
     system("cd "+outdir+"; rm *.png *.ps *.gif *.txt *.html *.nc namelist*")
  end if

  print("Finished: CVDP-LE ("+systemfunc("date")+")")
  
