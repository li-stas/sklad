#include "common.ch"
#include "inkey.ch"
* �������� pro1 � pro2 (��⮪�� ��室�)
if !netfile('pro1')
   crddop('pro1')
   netuse('pro1')
   netadd()
   nuse('pro1')
endif
if !netfile('pro2')
   crddop('pro2')
   nuse('pro2')
endif

***************
func prpcod()
***************
retu .t.
if gnEnt=20
   pathr=gcPath_d+'res01\'
   netuse('tov','tovres',,1)
   pripcodr=1
   if netseek('t1','sklr,ktlr')
      if natr=nat
         pripcodr=0
         netrepl('sendv','1')
      endif
   endif
   if pripcodr=1
      sele tovres
      set orde to tag t2
      kgr=int(ktlr/1000000)
      if !netseek('t2','sklr,kgr,natr')
         netseek('t2','sklr,kgr')
      endif
      if foun()
         do while .t.
            rctovresr=slcf('tovres',,,,,"e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(60) ",,,,'kg=kgr','osv+osf#0',,str(ktlr,9)+' '+alltrim(natr))
            if lastkey()=K_ESC
               exit
            endif
            go rctovresr
            ktlnr=ktl
            mntovnr=mntov
            arec:={}
            getrec()
            if lastkey()>32.and.lastkey()<255
               lstkr=upper(chr(lastkey()))
               if !netseek('t2','sklr,int(ktlnr/1000000),lstkr')
                  go rctovresr
                endif
            endif
            if lastkey()=K_ENTER
               sele pr2
               netrepl('ktl,mntov','ktlnr,mntovnr')
               if ktlp=ktlr
                  netrepl('ktlp,mntovp','ktlnr,mntovnr')
               endif
               sele tov
               if netseek('t1','sklr,ktlr')
                  reclock()
                  putrec()
                  netrepl('sendv','1')
               else
                  netadd()
                  putrec()
                  netrepl('sendv','1')
               endif
               exit
            endif
         endd
      endif
   endif
   nuse('tovres')
endif
retu .t.

************
func prfl()
************
if !(gnVo=9.or.gnVo=6.and.(kopr=168.or.kopr=185))
   retu
endif
clzv=setcolor('gr+/b,n/bg')
wzv=wopen(10,20,12,60)
wbox(1)
zvr=space(20)
@ 0,1 say '����' get zvr
read
wclose(wzv)
setcolor(clzv)
if gnVo=9
   kklr=getfield('t1','kpsr','kln','kkl1')
else
   do case
      case gnEnt=14 // �����
           kklr=24022880
      case gnEnt=15 // ����⮯
           kklr=26533053
      case gnEnt=17 // ���⪠
           kklr=33525508
   endc
endif
if kklr#0
   cidr='id'+alltrim(str(kklr,8))
   cnamer='n'+alltrim(str(kklr,8))
else
   wmess('��� ⠡���� ��� �⮣� ���⠢騪�')
   retu
endif

cnatr='n'+alltrim(str(gnKln_c,8))

sele crosid
inde on str(&cidr,10) tag t9 to lcrosid
set orde to tag t9 in lcrosid

crtt('rid',"f:id c:n(10) f:ppt c:n(1) f:idp c:n(10) f:name c:c(40) f:mntov c:n(7) f:mntovp c:n(7) f:nat c:c(40) f:kf c:n(10,3) f:zen c:n(10,3)")
sele 0
use rid

sele 0
use (zvr)
go top
do while !eof()
   idr=mntov
   pptr=ppt
   idpr=mntovp
   if idpr=0
      idpr=idr
   endif
   namer=nat
   kfr=kf
   zenr=zen
   sele rid
   appe blank
   repl id with idr,;
        ppt with pptr,;
        idp with idpr,;
        name with namer,;
        kf with kfr,;
        zen with zenr
   sele (zvr)
   skip
