#include "common.ch"
#include "inkey.ch"
*LPOS
para p1
PRIVATE dtlmr
if !empty(p1)
   dtr=p1   // ��砫쭠� ���
else
   dtr=date()
endif
clea

if gnArm#0
   scdt_r=setcolor('gr+/b,n/w')
   wdt_r=wopen(8,20,13,60)
   wbox(1)
   @ 0,1 say '���     ' get dtr
   read
   wclose(wdt_r)
   setcolor(scdt_r)
   if lastkey()=K_ESC
      retu
   endif
endif

netuse('cskl')
netuse('ctov')
set prin to lposd.txt
set prin on
  pathr=gcPath_ew+'arnd\'

  dtlmr:=dtos(date())+' '+subs(time(),1,5)

  sele 0
  use (pathr+'localpos') excl
  zap
  inde on localcode tag t1

  sele 0
  use (pathr+'lposarch') excl
  zap
  inde on ol_code+localcode tag t1
  inde on wareh_code+localcode tag t2

  sele 0
  use (pathr+'lpossinh') excl
  zap
  inde on lposin_no tag t1

  sele 0
  use (pathr+'lpossind') excl
  zap
  inde on lposin_no+localcode tag t1

  sele 0
  use (pathr+'lpostrsh') excl
  zap
  inde on lposth_no tag t1

  sele 0
  use (pathr+'lpostrsd') excl
  zap
  inde on lposth_no+localcode tag t1

  lposostd()
  lpos2d()
  lpos3d()
  lposprd()
*wait
  lpossvd()
***********************************
func lposostd()
* ���⪨
  ***********************************
  sele cskl
  do while !eof()
     if !(ent=gnEnt.and.arnd=2)
        skip
        loop
     endif
     skr=sk
     pathr=gcPath_d+alltrim(path)
     mess(pathr)
     netuse('tov',,,1)
     do while !eof()
*        if osf#1
*           skip
*           loop
*        endif
        ktlr=ktl
        mntovr=mntov
        localcoder=alltrim(str(ktlr,9))

*        invent_nor=alltrim(znom)
*        serial_nor=alltrim(zn)
*        namer=getfield('t1','mntovr','ctov','nat')
        sele ctov
        netseek('t1','mntovr')
        namer=nat
        post_idr=posid
        posb_idr=posbrn
        invent_nor=alltrim(znom)
        serial_nor=alltrim(zn)
        sele localpos
        seek localcoder
        if !foun()
           dtlmr:=dtos(date())+' '+subs(time(),1,5)
           netadd()
           netrepl('localcode,invent_no,serial_no,name,dtlm,post_id,posb_id',;
           'localcoder,invent_nor,serial_nor,namer,dtlmr,post_idr,posb_idr')
        endif
        wareh_coder=padr(str(skr,3),20)
        sele lposarch
        set orde to tag t2
        seek wareh_coder+localcoder
        if !foun()
           dtlmr:=dtos(date())+' '+subs(time(),1,5)
           netadd()
           netrepl('wareh_code,localcode,stockdate,dtlm',;
                   'wareh_coder,localcoder,date(),dtlmr')
        endif
        sele tov
        skip
     endd
     nuse('tov')
     sele cskl
     skip
  endd

  sele cskl
  locate for ent=gnEnt.and.arnd=3
  skr=sk
  pathr=gcPath_d+alltrim(path)
  mess(pathr)
  netuse('tov',,,1)
  do while !eof()
