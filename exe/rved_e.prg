#include "common.ch"
#include "inkey.ch"
******************************************************************************
*��楤�� RVED_E - ����� ��室� �p��p��� ���� ������p�                                              *
******************************************************************************
set devi to scre
set colo to g/n,n/g
clea
stor 0 to tov2,ski2,nac2,tar2,trn2,sd2
stor ' ' to dtr
ns=71
@ 2,45 say '��� ��室� �த�樨'
@ 3,53 say dtoc(gdTd)
@ 1,32,4,79 box frame
menu10=1
@ 23,0 say '     ����, ���� �����⮢�� ���ଠ樨'
*** ��p�⨥ �⮣�� �� p��室� ***********************************************
netuse('rs3')
*** ��p�⨥ �p���筨�� ������p�� *******************************************
netuse('speng')
*** ��p�⨥ p��室� *********************************************************
netuse('rs1')
index on str(skl,4)+str(kto,2)+str(kpl,7) to trsho_r   //fill
set index to trsho_r
go top
*** ��p�⨥ �p���筨�� �p���p��⨩ *****************************************
netuse('kln',,'s')
DO WHILE .T.
*** �p��*********************************************************************
   @ 6,0 clea
   @ 23,15 say '�������� �롮� - . �롮� - ��. ��室 - ESC.'
   @ 5,6 say '����� ������:'
   @ 6,6 prompt '1. ��������� ��室� � ᪫��� �� ����                              '
   @ 7,6 prompt '2. ��������� ��室� � ᪫��� � ��砫� �����                      '
   @ 8,6 prompt '3. ����� �⮣�� �� ��室� �த�樨 � ᪫��� � ��砫� �����     '
   @ 9,6 prompt '4. ��室 � �।��饥 ����                                          '
   menu to menu10
*** p���� p����� *************************************************************
   do case
     case menu10=0.or.menu10=4
          exit
     case menu10=1
          dtr1="��������� ������� ��������� �� "  //+dtoc(doth)
     case menu10=2
          dtr1="��������� ������� ��������� � ������ ������ "
     case menu10=3
          dtr1="��������� ������� ��������� (�����) "
   endcase
*** ��� ���� **************************************************************
   doth=ctod('')
   @ 12,25 say '���     ��室�: '
   @ 23,0 say '    ������ ���� ��室� � �ଠ� ��.��.�� � ������ ������� "��" (ENTER) '
   otv=0
   do while otv=0
      @ 12,43 get doth pict '99.99.99'
      read
      if doth<>ctod(' ').or.lastkey()=K_ESC
         @ 23,0 clea
         exit
      endif
   enddo
   if lastkey()=K_ESC
      loop
   endif
*** ����p ᪫��� *************************************************************
   @ 14,25 say 'H���p ᪫���:'
   @ 23,0 say '    ������ ����p ᪫��� � ������ ������� "��" (ENTER)                    '
   store 0 to sklr,sklr1
   do while sklr=0
      @ 14,39 get sklr pict '9999'
      read
      if sklr>0.or.lastkey()=K_ESC
         @ 23,0 clea
         exit
      endif
   enddo
   if lastkey()=K_ESC
      loop
   endif
*** ��� ��� ****************************************************************
*   set colo to w/b,n/w
   @ 23,30 say '�������� �롮� - . �롮� - ��'
   @ 15,25 say '��� ���  : '
   c1=' ����� ���           '
   c2=' �����ᨮ���� �࣮���  '
   c3=' �⢥��⢥���� �࠭���� '
   @ 16,25 prompt c1
   @ 17,25 prompt c2
   @ 18,25 prompt c3
   menu to menu11
   @ 22,0 clea
   SELE rs1
   @ 23,0 clear
   set devi to print
   store 0 to nl,Npp
   lin=replicate("-",165)
   mes=month(doth)
*** ������� ������⥫��� ��ᨢ�� ******************************************
   declare sklsi[7],kszri[99],kopi1[99],kopi2[99],kopi3[99],kopi4[99],kopi5[99],kopi7[99]
   afill(sklsi,0) // � �� ���⥫�騪�(�� ��p���)
   afill(kopi1,0)
   afill(kopi2,0)
   afill(kopi3,0)
   afill(kopi4,0)
   afill(kopi5,0)
   afill(kopi7,0)
   newl=.T.
   go top
   do while !eof()
