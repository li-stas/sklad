#include "common.ch"
#include "inkey.ch"
para prznk,ktll,ktlpl
local slr
slr=select()

*  ���祭�� �ਧ���� prznk ��� ����� � ��⮪�� RSO
*  1 - �������� �믨ᠭ���� ���㬥��
*  2 - �������� ���㦥����� ���㬥��
*  3 - ���⨥ �ਧ���� ���⢥ত������ ���㬥��
*  4 - ���४�� ⮢�୮� ��� ���㬥��
*  5 - �������� ����樨 �� �믨ᠭ���� ���㬥��
*  6 - ����� � ⮢�୮� �⤥��
*  7 - ���㧪� � ᪫���
*  8 - ���⢥ত���� ᪫����
*  9 - �������� ������ ���㬥��
* 10 - ���४�� 蠯��
* 11 - ��⥢�� �����
* 12 - ���⠭�������
* 14 - ���४�� ����樨 ���-�� �� "0"  ������� �� 5!!!
* 15 - ���⨥ ���㧪�
* 16 - ��⠭���� ���㧪�
* 17 - ����� �ࠩ� (kopi)
* 18 - ���� ������
* 19 - ��� � ��� � ddc#date()
* 20 - ��� ���� ���
* 21 - ������ 業 �� F2
* 22 - ���⨥ ��
* 23 - ��� ��
* 24 - ��� ��
* 25 - ���� RS3

if prznk # PrNppr
   sele cskl
   netseek('t1','gnSk')
   reclock()
   Nppr=rsoNpp
   if Nppr=999999
      Nppr=1
      netrepl('rsoNpp','2')
   else
      netrepl('rsoNpp','rsoNpp+1')
   endif

   netuse('rso1')
   arec:={}
   sele rs1
   getrec()
   sele rso1
   netadd()
   putrec()
   netrepl('Npp,dNpp,tNpp,KtoNpp,PrNpp','Nppr,date(),time(),gnKto,prznk')
   PrNppr=prznk
   if fieldpos('docip')#0
      if !empty(gcNnetname)
          netrepl('docip','gcNnetname')
      else
          netrepl('docip','unamer')
      endif
   endif
endif
netuse('rso2')


