#include "common.ch"
#include "inkey.ch"

#translate  NTRIM(< v1 >) => LTRIM(STR(< v1 >))

******************************************************
* ��楤��� � �㭪樨
******************************************************

************************
func faot(p1,p2,p3)
  ************************
  do case
     case lastkey()=K_SPACE
          if subs(aot[p2],16,1)='�'
             aot[p2]=stuff(aot[p2],16,1,' ')
          else
             aot[p2]=stuff(aot[p2],16,1,'�')
          endif
          retu 2
     case lastkey()=K_ENTER
          retu 1
     othe
          retu 2
  endc
  retu 0
**************
func sklkln()
  **************
  sele kln
  if sklr=0.or.!netseek('t1','sklr')
     if gnSk#242
        sele kln
        set orde to tag t2
        go top
        do while .t.
           rcn_kln=recn()
           sklr=slcf('kln',,,,,"e:nkl h:'���' c:c(30) e:kkl h:'���' c:n(7)",'kkl',,,,'kkl>=8000.and.kkl<10000')
           if lastkey()=K_ENTER.or.lastkey()=K_ESC
              exit
           endif
           if lastkey()>32.and.lastkey()<255
           //if lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
              lstkr=upper(chr(lastkey()))
              if !netseek('t2','lstkr')
                 go rcn_kln
              endif
           endif
        enddo
     endif
     if !netseek('t1','sklr','tov').and.gnD0k1=0
        save scre to scmess
        mess('� �⮣� ������⭨�� ��� ⮢��',3)
        sklr=0
        rest scre from scmess
        retu .f.
     endif
  endif
  retu .t.
***************
func kplpkln()
  ***************
  skltr=kplr
  sele kln
  if kplr=0.or.!netseek('t1','kplr')
     sele kln
     set orde to tag t2
     go top
     do while .t.
        rcn_kln=recn()
        if gnSk#243
           kplr=slcf('kln',,,,,"e:nkl h:'���' c:c(30) e:kkl h:'���' c:n(7)",'kkl',,,,'kkl>=8000.and.kkl<10000')
        else
           kplr=slcf('kln',,,,,"e:nkl h:'���' c:c(30) e:kkl h:'���' c:n(7)",'kkl',,,,'kkl>=20000')
        endif
        skltr=kplr
        if lastkey()=K_ENTER
           exit
        endif
        if lastkey()>32.and.lastkey()<255
        //if lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
           lstkr=upper(chr(lastkey()))
           if !netseek('t2','lstkr')
              go rcn_kln
           endif
        endif
     endd
  endif
  retu .t.

**************
func kplkln()
  **************
  if kopr#154
     sele kpl
     if kplr#0.and.(gnEnt=20.or.gnEnt=21)
        if !netseek('t1','kplr')
           kplr=0
        endif
     endif
  endif
  if kplr=0
     sele kln
     go top
     kklr=kplr
     kplr=slct_kl(10,1,12)
     if kopr#154
        if !netseek('t1','kplr','kpl')
           kplr=0
        endif
     endif
     if kplr=0
        retu .f.
     endif
     if prExter=2.and.kopr#154
        if kplr#20034
           if !netseek('t1','kplr','kpl')
              kplr=0
              retu .f.
           endif
        endif
     endif
  endif
  if gnCtov=1.and.gnVo=9.and.pr361r=1.and.(gnEnt=13.or.gnEnt=20.or.gnEnt=21) //(gnVo=9.or.gnVo=6.and.(kopr=168.or.kopr=185).and.(gnEnt=14.or.gnEnt=15.or.gnEnt=17)).and.kopr#154
     if okplr=0
        sele klndog
        if !klndog(kplr)
          retu .f.
        endif
     else
        sele klndog
        if !klndog(okplr)
          retu .f.
        endif
     endif
     nnzr=str(ndog,6)
     dnzr=dtdogb
     if empty(ttn1cr)
        @ 0,39 say subs(nnzr,1,8)+' ��  '+dtoc(dnzr)
     else
        @ 0,39 say ttn1cr
     endif
  endif
  sele kln
  netseek('t1','kplr')
  IF !(_FIELD->Kkl=_FIELD->Kklp .OR.  _FIELD->Kklp=0)
    IF _FIELD->Kklp#0 .AND. _FIELD->Kkl#_FIELD->Kklp
      //��९�ᢠ�����
      kgpr:=kplr
      kplr:=_FIELD->Kklp
      return .f.
    ENDIF
  ENDIF
  if kkl1=0.and.kplr<>0
     wmess('��� ������ �� ����� ���� ���⥫�騪��',3)
     return .f.
  endif
  retu .t.
*******************
func kgpkln()
*******************
if kgpr=0.and.gnVo=9.and.kopr#154
   if select('tkplkgp')#0
      sele tkplkgp
      use
      erase tkplkgp.dbf
   endif
   crtt('tkplkgp',"f:a c:c(1) f:c c:c(1) f:kgp c:n(7)")
   sele 0
   use tkplkgp
   if select('kplkgp')=0
      sele kln
      set orde to tag t4
      if netseek('t4','kplr')
         do while kklp=kplr
            kgp_rr=kkl
            if prExter=2
               if kgp_rr#20034
                  if !netseek('t1','kgp_rr','kgp')
                     sele kln
                     skip
                     loop
                  endif
               endif
            endif
            sele tkplkgp
            netadd()
            netrepl('c,kgp',"'C',kgp_rr")
            sele kln
            skip
         endd
         sele kln
         set orde to tag t1
      endif
   else
      sele kplkgp
      if empty(indexkey(2))
         sele kln
         set orde to tag t4
         if netseek('t4','kplr')
            do while kklp=kplr
               if kkl=kklp
                  skip
                  loop
               endif
               kgp_rr=kkl
               if prExter=2
                  if kgp_rr#20034
                     if !netseek('t1','kgp_rr','kgp')
                        sele kln
                        skip
                        loop
                     endif
                  endif
               endif
               sele tkplkgp
               netadd()
               netrepl('c,kgp',"'C',kgp_rr")
               sele kln
               skip
            endd
            sele kln
            set orde to tag t1
         endif
         sele kplkgp
         if netseek('t1','kplr')
            do while kpl=kplr
               if kkl=kklp
                  skip
                  loop
               endif
               kgp_rr=kgp
               if prExter=2
                  if kgp_rr#20034
                     if !netseek('t1','kgp_rr','kgp')
                        sele kln
                        skip
                        loop
                     endif
                  endif
               endif
               sele tkplkgp
               locate for kgp=kgp_rr
               if !foun()
                  netadd()
                  netrepl('kgp','kgp_rr')
               endif
               sele kplkgp
               skip
            endd
         endif
      else
         sele kplkgp
         set orde to tag t3
         if netseek('t3','ktar,kplr')
            do while ktar=kta.and.kpl=kplr
               kgp_rr=kgp
               kklpr=getfield('t1','kgp_rr','kln','kklp')
               if kgp_rr=kklpr
                  skip
                  loop
               endif
               if prExter=2
                  if kgp_rr#20034
                     if !netseek('t1','kgp_rr','kgp')
                        sele kplkgp
                        skip
                        loop
                     endif
                  endif
               endif
               sele tkplkgp
               locate for kgp=kgp_rr
               if !foun()
                  netadd()
                  ar='A'
                  netrepl('kgp,a','kgp_rr,ar')
                  cr=''
                  if kklpr#0
                     cr='C'
                     sele tkplkgp
                     netrepl('c','cr')
                  endif
               endif
               sele kplkgp
               skip
            endd
         endif
         sele kplkgp
         set orde to tag t1
         if netseek('t1','kplr')
            do while kpl=kplr
               kgp_rr=kgp
               kklpr=getfield('t1','kgp_rr','kln','kklp')
               if kgp_rr=kklpr
                  skip
                  loop
               endif
               if prExter=2
                  if kgp_rr#20034
                     if !netseek('t1','kgp_rr','kgp')
                        sele kplkgp
                        skip
                        loop
                     endif
                  endif
               endif
               sele tkplkgp
               locate for kgp=kgp_rr
               if !foun()
                  netadd()
                  netrepl('kgp','kgp_rr')
                  cr=''
                  if kklpr#0
                     cr='C'
                     sele tkplkgp
                     netrepl('c','cr')
                  endif
               endif
               sele kplkgp
               skip
            endd
         endif
      endif
   endif
   sele tkplkgp
   go top
   kgpr=slcf('tkplkgp',,,12,,"e:a h:'A' c:c(1) e:c h:'C' c:c(1) e:kgp h:'���' c:n(7) e:getfield('t1','tkplkgp->kgp','kln','nkl') h:'������������' c:c(30) e:getfield('t1','tkplkgp->kgp','kln','adr') h:'����' c:c(30)",'kgp',,,,,,'��㧮�����⥫�')
   sele tkplkgp
   use
   erase tkplkgp.dbf
endif

if kgpr=0
   sele kln
   if !netseek('t1','kgpr')
      sele kln
      go top
   endif
   kklr=kgpr
   kgpr=slct_kl(10,1,12)
   if kgpr=0
      retu .f.
   endif
endif
if kgpr#0
   if prExter=2.and.kopr#154
      if kgpr#20034
         if !netseek('t1','kgpr','kgp')
            wmess('��� ��㧮�����⥫� � �ࠢ�筨��',3)
            retu .f.
         endif
      endif
   endif
   kklpr=getfield('t1','kgpr','kln','kklp')
   if kgpr=kklpr
      if okklr#0
         if kgpr#okklr
            wmess('��������!!! ��㧮�����⥫� - ���⥫�騪',3)
         endif
      else
         wmess('��������!!! ��㧮�����⥫� - ���⥫�騪',3)
      endif
   endif