*** ����� 蠯�� **************************************************************
      if newl=.T.
         setprc(0,0)
         nl=nl+1
         @ prow()+1,0 say lin
         @ prow()+1,41 say dtr1
         @ prow()+1,57 say doth pict '99.99.99'
         m11=ltrim(str(menu11))
         if sklr=9999
            @ prow()+1,41 say c&m11+"  ᪫��� N>9000"
         else
            @ prow()+1,41 say c&m11+"  ᪫�� N  "+str(sklr)
         endif
         @ prow(),113 say '���� '+str(nl,3)
         @ prow()+1,0 say lin
         @ prow()+1,0 say '  ���  :����� :���.�����:   �⮨�����   :   �⮨�����   :     �㬬�     :     �㬬�     :   �࠭ᯮ��-  : ���  :     �㬬�     :   �ᥣ� ��     : ��� :���(�)    :'
         @ prow()+1,0 say '��室� :���. :���⥦�. :     ⮢��    :     ���      :   �࣮���    :    ��業��    :      ��      :����:               :  ��室����    :����.: �p㧠     :'
         @ prow()+1,0 say '        :����.:���㬥��:               :               :    ᪨���     :               :    ��室�    :�����:               :   ���㬥���    :     :           :'
        //                 99.99.99 999999       999 999999999999.99 999999999999.99 999999999999.99 999999999999.99 999999999999.99        999999999999.99 999999999999.99    99  99999.999999
        //                 0123456789+123456789+123456789+123456789+123456789+123456789+123456789+123456789+1234567890+123456789+123456789+123456789+123456789+123456789+123456789+12345678+123
        //                          10        20        30        40        50        60        70        80         90       100       110       120       130       140       150      160
         @ prow()+1,0 say lin
         ns=10
      endif
      do case
*** ����� ᯨ᪠ p��室�� ****************************************************
         case menu10=1.or.menu10=2
              if nl=1
                 if sklr=9999
                    set softseek on
                    sir=str(9000,4)
                    netseek('t1',sir,,1)
                    if skl>=9000
                       sklr1=sklr
                       sklr=skl
                    endif
                    set softseek off
                 else
                    sir=str(sklr,4)
                    netseek('t1',sir,,1)
                 endif
                 declare skls[7],kszr[99],sklsi[7],kszri[99]
                 afill(skls,0)  // � �� c����� (�� ��p���)
                 afill(kszr,0)  // � �� ᪫��� (�� c⮫���)
                 vsvs=0
              endif
              newl=.F.
              newp=.T.
              vsvp=0
              store 0 to kpsk,kolp
              set device to screen
              @ 23,0 say "   �롮p�� �⮣�� �� �������.                 "
              set device to print
              do while skl=sklr    // 2 - �롮p�� �� ᪫���
                 if val(substr(ltrim(str(kop)),1,1))=menu11;
                    .and.val(substr(ltrim(str(kop)),2,2))<90;
                    .and.((val(dtos(dot))<=val(dtos(doth)).and.menu10=2).or.;
                    (val(dtos(dot))=val(dtos(doth)).and.menu10=1));
                    .and.month(dot)=mes.and.prz=1
                    kpsk=kpl
                    mnr=ttn
*** ����� ������������ ������ ************************************************
                    if newp
                       sele kln
                       netseek('t1','kpsk')
                       @ ns,1 say kpsk
                       if found()
                          @ ns,10 say nkl
                       endif
                       ns=ns+1
                       sele rs1
                    endif
*** ����� ���� , �� � ���� ���p�樨 *******************************************
                    set device to screen
                    @ 23,0 say "    ����� �⮣�� �� �������. ��H N "
                    @ 23,40 say ttn
                    Npp=Npp+1
                    zzz = 0
                    www = 0
                    set device to print
                    @ ns,0 say dot pict '99.99.99'
                    @ ns,9 say str(ttn,6)
                    @ ns,22 say str(Npp,3)

                    zzz = kop
                    www = vsv
                    vsvs=vsvs+vsv
                    vsvp=vsvp+vsv