*     if osf#1
*        skip
*        loop
*     endif
     sklr=skl
     ol_coder=padr(alltrim(str(sklr,7)),25)
     ktlr=ktl
     mntovr=mntov
     optr=opt
     localcoder=padr(alltrim(str(ktlr,9)),20)
     sele ctov
     netseek('t1','mntovr')
     namer=nat
     post_idr=posid
     posb_idr=posbrn
     invent_nor=alltrim(znom)
     serial_nor=alltrim(zn)

     sele localpos
     seek localcoder
     if !foun()
        dtlmr:=dtos(date())+' '+subs(time(),1,5)
        date45r=ctod('09.05.1945')
        netadd()
        netrepl('localcode,invent_no,serial_no,name,price,dtlm,post_id,posb_id,date',;
        'localcoder,invent_nor,serial_nor,namer,optr,dtlmr,post_idr,posb_idr,date45r')
     endif

     sele lposarch
     set orde to tag t1
     seek ol_coder+localcoder
     if !foun()
        dtlmr:=dtos(date())+' '+subs(time(),1,5)
        netadd()
        netrepl('ol_code,localcode,stockdate,dtlm',;
                'ol_coder,localcoder,date(),dtlmr')
     endif
     sele tov
     skip
  endd
  nuse('tov')
  retu.t.
********************************
func lposprd()
* ��室�,��室�
  *********************************
  sele cskl
  go top
  do while !eof()
     if !(ent=gnEnt.and.arnd=2)
        skip
        loop
     endif
     skr=sk
     dir_rr=alltrim(path)

     for yyr=year(date()) to year(dtr) step -1
         pathgr=gcPath_e+'g'+str(yyr,4)+'\'
         do case
            case year(date())=year(dtr)
                 mm1r=month(date())
                 mm2r=month(dtr)
            case yyr=year(date())
                 mm1r=month(date())
                 mm2r=1
            case yyr=year(dtr)
                 mm1r=12
                 mm2r=month(dtr)
            othe
                 mm1r=12
                 mm2r=1
         endc
         for mmr=mm1r to mm2r step -1
             pathmr=pathgr+'m'+iif(mmr<10,'0'+str(mmr,1),str(mmr,2))+'\'
             pathr=pathmr+dir_rr
             if !netfile('tov',1)
                loop
             endif

             mess(pathr)
             netuse('pr1',,,1)
             netuse('pr2',,,1)
             netuse('rs1',,,1)
             netuse('rs2',,,1)
             netuse('tov',,,1)

             sele pr1 // 101,188,183
             do while !eof()
                if prz=0
                   skip
                   loop
                endif
                if !(kop=101.or.kop=188.or.kop=183)
                   skip
                   loop
                endif
                if dpr<dtr
                   skip
                   loop
                endif
                sklr=skl
                kopr=kop
                mnr=mn
                sklsr=skls
                dprr=dpr
                lposin_nor=padr(alltrim(str(mnr,6))+' '+str(skr,3)+' 1',50)
                lposth_nor=lposin_nor
                if kopr=101
                   if dprr>=ctod('26.12.2012')
                      contr_nor='18005'
                      contr_sdr=ctod('26.12.2012')
                      contr_edr=ctod('31.12.'+str(year(dprr),4))
                   else
                      contr_sdr=dnz
                      if !empty(contr_sdr)
                         contr_edr=ctod('31.12.'+str(year(dprr),4))
                      else
                         contr_edr=ctod('')
                      endif
                      contr_nor=nnz
                   endif
                else
*                   lposin_nor=''
*                   lposth_nor=''
                   contr_nor=''
                   contr_sdr=ctod('')
                   contr_edr=ctod('')
                endif
                ol_coder=padr(alltrim(str(sklsr,7)),25)
                wareh_coder=padr(str(skr,3),20)
