pro term_length
  set_plot,'X'
  plotstuff,/set,/silent ; my plot settings

  ; read in the Senator data
  readcol,'former_US_senators.csv',delim=',', $
          senator, years, state, party, life, $
          f='(A,A,A,A,A)',skipline=1,/silent
  
  ; split the string in to years
  y0 = float(strmid(years,0,4))
  y1 = float(strmid(years,5,4))
  
  dur = y1 - y0
  dur[where(y1 lt 1700)] = 1.

  print,mean(dur),median(dur)
  print,mean(dur[where(y0 gt 1950)]),median(dur[where(y0 gt 1950)])

  
  set_plot,'ps'

  device, filename='dur_hist.eps',$
          /encap,/color,/inch,xsize=7,ysize=5
  
  plothist,dur, xtitle='!7Duration (years)',ytitle='!7# of Senators',thick=4,/half
  xyouts, 35, 450,/data,'Average = '+string(mean(dur),f='(F3.1)')+' years',charsize=1

  device,/close

  medbin, y0, dur, xx,yy,2,1700,2000

  device,filename='dur_time.eps',$
         /encap,/color,/inch,xsize=9,ysize=5
  loadct,0,/silent
  plot, y0, dur,psym=8,symsize=1.5,xtitle='!7Year Elected',$
        ytitle='!7Duration (years)',/xsty
  oplot,y0,dur,psym=8,color=200,symsize=1.3

  loadct,39,/silent
  oplot,xx,yy,color=230,thick=5

  legend,['Running 2-year median'],linestyle=0,color=230,charsize=1,box=0
  device,/close
  
  set_plot,'X'
  stop
end