endd
sele rid
rccr=recc()
@ 0,1 say str(rccr,10)
go top
do while !eof()
   @ 1,1 say str(recn(),10)
   idr=id
   idpr=idp
   sele crosid
   seek str(idr,10)
   if foun()
      mntovr=mntov
      natr=&cnatr
      sele rid
      repl mntov with mntovr,;
           nat with natr
   endif
   sele crosid
   seek str(idpr,10)
   if foun()
      mntovpr=mntov
      sele rid
      repl mntovp with mntovpr
   endif
   sele rid
   skip
endd
go top

*cDelim=CHR(13) + CHR(10)
*hzvr=fopen(zvr)
*n=1
*do while !feof(hzvr)
*   if n<7
*      n=n+1
*      aaa=FReadLn(hzvr, 1, 80, cDelim)
*      loop
*   endif
*   aaa=FReadLn(hzvr, 1, 80, cDelim)
*   namer=subs(aaa,5,40)
*   ckolr=subs(aaa,46,10)
*   cidr=subs(aaa,59,10)
*   kvpr=val(ckolr)
*   idr=val(cidr)
*   sele zv
*   if idr#0
*      appe blank
*      repl id with idr,name with namer,kvp with kvpr
*   endif
*endd
*fclose(hzvr)
*save scre to sczv

save screen to sccrid
rcridr=recn()
kg_r=0
do while .t.
   foot('ENTER,INS','�믮�����,��ࠢ�筨�')
   sele rid
   go rcridr
   rcridr=slcf('rid',1,1,18,,"e:name h:'���筨�' c:c(38) e:mntov h:'���' c:n(7) e:nat h:'SELF' c:c(30)",,,1)
   if lastkey()=K_ESC
      sele rid
      use
*      nuse()
      erase rid.dbf
      erase lcrosid.cdx
      sele (zvr)
      use
      rest screen from sccrid
      retu
   endif
   if lastkey()=K_ENTER
      exit
   endif
   if lastkey()=K_INS
      go rcridr
      namer=name
      @ 2,2 say namer color 'r/w'
      sele ctov
      set orde to tag t2
      if !netseek('t2','kg_r')
         go top
      endif
      rcctovr=recn()
      do while .t.
         foot('ENTER,F8','�����,��㯯�')
         rcctovr=slcf('ctov',1,40,18,,"e:mntov h:'���' c:n(7) e:nat h:'������������' c:c(30)")
         if lastkey()=K_ESC
            exit
         endif
         go rcctovr
         mntovr=mntov
         do case
            case lastkey()=K_ENTER
                 go rcctovr
                 mntovr=mntov
                 natr=nat
                 sele rid
                 netrepl('mntov,nat','mntovr,natr')
                 exit
            case lastkey()=K_F8
                 sele cgrp
                 set orde to tag t2
                 go top
                 rcn_gr=recn()
                 do while .t.
                    sele cgrp
                    set orde to tag t2
                    rcn_gr=recn()
                    forgr='.T.'
                    kg_r=slcf('cgrp',,,,,"e:kgr h:'���' c:n(3) e:ngr h:'������������' c:c(20)",'kgr',,,,forgr)
                    do case
                       case lastkey()=K_ENTER
                            sele ctov
                            if !netseek('t2','kg_r')
                               go rcctovr
                            else
                               rcctovr=recn()
                            endif
                            exit
                       case lastkey()=K_ESC
                            exit
                       case lastkey()>32.and.lastkey()<255
                            sele cgrp
                            lstkr=upper(chr(lastkey()))
                            if !netseek('t2','lstkr')
                               go rcn_gr
                            endif
                            loop
                       othe
                            loop
                    endc
                 endd
                 sele ctov
                 loop
            case lastkey()>32.and.lastkey()<255
                 sele ctov
                 lstkr=upper(chr(lastkey()))
                 if !netseek('t2','int(mntovr/10000),lstkr')
                    go rcctovr
                 else
                    rcctovr=recn()
                 endif
         endc
      endd
   endif
endd
rest screen from sccrid

