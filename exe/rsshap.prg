#include "common.ch"
#include "inkey.ch"
*************
func rsshp()
*************
do case
   case gnVo=0
        nopr='��⮬���᪨� ��室'
        @ 3,1 say  '���筨�  : '+alltrim(nsksr)
        if msklsr=1
           @ 4,1 say  '������⭨� '+alltrim(nsklsr)
        endif
        @ 5,1 say  '�����祭��: '+gcNskl //10
        if gnMskl=1
           nsklr=getfield('t1','sklr','kln','nkl')
           @ 6,1 say '������⭨� '+alltrim(nsklr)
        endif
   case gnVo=2 // ��������
        if przn=1
           if okklr=0
              wmess('��� ���� ��㧮�����⥫� � SOPER',3)
              retu .f.
           endif
           store okklr to kgpr
           store okplr to kplr
        endif
        nkgpr=getfield('t1','kgpr','kln','nkl')
        nkplr=getfield('t1','kplr','kln','nkl')
        @ 3,1 say  '���筨�  : '+gcNskl //10
        if przn=1
           if who=2.or.who=3.or.who=4
              @ 4,1 say  '��࣮�� �����:' get ktar pict '9999' valid kta()
              read
              if lastkey()=K_ESC
                 retu .f.
              endif
           endif
        endif
        nktar=getfield('t1','ktar','s_tag','fio')
        @ 4,17 say str(ktar,4) +' '+ alltrim(nktar)
        @ 5,1 say  '�����祭��: '+str(kgpr,7)+' '+alltrim(nkgpr)
        if autor#0.and.mskltr=1
           skltr=kplr
        endif
   case gnVo=5.or.gnVo=4  // ���,��⮪�� �� �����⭮� ��
        @ 3,1 say  '���筨�:   '+gcNskl //10
        if gnVo=5.and.kopr=193
           necsr=getfield('t1','kecsr','s_tag','fio')
           @ 3,35 say  '��ᯥ����: '+ str(kecsr,3) +' '+ alltrim(necsr)
        endif
        if prlkr=0.and.gnVo=5.and.kopr=193
           if przn=1
              if who=2.or.who=3.or.who=4
                 @ 3,35 say  '��ᯥ����:' get kecsr pict '999'
                 read
                 if lastkey()=K_ESC
                    retu .f.
                 endif
                 if kecsr=0.or.!netseek('t1','kecsr','s_tag')
                    sele s_tag
                    go top
                    kecsr=SLCf('s_tag',,,10,,"e:kod h:'���' c:n(3) e:fio h:'  �.  �.  �. ' c:c(30)",'kod')
                 endif
              endif
           endif
           necsr=getfield('t1','kecsr','s_tag','fio')
           @ 3,48 say str(kecsr,3) +' '+ alltrim(necsr)
        endif
        if prlkr=0
           if przn=1
              if gnMskl=1 .and. !(gnVo=4)
                @ 4,1 say '������⭨�:' get sklr pict '9999999' valid sklkln()
              else
                @ 4,1 say '������⭨�:' get sklr pict '9999999' valid skltar()
              endif
              read
              if lastkey()=K_ESC.or.sklr=0 // ��易⥫�� �롮� ����᪫���
                 retu .f.
              endif
           endif
           nsklr=getfield('t1','sklr','kln','nkl')
           if gnMskl=1 .and. !(gnVo=4)
              @ 4,14 say str(sklr,7)+' '+alltrim(nsklr)
           else
              @ 4,14 say str(sklr,7)+' '+alltrim(nsklr)
           endif
        endif
        if gnVo=5
           if przn=1
              if prlkr=0
                 @ 5,1 say  '���:       ' get kplr pict '999999' valid kplbs()
              else
                 @ 5,1 say '��⮬����� :' get ttnkpsr pict '9999999' valid kpskln()
              endif
              read
              if lastkey()=K_ESC
                 retu .f.
              endif
           endif
           if prlkr=1.or.(prlkr=0.and.ttnkpsr#0)
              skltr=ttnkpsr
           endif
           nkplr=getfield('t1','kplr','bs','nbs')
           nttnkpsr=getfield('t1','ttnkpsr','kln','nkl')
           if prlkr=0
              if ttnkpsr=0
                 @ 5,14 say str(kplr,6)+' '+alltrim(nkplr)
              else
                 @ 5,14 say str(kplr,6)+' '+alltrim(nkplr)+' '+alltrim(nttnkpsr)
              endif
           else
              @ 5,14 say str(ttnkpsr,6)+' '+alltrim(nttnkpsr)
           endif
        else
           @ 5,1 say space(20)
        endif
        if prlkr=0
           @ 6,1 say  '���ࠧ�������:'
           if przn=1
              @ 6,16 get kgpr pict'9999999' valid pdr()
              read
              if lastkey()=K_ESC
                 retu .f.
              endif
           endif
           nkgpr=getfield('t1','kgpr','podr','npod')
           @ 6,16 say str(kgpr,7)+' '+alltrim(nkgpr)
        endif
        if gnVo=4
           kplr=sklr
        endif
   case gnVo=6.or.gnVo=7.or.gnVo=8  // ��ॡ�᪠/� �������/������
        @ 3,1 say  '���筨�:   '+gcNskl //10
        if gnMskl=1
           if przn=1
              @ 4,1 say  '������⭨�:' get sklr pict '9999999' valid sklkln()
              read
              if lastkey()=K_ESC.or.sklr=0 // ��易⥫�� �롮� ����᪫���
                 retu .f.
              endif
           else
              @ 4,1 say  '������⭨�: '+str(sklr,7)
           endif
           nsklr=getfield('t1','sklr','kln','nkl')
           @ 4,14 say str(sklr,7)+' '+alltrim(nsklr)
        endif
        if autor=1
           @ 5,1 say  '�����祭��: '+nskltr
        endif
        if autor=3 // ����� - �����
           if przn=1
              @ 5,1 say  '�����祭��: ' get sktr pict '999' valid skt()
              read
              if lastkey()=K_ESC.or.sktr=0
                 retu .f.
              endif
           else
              @ 5,1 say  '�����祭��: '+str(sktr,7)+' '+nskltr
           endif
           sele rs1
           @ 6,1 say  '�⤥�     : '+' '+str(otnr,2)+' '+notnr
            if przn=1
*                 @ 6,1 say  '�⤥�     : ' get otnr pict '99' valid otn()
*                 read
           endif
           sele rs1
           @ 7,1 say  '��㯯�    : '+' '+str(kgnr,3)+' '+ngnr
           if przn=1
*                 @ 7,1 say  '��㯯�    : ' get kgnr pict '999' valid kgn()
*                 read
           endif
        endif
        if autor=4 // �।���⨥ - �।���⨥
           if przn=1
              @ 5,1 say  '�।���⨥:' get entpr pict '99' valid entp()
              read
              if lastkey()=K_ESC.or.entpr=0
                 retu .f.
              endif
              @ 6,1 say  '�����:      ' get sktr pict '999' valid sktp()
              read
              if lastkey()=K_ESC.or.sktpr=0
                 retu .f.
              endif
           else
              @ 5,1 say  '�।���⨥: '+' '+str(entpr,2)+' '+nentpr
              @ 6,1 say  '�����:       '+' '+str(sktpr,7)+' '+nsktpr
           endif
           sele rs1
            @ 7,1 say  '�⤥�:'+' '+str(otnr,2)+' '+subs(notnr,1,10)
           if przn=1
*                 @ 7,1 say  '�⤥�:' get otnr pict '99' valid otnp()
              read
           endif
           sele rs1
           @ 7,22 say  '��㯯�:'+' '+str(kgnr,3)+' '+ngnr
           if przn=1
*                 @ 7,22 say  '��㯯�:' get kgnr pict '999' valid kgnp()
              read
           endif
        endif
        if mskltr#0
           if przn=1
              if gnVo=6.or.gnVo=7
                 @ 6,1 say  '������⭨�:' get kplr pict '9999999' valid kplpkln()
                 read
                 if lastkey()=K_ESC
                    retu .f.
                 endif
                 if autor#0
                    skltr=kplr
                 endif
                 kgpr=kplr
              endif
              if gnVo=7.or.gnVo=8 // (7,8)
                 @ 6,40 say '���ࠧ�������' get kgpr pict '9999999' valid pdr()
                read
                 if lastkey()=K_ESC
                    retu .f.
                 endif
                 pdrr=kgpr
                 nkgpr=getfield('t1','kgpr','podr','npod')
                 @ 6,54 say str(kgpr,7)+' '+alltrim(nkgpr)
              endif
           endif
           nkplr=getfield('t1','kplr','kln','nkl')
           @ 6,14 say str(kplr,7)+' '+alltrim(nkplr)
        endif
   case gnVo=1.or.gnVo=9.or.gnVo=3.and.kopr#135.and.kopr#136.and.kopr#137  // ���㯠⥫�/������ ���⠢騪�/�����ᨮ���� �࣮��� ����
        kgpcatr=getfield('t1','kgpr','kgp','kgpcat')
        nkgpcatr=alltrim(getfield('t1','kgpcatr','kgpcat','nkgpcat'))
        @ 3,1 say  '���筨�:    '+alltrim(gcNskl)+space(5)
        @ 3,col()+1 say nkgpcatr color 'r+/n'
        if gnMskl=1
            if przn=1
               @ 4,1 say  '������⭨�:' get sklr pict '9999999' valid sklkln()
               read
               if lastkey()=K_ESC.or.sklr=0 // ��易⥫�� �롮� ����᪫���
                  retu .f.
               endif
            endif
            nsklr=getfield('t1','sklr','kln','nkl')
            @ 4,14 say str(sklr,7)+' '+alltrim(nsklr)
        else
             // ���� �࣮���� �����
           if who=2 .or. who=3.or.who=4
              if przn=1
                 if gnEnt=20
                       @ 4,1 say  '��࣮�� �����:' get ktar pict '9999' valid kta20()
                 else
                    @ 4,1 say  '��࣮�� �����:' get ktar pict '9999' valid kta()
                 endif
                 read
                 if lastkey()=K_ESC
                    retu .f.
                 endif
              endif
           endif
           nktar=getfield('t1','ktar','s_tag','fio')
           @ 4,1 say  '��࣮�� �����:'
           @ 4,17 say str(ktar,4)+'('+str(ktasr,4)+','+str(exter,1)+')'+' '+ alltrim(nktar)
        endif
        if przn=1
           if corsh=0
              if okplr#0
                 kplr=okplr
              else
                 kplr=0
              endif
              if okklr#0
                 kgpr=okklr
              else
                 kgpr=0
              endif
           else
              kplr=nkklr
              kgpr=kpvr
           endif
           if gnEnt=20
              @ 5,1 say  '���⥫�騪:  ' get kplr pict '9999999' valid kpl20()
           else
              do case
                 case prexter=1
                      @ 5,1 say  '���⥫�騪:  ' get kplr pict '9999999' valid kplkta()
                 case prexter=2
                      @ 5,1 say  '���⥫�騪:  ' get kplr pict '9999999' valid kplkln()
                 other
                     @ 5,1 say  '���⥫�騪:  ' get kplr pict '9999999' valid tmkpl()
              endc
           endif
           read
           if lastkey()=K_ESC
              retu .f.
           endif
          if autor#0.and.mskltr=1
              skltr=kplr
           endif
        endif
        nkplr=getfield('t1','kplr','kln','nkl')
        @ 5,1 say  '���⥫�騪:   ' +str(kplr,7)+' '+alltrim(nkplr)

        if przn=1
           if kgpr=0
*                 kgpr=kplr
           else
              if okplr#0
                 if okplr#kplr
*                      kgpr=kplr
                    kgpr=kpvr
                  endif
                 if okplr=kplr
                     kgpr=okklr
                 endif
              endif
           endif
           if gnEnt=20
              @ 6,1 say  '�����⥫�:  ' get kgpr pict '9999999' valid kgp20()
           else
              do case
                 case prexter=1
                      @ 6,1 say  '�����⥫�:  ' get kgpr pict '9999999' valid kgpkln()
                 case prexter=2
                      @ 6,1 say  '�����⥫�:  ' get kgpr pict '9999999' valid kgpkln()
                 othe
                      @ 6,1 say  '�����⥫�:  ' get kgpr pict '9999999' valid tmkgp()
              endc
           endif
           read
           if lastkey()=K_ESC
              retu .f.
           endif
        endif
        if gnEnt=20
           nkgpr=getfield('t1','kgpr','kgp','ngrpol')
           if empty(nkgpr)
              nkgpr=getfield('t1','kgpr','kln','nkl')
           endif
        else
           nkgpr=getfield('t1','kgpr','kln','nkl')
        endif
        @ 6,1 say  '�����⥫�:   '+str(kgpr,7)+' '+alltrim(nkgpr)
        if przn=1
           if kpvr=0
              kpvr=kgpr
           else
              if kpvr#kgpr
                 kpvr=kgpr
              endif
           endif
        endif
        if autor#4
              nkpvr=getfield('t1','kpvr','kgp','ngrpol')
              if empty(nkpvr)
                 nkpvr=getfield('t1','kpvr','kln','nkl')
              endif
           @ 7,1 say  '�㭪� ����.:  '+str(kpvr,7)+' '+alltrim(nkpvr)+' '
              if przn=1
                 @ 7,col() get npvr
                 read
              endif
           @ 7,14 clea to 7,79
           @ 7,14 say str(kpvr,7)+' '+alltrim(nkpvr)+' '+alltrim(npvr)
           @ 7,70 say str(nndsr,10)
        else // �।���⨥ - �।���⨥
           if autor=4
              if przn=1
                 @ 7,1 say  '�।��' get entpr pict '99' valid entp()
                 read
                 if lastkey()=K_ESC.or.entpr=0
                    retu .f.
                 endif
                 @ 7,20 say  '�����:' get sktr pict '999' valid sktp()
                 read
                 if lastkey()=K_ESC.or.sktpr=0
                   retu .f.
                 endif
              else
                 @ 7,1 say  '�।�� '+' '+str(entpr,2)+' '+nentpr
                @ 7,20 say  '�����:'+' '+str(sktpr,7)+' '+nsktpr
              endif
              sele rs1
              @ 7,30 say  '�⤥�:'+' '+str(otnr,2)+' '+subs(notnr,1,10)
              if przn=1
                 @ 7,30 say  '�⤥�:' get otnr pict '99' valid otnp()
                 read
              endif
              sele rs1
              @ 7,40 say  '��㯯�:'+' '+str(kgnr,3)+' '+ngnr
              if przn=1
                 @ 7,40 say  '��㯯�:' get kgnr pict '999' valid kgnp()
                 read
              endif
           endif
        endif
   case gnVo=3.and.(kopr=135.or.kopr=136.or.kopr=137)  // �����ᨮ����
        kgpcatr=getfield('t1','kgpr','kgp','kgpcat')
        nkgpcatr=alltrim(getfield('t1','kgpcatr','kgpcat','nkgpcat'))
        if przn=1
           if gnKt=0
              @ 4,1 say  '����   :' get kplr pict '9999999'
           else
              @ 4,1 say  '�� ����:' get kplr pict '9999999'
           endif
           read
           if lastkey()=K_ESC.or.kplr=0 // ��易⥫�� �롮� ����᪫���
              retu .f.
           endif
           nkplr=getfield('t1','kplr','kln','nkl')
           @ 4,10 say str(kplr,7)+' '+alltrim(nkplr)
           if gnKt=0
              * ���� �࣮���� �����
              if who=2 .or. who=3.or.who=4
                 @ 5,1 say  '��࣮�� �����:' get ktar pict '9999'
                 read
                 if lastkey()=K_ESC
                    retu .f.
                 endif
                 nktar=getfield('t1','ktar','s_tag','fio')
                 @ 5,1 say  '��࣮�� �����: '+str(ktar,4)+' '+ alltrim(nktar)
              endif
              mnktr=0
              skltr=kplr
              @ 6,1 say  '�����⥫�:  ' get kgpr pict '9999999'
              read
              if lastkey()=K_ESC
                 retu .f.
              endif
              ngpr=getfield('t1','kgpr','kln','nkl')
              @ 6,11 say str(kgpr,7)+' '+alltrim(ngpr)
           else
              @ 5,1 say  '��� �����ᨨ' get ttnktr pict '999999' valid ttnkt()
              read
              if lastkey()=K_ESC
                 retu .f.
              endif
              @ 5,1 say  '��� �����ᨨ ' +str(ttnktr,6)+' '+str(nndsktr,10)+' '+dtoc(dnnktr)
              skltr=getfield('t1','sktr','cskl','skl')
              sklr=kplr
              kgpr=gnKkl_c
              ngpr=gcName_c
              ngpr=getfield('t1','kgpr','kln','nkl')
              @ 6,1 say '�����⥫� '+str(kgpr,7)+' '+alltrim(ngpr)
           endif
        else
           if gnKt=0
              @ 4,1 say  '����   : '+str(kplr,7)
           else
              @ 4,1 say  '�� ����: '+str(kplr,7)
           endif
           nkplr=getfield('t1','kplr','kln','nkl')
           @ 4,col()+1 say alltrim(nkplr)
           if gnKt=0
              nktar=getfield('t1','ktar','s_tag','fio')
              @ 5,1 say  '��࣮�� �����: '+str(ktar,4)+' '+ alltrim(nktar)
           else
              @ 5,1 say  '��� �����ᨨ ' +str(ttnktr,6)+' '+str(nndsktr,10)+' '+dtoc(dnnktr)
           endif
           ngpr=getfield('t1','kgpr','kln','nkl')
           @ 6,1 say '�����⥫� '+str(kgpr,7)+' '+alltrim(ngpr)
        endif
        kpvr=kgpr
        nkpvr=ngpr
        nkklr=kplr
        @ 7,1 clea to 7,79
        @ 7,1 say '�㭪� �����祭�� '+str(kpvr,7)+' '+alltrim(nkpvr)+' '+alltrim(npvr)
        @ 7,70 say str(nndsr,10)
   case gnVo=10  // �७��
        if gnEnt=21.and.gnArnd=3.and.przn=1
           @ 3,1 say '�����祭��:' get sktr valid skt()
           read
        endif
        @ 3,1 say '�����祭��:'+' '+str(sktr,3)+' '+getfield('t1','sktr','cskl','nskl')
        nktar=getfield('t1','ktar','s_tag','fio')
        if gnEnt=21
           @ 4,1 say  '��࣮�� �����:'
           @ 4,17 say str(ktar,4)+' '+ alltrim(nktar)
        endif
        if przn=1
           if gnEnt=21
              @ 4,1 say  '��࣮�� �����:' get ktar pict '9999' valid kta()
              read
              if lastkey()=K_ESC
                 retu .f.
              endif
              nktar=getfield('t1','ktar','s_tag','fio')
           endif
           @ 5,1 say  '�७����:   ' get kplr pict '9999999' valid akplkpl()
           read
           if lastkey()=K_ESC
              retu .f.
           endif
        endif
        nkplr=getfield('t1','kplr','kln','nkl')
        firmr=alltrim(nkplr)
        @ 4,17 say str(ktar,4)+' '+ alltrim(nktar)
        @ 5,1 say '�७����:   '+' '+str(kplr,7)+' '+alltrim(nkplr)
        if przn=1
           if gnArnd=2
              @ 6,1 say  '�����祭��:  ' get kgpr pict '9999999' valid akgpkgp()
           else
              @ 6,1 say  '���筨�  :  ' get kgpr pict '9999999' valid akgpkgp()
           endif
           read
           if lastkey()=K_ESC.or.kgpr=0
              retu .f.
           endif
        endif
*        if gnEnt=20
           ngpr=getfield('t1','kgpr','kgp','ngrpol')
           if empty(ngpr)
              ngpr=getfield('t1','kgpr','kln','nkl')
           endif
*        else
*           ngpr=getfield('t1','kgpr','kln','nkl')
*        endif
        if gnArnd=2
           @ 6,1 say '�����祭��:  '+' '+str(kgpr,7)+' '+alltrim(ngpr)
        else
           @ 6,1 say '���筨�  :  '+' '+str(kgpr,7)+' '+alltrim(ngpr)
        endif
        if tskltr=3
           tmestor=getfield('t2','kplr,kgpr','etm','tmesto')
           if tmestor=0
              tmestor=getfield('t2','kplr,kgpr','tmesto','tmesto')
           endif
           if tmestor=0
              if kplr#0.and.kgpr#0
                 sele cntcm
                 reclock()
                 tmestor=tmesto
                 netrepl('tmesto','tmesto+1')
                 sele tmesto
                 netadd()
                netrepl('tmesto,kpl,kgp','tmestor,kplr,kgpr')
              endif
           endif
           skltr=tmestor
        endif
        if gnTskl#3
           sklr=gnSkl
        else
           tmestor=getfield('t2','kplr,kgpr','etm','tmesto')
           if tmestor=0
              tmestor=getfield('t2','kplr,kgpr','tmesto','tmesto')
           endif
           if tmestor=0
              if kplr#0.and.kgpr#0
                 sele cntcm
                 reclock()
                 tmestor=tmesto
                 netrepl('tmesto','tmesto+1')
                 sele tmesto
                 netadd()
                 netrepl('tmesto,kpl,kgp','tmestor,kplr,kgpr')
              endif
           endif
           sklr=tmestor
        endif
endc
retu .t.
**************
func ttnkt()
**************
sele tov
if netseek('t1','kplr')
   do while skl=kplr
      if ttnkt=ttnktr
         exit
      endif
      skip
   endd
   if skl#kplr.or.eof()
      wmess('��� ⮢�� �� �⮬� ���㬥���',2)
      retu .t.
   endif
   dtktr=dtkt
   skktr=skkt
   dir=alltrim(getfield('t1','skktr','cskl','path'))
   pathr=gcPath_e+'g'+str(year(dtktr),4)+'\m'+iif(month(dtktr)<10,'0'+str(month(dtktr),1),str(month(dtktr),2))+'\'+dir
   if netfile('rs1',1)
      netuse('rs1','rs1vz',,1)
      if netseek('t1','ttnktr')
         nndsktr=nnds
         dnnktr=dot
         if vo#3
            wmess('��� �� �������',2)
            nuse('rs1vz')
            retu .f.
         endif
         if prz=0
            wmess('�� ���⢥ত��',2)
            nuse('rs1vz')
            retu .f.
         endif
      else
         wmess('��� ���㬥��',2)
         nuse('rs1vz')
         retu .f.
      endif
      nuse('rs1vz')
   else
      wmess('��� rs1.dbf '+str(skktr,3)+' '+dtoc(dtktr),2)
      retu .f.
   endif
endif
retu .t.
