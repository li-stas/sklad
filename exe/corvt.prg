clea
set print on
* ���४�� ���㬥�⮢ �� �����⭮� �� ⥪�饣� �����

netuse('cskl')
do while !eof()
   if ent#gnEnt
      skip
      loop
   endif
   if tpstpok=0
      skip
      loop   
   endif
   if tpstpok=1
      prer='pst'  
   else
      prer='pok'  
   endif
   cskr='sk'+prer+'r'
   &cskr=sk
   pathr=gcPath_d+alltrim(path)
   if !netfile('tov',1)   
      sele cskl
      skip
      loop 
   endif
   netuse('tov','tov'+prer,,1) 
   netuse('soper','soper'+prer,,1) 
   netuse('sgrp','sgrp'+prer,,1) 
   netuse('tovm','tovm'+prer,,1) 
   netuse('pr1','pr1'+prer,,1) 
   netuse('pr2','pr2'+prer,,1) 
   netuse('pr3','pr3'+prer,,1) 
   netuse('rs1','rs1'+prer,,1) 
   netuse('rs2','rs2'+prer,,1) 
   netuse('rs3','rs3'+prer,,1) 
   sele cskl
   skip
   loop
endd

sele cskl
go top
do while !eof()
   if ent#gnEnt
      skip
      loop   
   endif
   if tpstpok#0
      skip
      loop   
   endif
   if arnd#0
      skip
      loop
   endif
   if rasc=0
      skip
      loop
   endif
   pathr=gcPath_d+alltrim(path)
   if !netfile('tov',1)
      sele cskl
      skip
      loop   
   endif
   rccsklr=recn()
   if !netfile('soper',1)
      wait pathr
   endif
   netuse('soper',,,1)
   corrska()
   sele cskl
   go rccsklr
   sele soper 
   locate for auto=2
   if !foun()
      nuse('soper')  
      sele cskl
      skip
      loop      
   endif  
   sele cskl
   skr=sk 
   ?pathr
   netuse('sgrp',,,1)
   netuse('tov',,,1)
   netuse('pr1',,,1)
   netuse('pr2',,,1)
   netuse('pr3',,,1)
   netuse('rs1',,,1)
   netuse('rs2',,,1)
   netuse('rs3',,,1)

   * �������� �����������  
   for i_i=1 to 2
       if i_i=1
          prer='pst'  
       else
          prer='pok'  
       endif
       cskr='sk'+prer+'r'
       sele ('pr1'+prer)
       go top
       ?'pr1'+prer 
       do while !eof()
          if vo=6.and.kop=111
             skip
             loop     
          endif 
          mnr=mn     
          amnr=amn
          sksr=sks
          rcr=recn()
          if amnr#0.and.sksr#0.and.sksr=skr    
             prdvr=0
             locate for amn=amnr.and.sks=sksr
             do while .t.
                cont
                if foun()
                   prdvr=1
                   netrepl('amn,sks','0,0')
                   ?'MN '+str(mnr,6)+' AMN '+str(amnr,6)+' SKS '+str(sksr,6)+' ������� amn,sks'  
                else
                   if prdvr=1
                      go rcr 
                      netrepl('amn,sks','0,0')
                      sele rs1
                      if netseek('t1','amnr')  
                         netrepl('amn','0')   
                      endif 
                      sele ('pr1'+prer)
                   endif    
                   exit   
                endif    
             endd
             if prdvr=1
                amnr=0
                sksr=0  
             endif 
          endif    
          go rcr
          if sksr=0.or.amnr=0
             ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ sks=0.or.amn=0' 
             delpr(prer) 
             sele ('pr1'+prer)
             skip
             loop    
          endif   
          sele cskl
          if !netseek('t1','sksr')
             ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ ��� � cskl' 
             sele ('pr1'+prer)
             delpr(prer) 
             sele ('pr1'+prer)
             skip
             loop  
          else
             if ent#gnEnt
                ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ ent#gnEnt' 
                sele ('pr1'+prer)    
                delpr(prer) 
                sele ('pr1'+prer)    
                skip
                loop   
             endif  
          endif
          if sksr#skr
             sele ('pr1'+prer)
             skip
             loop 
          endif                    
          sele rs1
          if !netseek('t1','amnr')   
             ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ ��� � RS1' 
             sele ('pr1'+prer)    
             delpr(prer) 
             sele ('pr1'+prer)    
             skip
             loop   
          else
             if prz=0
                ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ RS1 PRZ=0' 
                sele ('pr1'+prer)    
                delpr(prer) 
                sele ('pr1'+prer)    
                skip
                loop   
             else
                if amn#mnr
                   ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+str(amn,6)+' '+'������ RS1 AMN#MNR' 
                   sele ('pr1'+prer)    
                   delpr(prer) 
                   sele ('pr1'+prer)    
                   skip
                   loop   
                endif  
                if &cskr#skt
                   ?str(mnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+str(amn,6)+' '+'������ RS1 skt ' 
                   sele ('pr1'+prer)    
                   delpr(prer) 
                   sele ('pr1'+prer)    
                   skip
                   loop   
                endif  
             endif
          endif    
          sele ('pr1'+prer)
          skip
       endd
       sele ('rs1'+prer)
       go top 
       ?'rs1'+prer 
       do while !eof()
          ttnr=ttn     
          amnr=amn
          sksr=sks
          rcr=recn()
          if amnr#0.and.sksr#0.and.sksr=skr    
             prdvr=0
             locate for amn=amnr.and.sks=sksr 
             do while .t.
                cont
                if foun()
                   prdvr=1  
                   netrepl('amn,sks','0,0')
                   ?str(ttn,6)+' AMN '+str(amnr,6)+' SKS '+str(sksr,3)+' ������� amn,sks'  
                else
                   if prdvr=1
                      go rcr
                      netrepl('amn,sks','0,0')
                      sele pr1  
                      if netseek('t2','amnr')
                         netrepl('amn','0')
                      endif
                      sele ('rs1'+prer)
                   endif 
                   exit   
                endif    
             endd
             if prdvr=1
                amnr=0
                sksr=0   
             endif
          endif    
          go rcr
          if sksr=0.or.amnr=0
             ?str(ttnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ sks=0.or.amn=0' 
             sele ('rs1'+prer)
             delrs(prer) 
             sele ('rs1'+prer)
             skip
             loop 
          endif   
          sele cskl
          if !netseek('t1','sksr')
             ?str(ttnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ ��� � cskl' 
             sele ('rs1'+prer)
             delrs(prer) 
             sele ('rs1'+prer)
             skip
             loop 
          else
             if ent#gnEnt
                ?str(ttnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ ent#gnEnt' 
                sele ('rs1'+prer)
                delrs(prer) 
                sele ('rs1'+prer)
                skip
                loop 
             endif  
          endif              
          if sksr#skr
             sele ('rs1'+prer)
             skip
             loop 
          endif
          sele pr1
          if !netseek('t2','amnr')   
             ?str(ttnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ ��� � PR1' 
             delrs(prer) 
             sele ('rs1'+prer)
             skip
             loop 
          else
             if prz=0
                ?str(ttnr,6)+' sks '+str(sksr,3)+' amn '+str(amnr,6)+' '+'������ PR1 PRZ=0' 
                delrs(prer) 
                sele ('rs1'+prer)
                skip
                loop 
             else 
                if amn#ttnr
                   ?str(ttnr,6)+' sks '+str(sksr,3)+' amnr '+str(amnr,6)+' '+str(amn,6)+' '+'������ PR1 AMN#TTNR' 
                   delrs(prer) 
                   sele ('rs1'+prer)
                   skip
                   loop 
                endif
                if &cskr#skt
                   ?str(ttnr,6)+' sks '+str(sksr,3)+' amnr '+str(amnr,6)+' '+str(amn,6)+' '+'������ PR1 skt' 
                   delrs(prer) 
                   sele ('rs1'+prer)
                   skip
                   loop 
                endif
             endif
          endif    
          sele ('rs1'+prer)
          skip
       endd
   next
   * ���㬥���
   ?'��室'    
   sele pr1
   go top
   do while !eof()
      store 0 to prktr,prtr,prkstr,prstr
      przr=prz
      mnr=mn
      ndr=nd   
      vor=vo
      kopr=kop
      sklr=skl
      sktr=skt
      skltr=sklt
      amnr=amn
      pstr=pst
      kpsr=kps
      dprr=dpr
      rcpr1r=recn()
      sele soper
      locate for d0k1=1.and.vo=vor.and.kop=mod(kopr,100)
      if foun()
         skar=ska
         autor=auto
         if autor#2
            sele pr1
            skip
            loop     
         else
            if sktr#skar
               sele pr1
               netrepl('skt,amn','skar,0') 
               sktr=skt 
            endif        
            if skltr#kpsr
               sele pr1
               netrepl('sklt','kpsr') 
               skltr=sklt 
            endif        
         endif
      else
         sele pr1
         skip
         loop    
      endif
      go rcpr1r
      tpstpokr=0
      store '' to pathtr
      pathtr=alltrim(getfield('t1','sktr','cskl','path'))
      pathr=gcPath_d+pathtr
      if !netfile('tov',1)
         ?'��� ᪫��� ��� ��⮬��' 
         sele pr1
         skip
         loop    
      endif 
      tpstpokr=getfield('t1','sktr','cskl','tpstpok')
      if tpstpokr=0
         ?'᪫�� ��� ��⮬�� tpstpok=0 ' 
         sele pr1
         skip
         loop    
      endif   
      if tpstpokr=1
         prer='pst'    
      else
         prer='pok'    
      endif
      sele pr2
      if !netseek('t1','mnr')
         if amnr#0    
            sele pr1
            if pprha(2)
               ?str(ndr,6)+' '+str(mnr,6)+' '+str(sktr,3)+' 㤠����� ��⮬��-��� ⮢��'  
            endif    
            sele pr1
            netrepl('amn','0')
            skip
            loop
         endif 
      endif
      sele pr1
      if !vztara(1)
         if amnr#0 
            sele pr1
            if pprha(2)
               ?str(ndr,6)+' '+str(mnr,6)+' '+str(sktr,3)+' 㤠����� ��⮬��-��� ��.���'  
            endif  
            sele pr1    
            netrepl('amn','0')
            skip
            loop
         endif 
      else
         sele pr1
         if przr=1
            if !pprha(2)
               ?str(ndr,6)+' '+str(mnr,6)+' '+str(sktr,3)+' ���� ��⮬��'  
            else
               ?str(ndr,6)+' '+str(mnr,6)+' '+str(sktr,3)+' ���४�� ��⮬��'  
            endif  
            sele pr1
            pprha(1)
         endif
      endif 
      sele pr1
      skip
   endd
   ?'���室'    
   sele rs1
   go top
   do while !eof()
      store 0 to prktr,prtr,prkstr,prstr
      przr=prz  
      ttnr=ttn
      vor=vo
      kopr=kop
      sklr=skl
      sktr=skt
      skltr=sklt
      amnr=amn
      pstr=pst
      kplr=kpl
      dotr=dot
      rcrs1r=recn() 
      sele soper
      locate for d0k1=0.and.vo=vor.and.kop=mod(kopr,100)
      if foun()
         skar=ska
         autor=auto
         if autor#2
            sele rs1
            skip
            loop     
         else
            if sktr#skar
               sele rs1
               netrepl('skt,amn','skar,0') 
               sktr=skt 
            endif        
            if skltr#kplr
               sele rs1
               netrepl('sklt','kplr') 
               skltr=sklt 
            endif        
         endif
      else
         sele rs1
         skip
         loop    
      endif
      sele rs1
      go rcrs1r
      tpstpokr=0
      store '' to pathtr
      pathtr=alltrim(getfield('t1','sktr','cskl','path'))
      pathr=gcPath_d+pathtr
      if !netfile('tov',1)
         ?'��� ᪫��� ��� ��⮬��' 
         sele rs1
         skip
         loop    
      endif 
      tpstpokr=getfield('t1','sktr','cskl','tpstpok')
      if tpstpokr=0
         ?'᪫�� ��� ��⮬�� tpstpok=0 ' 
         sele rs1
         skip
         loop    
      endif   
      if tpstpokr=1
         prer='pst'    
      else
         prer='pok'    
      endif
      sele rs2  
      if !netseek('t1','ttnr')
         if amnr#0
            sele rs1
            if rprha(2)
               ?str(ttnr,6)+' '+str(sktr,3)+' 㤠����� ��⮬��-��� ⮢��'  
            endif    
            sele rs1
            netrepl('amn','0')
            skip
            loop
         endif
      endif
      sele rs1
      if !vztara(0)
         if amnr#0  
            sele rs1
            if rprha(2)
               ?str(ttnr,6)+' '+str(sktr,3)+' 㤠����� ��⮬��-��� ��.���'  
            endif  
            sele rs1    
            netrepl('amn','0')
            skip
            loop
         endif 
      else
         if przr=1     
            if !rprha(2)
               ?str(ttnr,6)+' '+str(sktr,3)+' ���� ��⮬��'  
            else
               ?str(ttnr,6)+' '+str(sktr,3)+' ���४�� ��⮬��'  
            endif  
            sele rs1
            rprha(1)
         endif   
      endif
      sele rs1
      skip
   endd
   nuse('soper')
   nuse('sgrp')
   nuse('tov')
   nuse('pr1')
   nuse('pr2')
   nuse('pr3')
   nuse('rs1')
   nuse('rs2')
   nuse('rs3')
   sele cskl
   go rccsklr     
   skip
endd

for i_i=1 to 2
    if i_i=1
       prer='pst'  
    else
       prer='pok'  
    endif
    nuse('soper'+prer) 
    nuse('sgrp'+prer) 
    nuse('tov'+prer) 
    nuse('tovm'+prer) 
    nuse('pr1'+prer) 
    nuse('pr2'+prer) 
    nuse('pr3'+prer) 
    nuse('rs1'+prer) 
    nuse('rs2'+prer) 
    nuse('rs3'+prer) 
next
nuse()
wmess('�믮���� ����.⥪.���.',3)
retu

**************
func delpr(p1)
**************
sele ('pr2'+p1)  
if netseek('t1','mnr') 
   do while mn=mnr
      netdel()  
      skip
   endd    
endif 
sele ('pr3'+p1)  
if netseek('t1','mnr') 
   do while mn=mnr
      netdel()  
      skip
   endd    
endif 
sele ('pr1'+p1)  
netdel()
retu .t.
**************
func delrs(p1)
**************
sele ('rs2'+p1)  
if netseek('t1','ttnr') 
   do while ttn=ttnr
      netdel()  
      skip
   endd    
endif 
sele ('rs3'+p1)  
if netseek('t1','ttnr') 
   do while ttn=ttnr
      netdel()  
      skip
   endd    
endif 
sele ('rs1'+p1)  
netdel()
retu .t.
***************
func vztara(p1)
* p1 - D0K1
***************
*store 0 to prtr,prstr && �ਧ��� ��� �� ���\��.���
*store 0 to prktr,prkstr && �ਧ� ����� �\�� � ��� (18,19,pr2)
if p1=1
   cflr='pr'
   cdocr='mn' 
else
   cflr='rs'
   cdocr='ttn' 
endif
sele (cflr+'2')
netseek('t1',cdocr+'r')
do while &cdocr=&(cdocr+'r').and.int(ktl/1000000)<2
   if int(ktl/1000000)=0
      if kf#0
         prktr=1
      endif
   endif
   if int(ktl/1000000)=1
      if kf#0
         prkstr=1
      endif
   endif
   skip
   if eof()
      exit
   endif
endd
if getfield('t1',cdocr+'r'+',19',cflr+'3','ssf')#0 && ���� ��
   prktr=1
else
   prktr=0
endif
if prktr=1
   if getfield('t1',cdocr+'r'+',12',cflr+'3','ssf')#0
      prtr=1 && �� �����⭠� ��
   endif
endif
if getfield('t1',cdocr+'r'+',18',cflr+'3','ssf')#0 && ���� �⥪����
   prkstr=1
else
   prkstr=0
endif
*if prkstr=1.and.pstr=1
*   prstr=1 && �� �����⭠� �⥪����
*else
*   prstr=0 && �����⭠� �⥪����
*endif
if (prktr=1.and.prtr=0).or.(prkstr=1.and.pstr=0)
   retu .t.
endif
retu .f.