sele rid
go top
do while !eof()
   if mntov=0
      netdel()
      skip
      if eof()
         exit
      endif
      loop
   endif
   idr=id
   namer=name
   mntovr=mntov
   mntovpr=mntovp
   pptr=ppt
   kfr=kf
   zenr=zen
   natr=nat
   sele crosid
   if netseek('t1','mntovr')
      netrepl(cidr+','+cnamer,'idr,namer')
      cnr='n'+alltrim(str(gnKln_c,8))
      netrepl(cnr,'natr')
   endif
   sele ctov
   if netseek('t1','mntovr')
      arec:={}
      getrec()
      kgrr=int(mntovr/10000)
      sele cgrp
      netseek('t1','kgrr')
      reclock()
      ktlr=ktl
      ktlpr=ktlr
      netrepl('ktl','ktl+1')
      sele tovm
      if !netseek('t1','sklr,mntovr')
         netadd()
         putrec()
         netrepl('skl','sklr')
      else
         netrepl('osvo','osvo+kfr')
      endif
      sele tov
      if !netseek('t1','sklr,ktlr')
         netadd()
         putrec()
         netrepl('skl,ktl,post,osvo','sklr,ktlr,kpsr,kfr')
      else
         netrepl('osvo','osvo+kfr')
      endif
      sele pr2
      set orde to tag t3
      if pptr=0
         if !netseek('t3','mnr,ktlpr,pptr,ktlr')
            sfr=roun(kfr*zenr,2)
            netadd()
            netrepl('mn,mntov,mntovp,ktl,ktlp,ppt,kf,zen,sf','mnr,mntovr,mntovpr,ktlr,ktlpr,pptr,kfr,zenr,sfr')
         else
            sfr=roun((kf+kfr)*zenr,2)
            netrepl('kf,sf','kf+kfr,sfr')
         endif
      else
         do while ppt=1
            skip -1
         endd
         ktlpr=ktl
         mntovpr=mntov
         if !netseek('t3','mnr,ktlpr,pptr,ktlr')
            sfr=roun(kfr*zenr,2)
            netadd()
            netrepl('mn,mntov,mntovp,ktl,ktlp,ppt,kf,zen,sf','mnr,mntovr,mntovpr,ktlr,ktlpr,pptr,kfr,zenr,sfr')
         else
            sfr=roun((kf+kfr)*zenr,2)
            netrepl('kf,sf','kf+kfr,sfr')
         endif
      endif
   endif
   sele rid
   skip
endd

sele (zvr)
use
sele rid
use
erase rid.dbf
erase lcrosid.cdx
prModr=1
retu .t.

***************************
func pechcen()
***************************
strr1=''
strsh=''
strs=0
*************
psp=1
***************
acopt:={}
acoptn:={}
sele soper
set order to tag t2
go top
zenr=space(10)
do while !eof()
   skar=ska
   tcen_r=tcen
   sele tcen
   if netseek('t1','tcen_r')
      ntcen_r=substr(ntcen,1,10)
      zenr=alltrim(zen)
      if ascan(acopt,zenr)#0
         sele soper
         skip
         loop
      endif
      if !empty(zenr)
*         tt=alltrim(zenr)+'r'
         aadd(acopt,zenr)
      endif
      strsh=strsh+ntcen_r+'|'
      strs=strs+11
   endif
   sele soper
   skip
enddo
@ 24,0 clear
ccp=1
@ 24,5  prompt' �������� '
@ 24,25 prompt'  ������  '
menu to ccp
@ 24,0 clea

SELE kln
if netseek('t1','kpsr')
   Tlfr = TLF
else
   Tlfr = ''
endif

@ 24,15 say '����� �������� ������'
If ccp = 1
  set prin to
  Set Prin To txt.txt
else
     if gnOut=1
        if gnEnt=21
           set prin to lpt2
        else
           set prin to lpt1
        endif
     else
        set prin to txt.txt
     endif
EndIF
set cons off
set prin on
set devi to print
if empty(gcPrn)
   ?chr(27)+chr(80)+chr(15)
endif
************

lstr=1
prwr=0

