#include "common.ch"
#include "inkey.ch"
  //��ࠢ�筨� TOV
netuse('tov')
netuse('sert')
netuse('ukach')
cntr=0
sele tov
set orde to tag t5
if !netseek('t5','sklr,mntovr')
   go top
endif
rctovr=recn()
prvid_r=2
nsklr=''
if gnMskl=1
   nsklr=alltrim(getfield('t1','sklr','kln','nkle'))
endif
prF1r=0
do while .t.
   if prF1r=0
      foot('F2,F4,F5,F9,F10','���FO,��ᬮ��,���,��室,���室')
   else
      foota('F4,F8,F9,F10','��� �� ���,������,����⏮�,�����!���')
   endif
   sele tov
   set order to tag t5
   go rctovr
   set cent off
   if prvid_r=1
      rctovr=slcf('tov',1,0,8,,"e:ktl h:'���' c:n(9) e:ksert h:'��� ��' c:n(6) e:getfield('t1','tov->ksert','sert','nsert') h:'����䨪��' c:c(20) e:kukach h:'���.�' c:n(6) e:getfield('t2','tov->kukach','ukach','dtukach') h:'��� �' c:d(8) e:dizg h:'����⮢' c:d(8) e:drlz h:'������' c:d(8) e:prmn h:'��室' c:n(6)",;
                ,,1,'skl=sklr.and.mntov=mntovr',,,str(mntovr,7)+' '+alltrim(natr)+' '+nsklr)
   else
      if tovmvidr=1
         if gnKt=1
            rctovr=slcf('tov',1,0,8,,"e:ktl h:'���' c:n(9) e:nei h:'���' c:c(3) e:opt h:'���� ��' c:n(8,3) e:osn h:'���.���.' c:n(9,2) e:osv h:'���.��.' c:n(9,2) e:osf h:'���.䠪�' c:n(9,2) e:skkt h:'Sk�' c:n(3) e:ttnkt h:'TT� K�' c:n(6) e:dtkt h:'��⠊' c:d(8) e:mnkt h:'����' c:n(6)",;
                           ,,1,'skl=sklr.and.mntov=mntovr',,,str(mntovr,7)+' '+alltrim(natr)+' '+nsklr)
         else
            if prjfr=0
               rctovr=slcf('tov',1,0,8,,"e:ktl h:'���' c:n(9) e:nei h:'���' c:c(3) e:opt h:'���� ��' c:n(8,3) e:cenpr h:'���� ��' c:n(8,3) e:osn h:'���.���.' c:n(9,2) e:osv h:'���.��.' c:n(9,2) e:osf h:'���.䠪�' c:n(9,2) e:osvo h:'���.���.' c:n(9,3) e:(cenpr/opt-tsz60-1)*100 h:'���' c:n(6,2)",;
                              ,,1,'skl=sklr.and.mntov=mntovr',,,str(mntovr,7)+' '+alltrim(natr)+' '+nsklr)
            else
               rctovr=slcf('tov',1,0,8,,"e:ktl h:'���' c:n(9) e:nei h:'���' c:c(3) e:opt h:'���� ��' c:n(8,3) e:cenpr h:'���� ��' c:n(8,3) e:osn h:'���.���.' c:n(9,2) e:osv h:'���.��.' c:n(9,2) e:iif(tov->otv=0,osf,getfield('t1','skljfr,tov->ktl','tovj','osf')) h:'���.䠪�' c:n(9,2) e:osvo h:'���.���.' c:n(9,3) e:(cenpr/opt-tsz60-1)*100 h:'���' c:n(6,2)",;
                              ,,1,'skl=sklr.and.mntov=mntovr',,,str(mntovr,7)+' '+alltrim(natr)+' '+nsklr)
            endif
         endif
      else
         rctovr=slcf('tov',1,0,8,,"e:ktl h:'���' c:n(9) e:nei h:'���' c:c(3) e:opt h:'���� ��' c:n(8,3) e:cenpr h:'���� ��' c:n(8,3) e:osn h:'���.���.' c:n(9,2) e:osv h:'���.��.' c:n(9,2) e:osfo h:'���.���' c:n(9,2) e:osvo h:'���.���.' c:n(9,3) e:(cenpr/opt-tsz60-1)*100 h:'���' c:n(6,2)",;
                           ,,1,'skl=sklr.and.mntov=mntovr',,,str(mntovr,7)+' '+alltrim(natr)+' '+nsklr)
      endif
   endif
   set cent on
   sele tov
   go rctovr
   ktlr=ktl
   sklr=skl
   mntovr=mntov
   kg_r=int(ktlr/1000000)
   do case
      case lastkey()=K_ESC
           exit
      case lastkey()=K_F1 // F1
           if prF1r=0
              prF1r=1
           else
              prF1r=0
           endif
      case lastkey()=K_F2
           if tovmvidr=1
              tovmvidr=2
           else
              tovmvidr=1
           endif
      case lastkey()=K_F4
           if gnAdm=0
              if gnArnd#0.or.gnCenp=1
                 tovins(1, 'tov')
              else
                 tovins(2, 'tov')
              endif
           else
              tovins(1, 'tov')
           endif
           sele tov
           go rctovr
//      case lastkey()=K_ALT_F4 .and.gnTpstPok=2.and.bom(gdTd)=ctod('01.09.2007').and.gnEnt=21 // ��� �� ���
//      case lastkey()=K_ALT_F4 .and.gnTpstPok#0.and.bom(gdTd)=bom(gdNPrd).and.(gnEnt=21.or.gnEnt=20) // ��� �� ���
      case lastkey()=K_ALT_F4 .and. bom(gdTd)=bom(gdNPrd).and.(gnEnt=21.or.gnEnt=20) // ��� �� ���
           store osn to osnr,osn_r
           cltt=setcolor('gr+/b,n/bg')
           wtt=wopen(10,20,12,50)
           wbox(1)
           @ 0,1 say '��� �� ���' get osnr pict '99999999.999'
           read
           wclose(wtt)
           setcolor(cltt)
           if lastkey()=K_ESC
             loop
           endif
           sele tov
           netrepl('osn','osn-osn_r+osnr')
           if gnCtov=1
              sele tovm
              if netseek('t1','sklr,mntovr')
                 netrepl('osn','osn-osn_r+osnr')
              endif
              sele tov
           endif
      case lastkey()=K_F5
           if prvid_r=1
              prvid_r=2
           else
              prvid_r=1
           endif
      case lastkey()=K_F9 // ��室
           tov_r='tov'
           pr1ktl()
      case lastkey()=K_F10 // ���室
           tov_r='tov'
           rs1ktl()
      case lastkey()=K_ALT_F8 // ��� ������ ��᭮�� ���⪠
        PSort(sklr,mntovr)
      case lastkey()=K_ALT_F9 //  ������� PRZ=1 (�) ������ ��᭮�� ���⪠
        PSort(sklr,mntovr,3)
      case lastkey()=K_ALT_F10 //  �� ������� PRZ=0 (�) ������ ��᭮�� ���⪠
        PSort(sklr,mntovr,2)
      case lastkey()=K_ALT_F3 //
        If RLock()
          Browse()
        EndIf
        dbrunLock(RecNo())
   endcase
enddo