*** ����� �㬬 �� ��p�� ���p�� � �⮣���� �㬬� �� ��H **********************
                    sele rs3
                    netseek('t1','mnr')
                    declare kszr1[99]
                    afill(kszr1,0)  // � �� �� (�� c⮫���)
                    if newp=.T.
                       afill(sklsi,0) // � �� ���⠢騪� (�� ��p���)
                       afill(kszri,0) // � �� ���⠢騪� (�� c⮫���)
                       kolp=1
                    endif
                    do while ttn=mnr .AND. .NOT. Eof()
                    // 3 - �롮p�� �� ��p�� �-�
                       do case
                          case ksz=10
                               skls[1]=skls[1]+ssf
                               sklsi[1]=sklsi[1]+ssf
                               @ ns,26 say str(ssf,15,2)
                          case ksz=19
                               skls[4]=skls[4]+ssf
                               sklsi[4]=sklsi[4]+ssf
                               @ ns,42 say str(ssf,15,2)
                          case ksz=20
                               skls[2]=skls[2]+ssf
                               sklsi[2]=sklsi[2]+ssf
                               @ ns,58 say str(ssf,15,2)
                          case ksz=40
                               skls[3]=skls[3]+ssf
                               sklsi[3]=sklsi[3]+ssf
                               @ ns,74 say str(ssf,15,2)
                          case ksz=62
                               skls[5]=skls[5]+ssf
                               sklsi[5]=sklsi[5]+ssf
                               @ ns,90 say str(ssf,15,2)
                          case ksz=90
                               skls[7]=skls[7]+ssf
                               sklsi[7]=sklsi[7]+ssf
                               @ ns,130 say str(ssf,15,2)
                       endcase
                       skip
                    enddo                // 3
                    @ ns,147 say substr(str(zzz,3),2,2)  // ��� ����.
                    @ ns,151 say str(www,12,6)           // ���
                    pr_p=.F.
                    for i=1 to 99
                        if kszr1[i]<>0
                           @ ns,85 say i
                           @ ns,98 say str(kszr1[i],15,2)
                           pr_p=.T.
                           ns=ns+1
                        endif
                    next
                    if !pr_p
                       ns=ns+1
                    endif
                    select rs1
                 endif
                 skip
                 if sklr1=9999.and.skl>9000
                    sklr=skl
                 endif
*** ����� �㬬 �� ��p�� ���p�� � �⮣���� �㬬� �� ���⠢訪� ***************
                 if kpl<>kpsk
                    newp=.T.
                    if kolp>1
                       @ns,0 say "�⮣�:"
                       ns=ns+1
                       @ ns,26  say str(sklsi[1],15,2)
                       @ ns,42  say str(sklsi[4],15,2)
                       @ ns,58  say str(sklsi[2],15,2)
                       @ ns,74  say str(sklsi[3],15,2)
                       @ ns,90  say str(sklsi[5],15,2)
                       @ ns,130 say str(sklsi[7],15,2)
                       pr_p=.F.
                       for i=1 to 99
                           if kszri[i]<>0
                              @ ns,85 say i
                              @ ns,98 say str(kszri[i],15,2)
                              pr_p=.T.
                              ns=ns+1
                           endif
                       next
                       vsvp=0
                       if pr_p=.F.
                          ns=ns+1
                       endif
                       kolp=1
                    endif
                 else
                    if val(substr(ltrim(str(kop)),1,1))=menu11;
                    .and.val(substr(ltrim(str(kop)),2,2))<90;
                    .and.((val(dtos(dot))<=val(dtos(doth)).and.menu10=2).or.;
                    (val(dtos(dot))=val(dtos(doth)).and.menu10=1)).and.skl=sklr;
                    .and.month(dot)=mes.and.prz=1
                        kolp=kolp+1
                        newp=.F.
                    endif
                 endif
*** �p����� ������ ���� ******************************************************
                 if ns>59
                    newl=.T.
                    exit
                 endif
              enddo       // 2
              if newl=.T.
                 loop
              endif
*** ����� �㬬 �� ��p�� ���p�� � �⮣���� �㬬� �� ᪫��� *******************
              @ ns,0 say "�ᥣ� �� ᪫��� :"
              ns=ns+1
              @ ns,26  say str(skls[1],15,2)
              @ ns,42  say str(skls[4],15,2)
              @ ns,58  say str(skls[2],15,2)
              @ ns,74  say str(skls[3],15,2)
              @ ns,90  say str(skls[5],15,2)
              @ ns,130 say str(skls[7],15,2)
              @ ns,151 say str(vsvs,12,6)
              pr_p=.F.
              for i=1 to 99
                  if kszr[i]<>0
                     @ ns,85 say i
                     @ ns,98 say str(kszr[i],15,2)
                     pr_p=.T.
                     ns=ns+1
                  endif
              next
              if pr_p=.F.
                 ns=ns+1
              endif
              @ ns,0 say "� ⮬ �᫥ �� ���� ������p�:"
              ns=ns+1