do case
*   case prznk=1 // �������� �믨ᠭ���� ���㬥��
   case prznk=2.or.prznk=1.or.prznk=21   // �������� ���㦥����� ���㬥�� ��� �������� �믨ᠭ���� ���㬥�� ��� F2
        sele rs2
        if netseek('t1','ttnr')
           do while ttn=ttnr
              arec:={}
              getrec()
              sele rso2
              netadd()
              reclock()
              putrec()
              netrepl('Npp','Nppr')
              sele rs2
              skip
           enddo
        endif
   case prznk=3 // ���⨥ �ਧ���� ���⢥ত������ ���㬥��
   case prznk=4.or.prznk=19 // ���४�� ⮢�୮� ��� ���㬥��
        sele rs2
        if !(ttn=ttnr.and.ktl=ktll.and.iif(ktlpl#nil,ktlp=ktlpl,.t.))
           if ktlpl=nil
              netseek('t1','ttnr,ktll,ktlpl')
           else
              netseek('t1','ttnr,ktll')
           endif
        endif
        reclock()
        arec:={}
        getrec()
        sele rso2
        netadd()
        reclock()
        putrec()
        netrepl('Npp','Nppr')
   case prznk=5 // �������� ����樨 �� �믨ᠭ���� ���㬥��
        sele rs2
        if !(ttn=ttnr.and.ktl=ktll.and.iif(ktlpl#nil,ktlp=ktlpl,.t.))
           if ktlpl=nil
              netseek('t1','ttnr,ktll,ktlpl')
           else
              netseek('t1','ttnr,ktll')
           endif
        endif
        arec:={}
        getrec()
        sele rso2
        netadd()
        reclock()
        putrec()
        netrepl('Npp','Nppr')
   case prznk=6 // ����� � ⮢�୮� �⤥��
   case prznk=7 // ���㧪� � ᪫���
   case prznk=8 // ���⢥ত���� ᪫����
   case prznk=9 // �������� ������ ���㬥��
   case prznk=10 // ���४�� 蠯��
   case prznk=11 // ��⥢�� �����
   case prznk=12 // ����⠭�������
   case prznk=15 // ���⨥ ���㧪�
   case prznk=16 // ��⠭���� ���㧪�
   case prznk=17 // ����� �ࠩ�(kopi)
   case prznk=14.or.prznk=18 // ���४�� �� "0" , ���� ������
        sele rs2
        if !(ttn=ttnr.and.ktl=ktll.and.iif(ktlpl#nil,ktlp=ktlpl,.t.))
           if ktlpl=nil
              netseek('t1','ttnr,ktll,ktlpl')
           else
              netseek('t1','ttnr,ktll')
           endif
        endif
        reclock()
        arec:={}
        getrec()
        sele rso2
        netadd()
        reclock()
        putrec()
        netrepl('Npp','Nppr')

endc

nuse('rso1')
nuse('rso2')
sele (slr)

***************
func ttnlist()
***************
sele rs1
rcttnr=recn()

dir_r=gcPath_ew+'ttnlist'
if dirchange(dir_r)#0
   dirmake(dir_r)
endif
dirchange(gcPath_l)
path_tlr=dir_r+'\'

dir_r=path_tlr+'g'+str(year(gdTd),4)
if dirchange(dir_r)#0
   dirmake(dir_r)
endif
dirchange(gcPath_l)
path_tlgr=dir_r+'\'

dir_r=path_tlgr+'m'+iif(month(gdTd)<10,'0'+str(month(gdTd),1),str(month(gdTd),2))
if dirchange(dir_r)#0
   dirmake(dir_r)
endif
dirchange(gcPath_l)
path_tlmr=dir_r+'\'

dir_r=path_tlmr+subs(gcDir_t,1,len(gcDir_t)-1)
if dirchange(dir_r)#0
   dirmake(dir_r)
endif
dirchange(gcPath_l)
path_tlsr=dir_r+'\'

dir_r=path_tlsr+'t'+alltrim(str(ttnr,6))
if dirchange(dir_r)#0
   dirmake(dir_r)
endif
dirchange(gcPath_l)
path_tltr=dir_r+'\'

pathr=path_tltr

if !netfile('rs1',1)
   copy file (gcPath_a+'rs1.dbf') to (pathr+'trsho14.dbf')
   copy file (gcPath_a+'rs2.dbf') to (pathr+'trsho15.dbf')
   lindx('trsho14','rs1',1)
   lindx('trsho15','rs2',1)
endif
if select('ttnlist')#0
   sele ttnlist
   use
endif

if !file(pathr+'ttnlist.dbf')
   crtt(pathr+'ttnlist','f:ttn c:n(6) f:sm c:n(12,2)')
endif

sele 0
use (pathr+'ttnlist')
sum sm to sm_rr
@ 23,68 say str(sm_rr,12,2)
netuse('rs1','rs1list',,1)
netuse('rs2','rs2list',,1)

rcttnlistr=recn()
store 0 to ttn_rr
save scre to scttnlist
sele ttnlist
go top
rcttnlistr=recn()
do while .t.
   foot('INS,DEL,ENTER,ESC','��������,�������,����㧨��,�⬥��')
   sele ttnlist
   rcttnlistr=slcf('ttnlist',,,,,"e:ttn h:'TTN' c:n(6) e:getfield('t1','ttnlist->ttn','rs1','dop') h:'���' c:d(10) e:getfield('t1','ttnlist->ttn','rs1','kop') h:'���' c:n(3) e:getfield('t1','ttnlist->ttn','rs1','sdv') h:'�㬬�'  c:n(12,2) e:sm h:'�㬬��' c:n(12,2)",,,1,,,,'��� ��� ����㧪�')
   sele ttnlist
   go rcttnlistr
   ttn_rr=ttn
   if lastkey()=K_ESC
      exit
   endif
   do case
      case lastkey()=K_ENTER
            ttnlista()
            exit
      case lastkey()=K_DEL // DEL
           sele rs1list
           if netseek('t1','ttn_rr')
              wmess('����㦥�')
              loop
           else
              sele ttnlist
              sm_rr=sm_rr-sm
              @ 23,68 say str(sm_rr,12,2)
              dele
              skip -1
              if bof()
                 go top
              endif
              rcttnlistr=recn()
           endif
      case lastkey()=K_INS // ins
           ttnlisti()
           @ 23,68 say str(sm_rr,12,2)
   endc
endd
rest scre from scttnlist
sele ttnlist
use
nuse('rs1list')
nuse('rs2list')
sele rs1
go rcttnr
reclock()
netrepl('ttnt','999999',1)
retu .t.

****************
func ttnlista()
****************
sele ttnlist
go top
do while !eof()
   ttn_r=ttn
   sele rs1
   if netseek('t1','ttn_r')
      reclock()
      sele rs2
      if netseek('t1','ttn_r')
         sele rs1
         arec:={}
         getrec()
         sele rs1list
         netadd()
         putrec()
         sele rs1
         netrepl('ttnt','ttnr',1)
         sele rs2
         do while ttn=ttn_r
            rclistr=recn()
            ktlr=ktl
            kvpr=kvp
            arec:={}
            getrec()
            sele rs2list
            netadd()
            putrec()
            sele rs2
            if !netseek('t1','ttnr,ktlr')
                netadd()
                putrec()
                netrepl('ttn','ttnr')
            else
                netrepl('kvp','kvp+kvpr')
            endif
            svpr=roun(kvpr*zen,2)
            netrepl('svp','svpr')
            sele rs2
            go rclistr
            netdel()
            skip
         endd
         sele rs1
         netrepl('sdv','0')
      endif
   endif
   sele ttnlist
   skip
endd
retu .t.

***************
func ttnlisti()
***************
cldclrins=setcolor('gr+/b,n/w')
wdclrins=wopen(12,25,15,45)
wbox(1)
do while .t.
   ttn_rr=0
   @ 0,1 say '���' get ttn_rr pict '999999'
   read
   if lastkey()=K_ESC
      exit
   endif
   if lastkey()=K_ESC
      exit
   endif
   if lastkey()=K_ENTER
      sele rs1
      if netseek('t1','ttn_rr')
         smr=sdv
         if prz=0.and.!empty(dop)
            sele rs2
            if netseek('t1','ttn_rr')
               sele ttnlist
               locate for ttn=ttn_rr
               if !foun()
                  appe blank
                  repl ttn with ttn_rr,;
                       sm with smr
                  sm_rr=sm_rr+smr
                  exit
               endif
            else
               wmess('��� ⮢��',2)
               loop
            endif
         else
            do case
               case prz=1
                    wmess('���⢥ত��',2)
                    loop
               case empty(dop)
                    wmess('�� ���㦥�',2)
            endc
         endif
      else
         wmess('�� ������',2)
         loop
      endif
   endif
enddo
wclose()
setcolor(cldclrins)
retu .t.