endif
if gnCtov=1
   if corsh=1
      sele rs2
      set orde to tag t2
      if netseek('t2','ttnr')
         do while ttn=ttnr
            if int(mntov/10000)<2
               skip
               loop
            endif
            mntovr=mntov
            if !chkmkkgp(mntovr,kgpr)
               retu .f.
            endif
            sele rs2
            skip
         endd
      endif
   endif
endif

if corsh=1.and.!(gnVo=5.or.gnVo=6.or.gnVo=4).and.gnArm=3
   sele sgrp
   go top
   plicr=0
   do while !eof()
      if lic#0
         plicr=1
         exit
      endif
      skip
   endd
   if plicr=1.and.!(kopr=169.or.kopr=151)
      sele rs2
      if netseek('t1','ttnr')
         do while ttn=ttnr
            ktlr=ktl
            licr=getfield('t1','int(ktlr/1000000)','sgrp','lic')
            nlicr=getfield('t1','licr','lic','nlic')
            if licr#0
               sele klnlic
               if okplr=0
                  if netseek('t1','kplr,kgpr')
                     lic_r=0
                     do while kkl=kplr.and.kgp=kgpr
                        if lic#licr
                          skip
                          loop
                        endif
                        if !(gdTd>=dnl.and.gdTd<=dol)
                           skip
                           loop
                        else
                           lic_r=1
                           exit
                        endif
                        skip
                     enddo
                     if lic_r=0
                        wmess(str(ktlr,9)+' � ��-�:'+str(kplr,7)+' ��⥪ �ப ��業��� ⨯:'+str(licr,1) +' �� '+nlicr,3)
                        retu .f.
                     endif
                  else
                     wmess('� ���-�:'+str(kplr,7)+' ��� ��業���',3)
                     retu .f.
                  endif
               else
                  if netseek('t1','okplr,kgpr')
                     lic_r=0
                     do while kkl=okplr.and.kgp=kgpr
                        if lic#licr
                           skip
                           loop
                        endif
                        if !(gdTd>=dnl.and.gdTd<=dol)
                           skip
                           loop
                        else
                           lic_r=1
                           exit
                        endif
                        skip
                     enddo
                     if lic_r=0
                        wmess(str(ktlr,9)+' � ��-�:'+str(okplr,7)+' ��⥪ �ப ��業��� ⨯:'+str(licr,1) +' �� '+nlicr,3)
                        retu .f.
                     endif
                  else
                     wmess('� ������:'+str(okplr,7)+' ��� ��業���',3)
                     retu .f.
                  endif
               endif
            endif
            sele rs2
            skip
         enddo
      endif
   endif
endif
retu .t.

**********************
func kplkta()
**********************
kpl_rr=0
if kplr=0
   if select('kplkgp')#0
      sele kplkgp
      if !empty(indexkey(2))
         if ktar#0.and.gnVo=9
            if select('tkplkta')#0
               sele tkplkta
               use
               erase tkplkta.dbf
            endif
            crtt('tkplkta',"f:kpl c:n(7)")
            sele 0
            use tkplkta
            sele kplkgp
            set orde to tag t3
            if netseek('t3','ktar')
               do while kta=ktar
                  kpl_rr=kpl
                  sele tkplkta
                  locate for kpl=kpl_rr
                  if !foun()
                     netadd()
                     netrepl('kpl','kpl_rr')
                  endif
                  sele kplkgp
                  skip
               endd
            endif
            sele tkplkta
            go top
            kpl_rr=slcf('tkplkta',7,10,12,,"e:kpl h:'���' c:n(7) e:getfield('t1','tkplkta->kpl','kln','nkl') h:'������������' c:c(40)",'kpl',,,,,,'���⥫�騪')
            if lastkey()=K_ESC
               kpl_rr=0
            endif
            sele tkplkta
            use
            erase tkplkta.dbf
         endif
      endif
   endif
endif


if kpl_rr#0
   kplr=kpl_rr
endif

if gnEnt=20.and.kplr#0.and.gnVo=9.and.pr361r=1.and.kopr#177
   codelistr=getfield('t1','kplr','kpl','codelist')
   if !empty(codelistr)
      ckopr=str(kopr,3)
      if at(ckopr,codelistr)=0
         wmess('�������⨬� ��� ����樨',2)
         retu .f.
      endif
   endif
endif

if !kplkln()
   retu .f.
endif

retu .t.


**************
func kpvkln()
**************
sele kln
if !netseek('t1','kpvr')
   sele kln
   go top
endif
kklr=kpvr
kpvr=slct_kl(10,1,12)
*if kpvr=0
*   retu .f.
*endif
retu .t.
*************
func kplbs()
*************
sele bs
if !netseek('t1','kplr')
   sele bs
   go top
endif
kplr=slcf('bs',,,,,"e:bs h:'���'c:n(6) e:nbs h:'������������' c:c(20)",'bs')
if lastkey()=K_ESC
   kplr=0
endif
retu .t.
*************
func kpsbs()
*************
sele kln
if !netseek('t1','ttnkpsr')
   sele kln
   go top
endif
ttnkpsr=slcf('kln',,,,,"e:kkl h:'���' c:n(7) e:nkl h:'������������' c:c(20)",'kkl')
if lastkey()=K_ESC
   ttnkpsr=0
endif
retu .t.
**********
func q()
**********
if qr>100
   qr=mod(qr,100)
endif
if !netseek('t1','gnD0k1,gnVu,gnVo,qr')
   if !netseek('t1','gnD0k1,gnVu,gnVo')
      qr=0
      retu .t.
   endif
endif
qr=SLCf('soper',,,,,"e:kop h:'���' c:n(3) e:nop h:'������������' c:c(40)",'kop',,,'d0k1=gnD0k1.and.vu=gnVu.and.vo=gnVo')
if lastkey()=K_ESC
   qr=0
   kopr=0
endif
retu .t.
***********
func pdr()
***********
sele podr
if !netseek('t1','kgpr')
   go top
endif
kgpr=slcf('podr',,,,,"e:pod h:'��' c:n(4) e:npod h:'������������' c:c(20)",'pod',,,,'pod<100')
if lastkey()=K_ESC
   kgpr=0
endif
retu .t.
**************
func skltar()
**************
sel=select()
if sklr#0
   sele kln
   if netseek('t1','sklr')
      return .t.
   else
      wmess('��� ⠪��� ������ ',3)
   endif
endif
save screen to ekr1
mess('���� ���� �ନ஢����')
crtt('ltar',"f:skl c:n(7) f:nskl c:c(40)")
sele 0
use ltar
index on str(skl,7) tag ltar1
sele tov
set orde to tag t1
go top
skl_rr=0
do while !eof()
   if skl#skl_rr
      skl_rr=skl
      nsklrr=''
      sele ltar
      seek str(skl_rr,7)
      if !FOUND()
         nsklrr=getfield('t1','skl_rr','kln','nkl')
         appe blank
         repl skl with skl_rr,nskl with nsklrr
      endif
   endif
   sele tov
   skip
endd
sele ltar
inde on nskl tag ltar2
go top
do while .t.
   rc_tar=recn()
   sklr=slcf('ltar',,,,,"e:nskl h:'������������' c:c(40) e:skl h:'���' c:n(7)",'skl')
   if lastkey()=K_ESC.or.lastkey()=K_ENTER
      exit
   endif
   if lastkey()>32.and.lastkey()<255
   //if lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
      lstkr=upper(chr(lastkey()))
      seek lstkr
      if !FOUND()
         go rc_tar
      endif
    endif
enddo
rest screen from ekr1
sele ltar
use
erase ltar.dbf
erase ltar.cdx
select(sel)
return .t.
****************
func vinprov()
****************
s92r=0
sele rs2
netseek('t1','ttnr')
DO WHIL TTN = ttnr
   ktlr=ktl
   kvpr=kvp
   bzenr=bzen
   SELE tov
   if netSEEK('t1','sklr,ktlr')
      keurr=keur
      keur1r=keur1
      keur2r=keur2
      keur3r=keur3
      keur4r=keur4
      keuhr=keuh
      do case
         case month(dotr)>2.and.month(dotr)<6
              keu_r=keur1r
         case month(dotr)>5.and.month(dotr)<9
              keu_r=keur2r
         case month(dotr)>8.and.month(dotr)<12
              keu_r=keur3r
         other
              keu_r=keur4r
     endc
     if keu_r=0
        keu_r=keurr
     endif
     s92r=s92r+ROUND(kvpr*bzenr,2)*keu_r/100
  endif
  SELE RS2
  Skip
ENDD
sele rs3
if s92r#0
   if netseek('t1','ttnr,92')
      netrepl('bssf','s92r')
   endif
endif
retu .t.
**********************
func rs3add(p1,p2,p3)
**********************
* p1 - ����� ����
* p2 - �㬬� ssf
* p3 - �㬬� bssf

priv ksz_rr,ssf_rr,bssf_rr

ksz_rr=p1

if p2=nil
   ssf_rr=0
else
   ssf_rr=p2
endif
if p3=nil
   bssf_rr=0
else
   bssf_rr=p3
endif