*** ����� �㬬 �� ��p�� ���p�� � �⮣���� �㬬� �� ���� ������p� ************
              if sklr1=9999
                 set softseek on
                 sir=str(9000,4)
                 netseek('t1',sir,,1)
                 if skl>=9000
                    sklr=skl
                 endif
                 set softseek off
              endif
              sir=str(sklr,4) //+ltrim(str(menu11))
              netseek('t1',sir,,1)
              do while skl=sklr
                   declare skls1[7],kszr[99]
                   afill(skls1,0)
                   afill(kszr,0)
                   vsvk=0
                   ktor=kto
                   do while skl=sklr.and.kto=ktor
                      if val(dtos(dot))<=val(dtos(doth));
                        .and.month(dot)=mes.and.prz=1;
                        .and.val(substr(ltrim(str(kop)),1,1))=menu11;
                        .and.val(substr(ltrim(str(kop)),2,2))<90
                        mnr=ttn
                        set device to screen
                        @ 23,0 say "   �롮p�� �⮣�� �� ���� ������p�.                 "
                        @ 23,46 say kto
                        set device to print
                        vsvk=vsvk+vsv
                        sele rs3
                        netseek('t1','mnr')
                        do while ttn=mnr .AND. .NOT. Eof()
                           do case
                              case ksz=10
                                   skls1[1]=skls1[1]+ssf
                              case ksz=19
                                   skls1[4]=skls1[4]+ssf
                              case ksz=20
                                   skls1[2]=skls1[2]+ssf
                              case ksz=40
                                   skls1[3]=skls1[3]+ssf
                              case ksz=62
                                   skls1[5]=skls1[5]+ssf
                              case ksz=90
                                   skls1[7]=skls1[7]+ssf
                           endcase
                           skip
                        enddo
                        select rs1
                      endif
                      skip
                      if sklr1=9999.and.skl>9000.and.skl<>sklr
                         sklr=skl
                      endif
                   enddo
                   @ ns,0 say str(ktor,2)
                   if used('speng')
                      sele speng
                      go top
                      locate for kgr=ktor
                      if found()
                         @ ns,4 say fio
                      endif
                      sele rs1
                   endif
                   @ ns,26  say str(skls1[1],15,2)
                   @ ns,42  say str(skls1[4],15,2)
                   @ ns,58  say str(skls1[2],15,2)
                   @ ns,74  say str(skls1[3],15,2)
                   @ ns,90  say str(skls1[5],15,2)
                   @ ns,130 say str(skls1[7],15,2)
                   @ ns,151 say str(vsvk,12,6)
                   pr_p=.F.
                   for i=1 to 99
                       if kszr[i]<>0
                          @ ns,85 say i
                          @ ns,98 say str(kszr[i],15,2)
                          pr_p=.T.
                          ns=ns+1
                       endif
                   next
                   if pr_p=.F.
                      ns=ns+1
                   endif
              enddo     // 2.1
              exit
*** ����� �⮣�� ��  p��室� **************************************************
         case menu10=3
              if sklr=9999
                 set softseek on
                 sir=str(9000,4)
                 netseek('t1',sir,,1)
                 if skl>=9000
                    sklr1=sklr
                    sklr=skl
                 endif
                 set softseek off
              else
                 sir=str(sklr,4)
                 netseek('t1',sir,,1)
              endif
              declare skls[7],kszr[99]
              afill(skls,0)  // � �� c����� (�� ��p���)
              afill(kszr,0)  // � �� ᪫��� (�� c⮫���)
              vsvs=0
              vsvp=0
              set device to screen
              @ 23,0 say "    �롮p�� �⮣�� �� ᪫���. ��H N "
              do while skl=sklr    // 2 - �롮p�� �� ᪫����
                 if val(substr(ltrim(str(kop)),1,1))=menu11;
                    .and.val(substr(ltrim(str(kop)),2,2))<90;
                    .and.val(dtos(dot))<=val(dtos(doth));
                    .and.month(dot)=mes.and.prz=1
                    @ 23,40 say ttn
                    mnr=ttn
                    vsvp=vsvp+vsv
                    sele rs3
                    netseek('t1','mnr')
                    do while ttn=mnr   // 3 - �롮p�� �� ��p�� �-�
                       do case
                          case ksz=10
                               skls[1]=skls[1]+ssf
                          case ksz=19
                               skls[4]=skls[4]+ssf
                          case ksz=20
                               skls[2]=skls[2]+ssf
                          case ksz=40
                               skls[3]=skls[3]+ssf
                          case ksz=62
                               skls[5]=skls[5]+ssf
                          case ksz=90
                               skls[7]=skls[7]+ssf
                       endcase
                       skip
                    enddo              // 3
                    select rs1
                 endif
                 skip
                 if sklr1=9999.and.skl>9000
                    sklr=skl
                 endif
              enddo            // 2
              @ 23,0 clear
              @ 23,0 say "    �����  �⮣�� �� ᪫���.       "
              set device to print