prsh()

SELE PR2
set orde to tag t3
netseek('t3','mnr')
do while mn=mnr
   ktlr=ktl
   ktlpr=ktlp
   pptr=ppt
   zenr=zen
   bzenr=bzen
   kfr=kf
   sfr=sf
   ktlr=ktl
   rcpr2_r=recn()
//   if !empty(zen_rr)
//      rzenr=getfield('t2','sklr,gnVu,ktlr','tov',zen_rr)
//   else
//     rzenr=0
//   endif
   natr=getfield('t1','sklr,ktlr','tov','nat')
   upakr=getfield('t1','sklr,ktlr','tov','upak')
   upakpr=getfield('t1','sklr,ktlr','tov','upakp')
   kger=getfield('t1','sklr,ktlr','tov','kge')
   nger=getfield('t1','kger','GrpE','nge')
//   natr=alltrim(nger)+' '+natr
//   nat_r=alltrim(nger)+' '+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')

   if getfield('t1','int(ktlr/1000000)','sgrp','mark')=1
      if NdOtvr=3.and.zenr=0
         nat_r=alltrim(nger)+' '+alltrim(natr)+iif(upakpr#0,' 1/'+kzero(upakpr,10,3),'')
      else
         nat_r=alltrim(nger)+' '+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
      endif
   else
      if NdOtvr=3.and.zenr=0
         nat_r=alltrim(natr)+iif(upakpr#0,' 1/'+kzero(upakpr,10,3),'')
      else
         nat_r=alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
      endif
   endif

   lnat_r=len(nat_r)
   if lnat_r<48
      if upakr=0
         nat_r=nat_r+space(48-lnat_r)
      else
 //         nat_r=alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr)
         nat_r=iif(getfield('t1','int(ktlr/1000000)','sgrp','mark')=1,alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr),alltrim(natr))
         lnat_r=len(nat_r)
         if NdOtvr=3.and.zenr=0
            cupakr=' 1/'+kzero(upakpr,10,3)
         else
            cupakr=' 1/'+kzero(upakr,10,3)
         endif
         lcupakr=len(cupakr)
         nat_r=nat_r+space(48-lnat_r-lcupakr)+cupakr
      endif
 //      nat_r=nat_r+space(48-lnat_r)
      lnat_r=48
   endif
   keir=getfield('t1','sklr,ktlr','tov','kei')
   neir=getfield('t1','keir','nei','nei')
   if lnat_r=48
      ?str(ktlr,9)+' '+nat_r+' '+subs(neir,1,4)
      prle()
   else
      store '' to xxx,yyy
      for i=lnat_r to 1 step -1
          yyy=right(nat_r,lnat_r-i)
          xxx=subs(nat_r,1,i)
          if i<48.and.subs(nat_r,i,1)=' '
             exit
          endif
      next
      if len(xxx)<48
         xxx=xxx+space(48-len(xxx))
      endif
      ?str(ktlr,9)+' '+xxx+' '+subs(neir,1,4)
      prle()
      ?space(9)+' '+yyy
      prle()
   endif
   /*
    *   strr1=''
    *   sele tov
    *   netseek('t1','vur,ktlr')
    *   sele tcen
    *   go top
    *   do while !eof()
    *      tt=alltrim(zen)+'r'
    *      tt1=alltrim(zen)
    *      sele tov
    *      &tt=&tt1
    *     strr1=strr1+str(&tt,10,3)+' '
    *    sele tcen
    *      skip
    *   enddo
    */
    sele tov
    netseek('t1','sklr,ktlr')
    for i=1 to len(acopt)
        tt=acopt[i]
        tt1=alltrim(acopt[i]+'r')
        strr1=strr1+str(&tt,10,3)+' '
    next
   ?strr1
   prle()
   sele pr2
   go rcpr2_r
   skip
Enddo
?''
prle()
eject

If ccp = 1
   edfile('txt.txt')
   @ 24,0 clear
   @ 24,5  prompt' ������ '
   @ 24,25 prompt' �����'
   menu to ccp
   if lastkey()=K_ESC
      set devi to scre
      retu
   endif
   @ 24,0 clear
   If ccp=1
      If gnOut=1
         set prin off
         set prin to
         !Copy txt.txt prn>nul
      EndIf
   EndIf
EndIf
set prin off
set print to
set cons on
set devi to scre
@ 24,0 clea
 //unlock
retu .t.
***************
func pechpr()
***************
lstr=1
prwr=0

prsh()
if rtcenr#0
   zen_rr=alltrim(getfield('t1','rtcenr','tcen','zen'))
else
   zen_rr=''
endif

SELE PR2
set orde to tag t3
netseek('t3','mnr')
ssdok=0
do while mn=mnr
   ktlr=ktl
   ktlpr=ktlp
   pptr=ppt
   if otpcr=0
      zenr=zen
   else
*      zenr=getfield('t2','sklr,gnVu,pr2->ktl','tov',cboptr)
      zenr=bzen
   endif
   bzenr=bzen
   kfr=kf
   sfr=sf
   ktlr=ktl
   rcpr2_r=recn()
   if !empty(zen_rr)
      rzenr=getfield('t1','sklr,ktlr','tov',zen_rr)
   else
      rzenr=0
   endif
   natr=getfield('t1','sklr,ktlr','tov','nat')
   upakr=getfield('t1','sklr,ktlr','tov','upak')
   upakpr=getfield('t1','sklr,ktlr','tov','upakp')
   kger=getfield('t1','sklr,ktlr','tov','kge')
   nger=getfield('t1','kger','GrpE','nge')
 //   natr=alltrim(nger)+' '+natr
   if NdOtvr=3.and.zenr=0
      nat_r=alltrim(nger)+' '+alltrim(natr)+iif(upakpr#0,' 1/'+kzero(upakpr,10,3),'')
   else
      nat_r=alltrim(nger)+' '+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
   endif
   lnat_r=len(nat_r)
   if lnat_r<48
      if upakr=0
         nat_r=nat_r+space(48-lnat_r)
      else
         nat_r=alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr)
         lnat_r=len(nat_r)
         if NdOtvr=3.and.zenr=0
            cupakr=' 1/'+kzero(upakpr,10,3)
         else
            cupakr=' 1/'+kzero(upakr,10,3)
         endif
         lcupakr=len(cupakr)
         nat_r=nat_r+space(48-lnat_r-lcupakr)+cupakr
      endif
//      nat_r=nat_r+space(48-lnat_r)
      lnat_r=48
   endif
   if NdOtvr=3.and.zenr=0
      neir='��.'
   else
      keir=getfield('t1','sklr,ktlr','tov','kei')
      neir=getfield('t1','keir','nei','nei')
   endif
   if lnat_r=48
      if otpcr=0
         if NdOtvr=3.and.zenr=0
            ?str(ktlr,9)+' '+nat_r+' '+subs(neir,1,4)+str(kfr/upakpr,10,3)+str(zenr,10,3)+iif(sfr<10000000,str(sfr,10,2),str(sfr,12,2))
         else
            ?str(ktlr,9)+' '+nat_r+' '+subs(neir,1,4)+str(kfr,10,3)+str(zenr,10,3)+iif(sfr<10000000,str(sfr,10,2),str(sfr,12,2))
         endif
      else
         if NdOtvr=3.and.zenr=0
            ?str(ktlr,9)+' '+nat_r+' '+subs(neir,1,4)+str(kfr/upakpr,10,3)+str(zenr,10,3)+iif(zenr*kfr<10000000,str(ROUND(zenr*kfr,2),10,2),str(round(zenr*kfr,2),12,2))
         else
            ?str(ktlr,9)+' '+nat_r+' '+subs(neir,1,4)+str(kfr,10,3)+str(zenr,10,3)+iif(zenr*kfr<10000000,str(ROUND(zenr*kfr,2),10,2),str(round(zenr*kfr,2),12,2))
         endif
      endif
      prle()
   else
      store '' to xxx,yyy
      for i=lnat_r to 1 step -1
          yyy=right(nat_r,lnat_r-i)
          xxx=subs(nat_r,1,i)
          if i<48.and.subs(nat_r,i,1)=' '
             exit
          endif
      next
      if len(xxx)<48
         xxx=xxx+space(48-len(xxx))
      endif
      if otpcr=0
         if NdOtvr=3.and.zenr=0
            ?str(ktlr,9)+' '+xxx+' '+subs(neir,1,4)+str(kfr/upakpr,10,3)+str(zenr,10,3)+iif(sfr<10000000,str(sfr,10,2),str(sfr,12,2))
         else
            ?str(ktlr,9)+' '+xxx+' '+subs(neir,1,4)+str(kfr,10,3)+str(zenr,10,3)+iif(sfr<10000000,str(sfr,10,2),str(sfr,12,2))
         endif
      else
         if NdOtvr=3.and.zenr=0
            ?str(ktlr,9)+' '+xxx+' '+subs(neir,1,4)+str(kfr/upakpr,10,3)+str(zenr,10,3)+iif(zenr*kfr<10000000,str(ROUND(zenr*kfr,2),10,2),str(round(zenr*kfr,2),12,2))
         else
            ?str(ktlr,9)+' '+xxx+' '+subs(neir,1,4)+str(kfr,10,3)+str(zenr,10,3)+iif(zenr*kfr<10000000,str(ROUND(zenr*kfr,2),10,2),str(round(zenr*kfr,2),12,2))
         endif
      endif
      prle()
      ?space(9)+' '+yyy
      prle()
   endif
   if rzenr#0
      ?space(9)+' '+space(48)+' '+space(4)+space(10)+str(rzenr,10,3)+space(10)
      prle()
   endif
   sertr=getfield('t1','sklr,ktlr','tov','sert')
   natdopr=''
   if sertr#0
      natdopr='����. '+ltrim(str(sertr,10))+' '
   endif
   srealr=getfield('t1','sklr,ktlr','tov','sreal')
   if srealr#0
      natdopr=natdopr+'��.ॠ�. '+ltrim(str(srealr,10))+' ��'
   endif
   if !empty(natdopr)
      ?space(8)+natdopr
      prle()
   endif
   ssdok=ssdok+round(zenr*kfr,2)
   sele pr2
   go rcpr2_r
   skip
Enddo
?''
prle()
if otpcr=0
  sele pr3
  if netseek('t1','mnr')
   do whil MN = mnr
      kszr=KSZ
      ssfr=SSF
      if ssfr#0
         prr=pr
         nszr=getfield('t1','kszr','dclr','nz')
         if kszr=18
            if pstr=0
               nszr=subs(nszr,1,10)+' (�����.) '
            else
               nszr=subs(nszr,1,10)+'(�������.)'
            endif
         endif
         ?space(48)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr,10,2),str(ssfr,12,2))
         prle()
      endif
      SELE PR3
      skip
   Endd
   ?textr
  endif
   prle()
   if netseek('t1','mnr,90')
      ssfr=ssf
      //?space(48)+'�⮣� �� ���㬥���  '+space(8)+str(ssfr,15,2) //+' ��.'
      ?space(48)+'����� �� ���㬥���  '+space(8)+str(ssfr,15,2) //+' ��.'
      prle()
   endif
