#include "common.ch"
#include "inkey.ch"
para p1
*************  ����� ��� ***************
local sel
sel=select()
kplr=p1
kk=1
kkr=1
vlpt1='lpt1'
vpt=2
@ 24,0 clea

ccp=1
do while .t.
   @ 24,5  prompt' �������� '
   @ 24,25 prompt'  ������  '
   @ 24,35 prompt'�����'
   menu to ccp
   if lastkey()=K_ESC
      set devi to scre
      exit
   endif
   @ 24,0 clea
   set devi to scre
   @ 24,11 say '����� �������� ������'
   If ccp = 1
      Set Prin To txt.TXT
   else
      if ccp=2
         set prin to
*      if gnOut=1
         if gnSpech=1
            alpt0={'��','���'}
            vpt=alert('������� �������',alpt0)
         endif
         if vpt=2 // �����쭠� �����
            set prin to lpt1
            kk=1
         endif    // ��⥢�� �����
         if vpt=1
            @ 24,0 say '������ �� ������� �������        '
            vlpt1='lpt2'
            alpt={'lpt2','lpt3'}
            vlpt=alert('������ �� ������� �������',alpt)
            if vlpt=1
               vlpt1='lpt2'
            else
               vlpt1='lpt3'
            endif
            kk=1
            kkr=1 // ���稪 ������஢
            @ 24,36 say '������⢮  �.'
            @ 24,52 get kk pict '9' valid kk<4
            read
            set prin to &vlpt1
         endif
*      else
*         Set Prin To txt.TXT
*      endif
       endif
   EndIF
   set prin on
   set cons off
   if vpt=2.and.ccp=2 // �����쭠� �����
      if empty(gcPrn)
         ??chr(27)+chr(80)+chr(15)
      else
         ??chr(27)+'E'+chr(27)+'&l4h2a0O'+chr(27)+'&k2S'+chr(27)+'&a20l'+chr(27)+'(3R'+chr(27)+'(s0p17.00h0s1b4102T'+chr(27)
      endif
   endif
   if vpt=1.and.ccp=2
      ??chr(27)+'E'+chr(27)+'&l4h2a0O'+chr(27)+'&k2S'+chr(27)+'&a20l'+chr(27)+'(3R'+chr(27)+'(s0p17.00h0s1b4102T'+chr(27)
   endif
   do while kkr<=kk
      if vpt=2
         prntar()
         exit
      else
         prntar()
      endif
      kkr=kkr+1
   enddo
set print off
set print to
set cons on
if ccp=3
   edfile('txt.txt')
endif

@ 24,0 clea
sele(sel)
exit
enddo
return


proc prntar  // �����

lstr=1
rswr=1
if vpt=2  // �����쭠� �����
   set devi to scre
   save scre to scmess
   mess(notr+' ��⠢� ���� � ������ �஡��',0)
   rest scre from scmess
endi
vtarsh()
if autor#0
   if skar#0
      netuse('cskl')
      if netseek('t1','skar')
         gcPath_tt=gcPath_d+alltrim(path)
         if !file(gcPath_tt+'tprds01.dbf')
            wmess('��� ��� ��� ��⮬���᪮�� ��室�',3)
            select(sel)
*            nuse('cskl')
            return
         endif
      else
         wmess('�� ������ ���� � CSKL',3)
         select(sel)
*         nuse('cskl')
         return
      endif
   else
      wmess('��� ���� ��� ��⮬���᪮�� ��室� � OPER',3)
      select(sel)
*      nuse('cskl')
      return
   endif
endif
pathr=gcPath_tt
netuse('tov','tovt',,1)
set orde to tag t5
netseek('t5','kplr')
skltr=kplr
ssvprt=0
ssvprst=0
Do While skl=skltr
   rcnr=recn()
   ktlr=ktl
   natr=nat
   osfr=osf
   osfmr=osfm
   optr=opt
   kgr=kg
   svpr=round(osfr*optr,2)
   ?' '+ substr(natr,1,30)+' '+str(osfr,10,3)+' '+str(optr,10,3)+' '+str(svpr,15,2)+' '+dtoc(dpp)
   rslet1()
   if kgr=0
      ssvprt=ssvprt+svpr
   else
      ssvprst=ssvprst+svpr
   endif
   sele tovt
   skip
enddo
*nuse('cskl')
nuse('tovt')
rslet1()
?''
?space(30)+'����������������������������������������'

?space(30)+'�⮣� �� �⥪���� '+space(5)+alltrim(str(ssvprst,15,2)) //+' ��.'
rslet1()
?space(30)+'�⮣� �� ��       '+space(5)+alltrim(str(ssvprt,15,2)) //+' ��.'
?''
?'  �����⭠� �� ������ ���� �����饭� �� ᪫�� ���⠢騪�'
?'  � �祭��  5  ������᪨�  ����  �  ���  ����祭�� ⮢��.'
?'  �  ��砥  ��������   �  �ப  ���  ������������� ��।'
?'  ���⠢騪��  �����  ���������  �� �㬬�  ���, ���᫥�����'
?'  �� ��������� �⮨����� ���.'
?''
?''
return

proc vtarsh
?'                        ��������� �� �����⭮� ��'
rslet1()
?''
?'���⠢騪 : '+alltrim(gcName_c)+'  ��� '+str(gnKln_c,8)
rslet1()
?'�����⥫� : '+ alltrim(nkplr)+'  ��� '+str(kplr,7)
rslet1()
?'���   '+dtoc(gdTd)
rslet1()
?'�����������������������������������������������������������������������������Ŀ'
?'�       ������������           �������⢮�  ����    �    �㬬�      � ���   �'
?'�          ���                �          �          �               �        �'
?'�������������������������������������������������������������������������������'
retu

proc rslet1
rswr++
if rswr>=43
   rswr=1
   lstr++
   eject
     if vpt<>1
      set devi to scre
      save scre to scmess
      mess('��⠢� ���� � ������ �஡��',0)
      rest scre from scmess
      vtarsh()
     endif
endif
retu