*** ����� �㬬 �� ��p�� ���p�� � �⮣���� �㬬� �� ���⠢訪� ***************
              @ ns,26  say str(skls[1],15,2)
              @ ns,42  say str(skls[4],15,2)
              @ ns,58  say str(skls[2],15,2)
              @ ns,74  say str(skls[3],15,2)
              @ ns,90  say str(skls[5],15,2)
              @ ns,130 say str(skls[7],15,2)
              @ ns,151 say str(vsvp,12,6)
              pr_p=.F.
              for i=1 to 99
                  if kszr[i]<>0
                     @ ns,85 say i
                     @ ns,98 say str(kszr[i],15,2)
                     pr_p=.T.
                     ns=ns+1
                  endif
              next
              if pr_p=.F.
                 ns=ns+1
              endif
              @ ns,0 say "� ⮬ �᫥ �� ���� ������p�:"
              ns=ns+1
*** ����� �㬬 �� ��p�� ���p�� � �⮣���� �㬬� �� ����� ���p�権 ***********
              set device to screen
              if sklr1=9999
                 set softseek on
                 sir=str(9000,4)
                 netseek('t1',sir,,1)
                 if skl>=9000
                    sklr=skl
                 endif
                 set softseek off
              endif
              sir=str(sklr,4)
              netseek('t1',sir,,1)
              @ 23,0 say "    �롮p�� �⮣�� �� ����� ������p�. ��H N                         "
              do while skl=sklr
                 declare skls1[7],kszr[99]
                 afill(skls1,0)
                 afill(kszr,0)
                 vsvk=0
                 ktor=kto
                 do while skl=sklr.and.kto=ktor
                    if val(dtos(dot))<=val(dtos(doth));
                      .and.month(dot)=mes.and.prz=1;
                      .and.val(substr(ltrim(str(kop)),1,1))=menu11;
                      .and.val(substr(ltrim(str(kop)),2,2))<90
                      mnr=ttn
                      @ 23,46 say ktor
                      vsvk=vsvk+vsv
                      sele rs3
                      netseek('t1','mnr')
                      do while ttn=mnr .AND. .NOT. Eof()
                         do case
                            case ksz=10
                                 skls1[1]=skls1[1]+ssf
                            case ksz=19
                                 skls1[4]=skls1[4]+ssf
                            case ksz=20
                                 skls1[2]=skls1[2]+ssf
                            case ksz=40
                                 skls1[3]=skls1[3]+ssf
                            case ksz=62
                                 skls1[5]=skls1[5]+ssf
                            case ksz=90
                                 skls1[7]=skls1[7]+ssf
                         endcase
                         skip
                      enddo
                      select rs1
                    endif
                    skip
                    if sklr1=9999.and.skl>9000.and.skl<>sklr
                       sklr=skl
                    endif
                 enddo
                 @ 23,0 clear
                 @ 23,0 say "    �����  �⮣�� �� ����� ������p�                           "
                 set device to print
                 @ ns,0 say str(ktor,2)
                 if file(speng)
                    sele speng
                    go top
                    locate for kgr=ktor.and.skl=sklr
                    if found()
                       @ ns,4 say fio
                    endif
                    sele rs1
                 endif
                 @ ns,26  say str(skls1[1],15,2)
                 @ ns,42  say str(skls1[4],15,2)
                 @ ns,58  say str(skls1[2],15,2)
                 @ ns,74  say str(skls1[3],15,2)
                 @ ns,90  say str(skls1[5],15,2)
                 @ ns,130 say str(skls1[7],15,2)
                 @ ns,151 say str(vsvk,12,6)
                 pr_p=.F.
                 for i=1 to 99
                     if kszr[i]<>0
                        @ ns,85 say i
                        @ ns,98 say str(kszr[i],15,2)
                        pr_p=.T.
                        ns=ns+1
                     endif
                 next
                 if pr_p=.F.
                    ns=ns+1
                 endif
                 set device to screen
              enddo
              set device to print
              exit
         otherwise
              exit
      endcase
      setprc (0,0)
   enddo
   @ ns+1,0 say lin
   @ ns+2,0 say " "
   set devi to screen
   sele rs1
enddo
use
nuse()
erase trsho_r.cdx
sklr=gnSkl
return