else
      //?space(48)+'�⮣� �� ���㬥���  '+space(8)+str(ssdok,15,2) //+' ��.'
      ?space(48)+'����� �� ���㬥���  '+space(8)+str(ssdok,15,2) //+' ��.'
endif



prw_r=prwr
for i=1 to 43-prw_r-3
    ?''
    prle()
next
//?' �������  _______________            ������� ������ _______________'
?' �i����  _______________            �i���� _______________'
/*
*prle()
*?''
*prle()
*?repl('-',93)
*/
eject

If ccp = 1
   edfile('txt.txt')
   @ 24,0 clear
   @ 24,5  prompt' ������ '
   @ 24,25 prompt' �����'
   menu to ccp
   if lastkey()=K_ESC
      set devi to scre
      retu
   endif
   @ 24,0 clear
   If ccp=1
      If gnOut=1
         set prin off
         set prin to
         !Copy txt.txt prn>nul
      EndIf
   EndIf
EndIf
retu .t.

***************
func prsh(p1)
  ***************
  if p1=nil
     if sklr<8000
        if otpcr=0
          ?space(20)+'������ N '+str(ndr,6)+' �� ᪫��'+str(sklr,7)+' ����.'+fktor
        else
          ?space(20)+'������ N '+str(ndr,6)+' �� ᪫��'+str(sklr,7)+' ����.'+fktor+'  � ஧����� 業��'
        endif
     else
        ?space(20)+'������ N '+str(ndr,6)+' � �������'+str(sklr,7)+' ����.'+fktor
     endif
     prle()

     if przr=0
        ?space(30)+' �� '+dtoc(dvpr)+' N  �� ��� '+str(mnr,6)
     else
        if gnEnt=20.and.pr1->otv=3.and.!empty(dnzr)
           ?space(30)+' �� '+dtoc(dnzr)+' N  �� ��� '+str(mnr,6)
        else
           ?space(30)+' �� '+dtoc(dprr)+' N  �� ��� '+str(mnr,6)
        endif
     endif
     prle()

     //?'���⠢騪 : '+ subs(nkpsr,1,30)+' ���  '+str(kpsr,7)+' ⥫ '+tlfr
     ?'����砫쭨�: '+ subs(nkpsr,1,30)+' ���  '+str(kpsr,7)+' ⥫ '+tlfr
     prle()
     if pr1->otv=3
        ?''
        prle()
     else
        //?'�������   : '+nnzr+' ���   '+dtoc(dnzr)+' '+iif(kzgr#0,str(kzgr,7)+' '+alltrim(nzgr),'')
        ?'�����i�   : '+nnzr+' �i� '+dtoc(dnzr)+' '+iif(kzgr#0,str(kzgr,7)+' '+alltrim(nzgr),'')
        prle()
     endif
     //?"��� ���p�樨 - "+str(kopr,3)+' '+nopr+ ' '+time()+' '+dtoc(date())+' '+alltrim(gcName)
     ?"��� ���p��i� - "+str(kopr,3)+' '+nopr+ ' '+time()+' '+dtoc(date())+' '+alltrim(gcName)
     prle()
     ?'                                                                                       ���� '+str(lstr,1)
  else
     ?'��室 N '+str(ndr,6)+'                                                                        ���� '+str(lstr,1)
  endif
  prle()
  if prce=.t.
           ?repl('-',strs)
           prle()
           //?'���  |                  ������������                    |��.�|'+space(strs-63)+'|'
             ?'���  |                  ������㢠���                    |��.�|'+space(strs-63)+'|'
           prle()
           ?repl('-',strs)
           prle()
           ?strsh
           prle()
           ?repl('-',strs)
           prle()
  else
           ?repl('-',93)
           prle()

         //?'| ���  |                  ������������                    |����| �����᪨ ���室�����    |'
           ?'| ���  |                  ������㢠���                    |����| ����筮 ��ਡ�⪮����     |'
           prle()
           ?'|      |                                                  |����|----------------------------|'
           prle()
         //?'| �.�  |                                                  |��.�|  � - �� |  ����  |  �㬬�  |'
           ?'| �.�  |                                                  |��.�|�i��i��� |  �i��  |  �㬠   |'
           prle()
           ?repl('-',93)
           prle()
  endif
  retu .t.

**************
func prle(p1)
  **************
  prwr++
  if prwr=42
     prwr=1
     lstr++
     eject
     if p1=nil
        if psp=1
           set devi to scre
           save scre to scmess
           mess('��⠢�� ���� � ������ �஡��',1)
           rest scre from scmess
        endif
        prsh(1)
     endif
  endif
  retu .t.