*                contr_nor=padr(alltrim(str(mnr,6)+' '+str(skr,3)+' 1'),50)
                if kopr=101.or.kopr=188
                   sele lpossinh
                   seek lposin_nor
                   if !foun()
                      dtlmr:=dtos(date())+' '+subs(time(),1,5)
                      netadd()
                      netrepl('lposin_no,date,totalsum,wareh_code,dtlm,status','lposin_nor,pr1->dpr,pr1->sdv,wareh_coder,dtlmr,2')
                      do case
                         case kopr=101
                              doc_typer=11
                         case kopr=188
                              doc_typer=15
                      endc
                      netrepl('doc_type','doc_typer')
                   endif
                endif
                if kopr=183
                   sele lpostrsh
                   seek lposth_nor
                   if !foun()
                      netadd()
                      doc_typer=17
                      dtlmr:=dtos(date())+' '+subs(time(),1,5)
                      netrepl('lposth_no,date,totalsum,doc_type,ol_code,wareh_code,dtlm,status',;
                              'lposth_nor,pr1->dpr,pr1->sdv,doc_typer,ol_coder,wareh_coder,dtlmr,2')
                   endif
                endif
                sele pr2
                if netseek('t1','mnr')
                   do while mn=mnr
                      mntovr=mntov
                      ktlr=ktl
                      pricer=zen
                      localcoder=padr(alltrim(str(ktlr,9)),20)
                      if kopr=101
                         sele localpos
                         seek localcoder
                         if !foun()
*                            ?str(yyr,4)+' '+str(mmr,2)+' '+str(skr,3)+' p '+str(mnr,6)+' '+str(ktlr,9)
                            sele tov
                            if netseek('t1','sklr,ktlr')
                               mntovr=mntov
                               sele ctov
                               netseek('t1','mntovr')
                               namer=nat
                               post_idr=posid
                               posb_idr=posbrn
                               invent_nor=alltrim(znom)
                               serial_nor=alltrim(zn)
                               sele localpos
                               dtlmr:=dtos(date())+' '+subs(time(),1,5)
                               netadd()
                               netrepl('localcode,invent_no,serial_no,name,dtlm,post_id,posb_id',;
                               'localcoder,invent_nor,serial_nor,namer,dtlmr,post_idr,posb_idr')
                               if kopr=101
                                  repl contr_no with contr_nor,;
                                       contr_sd with contr_sdr,;
                                       contr_ed with contr_edr,;
                                       date with dprr
                               endif
                            endif
                         endif
                      endif
                      if kopr=101.or.kopr=188
                         sele lpossind
                         seek lposin_nor+localcoder
                         if !foun()
                            netadd()
                            netrepl('lposin_no,localcode,price','lposin_nor,localcoder,pricer')
                         endif
                      endif
                      if kopr=183
                         sele lpostrsd
                         seek lposth_nor+localcoder
                         if !foun()
                            netadd()
                            netrepl('lposth_no,localcode,price','lposth_nor,localcoder,pricer')
                         endif
                      endif
                      sele pr2
                      skip
                   endd
                endif
                sele pr1
                skip
             endd

             sele rs1
             do while !eof()
                if !(kop=154.or.kop=188.or.kop=193)
                   skip
                   loop
                endif
                if prz=0
                   skip
                   loop
                endif
                if dot<dtr
                   skip
                   loop
                endif
                kopr=kop
                skltr=sklt
                sklr=skl
                ttnr=ttn
                sklr=skl
                lposin_nor=padr(alltrim(str(ttnr,6))+' '+str(skr,3)+' 0',50)
                lposth_nor=lposin_nor
                ol_coder=padr(alltrim(str(skltr,7)),25)
                wareh_coder=padr(str(skr,3),20)
                if kopr=154.or.kopr=188
                   sele lpossinh
                   seek lposin_nor
                   if !foun()
                      netadd()
                      do case
                         case kopr=154
                              doc_typer=12
                         case kopr=188
                              doc_typer=14
                      endc
                      dtlmr:=dtos(date())+' '+subs(time(),1,5)
                      netrepl('lposin_no,date,totalsum,doc_type,dtlm,status','lposin_nor,rs1->dot,rs1->sdv,doc_typer,dtlmr,2')
                      netrepl('wareh_code','wareh_coder')
                   endif
                endif
                if kopr=193
                   sele lpostrsh
                   seek lposth_nor
                   if !foun()
                      netadd()
                      doc_typer=16
                      dtlmr:=dtos(date())+' '+subs(time(),1,5)
                      netrepl('lposth_no,date,totalsum,doc_type,ol_code,dtlm,status','lposth_nor,rs1->dot,rs1->sdv,doc_typer,ol_coder,dtlmr,2')
                      netrepl('wareh_code','wareh_coder')
                   endif
                endif
                sele rs2
                if netseek('t1','ttnr')
                   do while ttn=ttnr
                      mntovr=mntov
                      ktlr=ktl
                      pricer=zen
                      localcoder=padr(alltrim(str(ktlr,9)),20)
                      sele localpos
                      seek localcoder
                      if !foun()