sele rs3
if netseek('t1','ttnr,ksz_rr')
   if (ssz#ssf_rr.or.ssf#ssf_rr.or.bssf#bssf_rr)
       if pbzenr=0
          netrepl('ssz,ssf','ssf_rr,ssf_rr')
       else
          if bprzr=0
             netrepl('ssz,ssf,bssf','ssf_rr,ssf_rr,bssf_rr')
          else
             netrepl('ssz,ssf','ssf_rr,ssf_rr')
          endif
       endif
   endif
else
   if (ssf_rr#0.or.bssf_rr#0)
      netAdd()
      if pbzenr=0
         netrepl('ttn,ksz,ssz,ssf','ttnr,ksz_rr,ssf_rr,ssf_rr')
      else
         if bprzr=0
            netrepl('ttn,ksz,ssz,ssf,bssf','ttnr,ksz_rr,ssf_rr,ssf_rr,bssf_rr')
         else
            netrepl('ttn,ksz,ssz,ssf','ttnr,ksz_rr,ssf_rr,ssf_rr')
         endif
      endif
   endif
endif
retu .t.
***********
func skt()
***********
  /*if gnEnt=21.and.gnSk=243
  *   sktr=242
  *   mskltr=getfield('t1','sktr','cskl','mskl')
  *   if autor=3
  *      @ 5,1 say  '�����祭��:  '+str(sktr,3)+' '+nskltr
  *   endif
  *   retu .t.
  *endif
  */
  do case
     case gnEnt=20
          if vor=6.and.kopr=188
             if sktr=239
                sktr=0
             endif
          endif
     case gnEnt=21
          if vor=6.and.kopr=188
             if STR(sktr,3) $ '238;239;703'
                sktr=0
             endif
          endif
  endc
  sele cskl
  if !netseek('t1','sktr')
     sktr=0
     go top
  else
     if gnArnd=2
        if !(ent=gnEnt.and.arnd=2.and.sk#gnSk)
           sktr=0
        endif
     else
        do case
           case gnEnt=13
                if !(ent=gnEnt.and.rasc=1.and.sk#142.and.sk#gnSk)
                   sktr=0
                endif
           case gnEnt=20
                if !(ent=gnEnt.and.rasc=1.and.sk#239.and.sk#gnSk)
                   sktr=0
                endif
           case gnEnt=21
                if gnArnd=0
                   if !(ent=gnEnt.and.rasc=1.and.(sk#238.or.sk#703).and.sk#gnSk)
                      sktr=0
                   endif
                else
                   sktr=0
                endif
           othe
                if !(ent=gnEnt.and.rasc=1.and.sk#gnSk)
                   sktr=0
                endif
        endc
     endif
  endif
  mskltr=mskl
  if mskltr=0
     skltr=skl
  else
     skltr=0
  endif
  nskltr=nskl
  if sktr=0
     sele cskl
     go top
     rccsklr=recn()
     do while .t.
        sele cskl
        go rccsklr
        if gnArnd=2
           rccsklr=slcf('cskl',,,10,,"e:sk h:'���' c:n(3) e:nskl h:'������������' c:c(30)",,,,,'ent=gnEnt.and.arnd=2.and.sk#gnSk',,'�����-�����祭��')
        else
           if gnAdm#1
              do case
                 case gnEnt=13
                      forcsklr='ent=gnEnt.and.rasc=1.and.sk#142.and.sk#gnSk'
                 case gnEnt=20
                      if gnRasc=2
                         forcsklr='ent=gnEnt.and.rasc=2.and.sk#239.and.sk#gnSk'
                      else
                         forcsklr='ent=gnEnt.and.rasc=1.and.sk#239.and.sk#gnSk'
                      endif
                 case gnEnt=21
                      if gnArnd=0
                         forcsklr='ent=gnEnt.and.rasc=1.and.(sk#238.or.sk#703).and.sk#gnSk'
                      else
                         forcsklr='ent=gnEnt.and.arnd=2'
                      endif
                 othe
                      forcsklr='ent=gnEnt.and.rasc=1.and.sk#gnSk'
              endc
           else
              forcsklr='ent=gnEnt.and.sk#gnSk'
           endif
           rccsklr=slcf('cskl',,,10,,"e:sk h:'���' c:n(3) e:nskl h:'������������' c:c(30)",,,,,forcsklr,,'�����-�����祭��')
        endif
        sele cskl
        go rccsklr
        sktr=sk
        mskltr=mskl
        gcPath_tt=gcPath_e+alltrim(path)
        if mskltr=0
           skltr=skl
        else
           skltr=0
        endif
        nskltr=nskl
        do case
           case lastkey()=K_ESC
                sktr=0
                retu .f.
           case lastkey()=K_ENTER
                exit
        endc
     enddo
  endif
  if autor=3
     @ 5,1 say  '�����祭��:  '+str(sktr,3)+' '+nskltr
  endif

  retu .t.

***************
func asklkpl()
***************
if sklr#0
   if !netseek('t1','sklr','tov')
      sklr=0
   endif
   if sklr#0
      if !netseek('t1','sklr','kpl')
         sklr=0
      endif
   endif
endif
if sklr=0
   sele kpl
   go top
   sklr=slcf('kpl',,,10,,"e:kpl h:'���' c:n(7) e:getfield('t1','kpl->kpl','kln','nkl') h:'������������' c:c(40)",'kpl',,,,"netseek('t1','kpl->kpl','tov')",,'�७����⥫�')
   if lastkey()=K_ESC
      retu .f.
   endif
endif
nsklr=getfield('t1','sklr','kln','nkl')
retu .t.
***************
func akplkpl()
  ***************
  local getlist:={}
  if kplr=20034
     kplr=0
  endif
  if gnArnd=0
     if kplr#0
        if !netseek('t1','kplr','kpl')
           kplr=0
        endif
     endif
  endif
  afltr='.t.'
  if kplr=0
     sele kpl
     go top
     aflt_r='.t.'
     afltr='.t.'
     do while .t.
        foot('F3','������')
        kplr=slcf('kpl',,,10,,"e:kpl h:'���' c:n(7) e:getfield('t1','kpl->kpl','kln','nkl') h:'������������' c:c(40)",'kpl',,,,afltr,'kpl#20034','�७����')
        if lastkey()=K_ESC
           retu .f.
        endif
        if lastkey()=K_ENTER
           exit
        endif
        if lastkey()=K_F3
           clttncr=setcolor('gr+/b,n/bg')
           wttncr=wopen(10,20,12,60)
           wbox(1)
           ctxtr=space(20)
           @ 0,1 say '���⥪��' get ctxtr
           read
           if lastkey()=K_ESC
              afltr=aflt_r
           endif
           if lastkey()=K_ENTER
              if !empty(ctxtr)
                 ctxtr=upper(alltrim(ctxtr))
                 afltr=aflt_r+".and.at(ctxtr,upper(getfield('t1','kpl->kpl','kln','nkl')))#0"
              endif
           endif
           wclose(wttncr)
           setcolor(clttncr)
        endif
     endd
  endif
  nkplr=getfield('t1','kplr','kln','nkl')
  retu .t.
***************
func akgpkgp()
***************
if kgpr#0
   if gnArnd=0
      if !netseek('t1','kgpr','kgp')
         kgpr=0
      endif
   endif
*   if gnArnd=2
*      if !netseek('t2','kplr,kgpr','etm')
*         kgpr=0
*      endif
*   endif
endif
if kgpr=0
   sele etm
   set orde to tag t2
   if netseek('t2','kplr')
       kgpr=slcf('etm',,,10,,"e:kgp h:'���' c:n(7) e:getfield('t1','etm->kgp','kln','nkl') h:'������������' c:c(40)",'kgp',,,,'kpl=kplr',,'�����祭��')
       if lastkey()=K_ESC
           kgpr=0
           retu .f.
       endif
   else
      kgpr=0
      retu .f.
   endif
endif
*if gnEnt=20
   ngpr=getfield('t1','kgpr','kgp','ngrpol')
   if empty(ngpr)
      ngpr=getfield('t1','kgpr','kln','nkl')
   endif
*else
*   ngpr=getfield('t1','kgpr','kln','nkl')
*endif
retu .t.
**************
func docgi()
**************
if !empty(docguidr)
   sele rs1
   locate for upper(docguid)=upper(docguidr)
   if foun().and.ttn#ttnr
      wmess('��� '+str(ttn,6)+' �㬬� '+str(sdv,12,2),3)
      if przn=1
*         retu .f.
      endif
   endif
endif
retu .t.
*************
func tmkpl()
*************
kpl_rr=0
if kplr#0
   sele etm
   set orde to tag t2
   if netseek('t2','kplr')
      kpl_rr=0
      do while kpl=kplr
         tmesto_rr=tmesto
         if netseek('t1','ktar,tmesto_rr','stagtm')
            kpl_rr=kplr
            exit
         endif
         sele etm
         skip
      endd
   else
      kpl_rr=0
   endif
endif
kplr=kpl_rr
if kplr=0
   sele stagtm
   set orde to tag t1
   if netseek('t1','ktar')
      crtt('tkplkta',"f:kpl c:n(7)")
      sele 0
      use tkplkta
      sele stagtm
      do while kta=ktar
         tmesto_rr=tmesto
         kpl_rr=getfield('t1','tmesto_rr','etm','kpl')
         sele tkplkta
         locate for kpl=kpl_rr
         if !foun()
            netadd()
            netrepl('kpl','kpl_rr')
         endif
         sele stagtm
         skip
      endd
      sele tkplkta
      go top
      kpl_rr=slcf('tkplkta',7,10,12,,"e:kpl h:'���' c:n(7) e:getfield('t1','tkplkta->kpl','kln','nkl') h:'������������' c:c(40)",'kpl',,,,,,'���⥫�騪')
      if lastkey()=K_ESC
         kpl_rr=0
      endif
      sele tkplkta
      use
      erase tkplkta.dbf
   endif
endif
if kpl_rr=0
   retu .f.
else
   kplr=kpl_rr
endif
if gnCtov=1.and.gnVo=9.and.(gnEnt=13.or.gnEnt=20.or.gnEnt=21)
   if okplr=0
      sele klndog
      if !klndog(kplr)
        retu .f.
      endif
      nnzr=str(ndog,6)
      dnzr=dtdogb
   endif
   if empty(docguidr)
      if empty(ttn1cr)
          @ 0,39 say subs(nnzr,1,8)+' ��  '+dtoc(dnzr)
      else
         @ 0,39 say ttn1cr
      endif
   else
   endif
endif
retu .t.
**************
func tmkgp()
**************
if kgpr#0
   tmesto_rr=getfield('t2','kplr,kgpr','etm','tmesto')
   if tmesto_rr=0
      kgpr=0
   else
      if !netseek('t1','ktar,tmesto_rr','stagtm')
         kgpr=0
      endif
   endif
endif
if kgpr=0
   if select('tkplkgp')#0
      sele tkplkgp
      use
      erase tkplkgp.dbf
   endif
   crtt('tkplkgp',"f:a c:c(1) f:c c:c(1) f:kgp c:n(7)")
   sele 0
   use tkplkgp
   sele etm
   set orde to tag t2
   netseek('t2','kplr')
   do while kpl=kplr
      tmesto_rr=tmesto
      kgp_rr=kgp
      if netseek('t1','ktar,tmesto_rr','stagtm')
         kklpr=getfield('t1','kgp_rr','kln','kklp')
         store '' to ar,cr
         if kklpr=kplr
            cr='C'
         endif
         sele tkplkgp
         netadd()
         netrepl('kgp,c','kgp_rr,cr')
      endif
      sele etm
      skip
   endd
   sele tkplkgp
   go top
   kgpr=slcf('tkplkgp',,,12,,"e:a h:'A' c:c(1) e:c h:'C' c:c(1) e:kgp h:'���' c:n(7) e:getfield('t1','tkplkgp->kgp','kln','nkl') h:'������������' c:c(30) e:getfield('t1','tkplkgp->kgp','kln','adr') h:'����' c:c(30)",'kgp',,,,,,'��㧮�����⥫�')
   sele tkplkgp
   use
   erase tkplkgp.dbf
endif

if kgpr=0
   retu .f.
endif

if gnCtov=1
   if corsh=1
      sele rs2
      set orde to tag t2
      if netseek('t2','ttnr')
         do while ttn=ttnr
            if int(mntov/10000)<2
               skip
               loop
            endif
            mntovr=mntov
            if !chkmkkgp(mntovr,kgpr)
               retu .f.
            endif
            sele rs2
            skip
         endd
      endif
   endif
endif
retu .t.

*************
func kta()
  *************
  sele s_tag
  if ktar#0
     if !netseek('t1','ktar')
        ktar=0
     else
        if uvol=1
           ktar=0
        endif
        ktasr=ktas
        if gnEnt=20.or.gnEnt=21.and.gnEntrm=0
           if ktasr=0.and.pr361r=1
              ktar=0
           endif
           if ent#gnEnt.and.pr361r=1
              ktar=0
           endif
        endif
     endif
  endif
  if ktar=0
     go top
     if pr361r=0
        ktar=SLCf('s_tag',,,10,,"e:kod h:'���' c:n(4) e:fio h:'  �.  �.  �. ' c:c(30)",'kod',,,,'uvol=0')
     else
        if gnEnt=20.or.gnEnt=21.and.gnEntrm=0
           ktar=SLCf('s_tag',,,10,,"e:kod h:'���' c:n(4) e:fio h:'  �.  �.  �. ' c:c(30)",'kod',,,,'ent=gnEnt.and.uvol=0')
        else
           ktar=SLCf('s_tag',,,10,,"e:kod h:'���' c:n(4) e:fio h:'  �.  �.  �. ' c:c(30)",'kod',,,,'uvol=0')
        endif
     endif
     if lastkey()=K_ESC
        ktar=0
        ktasr=0
        retu .f.
     endif
  endif
  if pr361r=1.and.ktar#0
     ktasr=getfield('t1','ktar','s_tag','ktas')
     if ktasr#0
        prExter=getfield('t1','ktasr','s_tag','prExte')
     else
        if gnEnt=20.or.gnEnt=21.and.gnEntrm=0
           wmess('��� �㯥ࢠ����',3)
           prExter=1
           retu .f.
        endif
     endif
     napr=getfield('t1','ktar','ktanap','nap')
     if napr=0
        if ktasr#0
           napr=getfield('t1','ktasr','ktanap','nap')
        endif
     endif
  else
     ktasr=0
     napr=0
     prExter=1
  endif
  retu .t.

***********************
func kta20(p1)
  * p1=1 ���쪮 �஢�ઠ
  * ��।�����: ktar
  ***********************
  sele s_tag
  if ktar#0
     if !netseek('t1','ktar')
        ktar=0
     else
        if !(ent=gnEnt.and.uvol=0.and.ktas#0)
           ktar=0
        endif
        ktasr=ktas
     endif
  endif

  if ktar=0.and.empty(p1)
     sele s_tag
     set orde to tag t2
     go top
     rcstagr=recn()
     if gnEntrm=0
        forstagr="ktas#0.and.uvol=0.and.ent=gnEnt.and.agsk#0.and.getfield('t1','s_tag->agsk','cskl','rm')=gnRm"
     else
        forstagr="ktas#0.and.uvol=0.and.ent=gnEnt.and.agsk#0.and.getfield('t1','s_tag->agsk','cskl','rm')=1"
     endif
     do while .t.
        sele s_tag
        go rcstagr
        rcstagr=slcf('s_tag',,,,,"e:kod h:'���' c:n(4) e:fio h:'� � �' c:c(30) e:Exte h:'�' c:n(1) e:ktas h:'�㯥�' c:n(4) e:getfield('t1','s_tag->ktas','s_tag','Exte') h:'C' c:n(1) e:agsk h:'�����' c:n(3)",,,,,forstagr,,'������')
        if lastkey()=K_ESC
           exit
           ktar=0
        endif
        sele s_tag
        go rcstagr
        ktar=kod
        do case
           case lastkey()=K_ENTER
                exit
        endc
     endd
  endif

  if ktar=0
     ktasr=0
     napr=0
     retu .f.
  else
     ktasr=getfield('t1','ktar','s_tag','ktas')
     Exter=Exte(ktar)
     napr=getfield('t1','ktar','ktanap','nap')
     if napr=0
        if ktasr#0
           napr=getfield('t1','ktasr','ktanap','nap')
        endif
     endif
     retu .t.
  endif

***********************
func kpl20()
* ��।�����: ktar,kplr
***********************
if kopr=169.and.kplr#0
   if gnArm#0
      if getfield('t1','kplr','kln','kkl1')=0
         wmess('�� �� ���⥫�騪',2)
         retu .f.
      endif
   else
      kplr=20034
      retu .t.
   endif
endif

if kplr#0.and.kopr#169.and.kopr#168
   kplr=chkkpl()
endif

prretr=.t.


if kplr=0
   crtt('tkpl','f:kpl c:n(7)')
   sele 0
   use tkpl
   inde on str(kpl,7) tag t1
   do case
      case Exter=0.or.Exter=3
           * �।�������� KPLKGP,���������� �� KPL
           sele kplkgp
           set orde to tag t3
           if netseek('t3','ktar')
              do while kta=ktar
                 kplr=kpl
                 sele tkpl
                 locate for kpl=kplr
                 if !foun()
                    appe blank
                    repl kpl with kplr
                 endif
                 sele kplkgp
                 skip
              endd
           endif
      case Exter=1.or.Exter=2
           * �।�������� STAGTM
           sele stagtm
           set orde to tag t1
           if netseek('t1','ktar')
              do while kta=ktar
                 tmesto_r=tmesto
                 kplr=getfield('t1','tmesto_r','etm','kpl')
                 sele tkpl
                 if !netseek('t1','kplr')
                    appe blank
                    netrepl('kpl','kplr')
                 endif
                 sele stagtm
                 skip
                 loop
              endd
           endif
   endc
   sele tkpl
   go top
   rctkplr=recn()
   do while .t.
      sele tkpl
      go rctkplr
      do case
         case Exter=0.or.Exter=3
              foot('INS','��������')
              cnplr='KPLKGP'
         case Exter=1
              foot('','')
              cnplr='STAGTM'
         case Exter=2
              foot('INS','��������')
              cnplr='STAGTM'
      endc
      rctkplr=slcf('tkpl',,,,,"e:kpl h:'���' c:n(7) e:getfield('t1','tkpl->kpl','kln','nkl') h:'������������' c:c(31) e:getfield('t1','tkpl->kpl','klndog','ndog') h:'�������' c:n(6) e:getfield('t1','tkpl->kpl','klndog','dtdoge') h:'��⠎' c:d(10) e:getfield('t1','tkpl->kpl','kpl','codelist') h:'���' c:c(19)",,,,,,,'���⥫�騪� '+cnplr)
      if lastkey()=K_ESC
         kplr=0
         prretr=.f.
         exit
      endif
      sele tkpl
      go rctkplr
      kplr=kpl
      do case
         case lastkey()=K_ENTER
              if !(kopr=169.or.kopr=168)
                 kplr=chkkpl()
              endif
              if kplr#0
                 exit
              endif
         case lastkey()=K_INS.and.Exter#1 // ��������
              tkplins()
      endc
   endd
   if select('tkpl')#0
      sele tkpl
      use
      erase tkpl.dbf
      erase tkpl.cdx
   endif
endif

retu prretr

***********************
func chkkpl(p1)
* ��।����� kplr,ktar
* p1 ��� wmess
* ��� VO=9
***********************
local kpl_r
kpl_r=kplr

if kopr=169.or.kopr=151.or.kopr=154.or.kopr=177.or.kopr=168
   retu kpl_r
endif

if !dog(kplr)
   if empty(p1)
      wmess('�஡���� � ������஬',2)
   endif
   kpl_r=0
else
   if !codelist(kplr)
      if empty(p1)
         wmess('�������⨬� ���',2)
      endif
      kpl_r=0
   else
      do case
         case Exter=0
              *
         case Exter=1
              * �஢�ઠ �� stagtm
              sele stagtm
              if !netseek('t1','ktar')
                 if empty(p1)
                    wmess('��� �࣮��� ���� ��� ����� � STAGTM',2)
                 endif
                 kpl_r=0
              else
                 sele etm
                 set orde to tag t2
                 if !netseek('t2','kplr')
                    if empty(p1)
                       wmess('��� �� ���� ��� ���⥫�騪� � ETM',2)
                    endif
                    kpl_r=0
                 else
                    prktatmr=0
                    do while kpl=kplr
                       tmestor=tmesto
                       if netseek('t1','ktar,tmestor','stagtm')
                          prktatmr=1
                          exit
                       endif
                       sele etm
                       skip
                    endd
                    if prktatmr=0
                       if empty(p1)
                          wmess('��� �� ���� ��� ����� � �⨬ ���� � STAGTM',2)
                       endif
                       kpl_r=0
                    endif
                 endif
              endif
         case Exter=2
              *
      endc
   endif
endif
retu kpl_r

**************
func kgp20()
**************
if kgpr#0
   kgpr=chkkgp()
endif

prretr=.t.

if kgpr=0
   crtt('tkgp','f:kgp c:n(7)')
   sele 0
   use tkgp
   inde on str(kgp,7) tag t1
   do case
      case Exter=0.or.Exter=3
           // �।�������� ETM
           sele etm
           set orde to tag t2
           if netseek('t2','kplr')
              do while kpl=kplr
                 kgpr=kgp
                 kgpr=chkkgp(1,1)
                 if kgpr=0
                    sele kplkgp
                    skip
                    loop
                 endif
                 sele tkgp
                 appe blank
                 repl kgp with kgpr
                 sele etm
                 skip
              endd
           endif
      case Exter=1.or.Exter=2
           // �।�������� STAGTM
           sele stagtm
           set orde to tag t1
           if netseek('t1','ktar')
              do while kta=ktar
                 tmesto_r=tmesto
                 kpl_r=getfield('t1','tmesto_r','etm','kpl')
                 if kpl_r#kplr
                    sele stagtm
                    skip
                    loop
                 endif
                 kgp_r=getfield('t1','tmesto_r','etm','kgp')
                 sele tkgp
                 locate for kgp=kgp_r
                 if !foun()
                    appe blank
                    netrepl('kgp','kgp_r')
                 endif
                 sele stagtm
                 skip
                 loop
              endd
           endif
   endc
   sele tkgp
   go top
   rctkgpr=recn()
   do while .t.
      sele tkgp
      go rctkgpr
      do case
         case Exter=0.or.Exter=3
              foot('INS','��������')
              cngpr='ETM'
         case Exter=1
              foot('','')
              cngpr='STAGTM'
         case Exter=2
              foot('INS','��������')
              cngpr='STAGTM'
      endc
      rctkgpr=slcf('tkgp',,,,,"e:kgp h:'���' c:n(7) e:getfield('t1','tkgp->kgp','kln','nkl') h:'������������' c:c(40) e:getfield('t1','tkgp->kgp','kgp','rm') h:'���' c:n(1) ",,,,,,,'��㧮�����⥫� '+cngpr)
      if lastkey()=K_ESC
         kgpr=0
         prretr=.f.
         exit
      endif
      sele tkgp
      go rctkgpr
      kgpr=kgp
      do case
         case lastkey()=K_ENTER
              kgpr=chkkgp(,1)
              if kgpr#0
                 exit
              endif
         case lastkey()=K_INS.and.Exter#1 // ��������
              tkgpins()
      endc
   endd
   if select('tkgp')#0
      sele tkgp
      use
      erase tkgp.dbf
      erase tkgp.cdx
   endif
endif
retu prretr

*****************************
func chkkgp(p1,p2)
* ��।����� ktar,kplr,kgpr,kpvr
* p1 ��� wmess
* p2 ��� �஢ nkkl,kpv
* ��� VO=9
*****************************
if  empty(p2)
   if (kopr=169.or.kopr=168).and.corsh=0
      if kpvr=0
         kgp_r=kgpr
      else
         kgp_r=kpvr
      endif
      if nkklr=0
         kpl_r=kplr
      else
         kpl_r=nkklr
      endif
   else
      kgp_r=kgpr
      kpl_r=kplr
   endif
else
   kgp_r=kgpr
   kpl_r=kplr
endif
***********************************************************
***********************************************************
if kopr=151.or.kopr=154.or.kopr=177 //.or.kopr=169
   retu kgp_r
endif
***********************************************************
***********************************************************
if kgp_r#0
   if Exter=0
      if !netseek('t1','kgp_r','kln')
         if empty(p1)
            wmess('��㧮�����⥫� ��� � �� �����⮢ KLN',2)
         endif
         kgp_r=0
      endif
   else
      if !netseek('t1','kgp_r','kgp')
         if empty(p1)
            wmess('��� � �ࠢ�筨�� ��㧮�����⥫��',2)
         endif
         kgp_r=0
      else
         if kgp_r#20034
            if !kgprm(kgp_r)
               if empty(p1)
                  wmess('��㧮�����⥫� �� �⮣� ॣ����',2)
               endif
               kgp_r=0
            else
               do case
                  case Exter=0
                       *
                  case Exter=1
                       * �஢�ઠ �� stagtm
                       sele stagtm
                       if !netseek('t1','ktar')
                          if empty(p1)
                             wmess('��� �࣮��� ���� ��� ����� � STAGTM',2)
                          endif
                          kgp_r=0
                       else
                          sele etm
                          set orde to tag t3
                          if !netseek('t3','kgp_r,kpl_r')
                             if empty(p1)
                                wmess('��� ���� � ETM',2)
                             endif
                             kgp_r=0
                          else
                             prktatmr=0
                             do while kgp=kgp_r
                                tmestor=tmesto
                                if netseek('t1','ktar,tmestor','stagtm')
                                   prktatmr=1
                                   exit
                                endif
                                sele etm
                                skip
                             endd
                             if prktatmr=0
                                if empty(p1)
                                   wmess('��� �� ���� ��� ����� � �⨬ ��/��� � STAGTM',2)
                                endif
                                kgp_r=0
                             endif
                          endif
                       endif
                  case Exter=2
                       *
               endc
            endif
         endif
      endif
   endif
endif
retu kgp_r

*****************
func codelist(p1)
* ��� VO=9
*****************
if vor#9
   retu .t.
endif
if kopr=177
   retu .t.
endif
if kopr=168
   retu .t.
endif
kpl_rr=p1
codelistr=getfield('t1','kpl_rr','kpl','codelist')
if !empty(codelistr)
   ckopr=str(kopr,3)
   if at(ckopr,codelistr)=0
      if gnEnt=20
         if kopr#177
            retu .f.
         endif
      else
         retu .f.
      endif
   endif
else
   if gnEnt=20
      if kopr#177
         retu .f.
      endif
   else
      retu .f.
   endif
endif
retu .t.

*****************
func Exte(p1)
  *****************
  * ��।������ ०��� �믨᪨ ���㬥�� ��� �����
  local Exte_r
  kta_rr=p1
  sele s_tag
  if !netseek('t1','kta_rr')
     Exte_r=0
  else
     ktas_rr=ktas
     Exte_r=Exte
     if Exte_r=0
        if ktas_rr#0
           Exte_r=getfield('t1','ktas_rr','s_tag','Exte')
        endif
     endif
  endif
  retu Exte_r

*********************
func chkmkkgp(p1,p2)
  *********************
  * p1 - mntovr
  * p2 - kgpr
  local mkexclr,mntovr,kgpr,i,aaa
  mntovr=p1
  kgpr=p2
  if gnCtov#1
     retu .t.
  endif
  mkeep_r=getfield('t1','mntovr','ctov','mkeep')
  nmkeep_r=getfield('t1','mkeep_r','mkeep','nmkeep')
  if mkeep_r#0
     mkexclr=getfield('t1','kgpr','kgp','mkexcl')
     if !empty(mkexclr)
        mkexclr=alltrim(mkexclr)
        aaa=''
        for i=1 to len(mkexclr)
            if subs(mkexclr,i,1)=','
               mkeep_rr=val(aaa)
               if mkeep_r=mkeep_rr
                  wmess('��� '+alltrim(nmkeep_r)+' �㦠� �窠',2)
                  retu .f.
               else
                  aaa=''
               endif
            else
               aaa=aaa+subs(mkexclr,i,1)
            endif
        next
        if !empty(aaa)
           mkeep_rr=val(aaa)
           if mkeep_r=mkeep_rr
              wmess('��� '+alltrim(nmkeep_r)+' �㦠� �窠',2)
              retu .f.
           else
              aaa=''
           endif
        endif
     endif
  endif
  retu .t.

************************
func dog(p1,nl_kopr)
  * p1 - ��� ���⥫�騪� nl_kopr - ��� ����樨
  ************************
  local prtr
  DEFAULT nl_kopr TO kopr
  if str(nl_kopr,3) $ '177;129;139;168;169'
    retu .t.
  endif
  prtr=.t.
  kkl_r=p1
  als_rr=alias()
  if !empty(als_rr)
     rcals_rr=recn()
  endif
  sele klndog
  if !netseek('t1','kkl_r')
    prtr=.f.
    #ifdef __CLIP__
       outlog(3,__FILE__,__LINE__,"seek",kkl_r)
    #endif
  endif
  if ndog=0
    prtr=.f.
    #ifdef __CLIP__
       outlog(3,__FILE__,__LINE__,"ndog=0",kkl_r)
    #endif
  endif
  if dtDogE < Date()
     prtr=.f.
  #ifdef __CLIP__
     outlog(3,__FILE__,__LINE__,"dtDogE < Date()",kkl_r)
  #endif
  endif
  if !empty(als_rr)
     sele (als_rr)
     go rcals_rr
  endif
  retu prtr

****************************
func kgprm(p1)
  * p1 - ��� ��㧮�����⥫�
  ****************************
  local prtr
  if kopr=177
  *   retu .t.
  endif
  if gnEnt#20
     retu .t.
  endif
  prtr=.t.
  kgp_r=p1
  als_rr=alias()
  if !empty(als_rr)
     rcals_rr=recn()
  endif
  rmr=getfield('t1','kgp_r','kgp','rm')
  if gnEntrm=0
     if rmr>2
        prtr=.f.
     endif
  else
     if rmr#gnRmSk
        prtr=.f.
     endif
  endif
  if !empty(als_rr)
     sele (als_rr)
     go rcals_rr
  endif
  retu prtr

*****************
func rfinskl(p1)
*****************
* NIL-�뢮� �� �࠭
* 1  -�����
local sllr,ecran1,oldc
sllr=sele()
if p1=NIL
   save screen to ecran
   oldc=setcolor()
endif
store 0 to symkl
store '' to symklr

sele dkkln
if !netseek('t1','kplr')
   if p1=NIL
      wmess('������ �� ������� ����������',3)
   endif
   select(sllr)
   retu
endif
do while kkl=kplr
   if getfield('t1','dkkln->bs','bs','uchr')#0
      symkl=symkl+dn-kn+db-kr+dp
   endif
   skip
enddo
if symkl=0
   if p1=NIL
      wmess('������ �� ������� ����������',3)
   endif
   select(sllr)
   retu
else
   if symkl>0
      symklr='�����. ������.  - '
   else
      symklr='�।. ������.   - '
   endif
      if p1=NIL
         setcolor('n/w')
         @ 07,20 clea to 12,57
         @ 07,20 to 12,57 doubl
         @ 07,25 say '�����ᮢ�� ���ﭨ� ������:' color 'r/w'
         @ 09,25 say symklr+alltrim(str(symkl,14,2))
         inkey(0)
         rest screen from ecran
         setcolor(oldc)
   endif
endif
select(sllr)
retu .t.

****************
func tkplins()
****************
local getlist:={}
sele kpl
go top
rckplr=recn()
forkpl_r=".t..and.!netseek('t1','kpl->kpl','tkpl')"
forkplr=forkpl_r
ctxtr=''
do while .t.
   sele kpl
   go rckplr
   foot('F3,ENTER','����,��������')
   rckplr=slcf('kpl',,,,,"e:kpl h:'���' c:n(7) e:getfield('t1','kpl->kpl','kln','nkl') h:'������������' c:c(32) e:getfield('t1','kpl->kpl','klndog','ndog') h:'�������' c:n(6) e:getfield('t1','kpl->kpl','klndog','dtdoge') h:'��⠎' c:d(10) e:getfield('t1','tkpl->kpl','kpl','codelist') h:'���' c:c(28)",,,,,forkplr,,'��ࠢ�筨� ���⥫�騪��')
   if lastkey()=K_ESC
      exit
   endif
   sele kpl
   go rckplr
   kplr=kpl
   do case
      case lastkey()=K_ENTER
           sele tkpl
           if !netseek('t1','kplr')
              appe blank
              repl kpl with kplr
              rctkplr=recn()
              exit
           else
              wmess('����� 㦥 ����')
           endif
      case lastkey()=K_F3 // ����
           clttncr=setcolor('gr+/b,n/bg')
           wttncr=wopen(10,20,12,60)
           wbox(1)
           ctxtr=space(20)
           @ 0,1 say '���⥪��' get ctxtr
           read
           if lastkey()=K_ESC
              forkplr=forkpl_r
           endif
           if lastkey()=K_ENTER
              if !empty(ctxtr)
                 ctxtr=upper(alltrim(ctxtr))
                 forkplr=forkpl_r+".and.at(ctxtr,upper(getfield('t1','kpl->kpl','kln','nkl')))#0"
                 sele kpl
                 go top
                 rckplr=recn()
              endif
           endif
           wclose(wttncr)
           setcolor(clttncr)
   endc
endd
retu .t.

****************
func tkgpins()
****************
local getlist:={}
if Exter=0.or.Exter=2
   sele kgp
   go top
   rckgpr=recn()
   forkgp_r=".t..and.!netseek('t1','kgp->kgp','tkgp')"
   forkgpr=forkgp_r
   ctxtr=''
   do while .t.
      sele kgp
      go rckgpr
      foot('F3,ENTER','����,��������')
      rckgpr=slcf('kgp',,,,,"e:kgp h:'���' c:n(7) e:getfield('t1','kgp->kgp','kln','nkl') h:'������������' c:c(40) e:getfield('t1','kgp->kgp','kgp','rm') h:'���' c:n(1)",,,,,forkgpr,,'��ࠢ�筨� ��㧮�����⥫��')
      if lastkey()=K_ESC
         exit
      endif
      sele kgp
      go rckgpr
      kgpr=kgp
      do case
         case lastkey()=K_ENTER
              sele tkgp
              if !netseek('t1','kgpr')
                 appe blank
                 repl kgp with kgpr
                 rctkgpr=recn()
                 exit
              else
                 wmess('����� 㦥 ����')
              endif
         case lastkey()=K_F3 // ����
              clttncr=setcolor('gr+/b,n/bg')
              wttncr=wopen(10,20,12,60)
              wbox(1)
              ctxtr=space(20)
              @ 0,1 say '���⥪��' get ctxtr
              read
              if lastkey()=K_ESC
                 forkgpr=forkgp_r
              endif
              if lastkey()=K_ENTER
                 if !empty(ctxtr)
                    ctxtr=upper(alltrim(ctxtr))
                    forkgpr=forkgp_r+".and.at(ctxtr,upper(getfield('t1','kgp->kgp','kln','nkl')))#0"
                    sele kgp
                    go top
                    rckgpr=recn()
                 endif
              endif
              wclose(wttncr)
              setcolor(clttncr)
      endc
   endd
else // Exter=3
   sele kln
   go top
   rcklnr=recn()
   forklnr='.t.'
   forkln_r='.t.'
   ctxtr=''
   do while .t.
      sele kln
      go rcklnr
      foot('F3,ENTER','����,��������')
      rcklnr=slcf('kln',,,,,"e:kkl h:'���' c:n(7) e:nkl h:'������������' c:c(40)",,,,,forklnr,,'��ࠢ�筨� �����⮢ KLN')
      if lastkey()=K_ESC
         exit
      endif
      sele kln
      go rcklnr
      kgpr=kkl
      do case
         case lastkey()=K_ENTER
              sele tkgp
              if !netseek('t1','kgpr')
                 appe blank
                 repl kgp with kgpr
                 rctkgpr=recn()
                 exit
              else
                 wmess('����� 㦥 ����')
              endif
         case lastkey()=K_F3 // ����
              clttncr=setcolor('gr+/b,n/bg')
              wttncr=wopen(10,20,12,60)
              wbox(1)
              ctxtr=space(20)
              @ 0,1 say '���⥪��' get ctxtr
              read
              if lastkey()=K_ESC
                 forklnr=forklnr_r
              endif
              if lastkey()=K_ENTER
                 if !empty(ctxtr)
                    ctxtr=upper(alltrim(ctxtr))
                    forklnr=forkln_r+".and.at(ctxtr,upper(kln->nkl))#0"
                    sele kln
                    go top
                    rcklnr=recn()
                 endif
              endif
              wclose(wttncr)
              setcolor(clttncr)
      endc
   endd
endif
retu .t.

*****************
func chkttn(p1)
* ��।����� ktar
* p1 ��� wmess
* ��� VO=9
*****************
local kpl_r,kgp_r
if !kta20()
   if empty(p1)
      wmess('�஡���� � ����⮬',2)
   endif
   retu .f.
endif

if empty(p1)
   kpl_r=chkkpl()
else
   kpl_r=chkkpl(1)
endif

if kpl_r=0
   retu .f.
endif

if empty(p1)
   kgp_r=chkkgp()
else
   kgp_r=chkkgp(1)
endif

if kgp_r=0
   retu .f.
endif
retu .t.

***************
func chklic()
***************
if kopr=169
   retu .t.
endif

if gnEnt=20.and.kopr=168.and.vor=9
   retu .t.
endif

if vor=9
   sele sgrp
   go top
   plicr=0
   do while !eof()
      if lic#0
         plicr=1
         exit
      endif
      skip
   endd
   if plicr=1
      sele rs2
      if netseek('t1','ttnr')
         do while ttn=ttnr
            ktlr=ktl
            licr=getfield('t1','int(ktlr/1000000)','sgrp','lic')
            nlicr=getfield('t1','licr','lic','nlic')
            if licr#0
               if gnEntRm=1.or.gnEntRm=0.and.!(kopr=169.or.kopr=168)
                  sele klnlic
                  if netseek('t1','kplr,kgpr')
                     lic_r=0
                     do while kkl=kplr.and.kgp=kgpr
                        if lic#licr
                          skip
                          loop
                        endif
                        if !(dvpr>=dnl.and.dvpr<=dol)
                          skip
                          loop
                        else
                           lic_r=1
                           exit
                        endif
                        skip
                     enddo
                     if lic_r=0
                        wmess(str(ktlr,9)+' dvpr:'+DTOS(dvpr)+' � ��-�:'+str(kplr,7)+' ��⥪ �ப ���-�� �� '+LEFT(nlicr,10),3)
                        retu .f.
                     endif
                  else
                     wmess('� �⮣� ������ ��� ��業���',3)
                     retu .f.
                  endif
               else
                  wmess('� �⮣� ������ ��� ��業���',3)
                  retu .f.
               endif
            endif
            sele rs2
            skip
         enddo
      endif
   endif
endif
retu .t.


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-08-19 * 11:36:18am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION klndog(nl_klpr)
  Private np_kplr:=nl_klpr
  sele klndog
  if !netseek('t1','np_kplr')
      wmess('��� �������',2)
      kplr=0
      retu .f.
  else
      if ndog=0
        wmess('��� �������',2)
        kplr=0
        retu .f.
      else
        if empty(dtdoge)
          wmess('��� ���� �����.�����.',2)
          kplr=0
          retu .f.
        else
          if dtdoge<date()
              wmess('�����稫�� �������',2)
              kplr=0
              retu .f.
          endif
        endif
      endif
  endif
  RETURN (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  12-26-19 * 10:15:27am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION XmlAmbar()

  set console off
  set print on
  set print to ('ambar' + allt(str(ttnr)) + '.xml')

  ??'<?xml version="1.0" encoding="cp866"?>'
  ?'<ValueTable xmlns="http://v8.1c.ru/8.1/data/core" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">������⢮</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:decimal</Type>'
  ?'      <NumberQualifiers>'
  ?'        <Digits>15</Digits>'
  ?'        <FractionDigits>3</FractionDigits>'
  ?'        <AllowedSign>Nonnegative</AllowedSign>'
  ?'      </NumberQualifiers>'
  ?'    </ValueType>'
  ?'    <Title>������⢮</Title>'
  ?'    <Width xsi:type="xs:decimal">10</Width>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">����</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:decimal</Type>'
  ?'      <NumberQualifiers>'
  ?'        <Digits>15</Digits>'
  ?'        <FractionDigits>2</FractionDigits>'
  ?'        <AllowedSign>Nonnegative</AllowedSign>'
  ?'      </NumberQualifiers>'
  ?'    </ValueType>'
  ?'    <Title>����</Title>'
  ?'    <Width xsi:type="xs:decimal">10</Width>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">���ࠢ����������</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">������������������������</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">������������������������������</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">�����������������栈���७��</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">��⨪㫍�����������</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">���������������</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">���劮�������������</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">������㯠⥫�</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'
  ?'  <column>'
  ?'    <Name xsi:type="xs:string">������⠢騪�</Name>'
  ?'    <ValueType>'
  ?'      <Type>xs:string</Type>'
  ?'      <StringQualifiers>'
  ?'        <Length>250</Length>'
  ?'        <AllowedLength>Variable</AllowedLength>'
  ?'      </StringQualifiers>'
  ?'    </ValueType>'
  ?'  </column>'

  sele rs2
  ordsetfocus('t1')
  netseek('t1','ttnr')

  Do While ttn = ttnr
    sele rs2
    ?'  <row>'
    ?'    <Value>' + allt(str(rs2->kvp)) + '</Value>' // �-��
    ?'    <Value>' + allt(str(rs2->zen)) + '</Value>' // ��� ���
    ?'    <Value>�⏮�⠢騪�</Value>'
    ?'    <Value>' + XmlCharTran(getfield('t1','rs2->MnTov','ctov','NaT')) + '</Value>'
    ?'    <Value>' + XmlCharTran(getfield('t1','rs2->MnTov','ctov','NaT')) + '</Value>'
    ?'    <Value>��</Value>' // �� ���
    ?'    <Value>' + allt(str(rs2->MnTov)) + '</Value>' //��⨪㍮��������늮� ⮢��
    ?'    <Value>' + allt(str(rs2->MnTov)) + '</Value>' //�������ફ����� ��� ⮢��

    Barr := getfield('t1','rs2->MnTov','ctov','Bar')
    cBar := '21'+padl(allt(str(rs2->MnTov)),11,'0')
    cBar += Iif(empty(Barr),'',';'+allt(str(Barr)))

    ?'    <Value>' + cBar +'</Value>'

    ?'    <Value>' ;
    + padl(allt(str(kgpr)),7,'0') ;
    + '-' + padl(allt(str(gnKkl_c)),7,'0') ;
    + '</Value>' // ��� �����⥫�

    ?'    <Value>' + allt(str(gnKkl_c)) + '</Value>'   // ��� ���⠢騪�
    ?'  </row>'
    rs2->(DBSkip())
  EndDo

  ?'</ValueTable>'
  ?

  set print to
  set print off

  RETURN (NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  10-02-20 * 11:22:45pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION SendEdiDesadv()
  LOCAL cEmailList, aEmailList, i
  LOCAL cFile, cFileERase
  cEmailList := allt(getfield("t1","rs1->kpv","kln","email"))

  If !Empty(cEmailList) .and. !(str(rs1->kop,3) $ "170;139")
    aEmailList := split(cEmailList,",")
    outlog(3,__FILE__,__LINE__,"aEmailList",aEmailList)

    For i:=1 To len(aEmailList)
      outlog(3,__FILE__,__LINE__,"aEmailList i",aEmailList[i])
      cFile := SendDesadv(aEmailList[i])
      If !empty(cFile)
        cFileERase := cFile
      EndIf
    Next i

    If !empty(cFileERase)
      ERASE (cFile)
    EndIf

  else
    outlog(3,__FILE__,__LINE__,"empty Email for",rs1->kpv)
  endif
  RETURN ( NIL )



/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-26-20 * 10:34:49pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION SendDesadv(cEmailList)
  LOCAL cFile
  LOCAL cAdrrFtp, cLoginFtp, cPassWdFtp, cPortFtp, cRDir
  LOCAL nPosSobaka, nPosToPoint, nPosRDir
  local cCmd, cStdOut:=space(0), cStdErr:=space(0)
  LOCAL kkl2gln4kpv, kkl2gln4nkkl


    If Empty(cEmailList) .or. left(cEmailList, 1) = "*"
      Return nil
    EndIf

    If Left(cEmailList, 4) = "ftp:"
      nPosSobaka := AT("@", cEmailList)
      If Empty(nPosSobaka)
        outlog(3,__FILE__,__LINE__,"Empty(nPosSobaka)",cEmailList)
        Return nil
      Else
        cStr := Substr(cEmailList, 5, nPosSobaka - 5)
        nPosToPoint := AT(":", cStr)
        If Empty(nPosToPoint)
          outlog(3,__FILE__,__LINE__,"Empty(nPosToPoint) ��� ��஫�",cEmailList)
          Return nil
        else
          cLoginFtp := Left(cStr, nPosToPoint - 1)
          cPassWdFtp := Substr(cStr, nPosToPoint + 1)
        EndIf

        // ��᫥ @
        cStr := Substr(cEmailList, nPosSobaka + 1)

        // ����稥 ����
        nPosToPoint := AT(":", cStr)
        nPosRDir :=  AT("/", cStr)
        cAdrrFtp := ""
        If Empty(nPosToPoint)
          cPortFtp := "21"
        Else
          cAdrrFtp := Left(cStr, nPosToPoint - 1)
          If Empty(nPosRDir)
            cPortFtp := Substr(cStr, nPosToPoint + 1)
          Else
            cPortFtp := Substr(cStr, nPosToPoint + 1, nPosRDir - nPosToPoint - 1)
          EndIf
          If empty(val(cPortFtp))
            cPortFtp := "21"
          EndIf
        EndIf

        If Empty(nPosRDir)
          cRDir := ""
        Else
          cRDir := Substr(cStr, nPosRDir + 1)
        EndIf

        Do Case
        Case Empty(nPosToPoint) .and. Empty(nPosRDir)
          cAdrrFtp := cStr
        Case !Empty(nPosToPoint)
          cAdrrFtp := Left(cStr, nPosToPoint - 1)
        Case !Empty(nPosRDir)
          cAdrrFtp := Left(cStr, nPosRDir - 1)
        EndCase


        outlog(3,__FILE__,__LINE__,"cAdrrFtp, cPortFtp",cAdrrFtp,cPortFtp)
        outlog(3,__FILE__,__LINE__,"cLoginFtp, cPassWdFtp,  cRDir",;
         cLoginFtp, cPassWdFtp, cRDir)

        //Return nil

      EndIf
    else
      cEmailList := lower(cEmailList)

    EndIf


    kkl2gln4kpv := kkl2gln(rs1->kpv)
    kkl2gln4nkkl := kkl2gln(rs1->nkkl)

    If left(cEmailList,4) = "edin";
      .and. (len(kkl2gln4kpv) < 13 .or. len(kkl2gln4nkkl) < 13 )

      If rs1->nkkl = gnKkl_c .or. rs1->kpv = gnKkl_c
        // ᠬ� ᥡ� �� ��ࠢ�塞
        Return nil
      EndIf

      If len(kkl2gln4kpv) < 13
        outlog(3, __FILE__, __LINE__, "��� GLN rs1->kpv", rs1->kpv)
      EndIf

      If len(kkl2gln4nkkl) < 13
        outlog(3, __FILE__, __LINE__, "��� GLN rs1->nkkl", rs1->nkkl)
      EndIf

      Return nil
    EndIf

    cFile :=  EdiDesadv(rs1->dvp, rs1->ttn,;
    getfield("t1","rs1->kpv","kln","nkl"),;
    getfield("t1","rs1->nkkl","kln","nkl");
    )
    outlog(3, __FILE__, __LINE__, "cFile", cFile)

    If Left(cEmailList, 4) = "ftp:"
      outlog(3, __FILE__, __LINE__, "cFile->ftp:", cFile)

      dirchange(gcPath_l)
      cCmd := "/home/itk/copy_ftp/FtpPut.sh "
      cCmd += "";
        +" "+set("D:")+ATREPL('\',dirname(),'/')+"/"+cFile;
        +" "+cAdrrFtp;
        +" "+cPortFtp;
        +" "+cLoginFtp;
        +" "+cPassWdFtp;
        +" "+cRDir

      if (syscmd(cCmd, " ", @cStdOut, @cStdErr) !=0)

        outlog(__FILE__,__LINE__,"error cCmd:"+'"'+cCmd+'"'+",cStdOut:"+'"'+cStdOut+'"'+",+cStdEr"+'"'+cStdErr+'"')

      endif

      cEmailList := "" // "lista@bk.ru"
    else
      cEmailList += "" // ",lista@bk.ru" // ""
    endif
    outlog(3,__FILE__,__LINE__,cEmailList)
    If !Empty(cEmailList)
      cMessErr := "" //"���㧪� ����� 䠩�"

        SendingJafa(;
        cEmailList,;
        {{ cFile,;
      translate_charset(host_charset(), "utf-8", "";
      + gcName_cc ;//" ����� ";
      +" ���㧪� ";
      + cFile);
      +" "+DTOC(DATE(),"YYYYMMDD")}},;
      cMessErr,;
      228)
    EndIf

  RETURN ( cFile )


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-06-20 * 10:15:11am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION EdiDesadv(dvpr, ttnr, cNGp, cNPl)
  LOCAL cSele:=Select()
  LOCAL cFile
  LOCAL lUtf8:=.T.
  LOCAL cPRINTER_CHARSET := set("PRINTER_CHARSET")
  cNGp := allt(Translit4File(cNGp))
  cNPl := allt(Translit4File(cNPl))


  cFile :=  lower("Desadv";            //6
   + "_" + Right(DTOS(dvpr),6);     //7
   + "_" + allt(str(ttnr));         //7 __19
   + "_" + LEFT(cNGp, 10);
   + "_" + LEFT(cNPl, 10);
   + ".xml")

  If !file(cFile)
    //set("PRINTER_CHARSET","utf-8")
    set("PRINTER_CHARSET","cp1251")
    set console off
    set print on
    set print to (cFile) //temp.dat

    sele rs1
    ordsetfocus('t1')
    netseek('t1','ttnr')

    If lUtf8
      ??'<?xml version="1.0" encoding="utf-8"?>'
    Else
      ??'<?xml version="1.0" encoding="windows-1251"?>'
    EndIf

    ?'<DESADV>'
    //����� 㢥�������� �� ���㧪�
    ?'    <NUMBER>' + ntrim(rs1->ttn) + '</NUMBER>'
    ?'    <DATE>' + DTOC(rs1->DVP, 'YYYY-MM-DD') + '</DATE>'
    //��� ���⠢��
    ?'    <DELIVERYDATE>' + DTOC(rs1->DOP, 'YYYY-MM-DD') + '</DELIVERYDATE>'

    // ����� ������
    cOrderNumber:=rs1->DocGuId
    cOrderDate:=rs1->TimeCrt
    If Empty(cOrderNumber)    // ��� ���㬥��, ��६ �� ����୮��
      cOrderNumber:=getfield('t1','rs1->TtnP','rs1','DocGuId')
      cOrderDate:=getfield('t1','rs1->TtnP','rs1','TimeCrt')
    EndIf
    If Empty(cOrderNumber)    // ���㬥�� �㪠�� ���࠭
      cOrderNumber:=ntrim(rs1->ttn)
      cOrderDate:=DTOC(rs1->DVP, 'YYYY-MM-DD')
    EndIf
    ?'    <ORDERNUMBER>' + allt(cOrderNumber) + '</ORDERNUMBER>'
    ?'    <ORDERDATE>' + left(cOrderDate, 10) + '</ORDERDATE>'

    // ����� ���������
    ?'    <DELIVERYNOTENUMBER>' + ntrim(rs1->ttn) + '</DELIVERYNOTENUMBER>'
    ?'    <DELIVERYNOTEDATE>' + DTOC(rs1->DOP, 'YYYY-MM-DD') + '</DELIVERYNOTEDATE>'

    ?'    <HEAD>'
    // GLN ���⠢騪�
    ?'      <SUPPLIER>' + kkl2gln(gnKkl_c) + '</SUPPLIER>'
    //GLN ���㯠⥫�
    ?'      <BUYER>' + kkl2gln(rs1->nkkl) + '</BUYER>'
    //GLN ���� ���⠢��
    ?'      <DELIVERYPLACE>' + kkl2gln(rs1->kpv) + '</DELIVERYPLACE>'
    //GLN ��ࠢ�⥫� ᮮ�饭��
    ?'      <SENDER>' + kkl2gln(gnKkl_c) + '</SENDER>'
    //GLN �����⥫� ᮮ�饭��
    ?'      <RECIPIENT>' + kkl2gln(rs1->nkkl) + '</RECIPIENT>'

    /*
    //����� �࠭���樨
    ?'      <EDIINTERCHANGEID>'+ntrim(5650)+'</EDIINTERCHANGEID>'
    */

    ?'      <PACKINGSEQUENCE>'
    ?'        <HIERARCHICALID>'+ntrim(1)+'</HIERARCHICALID>'

    sele rs2
    ordsetfocus('t1')
    netseek('t1','ttnr')
    i := 1
    Do While ttn = ttnr
      sele rs2
      ?'        <POSITION>'
      ?'          <POSITIONNUMBER>' + ntrim(i++) + '</POSITIONNUMBER>'
      // ���媮� �clvrtத��
      Barr := getfield('t1','rs2->MnTov','ctov','Bar')
      cBar := '21'+padl(ntrim(rs2->MnTov),11,'0')
      //cBar += Iif(empty(Barr),'',';'+allt(str(Barr)))
      cBar := Iif(empty(Barr),cBar,ntrim(Barr))

      ?'          <PRODUCT>' + cBar + '</PRODUCT>'
      // ��⨪� � �� ���⠢騪�
      ?'          <PRODUCTIDSUPPLIER>'+ntrim(rs2->MnTov)+'</PRODUCTIDSUPPLIER>'

      /*
      // ��⨪� � �� ���㯠⥫�
      ?'          <PRODUCTIDBUYER>'3607340723902'</PRODUCTIDBUYER>'
      */

      // ���⠢�塞�� ������⢮
      ?'          <DELIVEREDQUANTITY>' + ntrim(rs2->kvp) + '</DELIVEREDQUANTITY>'
      //��������� �?��?���
      //?'          <ORDEREDQUANTITY>' + ntrim(rs2->kvp) + '</ORDEREDQUANTITY>'
      //?'          <DELIVEREDUNIT>'+'��.'+'</DELIVEREDUNIT>'
      ?'          <DELIVEREDUNIT>'+'PCE'+'</DELIVEREDUNIT>'
      ?'          <PRICE>'+ntrim(rs2->Zen)+'</PRICE>'
      ?'          <PRICEWITHVAT>';
                  + allt(str(rs2->Zen * (1 + gnNds / 100), 10, 3));
                  + '</PRICEWITHVAT>'
      ?'          <TAXRATE>' + ntrim(gnNds) + '</TAXRATE>'
      ?'          <DESCRIPTION>' + XmlCharTran(getfield('t1','rs2->MnTov','ctov','nat')) + '</DESCRIPTION>'
      ?'         </POSITION>'
      rs2->(DBSkip())
    EndDo

    ?'      </PACKINGSEQUENCE>'
    ?'    </HEAD>'
    ?'</DESADV>'
    ?

    set print to
    set print off
    set("PRINTER_CHARSET",cPRINTER_CHARSET)

    If lUtf8
      cLogSysCmd:=""
      SYSCMD(;
      "cp ";
      + cFile;
      +" " ;
      + "temp.dat","",@cLogSysCmd)
      //outlog(__FILE__,__LINE__,cLogSysCmd)

      SYSCMD(;
      "iconv -f CP1251 -t UTF8 ";
      +"temp.dat";
      +" -o " ;
      + cFile,"",@cLogSysCmd)
      //outlog(__FILE__,__LINE__,cLogSysCmd)
    else

    ENDIF
  EndIf

  Select (cSele)

  RETURN (cFile)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-07-20 * 11:32:07am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION kkl2gln(_kpl_kgp)
  Private kpl_kgp := _kpl_kgp
  Local cGln

  cGln:=getfield('t1','kpl_kgp','kln','ns2')
  If Empty(cGln)
    cGln := ntrim(kpl_kgp)
  EndIf

  RETURN (allt(cGln))

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-10-20 * 11:26:43am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION Translit4File(cNGp)

  CharRepl("������񦧨�����������������������������������������������������",;
  @cNGp,;
           "abvgdeejziiklmnoprstufxc4ww'y'euqABVGDEEJZIIKLMNOPRSTUFXC4WW'Y'EUQ";
  )

  CharRepl(' "/',@cNGp,"_''")
  cNGp := CharRem("'", cNGp)
  RETURN ( cNGp )

