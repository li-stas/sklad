sele tara
netseek('t1','kplr')
if !FOUND()
   save scre to scmess
   mess('��� ������ �� ��᫥�������� �� ��',3)
   rest scre from scmess
   retu
endif
tkdayr=tkday
if empty(dotr)
   save scre to scmess
   mess('���砫� �ᯥ�⠩� ���㬥��',3)
   rest scre from scmess
   retu
endif
sele rs2
set orde to tag t1
seek str(ttnr,6)+space(3)
if !FOUND()
   save scre to scmess
   mess('� �⮩ ��� ��� ���',3)
   rest scre from scmess
   retu
endif
dtsertr=dotr
netuse('tsert',,'s')
set orde to tag t2
seek str(gnSk,3)+str(ttnr,6)
if !FOUND()
   set orde to tag t1
   go bott
   tsertr=tsert+1
   netadd()
   netrepl('tsert,sk,ttn,dtsert','tsertr,gnSk,ttnr,dtsertr')
else
   tsertr=tsert
   dtsertr=dtsert
endif
sele tsert
use
sele kln
netseek('t1','kplr')
if FOUND()
   if !empty(kkl1)
      kkl1r=kkl1
   else
      kkl1r=kplr
   endif
   adrr=alltrim(adr)
   nklr=alltrim(nkl)
   setprc(0,0)
   set devi to prin
   @ 1,1 say'                                ����䨪�� N '+alltrim(str(tsertr,6))
   @ prow()+1,1 say '                �� ᤠ�� ���, ���㦥���� '+dtoc(dtsertr)
   @ prow()+1,1 say '          �� ��� N '+str(ttnr,6)+' � ���� '+nklr+' '+adrr
   @ prow()+1,1 say  ''
   @ prow()+1,1 say '������������������������������������������������������������������������������Ŀ'
   @ prow()+1,1 say '�       ������������           �   ����   �������⢮���.���   �㬬�  �  ���  �'
   @ prow()+1,1 say '�          ���                �          �          �     �          ������⠳'
   @ prow()+1,1 say '������������������������������������������������������������������������������Ĵ'
   sele rs2
   netseek('t1','ttnr')
   do while ttn=ttnr
      if int(ktl/1000000)#0
         skip
         loop
      endif
      ktlr=ktl
      kvpr=kvp
      zenr=zen
      svpr=svp
      sele tov
      netseek('t1','sklr,ktlr')
      if FOUND()
         dvozr=dtsertr+tkdayr
         @ prow()+1,1 say '�'+nat+'�'+str(zenr,10,3)+'�'+str(kvpr,10,3)+'�'+nei+'�'+str(svpr,10,2)+'�'+dtoc(dvozr)+'�'
      endif
      sele rs2
      skip
   enddo
   @ prow()+1,1 say '��������������������������������������������������������������������������������'
   @ prow()+1,1 say ''
   @ prow()+1,1 say '   ��� �������� ������� '+alltrim(gcName_c)+' ,��室�饬��� �� ����� '
   @ prow()+1,1 say alltrim(gcAdr_c)+' ,� �祭�� '+alltrim(str(tkdayr,3))+' ���� � ������ '
   @ prow()+1,1 say '����祭�� ⮢��.'
   @ prow()+1,1 say '   �� ������ ������ ��� �� 15 ����,"����������" 㯫�稢��� "��������������"'
   @ prow()+1,1 say ' ���� � ࠧ��� 150 ��業⮢ �⮨���� �� �����饭��� � �ப ���,'
   @ prow()+1,1 say '� ��� 15 ���� - 300 ��業⮢.'
   @ prow()+1,1 say '   �� ������ ��� � �������� � ���㧮�묨 ���㬥�⠬� ��易⥫쭮 '
   @ prow()+1,1 say '�।�⠢����� �����饣� ���䨪��.� ��⨢��� ��砥, ����� ��'
   @ prow()+1,1 say '�������饭��� ��� �ந�������� �� 業��, �������騬 �� ������ ��ࠧ������'
   @ prow()+1,1 say '��ࢮ��砫쭮� ������������ ������� "����������".'
   @ prow()+1,1 say ''
   @ prow()+1,1 say ''
   @ prow()+1,1 say '                                                      -------------------------- '
   @ prow()+1,1 say '                                                               �������'
   set devi to scre
endif