/*
*                         ?str(yyr,4)+' '+str(mmr,2)+' '+str(skr,3)+' r '+str(ttnr,6)+' '+str(ktlr,9)
*                         sele tov
*                         if netseek('t1','sklr,ktlr')
*                            mntovr=mntov
*                            invent_nor=alltrim(znom)
*                            serial_nor=alltrim(zn)
*                            namer=getfield('t1','mntovr','ctov','nat')
*                            sele localpos
*                            dtlmr:=dtos(date())+' '+subs(time(),1,5)
*                            date45r=ctod('09.05.1945')
*                            netadd()
*                            netrepl('localcode,invent_no,serial_no,name,dtlm','localcoder,invent_nor,serial_nor,namer,dtlmr')
*                            repl contr_no with contr_nor,;
*                                 contr_sd with pr1->dpr,;
*                                 contr_ed with pr1->dpr+255,;
*                                 date with date45r
*                         endif
*/
                      endif
                      if kopr=193
                         sele lpostrsd
                         seek lposth_nor+localcoder
                         if !foun()
                            netadd()
                            netrepl('lposth_no,localcode,price,tscon_no,tsconsd,tsconed','lposth_nor,localcoder,pricer,lposth_nor,rs1->dot,rs1->dot+255')
                         endif
                      endif
                      if kopr=154.or.kopr=188
                         sele lpossind
                         seek lposin_nor+localcoder
                         if !foun()
                            netadd()
                            //netrepl('lposin_no,localcode,price,wareh_code','lposin_nor,localcoder,pricer,wareh_coder')
                            netrepl('lposin_no,localcode,price','lposin_nor,localcoder,pricer')
                         endif
                      endif
                      sele rs2
                      skip
                   endd
                endif
                sele rs1
                skip
             endd

             nuse('pr1')
             nuse('pr2')
             nuse('rs1')
             nuse('rs2')
             nuse('tov')
         next
     next
     sele cskl
     skip
  endd
  retu .t.
*******************************
func lpossvd()
* ��室-���室 ���
  *******************************
  mess('��裡')
  sele lpostrsd
  kolar=recc()
  coun to koler for empty(tscon_no)
  kolir=0
  if gnArm#0
     @ 0,1 say kolar
     @ 1,1 say koler
  endif
  go top
  do while !eof()
     if !empty(tscon_no)
        skip
        loop
     endif
     lposth_nor=lposth_no // ����� ���㬥��
     localcoder=localcode
     sele lpostrsh
     seek lposth_nor
     if foun()
        ol_coder=ol_code
        wareh_coder=wareh_code
        sele lposarch
        set orde to tag t1
        seek ol_coder+localcoder
        if foun()
           tscon_nor=tsidnum
           tsconsdr=tsidsdat
           tsconedr=tsidedat
           sele lpostrsd
           repl tscon_no with tscon_nor,;
                tsconsd with tsconsdr,;
                tsconed with tsconedr
        endif
     endif
     sele lpostrsd
     skip
  endd
  retu .t.

  sele localpos
  use
  sele lposarch
  use
  sele lpossind
  use
  sele lpossinh
  use
  sele lpostrsd
  use
  sele lpostrsh
  use
  nuse()
set prin to
set prin off
