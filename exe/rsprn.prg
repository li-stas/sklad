#include "common.ch"
#include "inkey.ch"
#define KK_GET

// if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv)
// ᨬ���쭮 ������祭�� ���.��� - ���⠥� ��� ����� ���



*************  ����� ��� ***************
para p1,p2,p3
   // p1 1 - ������,2- �⥢��,3-�⥢�� 1��,4-�⥢�� ���
   // p2 - ��� � �᫨ �� �� 㬮��
  *****************************************
  STATIC lSeekError
  LOCAL j,kEkzr

  lSeekError:=.F.
  fkto_r=fktor
  mntovr=getfield('t1','ttnr','rs2','mntov')
  setprnr=''
  NVipdr=''
  store space(30) to prvzr,avtor,vodr
  store 0 to vmestr,s90ndsr,NoPrnr,NoPrn_r
  if PrnOprnr=1
    vzz:=1
  endif


  netuse('knasp')
  netuse('opfh')
  netuse('kplid')
  netuse('kplidx')
  netuse('KProd')

  store 0 to kk,psp,kkr,prassor,svczr
  filedelete('*.prn')
  //tttnr=1
  prosfor=0
  vvcenr=2
  vpr=1
  kkr=1
  kk=1
  psp=1
  notr=''
  otr=0
  itogr=0
  otkr=0
  prprn6r=0
  vlpt1='lpt1'
  do case
     case atrcr=0
          if gnEnt=21
             vlpt1='lpt2'
          else
             vlpt1='lpt1'
          endif
     case atrcr=1
          vlpt1='lpt3'
     case atrcr=2
          vlpt1='lpt2'
  endcase
  if !netuse('nds')
     retu
  endif

  #ifndef KK_GET
    IF EMPTY(SELECT("Sl"))
      USE _slct ALIAS sl NEW
    ENDIF
    sele sl
    ZAP
    IF !FILE("RsPrn.dbf")
      DBCREATE("RsPrn",{ {"Name","C",10,0} })
      USE RsPrn NEW
      DBAPPEND();  _FIELD->Name:="��壠����"
      DBAPPEND();  _FIELD->Name:="�������"
      DBAPPEND();  _FIELD->Name:="�-215"
      DBAPPEND();  _FIELD->Name:="����䨪���"
    ELSE
      USE RsPrn NEW
    ENDIF
    DBGOTOP()
  #endif

  if select('PRs2')#0
    sele PRs2
    use
  endif

  erase PRs2.dbf
  erase PRs2.cdx
  lcrtt('PRs2','rs2')
  sele 0
  use PRs2 excl
  IF ! CompArray(PRs2->(DBSTRUCT()), rs2->(DBSTRUCT()))
    wmess('��ᮮ⢥⢨� ������� rs2 � �⮬ ��२���'+DTOC(gdTd),2)
    wmess("������ ������������",2)
    #ifdef __CLIP__
    outlog(__FILE__,__LINE__,"PRs2",PRs2->(DBSTRUCT()))
    outlog(__FILE__,__LINE__,"rs2",rs2->(DBSTRUCT()))
    #endif
    retu
    //
  ENDIF
  use

  erase PRs2.dbf
  erase PRs2.cdx
  lcrtt('PRs2','rs2','f:kg c:n(3) f:nat c:c(90) f:zenbb c:n(15,3) f:zenbt c:n(15,3) f:id c:c(9) f:nai c:c(60) f:vesp c:n(12,3) f:NoPrn c:n(1)')
  sele 0
  use PRs2 excl

  if select('PRs2m')#0
     sele PRs2m
     use
  endif
  erase PRs2m.dbf
  erase PRs2m.cdx
  lcrtt('PRs2m','rs2','f:kg c:n(3) f:nat c:c(90) f:zenbb c:n(15,3) f:zenbt c:n(15,3) f:id c:c(9) f:nai c:c(60) f:vesp c:n(12,3) f:nei c:c(4) f:NoPrn c:n(1)')
  sele 0
  use PRs2m excl

  sele rs1
  pr177r=pr177
  pr169r=pr169
  pr129r=pr129
  pr139r=pr139

  if fieldpos('mntov177')#0
    mntov177r=mntov177
    prc177r=prc177
  else
    mntov177r=0
    prc177r=0
  endif

    kolpos_r:=0
    kolposNoPrn:=0
  // ������ ���㬥���
  if EMPTY(PrnOprnr) .and. pr169rEQ2(ttnr) //(pr177r=2.or.pr169r=2.or.pr129r=2.or.pr139r=2)

    sm10r=getfield('t1','ttnr,10','rs3','ssf') // �㬬� ⮢��
    kvp_r:=0

    Crt_trs2()
      AddRec2Trs2(rs1->(mk169 +  mk129 + mk139)) // mk177 +
    sele trs2
    aRecTRs2:=trs2->({npp,nat,Ukt,upu,kod,kol,zen,sm})
    close trs2

    sele rs2
    netseek('t1','ttnr');  arec:={};  getrec()
    count to kolposNoPrn while ttn=ttnr

    kolposNoPrn-- // ���� 㦥 �뢥��
    kolpos_r:=kolposNoPrn

    sele PRs2
    netadd(); putrec()
    netrepl('mntov',{mntov177r})
    netrepl('npp,nat,Ukt,upu,kod,kvp,zen,svp',;
            aRecTRs2)

    sele PRs2m
    netadd(); putrec()
    netrepl('mntov',{mntov177r})
    netrepl('npp,nat,Ukt,upu,kod,kvp,zen,sm',;
            aRecTRs2)

  Else
    sele rs2
    set rela to
    set orde to tag t1
    go top
    store 0 to minkdOplr,maxkdOplr,prmk17r,NoPrnr,NoPrn_r
    if netseek('t1','ttnr')
       do while ttn=ttnr


          arec:={}
          getrec()
          kgr=int(ktlp/1000000)
          kg_r=int(ktl/1000000)
          mntovpr=mntovp
          mntovr=mntov
          ktlpr=ktlp
          ktlr=ktl
          zenr=zen
          zenbtr=0
          zenbbr=0
          kvpr=kvp
          if gnEnt=21
             vmestr=vmestr+kvpr
          endif
          if gnVo=1.and.kg_r>1.and.kpsbbr=1
             prbbr=getfield('t1','kg_r','cgrp','prbb')
             if prbbr=1
                zenbtr=cvzbt
                zenbbr=cvzbb
             else
                zenbtr=0
                zenbbr=0
             endif
          else
             zenbtr=0
             zenbbr=0
          endif
          if gnCtov=3
             natr=getfield('t1','ktlpr','ctovk','nat')
             neir=getfield('t1','ktlpr','ctovk','nei')
          else
             natr=getfield('t1','mntovpr','ctov','nat')
             neir=getfield('t1','mntovpr','ctov','nei')
          endif
          store '' to idr,nair
          sele kplid
          if netseek('t1','kplr')
             idr=getfield('t2','kplr,mntovr','kplidx','id')
             if !empty(idr)
                nair=getfield('t1','kplr,idr','kplid','nai')
             endif
          endif
          if gnCtov=1
             sele ctov
             if fieldpos('NoPrn')#0
                NoPrn_r=getfield('t1','mntovr','ctov','NoPrn')
                if NoPrn_r=1
                   if NoPrnr=0
                      NoPrnr=1
                   endif
                endif
             endif
             if prmk17r=0
                mkeep_r=getfield('t1','mntovr','ctov','mkeep')
                if mkeep_r=17
                   prmk17r=1
                endif
             endif
             izgr=getfield('t1','mntovr','ctov','izg')
             if izgr#0
                kdOpl_r=getfield('t1','kplr,izgr,999','klnnac','kdOpl')
                if kdOpl_r=0
                   kdOpl_r=getfield('t1','kplr,izgr,kg_r','klnnac','kdOpl')
                endif
                if kdOpl_r#0
                   if minkdOplr=0
                      minkdOplr:=kdOpl_r
                   else
                      if kdOpl_r<minkdOplr
                         minkdOplr:=kdOpl_r
                      endif
                   endif
                   if maxkdOplr=0
                      maxkdOplr:=kdOpl_r
                   else
                      if kdOpl_r>maxkdOplr
                         maxkdOplr:=kdOpl_r
                      endif
                   endif
                endif
             endif
          endif
          vespr=getfield('t1','sklr,ktlr','tov','vesp')

          sele PRs2
          netadd()
          put_rec()
          netrepl('kg,nat,zenbt,zenbb,id,nai,vesp,NoPrn','kgr,natr,zenbtr,zenbbr,idr,nair,vespr,NoPrn_r')

          sele PRs2m
          locate for mntov=mntovr
          if !foun()
             netadd()
             putrec()
             netrepl('kg,nat,zenbt,zenbb,id,nai,vesp,NoPrn','kgr,natr,zenbtr,zenbbr,idr,nair,vespr,NoPrn_r')
             netrepl('nei','neir')
          else
             netrepl('kvp','kvp+kvpr')
          endif
          sele rs2
          skip
       enddo
    endif



    sele PRs2
    if kolposr#0
       rccr=recc()
       if rccr#kolposr
          wmess('��ᮢ������� ��� ��� '+str(ttnr,6),2)
          #ifdef __CLIP__
            outlog(__FILE__,__LINE__,"��ᮢ������� ��� ���","PRs2",rccr,"KOLPOS",kolposr,ttnr)
          #endif
          retu
       endif
    endif
  EndIf
  sele PRs2
  index on STR(kg,3)+nat+str(ktlp,9)+str(ppt)+str(ktl) tag t1
  index on STR(kg,3)+str(vesp,12,3) tag t2
  set orde to tag t1

  sele PRs2
  go top
  PRs2->(Create_PRs2Grp())

  sele PRs2
  go top

if gnVo=9.or.gnVo=2.or.gnVo=1.or.gnVo=3.or.gnVo=10  // ���㯠⥫�,��������
   if p1#3
      if Who=1
        vzz=1
      else
        if (gnRasc=2.or.gnRasc=1.and.mk169r#0.and.pr169r#2).and.who=5.and.gnArm=25
          vzz=1
        else
          Vzz=2
        endif
      endif
      If (who=3.or.who=4)
        aPrn={' ��� ','���-䠪���','���','1��','XXX'}
        If ChkPrn11tn(.f.)
          aPrn[1]:=RTrim(aPrn[1])+'+���  '
          aPrn[4]:='*'+RTrim(aPrn[4])
        EndIf
        vzz=alert('��� ���㬥��',aPrn)
        If vzz=4
          lPrn11tn:=.T.
        EndIf
        If vzz#2 //���-䠪��� ���塞 ��������
          PRs2->(UpdateNat())
          PRs2m->(UpdateNat())
        EndIf


      endif
   else
      vzz=1
   endif
   if gnEnt=21.and.(vzz=1.or.vzz=3).and.gnRasc#0.and.gnVo=9
      if empty(getfield('t1','ktar','s_tag','idlod'))
         wmess('��� ���� SalesWork ��� ����� '+str(ktar,4))
         retu
      endif
   endif
   if (vzz=1.or.vzz=3).and.pvtr=0.and.mrshr=0.and.p1#3
      amrsh={'���','��'}
      amrshr=alert('��� �������!�த������?',amrsh)
      if lastkey()=K_ESC.or.amrshr=1
         if select('rsprn')#0
            sele rsprn
            use
         endif
         retu
      endif
   endif
   if mrshr#0.and.pvtr=0
      mrshnppr=getfield('t1','mrshr,entr,skr,ttnr','czg','npp')
   else
      mrshnppr=0
   endif
 // **��������**************
 //   if vzz=1.and.empty(dopr).and.gnEnt=20
 //      apcenr=1
 //      r s2prc(1)
 //      pere(3)
 //   endif
 // ***********************
   rsw_r=42
   prosfor=0

   prprn6r=0
   do case
      case vzz=1.or.vzz=3
           n11='����⪮�� �������� N '
           sele rs2
           if netseek('t3','ttnr')
              do while ttn=ttnr
                 if int(ktl/1000000)=350.or.;
                    int(ktl/1000000)=343.or.;
                    int(ktl/1000000)=338.or.;
                    int(ktl/1000000)=344.or.;
                    int(ktl/1000000)=346.or.;
                    int(ktl/1000000)=348.or.;
                    int(ktl/1000000)=345.or.;
                    int(ktl/1000000)=339.or.;
                    int(ktl/1000000)=342
                    prassor=1
                    exit
                  endif
                 skip
              enddo
           endif
           sele rs2
           if netseek('t3','ttnr')
              do while ttn=ttnr
                 mntovr=mntov
                 if ctovr=1
                    mkeepr=getfield('t1','mntovr','ctov','mkeep')
                 else
                    mkeepr=0
                 endif
                 if mkeepr=25
                    prprn6r=1
                    exit
                  endif
                 skip
              enddo
           endif
      case Vzz=2
           if !(kopr=129.or.kopr=139)
              if !dog(kplr).and.gnVo=9
                 wmess('�஡���� � ������஬',1)
                 retu
              endif
           endif
           if gnVo=9.and.!kgprm(kpvr)
              wmess('��㧮�����⥫� �� �⮣� ॣ����',1)
              retu
           endif
           n11='                 ���-䠪��� N '
           sele rs2
           if netseek('t3','ttnr')
              foot('Space,ENTER,ESC','�⡮�,�����,�⬥��')
              aOt:={}
              kolospr=0
              do while ttn=ttnr
                 ktlr=ktl
                 ktlpr=ktlp
                 pptr=ppt
                 mntovr=mntov
                 if pptr=0
                    sele tov
                    oldtr:=ordsetfocus("T1")
                    if netseek('t1','sklr,ktlr')
                       otr=ot
                       if otr=0.and.int(ktlr/1000000)>1
                          otr=getfield('t1','int(ktlr/1000000)','sgrp','ot')
                          if otr#0
                             netrepl('ot','otr')
                          endif
                       endif
                       if ascan(aOt,str(otr,2))=0
                          aadd(aOt,str(otr,2))
                          kolospr=kolospr+1
                       endif
                    endif
                    ordsetfocus(oldtr)
                 endif
                 sele rs2
                 skip
              enddo
              sele rs1
              if fieldpos('kolosp')#0
                 netrepl('kolosp,kolpsp','kolospr,0',1)
              endif
              for i=1 to len(aOt)
                  otr=val(aOt[i])
                  sele cskle
                  if netseek('t1','skr,otr')
                     aOt[i]=aOt[i]+'�'+subs(nai,1,11)+'��'
                  else
                     aOt[i]=aOt[i]+'�'+space(11)+'��'
                  endif
              next
              asort(aOt)
              if atrcr=0
                 clwot=setcolor('gr+/b')
                 wot=wopen(9,29,15,46)
                 wbox(1)
                 setcolor('n/w,n/bg')
                 nn=achoice(0,0,3,15,aOt,,'faOt')
                 if lastkey()=K_ESC
                     wclose(wot)
                     setcolor(clwot)
                     retu
                 endi
                 wclose(wot)
                 setcolor(clwot)
              else
                 nn=0
              endif
           else
              wmess('��� ⮢��',2)
              retu
           endif
      case vzz=5
           n11=''
   endcase
endif
if gnVo=6.or.gnVo=8  // ��ॡ�᪠
  if Who = 1
    Vzz = 1
  else
    Vzz = 2
  endif
  rsw_r=42
  If Who = 3.or.who=4
    aPrn={' ��� ','���-䠪���','��᪫����','1��','XXX'}
    If ChkPrn11tn(.f.)
       aPrn[1]:=RTrim(aPrn[1])+'+���  '
       aPrn[4]:='*'+RTrim(aPrn[4])
    EndIf
    vzz=alert('��� ���㬥��',aPrn)
    If vzz=4
      lPrn11tn:=.T.
    EndIf

  endif
endif
   rsw_r=42

if empty(dopr).and.(vzz=1.or.vzz=3)
   prosfor=1   // �ਧ��� ���४樨 OSFO
endif

if gnAdm=0.and.atrcr=0 //who#5
   if p1=2.and.vzz=2.and.!EMPTY(dspr).and.gnCenR=0
      wmess('���-�����.�����쭠� ����� F5!')
      retu
   endif
endif
if (vzz=1.or.vzz=3).and.who#0.and.p1#3.and.gnArm#25
   @ 23,0 clea
   @ 23,1 say '��ᯥ����:'
   sele s_tag
   set order to tag t2
   go top
   @ 23,12 get kecsr pict '9999'
   read
   if kecsr=0
      foot('INS','�������� ������')
      do while lastkey()<>27
         sele s_tag
         set orde to tag t2
         kecsr=slcf('s_tag',,,10,,"e:kod h:'���' c:n(4)e:fio h:'  �.  �.  �. ' c:c(30)",'kod')
         rcn_ecs=recno()
         do case
            case lastkey()=K_INS
                 tagins(0)
                 kecsr=kod
            case lastkey()>32.and.lastkey()<255
            //case lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
                 lstkr=upper(chr(lastkey()))
                  netseek('t3','lstkr')
            case lastkey()=K_ENTER
                  exit
         endcase
      enddo
   endif
   if !netseek('t1','kecsr','s_tag')
      wmess('��������� ��ᯥ���� � ����� '+str(kecsr,4)+'  � s_tag.dbf',3)
      sele s_tag
      go top
      kecsr=SLCf('s_tag',,,10,,"e:kod h:'���' c:n(4) e:fio h:'  �.  �.  �. ' c:c(30)",'kod')
   endif
   @ 23,18 say getfield('t1','kecsr','s_tag','fio')
   if gnArnd=0
      @ 23,col()+1 say '����� ���' get AtNomr
      read
   else
      sele rs1
      if fieldpos('katran')#0
         @ 23,40 say '��⮬�����' get katranr
         read
         if lastkey()=K_ENTER
            if katranr#0
               if !netseek('t1','katranr','kln')
                  katranr=0
               endif
            endif
            if katranr=0
               netuse('kln','avto')
               set filt to kkl>=2000.and.kkl<3000
               go top
               if gnEnt=21
                  rckatranr=slcf('avto',,,10,,"e:kkl h:'���' c:n(4) e:nkl h:'     �����     ' c:c(15) e:adr h:'  ����⥫�    ' c:c(15) e:getfield('t1','avto->kklp','kln','nkl') h:'��ॢ��稪' c:c(30)",,,,,'avto->tabno=21',,'��⮬�����')
               else
                  rckatranr=slcf('avto',,,10,,"e:kkl h:'���' c:n(4) e:nkl h:'     �����     ' c:c(15) e:adr h:'  ����⥫�    ' c:c(15) e:getfield('t1','avto->kklp','kln','nkl') h:'��ॢ��稪' c:c(30)",,,,,'avto->tabno=20',,'��⮬�����')
               endif
               go rckatranr
               katranr=kkl
               AtNomr=alltrim(nkl)
               nuse('auto')
               if katranr#0
                  sele rs1
                  netrepl('AtNom','AtNomr',1)
                  if fieldpos('katran')#0
                     netrepl('katran','katranr',1)
                  endif
               endif
            endif
         endif
         @ 23,40 say '��⮬�����'+' '+AtNomr
      else
         @ 23,col()+1 say '����� ���' get AtNomr
         read
      endif
   endif
   necsr=getfield('t1','kecsr','s_tag','fio')
   @23,12 say str(kecsr,4)+'  '+alltrim(necsr)
endif
if vzz#4.and.atrcr=0.and.p1#3.and.gnArm#25 //who#5
   @ 24,0 clea
   @ 24,1 say '= ' GET textr
   read
   if lastkey()=K_ESC
      retu
   endif
   sele rs1
   if netseek('t1','ttnr',,,1)
      netrepl('text,kecs','textr,kecsr',1)
      if fieldpos('AtNom')#0
         netrepl('AtNom','AtNomr',1)
      endif
   endif
endif
if gnVo=5.and.prlkr=0   // ��� �� ᯨᠭ��
   save scre to scmess
   clea

   @ 1,1 say '�����祭�� ���i��i�:'
   @ 3,1 get zak1r
   @ 4,1 get zak2r
   @ 5,1 get zak3r

   @ 7,1 say '����� ���i��i�:'
   @ 9,1 get kom1r
   @ 10,1 get kom2r
   @ 11,1 get kom3r

   read

   rest scre from scmess
endif


@ 24,0 clea

ccp=1
do while .t.
   if atrcr=0.and.gnArm#25 //who#5
      @ 24,5  prompt' �������� txt.txt'
      @ 24,25 prompt'     ������      '
      menu to ccp
   else
      ccp=2
   endif
   if lastkey()=K_ESC
      set devi to scre
      exit
   endif
   @ 24,0 clea
   if who#0.and. Przr = 0.and.vzz#4
      Sele rs1
      sdvr=sdv
      sele nds
      if netseek('t2','kplr,0,skr,ttnr')
         netrepl('sum','sdvr')
      endif
      sele rs1
      if empty(dot).and.(vzz=1.or.vzz=3).and.ccp=2.and.p1#3
         if bom(gdTd)=bom(date())
            dotr=date()
         else
            dotr=dvpr
         endif
         if gnEnt=20
            if gnEntrm=0.or.gnVo#9
               @ 24,5 say '������ ���� ���㧪�' get dotr RANGE dvpr,eom(ADDMONTH(gdTd,1))
               read
               @ 24,0 clea
               if lastkey()=K_ESC
                  set devi to scre
                  exit
               endif
            else
               @ 24,5 say '������ ���� ���㧪�' get dotr RANGE date(),date()+1
               read
               @ 24,0 clea
               if lastkey()=K_ESC
                  set devi to scre
                  exit
               endif
            endif
         else
            @ 24,5 say '������ ���� ���㧪�' get dotr RANGE dvpr,eom(ADDMONTH(gdTd,1))
            read
            @ 24,0 clea
            if lastkey()=K_ESC
               set devi to scre
               exit
            endif
         endif
         // ���� ���㧪� ����� -> ࠧ�訬 ����� ���
         // (�஢�ઠ �� ����� ���� ��� ������?)
         lPrn11tn:=.T.

         if przp=0
            rso(7)
            przp=1
         endif
         totr=time()
         topr=time()
         netrepl('DOT,DOP,tot,top','dotr,dotr,totr,topr',1)
         dopr=dotr
         if fieldpos('DtOpl')#0
            if minkdOplr#0
               kdOplr=minkdOplr
            else
               kdOplr=0
               sele klndog
               if fieldpos('kdOpl')#0
                  if netseek('t1','nkklr')
                     kdOplr=kdOpl
                  endif
               endif
            endif
            DtOplr=dopr+kdOplr
         endif
         sele rs1
         if fieldpos('dtot')#0
            if empty(dtot)
               netrepl('dtOT,tmot','dopr,topr',1)
               SendEdiDesadv()
            endif
         endif
         if fieldpos('DtOpl')#0
            if !empty(DtOplr)
               netrepl('DtOpl','DtOplr',1)
            endif
         endif
         if fieldpos('dtots')#0
            if empty(dtots)
               netrepl('dtots','date()',1)
            endif
         endif
         #ifdef __CLIP__
         //lev!!
         //��⮬���᪨ ���⢥ত���� ������ ��� �� ᪫��
         if fieldpos('dvttn')#0
            IF !EMPTY(rs1->dvttn) //㤠�塞 ����� �����⨪� �.�. ����� ���������� �㬬� ���㬥�
            /*
*              IF !EMPTY(rs1->(FIELDPOS("dgdTd"))) .AND. BOM(rs1->dgdTd)=BOM(gdTd)
*                //�� ���⮥ ��� ��ਮ��, � ���஬� �⭮���� ���㬥�� �
*                //��ਮ�� ᮢ������ �� ��砫� �����
*                RProv({|| dokk->lev == 1  }, 2)//㤠���� �஢����
*              ELSE
*                //������㥬 㤠����� �஢����
*                RProv({|i| soper->(FIELDGET(FIELDPOS("lev"+LTRIM(STR(i,2))))) == 1  }, 1, .F.)//㤠���� �஢����
*              ENDIF
*/
            ENDIF
            /*
*            //�������� �஢����
*            RProv({|i| soper->(FIELDGET(FIELDPOS("lev"+LTRIM(STR(i,2))))) == 1  }, 1)//�������� �஢����
*/
            if empty(dvttn)
              netrepl('dvttn,tvttn,ktovttn','date(),time(),gnKto',1)
              prModr=1
            endif
         endif
         //end lev!
         #endif
      endif
      sele rs1
      dotr=dot
      totr=tot
      if empty(dop).and.(vzz=1.or.vzz=3).and.ccp=2.and.p1#3
         netrepl('DOP','dotr',1)
         netrepl('tOp','totr',1)
      endif
      dopr=dop
      topr=top
      sele czg
      if !empty(dopr).and.p1#3
         if netseek('t3','entr,skr,ttnr')
            netrepl('dop,top','dopr,topr')
         endif
      endif
   endif
   aPrnr=1
*****************************************************
   If !(who=2.or.who=5).and.bsor#0.and.(vzz=1.or.vzz=3).and.kopr#168.and.gnArm#25 //.and.gnEnt=21
      aPrnr=1
      if !(p1=3.or.p1=4)
         aPrn={'���','��� �����','��� 1-��'}
         aPrnr=alert('��� ���㬥��',aPrn)
      endif
   endif
*****************************************************
   do case
      case aPrnr = 2.or.aPrnr = 3 // ����� ��ண�� ���⭮��
           if aPrnr = 2
              clbsor=setcolor('gr+/b,n/bg')
              wbso=wopen(10,20,14,40)
              wbox(1)
              @ 0,1 say '���� ' get bsosr
              @ 1,1 say '����� ' get bsonr pict '999999'
              read
              if lastkey()=K_ESC.or.empty(bsosr).or.bsonr=0
                 wclose(wbso)
                 setcolor(clbsor)
                 exit
              endif
              wclose(wbso)
              setcolor(clbsor)
           else
            //
           endif
           bsosr=alltrim(upper(bsosr))
           sele rs1
           if netseek('t1','ttnr',,,1)
              netrepl('bsos,bson','bsosr,bsonr',1)
           endif
//           if gnAdm=0
//             sttn_create()
//              sttn_add()
//          endif
           for i=1 to bsor
               if i=1
                  vbr=1
                  kEkzr=4
                  clbor=setcolor('gr+/b,n/bg')
                  wbor=wopen(15,20,19,60)
                  wbox(1)
                  @ 0,1 say '����� 1-�� ������'
                  @ 1,1 say '������⢮ �' get kEkzr pict '9' range 1,4

                  @ 2,1 prom '���'
                  @ 2,col()+1 prom '��'
                  read
                  if lastkey()=K_ESC
                     vbr=1
                  else
                     menu to vbr
                     if lastkey()=K_ESC
                        vbr=1
                     endif
                  endif
                  wclose(wbor)
                  setcolor(clbor)
                  if vbr=2

                    /// �뢮�� � 䠩� ///
                    cTempPrn:="bso.txt"
                    set cons off
                    set prin to (cTempPrn)
                    set prin on
                    if aPrnr = 2
                      BsoLod() // bso1.prg
                    else
                      Bso1tn() // bso1.prg
                    endif
                    set prin off
                    set prin to
                    set cons on
                    //////////// ����� //////



                    ////// �뢮� �� ������ ////
                    set cons off
                    set prin on
                    if gnOut=1
                       if gnAdm=1
                          set prin to lpt1
                       else
                          set prin to lpt4
                       endif
                    else
                       set prin to bso2prn.txt
                       kEkzr:=1
                    endif

                    for j=1 to kEkzr
                      //COPY FILE (cTempPrn) TO prn
                      //TYPE (cTempPrn) TO PRINTER
                      PrnFToken(cTempPrn)
                    next
                    set prin off
                    set prin to
                    set cons on
                    //////////////// ����� �뢮�� ///

                  endif
               else
                  vbr=1
                  vbr=1
                  kEkzr=4
                  clbor=setcolor('gr+/b,n/bg')
                  wbor=wopen(15,20,19,60)
                  wbox(1)
                  @ 0,1 say '����� '+str(i,1)+'-�� ������'
                  @ 1,1 say '������⢮ �' get kEkzr pict '9' range 1,4
                  @ 2,1 prom '���'
                  @ 2,col()+1 prom '��'
                  read
                  if lastkey()=K_ESC
                     vbr=1
                  else
                     menu to vbr
                     if lastkey()=K_ESC
                        vbr=1
                     endif
                  endif
                  wclose(wbor)
                  setcolor(clbor)
                  if vbr=2
                     set cons off
                     if gnOut=1
                        set prin to lpt1
                     else
                        set prin to ('bso'+str(i,1)+'.txt')
                        kEkzr:=1
                     endif
                     set prin on

                     for j=1 to kEkzr
                        if aPrnr = 2
                          bsolod() // bso1.prg
                        else
                          bso1tn() // bso1.prg
                        endif
                     next

                     set prin off
                     set prin to
                     set cons on
                  endif
               endif
           next
           sele rs1
           netrepl('krbso','gnKto',1)
           //           bso1()
           //           bso2()
           exit
      case aPrnr = 1 // ���筨� ���㬥��
           set devi to scre
           if kopr=154 ;
            .or. iif(gnEnt=21,(kopr=160 .and. pstr=1),.f.)
              clbsor=setcolor('gr+/b,n/bg')
              wbso=wopen(10,10,15,70)
              wbox(1)
              store space(30) to prvzr,avtor,vodr
              do while .t.
                @ 0,1 say '��ॢi���� ' get prvzr
                @ 1,1 say '��⮬��i�� ' get avtor
                @ 2,1 say '���i�      ' get vodr
                read
                if lastkey()=K_ESC.or.lastkey()=K_ENTER
                  exit
                endif
              enddo
              wclose(wbso)
              setcolor(clbsor)
           endif
           if atrcr=0 //who#5
              @ 24,11 say '����� �������� ������'
           endif
           if vzz=2.and.p1#3
              rfinskl(1)
           endif
           if p1=3
              ccp=2
           endif
           If ccp = 1
              Set Prin To txt.TXT
           else
              set prin to
              if gnOut=1.or.(gnOut=2.and.gnAdm=1)
                 if p1=1 // �����쭠� �����
                    if gnEnt=21
                       set prin to lpt2
                    else
                       set prin to lpt1
                    endif
                    kk=1
                 endif    // ��⥢�� �����
                 if p1=2.or.p1=3.or.p1=4  //.and.(vzz=2.or.vzz=1.or.vzz=3)
                    if vzz=2.or.((vzz=1.or.vzz=3).and.(gnRasc=2.or.gnRasc=1.and.mk169r#0.and.pr169r#2).and.gnArm=25)
                       @ 24,0 say '������ �� ������� �������        '
                       if pvtr=0 // ����஧����
                          do case
 //                            case atrcr=0
 //                                  vlpt1='lpt1'
                             case atrcr=1
                                  vlpt1='lpt3'
                             case atrcr=2
                                  vlpt1='lpt2'
                          endcase
                       else      // �����뢮�
                          vlpt1='lpt3'
                       endif
                    else
                       alpt={'lpt1','lpt2'}
                       vlpt=alert('������ �� ������� �������',alpt)
                       if vlpt=1
                          vlpt1='lpt2'
                       else
                          vlpt1='lpt3'
                       endif
 //                       vlpt1='lpt'+str(vlpt,1)
                    endif
                    IF (vzz=1.or.vzz=3).and.kopr#168
                       if (gnRasc=2.or.gnRasc=1.and.mk169r#0.and.pr169r#2).and.who=5.and.gnArm=25
                          kk:=3
                       else
                          kk:=4
                          IF kopr=161 .AND. kplr=2050040 .OR. ;
                             kopr=169 .AND. kplr=20034
                             kk:=4
                          ENDIF
                       endif
                    ELSE
                       if gnEnt=20
                          kk:=IIF(gnRmsk=0,2,1)
                       else
                          kk:=1
                       endif
                       //������ ��ଫ���� ���㬥⮢
                       //rs3->(netseek('t1', 'ttnr'))
                       //rs3->(__dbLocate({||rs3->Ksz=46 },{||rs3->ttn = ttnr}))
                       //IF rs3->(FOUND()) .AND. round(rs3->ssf+rs3->bssf,0)#0
                       if kpvr=0
                          if kgpr=0
                             kkl_r=kplr
                          else
                             kkl_r=kgpr
                          endif
                       else
                          kkl_r=kpvr
                       endif
                       knaspr=getfield('t1','kkl_r','kln','knasp')
                       IF getfield("t1","ttnr,46","rs3","ssf")#0.and.knaspr#1701 //.or.pvtr=1
                         if gnEnt#21  // ���졠 �����
                            kk:=3
                         endif
                       ENDIF
                       if !empty(p2) // �-�� �
                          kk=p2
                       endif
                    ENDIF
                    kkr=1 // ���稪 ������஢
                    psp=2 // �ਧ��� �⥢�� ���� ��� ���� 蠯��
                    #ifdef KK_GET
                       if atrcr=0 //who#5
                          @ 24,36 say '������⢮  �.'
                          @ 24,52 get kk pict '9' valid kk < 5
                          read
                       endif
                    #else
                      sele RsPrn
                      DO WHILE .T.
                        rcName=slcf('RsPrn',,,4,,"e:Name h:'��� ����?' c:�(15)",,1, , , ,"W+/RB+,N/W")
                        RsPrn->(DBGOTOP())
                        DO CASE
                        CASE LASTKEY()=K_ENTER .OR. LASTKEY()=K_ESC
                          EXIT
                        ENDCASE
                      enddo
                   #endif
                    // *                    set prin to lpt2
                    set prin to (vlpt1) //txt.TXT  //
                 endif
              else
                 Set Prin To txt.TXT
              endif
           EndIF
           ffff=val(subs(vlpt1,4,1))
           rrrr=0
           set prin on
           set cons off
           if p1=1.and.ccp=2 // �����쭠� �����
              if gnEnt=21
                 alptl={'lpt2','lpt3'}
                 vlptlr=alert('������',alptl)
                 if vlptlr=1
                    clptlr='lpt2'
                 else
                    clptlr='lpt3'
                 endif
              else
                 alptl={'lpt1','lpt2'}
                 vlptlr=alert('������',alptl)
                 if vlptlr=1
                    clptlr='lpt1'
                 else
                    clptlr='lpt2'
                 endif
              endif
              if gnOut=1
                 set prin to (clptlr)
              else
                 set prin to txt.txt
              endif
              if clptlr='lpt1'
                 if empty(gcPrn)
                    ??chr(27)+chr(80)+chr(15)
                    setprnr=chr(27)+chr(80)+chr(15)
                 else
                    ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
                     setprnr=chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
                    IF (vzz=1.or.vzz=3).and.kopr#168
                       kk=4
                       IF kopr=161 .AND. kplr=2050040 .OR. ;
                          kopr=169 .AND. kplr=20034
                          kk:=4
                       ENDIF
                    ELSE
                       if gnEnt=20
                          kk:=IIF(gnRmsk=0,2,1)
                          kk=2
                       else
                          kk=1
                       endif
                       knaspr=getfield('t1','nKklr','kln','knasp')
                       IF getfield("t1","ttnr,46","rs3","ssf")#0.and.knaspr#1701
                          kk:=3
                       ENDIF
                       if !empty(p2) // �-�� �
                          kk=p2
                       endif
                    ENDIF
                    kkr=1 // ���稪 ������஢
                    psp=2 // �ਧ��� �⥢�� ���� ��� ���� 蠯��
                    if atrcr=0 //who#5
                       @ 24,36 say '������⢮  �.'
                       @ 24,52 get kk pict '9' valid kk < 5
                       read
                    endif
                 endif
              else // clptlr='lpt2'.or.clptlr='lpt3'
                 ??chr(27)+'E'+chr(27)+'&l1h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
                 setprnr=chr(27)+'E'+chr(27)+'&l1h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
                 IF (vzz=1.or.vzz=3).and.kopr#168
                    kk=4
                    IF kopr=161 .AND. kplr=2050040 .OR. ;
                       kopr=169 .AND. kplr=20034
                       kk:=4
                    ENDIF
                 ELSE
                    if gnEnt=20
                      kk:=IIF(gnRmsk=0,2,1)
                    else
                      kk=1
                    endif
                    knaspr=getfield('t1','nKklr','kln','knasp')
                    IF getfield("t1","ttnr,46","rs3","ssf")#0.and.knaspr#1701
                       kk:=3
                    ENDIF
                    if !empty(p2) // �-�� �
                       kk=p2
                    endif
                 ENDIF
                 kkr=1 // ���稪 ������஢
                 psp=2 // �ਧ��� �⥢�� ���� ��� ���� 蠯��
                 if atrcr=0 //who#5
                    @ 24,36 say '������⢮  �.'
                    @ 24,52 get kk pict '9' valid kk < 5
                    read
                 endif
              endif
           endif
           if gnAdm=1.and.gnOut=2
              set prin to txt.txt
           endif
           if (p1=2.or.p1=3.or.p1=4).and.ccp=2
 //              if vzz#3
                 ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
                 setprnr=chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
 //              else
 //                 ??chr(27)+'E'+chr(27)+'&l1h26a0O'+chr(27)+'&k2S'+chr(27)+'&a20l'+chr(27)+'(3R'+chr(27)+'(s0p17.00h0s1b4102T'+chr(27)
 //                 setprnr=chr(27)+'E'+chr(27)+'&l1h26a0O'+chr(27)+'&k2S'+chr(27)+'&a20l'+chr(27)+'(3R'+chr(27)+'(s0p17.00h0s1b4102T'+chr(27)
 //              endif
           endif
                 //           if (vzz=1.or.vzz=4).or.!(gnVo=9.or.gnVo=2.or.gnVo=1.or.gnVo=3).or.vzz=3 // ���
           if (vzz=1.or.vzz=4.or.vzz=3).or.!(gnVo=9.or.gnVo=2.or.gnVo=1.or.gnVo=3) // ���
                 //              if gnEnt=21.and.kopir=177.and.vzz#5
                 //                 avcen={'����=0','����#0'}
                 //                 vvcenr=alert('��� ����',avcen)
                 //              endif
              #ifdef KK_GET
                do while kkr<=kk
              #else
                sl->(DBGOTOP())
                DO WHILE  sl->(!EOF())
                  kkr:=VAL(sl->Kod)
              #endif
                 itogr=1
                 if p1=1
                    if kkr=1.and.kopr#168
                       kolpr=1
                       sele kln
                       if netseek('t1','kplr')
                          if gnEnt=21
                             if kopr=160.or.kopr=161
                                kolpr=2
                             else
                                if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv) // chr ���.���
                                   kolpr=2
                                endif
                             endif
                          else
                             if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv) // chr ���.���
                                kolpr=2
                             endif
                          endif
                       endif
                       if vzz=4
                          kolpr=kk
                       endif
                       #ifndef __CLIP__
                          kolpr=1
                       #endif
                       if vzz#3
                          if p1#4
                             if rs1->bso=0.or.rs1->kop=169
                                for iii=1 to kolpr
                                    if !empty(dopr) .and. dopr<ctod('14.01.2014')
                                      prn1tn()
                                    else
                                      prn11tn()
                                    endif
                                next iii
                                lPrn11tn:=.F.
                             else
                               if gnEnt=21.and.vzz=4
                                 if !empty(dopr) .and. dopr<ctod('14.01.2014')
                                   prn1tn()
                                 else
                                   prn11tn()
                                 endif
                                 lPrn11tn:=.F.
                               endif
                             endif
                          endif
                       endif
                    endif
                    if gnEnt=21.and.kkr=1.and.vzz#4
                       if (kopr=160.or.kopr=154)
                           // ����� �த ��� �������
                          if select('kps')#0
                             ndogtr=getfield('t1','kplr','kps','ndogt')
                             if !empty(ndogtr)
                                prntrl()
                             endif
                          endif
                          if kopr=154
                             prnlvz()
                          endif
                       endif
                       if getfield('t1','nkklr','kpl','prskpd')#0.and.vzz=1.and.kopr#170
                        If prUpr()=0
                          PrnPrc()
                        EndIf
                       endif
                    endif
                    if p1#3.and.vzz#4
                       if gnKto#331
                          PrnDoc()
                       endif
                    endif
                    if vzz#3.and.gnAdm=0
                       exit
                    endif
                 else
                    if kkr=1.and.kopr#168
                       kolpr=1
                       sele kln
                       if netseek('t1','kplr')
                          if gnEnt=21
                             if kopr=160.or.kopr=161
                                kolpr=2
                             else
                                if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv) // chr ���.���
                                   kolpr=2
                                endif
                             endif
                          else
                             if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv)  // chr ���.���
                                kolpr=2
                             endif
                          endif
                       endif
                       if vzz=4
                          kolpr=kk
                       endif
                       #ifndef __CLIP__
                          kolpr=1
                       #endif
                       if vzz#3
                          if p1#4
                             if rs1->bso=0.or.rs1->kop=169
                                for iii=1 to kolpr
                                    if !empty(dopr) .and. dopr<ctod('14.01.2014')
                                       prn1tn()
                                    else
                                       prn11tn()
                                    endif
                                next iii
                                lPrn11tn:=.F.
                             endif
                          else
                             if gnEnt=21.and.vzz=4
                                if !empty(dopr) .and. dopr<ctod('14.01.2014')
                                   prn1tn()
                                else
                                   prn11tn()
                                endif
                                lPrn11tn:=.F.
                             endif
                          endif
                       endif
                    endif
                    if gnEnt=21.and.kkr=1.and.vzz#4

                       if (kopr=160.or.kopr=154)
                           // ����� �த ��� �������
                          if select('kps')#0
                             ndogtr=getfield('t1','kplr','kps','ndogt')
                             if !empty(ndogtr)
                                prntrl()
                             endif
                          endif
                          if kopr=154
                             prnlvz()
                          endif
                       endif
                       if getfield('t1','nkklr','kpl','prskpd')#0.and.vzz=1.and.kopr#170
                        If prUpr()=0
                          PrnPrc()
                        EndIf
                       endif
                    endif
                    if p1#3.and.vzz#4
                       if gnKto#331
                          PrnDoc()
                       endif
                    endif
                 endif
              #ifdef KK_GET
                 kkr=kkr+1
              #else
                  ***************************************************
                  //                 IF p1=1 //�����쭠� �����
                  //                   EXIT
                   //                 ENDIF
                 ***************************************************
                 sl->(DBSKIP())
              #endif
              enddo
              if pprr=0
                 pprr=1
                 sele rs1
                 netrepl('ppr','pprr',1)
              endif
              if vor=9
                 pkpltara(nkklr)
              endif
              if gnEnt=20.and.gnRasc=2.and.gnArm=25.and.(who=5.or.gnAdm=1)
                  // ���⢥ত���� nof ���㬥��
                 nofprz()
              endif
              if gnEnt=20.and.gnRasc=1.and.mk169r#0.and.pr169r#2.and.gnArm=25.and.(who=5.or.gnAdm=1)
                  // ���㧪� nof ���㬥��
                 nofprz(1)
              endif
           else     // ���-䠪���
             if gnEntRm=0
               If type('aOt')='A'
                 kkk=len(aOt)
                 otkr=val(subs(aOt[kkk],1,2))
                 for ii_r=1 to kkk //len(aOt)
                    if subs(aOt[ii_r],16,1)='�'
                      otr=val(subs(aOt[ii_r],1,2))
                      notr=subs(aOt[ii_r],4,11)
                      if ii_r#kkk
                        itogr=0
                      else
                        itogr=1
                      endif
                      // ********************************************************
                      do while kkr<=kk
                        if kkr=1
                          kolpr=1
                          sele kln
                          if netseek('t1','kplr')
                            if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv) // chr ���.���
                              kolpr=2
                            endif
                          endif
                          if vzz=4
                            kolpr=kk
                          endif
                          if vzz#3
                            if p1#4.or.gnEnt=21
                              for iii=1 to kolpr
                                  if !empty(dopr) .and. dopr<ctod('14.01.2014')
                                    prn1tn()
                                  else
                                    prn11tn()
                                  endif
                              next iii
                              lPrn11tn:=.F.
                            endif
                          endif
                          if gnEnt=21.and.kopr=154
                            prnlvz()
                          endif
                        endif
                        if p1#3
                          if gnKto#331
                            PrnDoc()
                          endif
                        endif
                        kkr=kkr+1
                      enddo
// **********************************************************
                      kkr=1
                    endif
                     kkr=1
                  next
                else
                  wmess('��祣� �� ��࠭� aOt!',2)
                EndIf
              else // gnEntrm=1
                 otr=0
                 otkr=0
 //                 itogr=0
                 itogr=1
                 do while kkr<=kk
                    if kkr=1.and.kopr#168
                       kolpr=1
                       sele kln
                       if netseek('t1','kplr')
                          if nn#0 .or. !EMPTY(cnn) //.and.!empty(nsv) // chr ���.���
                             kolpr=2
                          endif
                       endif
                       if vzz=4
                          kolpr=kk
                       endif
                       if vzz#3
                          if p1#4.or.gnEnt=21
                             for iii=1 to kolpr
                                 if !empty(dopr) .and. dopr<ctod('14.01.2014')
                                    prn1tn()
                                 else
                                    prn11tn()
                                 endif
                             next iii
                             lPrn11tn:=.F.
                          endif
                       endif
                    endif
                    if kkr=1.and.gnEnt=21.and.kopr=154
                       prnlvz()
                    endif
                    if p1#3
                       if gnKto#331
                          PrnDoc()
                       endif
                       kkr=kkr+1
                    endif
                 enddo
              endif
           endif

           IF lSeekError
              #ifdef __CLIP__
                ALERT("�訡�� �ନ஢���� ���㬥��;"+;
                      "������ ����� ��� "+STR(Ttnr);
                     )
                setenv("CLIP_PRINT_PROG","/dev/null")
                outlog(__FILE__,__LINE__,"lSeekError PrintDoc", DATE(), TIME(), Ttnr)
              #endif
              QUIT
           ENDIF

           set prin off
           set prin to

           if vzz=2.and.ccp=2
              sele rs1
              if ppsf=9
                 netrepl('ppsf','1',1)
              endif
              if !empty(dfp)
                 netrepl('ppsf,dsp,tsp,ktosp','ppsf+1,date(),time(),gnKto',1)
              else
                 netrepl('ppsf','ppsf+1',1)
              endif
              ppsfr=ppsf
              if p1=2.and.atrcr=0
                 rso(11)
              endif
              sele rs1
           endif
           set devi to scre
           @ 24,0 clea
           exit
   endcase
enddo
#ifndef KK_GET
  CLOSE RsPrn
#endif
if select('PRs2')#0
   sele PRs2
   use
   erase PRs2.dbf
   erase PRs2.cdx
   sele PRs2grp
   use
endif
if select('PRs2m')#0
   sele PRs2m
   use
//   erase PRs2m.dbf
//  erase PRs2m.cdx
endif

/*****************************************************************
 
 PROCEDURE: PrnDoc
 �����..����........
 ����������.........  �����
 ���������..........
 ����������.........
 */
PROCEDURE PrnDoc()
  LOCAL nPre_kolpos_r:=kolpos_r  // save ��� ����権
  LOCAL l_prUpr
  s90ndsr=0

  prUpr=0 // �ਧ��� �१���� ����
  prUpr:=prUpr(prUpr)

  if prUpr=0.or.vzz=2
    ??setprnr
  else
     if kkr=1.and.prUpr=1.and.vzz=1
       if kopr=129.or.kopr=139
          ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p15.00h1s1b4102T'+chr(27)
          ?' �������� ����� '+str(kopr,3)+" "+allt(NOpr)
       else
          ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h1s1b4102T'+chr(27)
       endif
     else
        ??setprnr
        if kkr>1.and.prUpr=1.and.vzz=1
           if kopr=129.or.kopr=139
              ?' �������� ����� '+str(kopr,3)+" "+allt(NOpr)
           endif
        endif
     endif
  endif
  lnn=48
  lstr=1
  rswr=1
  if p1=1.and.atrcr=0 // �����쭠� ����� 1 �
    wmess(notr+' ��⠢� ���� � ������ �஡��',0)
  endif
  do case
  case vzz=5
    rsnsh()
  OtherWise
    if vzz=1.or.vzz=3
      if kopr#168

        l_prUpr:=l_prUpr(prUpr,kopr,kkr) //prUpr=0

        if l_prUpr=0 .or.vzz=2
          RsSh()
        else // ����� ��祭��� ���
          if kkr>1.and.vzz=1
            // ?str(skr,3)+' '+str(ttnr,6)+dtos(dopr) 03-05-18 11:11am
            ? LEFT(NTOC(skr,16),3)
            ?? ' ' + LEFT(NTOC(VAL(LEFT(str(ttnr,6),3)),16),3)
            ?? ' ' + Right(str(ttnr,6),3)
            ?? dtos(dopr)
            if !(rs1->prz=0)
              ??' �����'
            endif

              // �������� �窨 � ���� �ਬ�砭��
              if rs1->kpv#0
                  ?getfield('t1','rs1->kpv','kln','nkl')
                  ?RTRIM(getfield('t1','rs1->kpv','kln','adr'))
              else
                  ?getfield('t1','rs1->kgp','kln','nkl')
                  ?RTRIM(getfield('t1','rs1->kgp','kln','adr'))
              endif
              ??' '+ALLT(rs1->npv)
            ?''

          endif
        endif
      else
        if kkr#2
            RsSh()
        else
            RsSh(2)
        endif
      endif
    else
      RsSh()
    endif
  endcase

  if gnEnt#21
     vmestr=0
  endif
  ovesr=0


  /////////////////     �롮� ���
  // �६����� ����
  if !file('ptara.dbf')
     sele 0
     crtt('ptara','f:ktl c:n(9) f:nat c:c(60) f:kol c:n(10)')
     use ptara excl
     index on str(ktl,9) tag t1
     index on str(int(ktl/1000000),3)+nat tag t2
  else
     if select('ptara')#0
        sele ptara
        use
     endif
     erase ptara.dbf
     erase ptara.cdx
     sele 0
     crtt('ptara','f:ktl c:n(9) f:nat c:c(60) f:kol c:n(10)')
     use ptara excl
     index on str(ktl,9) tag t1
     index on str(int(ktl/1000000),3)+nat tag t2
  endif
  sele ptara
  set orde to tag t1

  // �롮� ��� �� �६ ����
  sele rs2
  set orde to tag t3
  netseek('t3','ttnr')
  do while ttn=ttnr
     kgr=int(ktl/1000000)
     ktlr=ktl
     mntovr=mntov
     kolr=kvp
     if kgr=0.or.kgr=1
        if ctovr=1
           natr=getfield('t1','mntovr','ctov','nat')
        else
           natr=getfield('t1','sklr,ktlr','tov','nat')
        endif
        sele ptara
        if !netseek('t1','ktlr')
           appe blank
           netrepl('ktl,nat,kol',{ktlr,natr,kolr})
        else
           netrepl('kol','kol+kolr')
        endif
     endif
     sele rs2
     skip
  enddo
  ///////////////////////////////////////////////////////

  svesr=0
  iotr=0
  sele rs2
  set orde to tag t3
  netseek('t3','ttnr')
  rsrc_r=recn()

  sele PRs2
  go top
  wll_r='ttn=ttnr'
  //kolpos_r:=0
  //kolposNoPrn:=0
  sm18r=0
  svpbtr=0
  Do While ttn=ttnr
    if vzz=1.or.vzz=3 // TTN ⨯ ��� 1 ��� 3 ���
      if PrnOprnr=1
        if NoPrn=1
          //��� �� �뢮���, �� ���稪 ����権 �������
          kolposNoPrn++
          kolpos_r++
          //delete
          skip
          loop
        endif
      endif
    endif
     ktlr=ktl
     ktlpr=ktlp
     pptr=ppt
     mntovr=mntov
     ktlmr=ktlm
     rcnr=recn()
     if fieldpos('sert')#0
        rs2sertr=sert
     else
        rs2sertr=0
     endif
     IF otr#0
        IF tov->(Seek_Tov_Ot(Sklr,Ktlpr,ttnr))
           IF tov->ot#otr
              sele PRs2
              SKIP
              LOOP
            ENDIF
        ELSE
           lSeekError:=.T.
           #ifdef __CLIP__
             outlog(__FILE__,__LINE__,"SEEK_TOV___",sklr,ktlpr)
           #endif
           sele PRs2
           ?str(ktlpr,9)+' �� ������ � TOV �� OT'
           kolpos_r=kolpos_r+1
           rsle()
           skip
           loop
        ENDIF
     ENDIF
     sele PRs2
     kvpr=kvp
     bzenr=bzen
     zenbtr=zenbt
     sm18r=sm18r+round(kvpr*zenbtr,2)
     idr=id
     nair=nai
     if vzz=5
        zenr=bzen
        svpr=round(kvpr*zenr,2)
     else
        zenr=zen
        svpr=svp
     endif
     zenbbr=zenbb
     zenbtr=zenbt
     if (vzz=1.or.vzz=3).and.zenbbr#0.and.zenbtr#0
        zenr=zenbbr
        svpr=round(kvpr*zenbbr,2)
     endif
     if (vzz=1.or.vzz=3).and.zenbtr#0.and.zenbtr#0
        svpbtr=svpbtr+round(kvpr*zenbtr,2)
     endif
     srr=sr
     if fieldpos('prosfo')#0
        prfosfor=1
        prosfo_r=prosfo
     else
        prfosfor=0
        prosfo_r=0
     endif
     vesr=0
     iotr=iotr+svpr
     IF tov->(Seek_Tov___(Sklr,Ktlr,ttnr))
        sele tov
        // if netseek('t1','sklr,ktlr')
        k1tr=k1t
        kger=kge
        vespr=vesp
        upakr=upak
        if ctovr=1
          natr=getfield('t1','mntovr','ctov','nat')
          If !(vzz=2)
            natr=natr(natr, dvpr)
          EndIf
        else
          natr=nat
        endif
        natbtr='���뫪� '+alltrim(str(vesp,12,2))+'�'
        neir=nei
        sertr=sert
        srealr=sreal
        vesr=ves
        optr=&coptr
        mntovr=mntov
        drlzr=drlz
        dizgr=dizg

        KSertr=KSert
        NSertr=getfield('t1','KSertr','Sert','NSert')
        NSertr=alltrim(NSertr)

        barr=getfield('t1','mntovr','ctov','bar')
        Uktr=getfield('t1','mntovr','ctov','Ukt')
        // ���� ���� �த�樨 fin/prd.prg
        KProdr:=0 ;  vidr:=""
        KProd->(KProd_KodVid(Uktr,@KProdr,@vidr))
        //
        kukachr=kukach
        prmnr=prmn
        locr=loc
        kodst1r=kodst1
        vesst1r=vesst1
        if prfosfor=0 // ��� ���� RS2.PROSFO
          if prosfor=1.and.ccp=2
            if fieldpos('osfo')#0
              netrepl('osfo','osfo-kvpr')
              if ctovr=1
                sele tovm
                if netseek('t1','sklr,mntovr')
                   netrepl('osfo','osfo-kvpr')
                endif
              endif
            endif
          endif
        else //  ���� ���� RS2.PROSFO
           if prosfor=1.and.ccp=2.and.prosfo_r=0
              if fieldpos('osfo')#0
                 netrepl('osfo','osfo-kvpr')
                 if ctovr=1
                    sele tovm
                    if netseek('t1','sklr,mntovr')
                       netrepl('osfo','osfo-kvpr')
                    endif
                 endif
              endif
              sele rs2
              if netseek('t3','ttnr,ktlpr,pptr,ktlr')
                 netrepl('prosfo','1')
              endif
           endif
        endif
        sele tov
        if rtcenr#0
           roptr=&croptr
        endif
        opt_r=opt
        cc27r=''
        if vzz=2
           natr=alltrim(natr)+iif(!empty(cc27r),' '+cc27r,'')
        endif
        if prUpr=0.or.vzz=2
           nat_r=''
           if getfield('t1','int(ktlr/1000000)','sgrp','mark')=1
              // OFF 06-07-17 01:32pm
              //nat_r+=alltrim(getfield('t1','kger','GrpE','nge'))+' '
              //+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
           else
              if gnEnt=21
                 nat_r+=alltrim(getfield('t1','kger','GrpE','nge'))+' '
                 //+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
              else
              endif
           endif
           nat_r+=alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
        else // ����� ��祭��� ��� ��ப�
          if kkr=1.and.gnEnt=20
            // ���� � � �த��� �모��� ᫮�� ����� � ��稫�� � �।���
            // � �� ��᫥ ����
            nat_r=alltrim(natr)
            pJfr=at('JAFFA',upper(nat_r))
            if pJfr=1
               nat_r=space(6)+subs(nat_r,6)
            endif
            pJfr=at('JAFFA',upper(nat_r))
            if pJfr#0
               nat_r=subs(nat_r,1,pJfr-1)
            endif
            pSlr=at('/',nat_r)
            if pSlr#0
               nat_r=subs(nat_r,1,pSlr-1)
            endif
          else
            if getfield('t1','int(ktlr/1000000)','sgrp','mark')=1
              nat_r=alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
            else
              if gnEnt=21
                nat_r=alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
              else
                nat_r=alltrim(natr)+iif(upakr#0,' 1/'+kzero(upakr,10,3),'')
              endif
            endif
            nat_r=padr(nat_r,48) // ��� ��祭��� ���� ������ ������ ���� 48
          endif
        endif
        if vzz=1.or.vzz=3 // TTN
           if !empty(nair)
              nat_r=alltrim(nair)
           else
              if gnEnt=21.and.kplr=3736127
                cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                nat_r=cAddNat+nat_r(nat_r,dvpr)+iif(!empty(NSertr),' '+NSertr,'')+' '+iif(barr#0,' '+str(barr,13),'')+Uktr()
              else
                 if prUpr=0
                    cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                    nat_r=cAddNat+nat_r(nat_r,dvpr)+iif(!empty(NSertr),' '+NSertr,'')+Uktr()
                 else
                    if kkr=1
                    else
                       cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                       nat_r=nat_r(nat_r,dvpr)+iif(!empty(NSertr),' '+NSertr,'')+Uktr()
                    endif
                 endif
              endif
           endif
           if gnVo=6.and.(kopr=101.or.kopr=181.or.kopr=121)
              nat_r=nat_r //+iif(kodst1r#0,' '+str(kodst1r,4),'')+iif(vesst1r#0,' '+str(vesst1r,10,3),'')
           endif
        endif
        if locr#0
           lnn=44
        else
           lnn=48
        endif
        lnat_r=len(nat_r)
        if lnat_r<lnn //50
          if upakr=0.or.(vzz=1.or.vzz=3).and.!empty(idr)
            nat_r=nat_r+space(lnn-lnat_r)
          else
            if gnEnt=21
              if kplr=3736127
                cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                nat_r=cAddNat+iif(.t.,alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr),alltrim(natr))+iif((vzz=1.or.vzz=3).and.!empty(NSertr),' '+NSertr,'')+' '+iif(barr#0,' '+str(barr,13),'')+Uktr()
              else
                cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                nat_r=cAddNat+iif(.t.,alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr),alltrim(natr))+iif((vzz=1.or.vzz=3).and.!empty(NSertr),' '+NSertr,'')+Uktr()
              endif
            else
              if prUpr=0
                cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                nat_r=cAddNat+iif(getfield('t1','int(ktlr/1000000)','sgrp','mark')=1,alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr),alltrim(natr))+iif((vzz=1.or.vzz=3).and.!empty(NSertr),' '+NSertr,'')+Uktr()
              else
                if kkr=1
                   nat_r=padr(nat_r,48) // ��� ��祭��� ���� ������ ������ ���� 48
                else
                  cAddNat:=""//(cAddNat:="", AktsSWZen(mntovr,Kpvr,nKklr, rs1->DtRo, @cAddNat),cAddNat) //, nMnTovNotActs,cPath_Order)
                  nat_r=cAddNat+iif(getfield('t1','int(ktlr/1000000)','sgrp','mark')=1,alltrim(getfield('t1','kger','GrpE','nge'))+' '+alltrim(natr),alltrim(natr))+iif((vzz=1.or.vzz=3).and.!empty(NSertr),' '+NSertr,'')+Uktr()
                endif
              endif
            endif
            lnat_r=len(nat_r)
            cupakr=' 1/'+kzero(upakr,10,3)
            lcupakr=len(cupakr)
            if prUpr=0
              nat_r=nat_r+space(lnn-lnat_r-lcupakr)+cupakr
            else
              if kkr=1
                 nat_r=nat_r+space(lnn-lnat_r-lcupakr)+space(lcupakr)
                 nat_r=padr(nat_r,48) // ��� ��祭��� ���� ������ ������ ���� 48
              else
                 nat_r=nat_r+space(lnn-lnat_r-lcupakr)+cupakr
              endif
            endif
            if (vzz=1.or.vzz=3).and.gnVo=6.and.(kopr=101.or.kopr=181)
              nat_r=nat_r //+iif(kodst1r#0,' '+str(kodst1r,4),'')+iif(vesst1r#0,' '+str(vesst1r,10,3),'')
            endif
          endif
        endif

        ///////////////////////  gnEnt=8   //////   /
        if gnEnt=8.and.upakr#0.and.mod(kvpr,1)=0
          aaa=int(kvpr/upakr)
          if mod(kvpr,upakr)#0
             aaa=aaa+1
          endif
          vmestr=vmestr+aaa
          if lnat_r=lnn  //50
            if zcr=0
              if .f. //vzz=3
              else
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                  if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                     ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(aaa,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+' '+iif(rs2sertr#0,'C','')
                  else
                     ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(aaa,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+' '+iif(rs2sertr#0,'C','')
                  endif
                else
                   ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
                endif
              endif
              rsle()
            else
              if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(aaa,3)+' '+str(opt_r,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+' '+iif(rs2sertr#0,'C','')
                rsle()
                ?space(9)+' '+space(48)+' '+space(4)+' '+space(10)+' '+space(3)+' '+str(zenr-opt_r,9,3)+' '
                rsle()
              else
                ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(aaa,3)+' '+str(opt_r,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+' '+iif(rs2sertr#0,'C','')
                rsle()
                ?space(9)+' '+space(48)+' '+space(4)+' '+space(10)+' '+space(3)+' '+str(zenr-opt_r,9,3)+' '
                rsle()
              endif
            endif
          else
             store '' to xxx,yyy
             for i=lnat_r to 1 step -1
                 yyy=right(nat_r,lnat_r-i)
                 xxx=subs(nat_r,1,i)
                 if i<lnn .and. subs(nat_r,i,1)=' '
                    exit
                 endif
             next
             if len(xxx)<lnn
                xxx=xxx+space(lnn-len(xxx))
             endif
             if !(kopr=177.and.(vzz=1.or.vzz=3))
                if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                   ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(aaa,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+' '+iif(rs2sertr#0,'C','')
                else
                   ?space(9)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(aaa,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+' '+iif(rs2sertr#0,'C','')
                endif
             else
                ?space(9)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
             endif
             rsle()
             ?space(9)+' '+yyy
             rsle()
          endif
          ovesr=ovesr+aaa*vespr
        endif
        ////////  END gnEnt=8   ///////

        svesr=svesr+round(kvpr*vesr,3)
        if str(gnEnt,3)$' 20; 21'.and.(vzz=1.or.vzz=3).and.prUpr=1
          if kopr=169
            zenr=round(zenr*1.2,2)
            // ��樧
            kg_r:=int(mntovr/10000)
            if !empty(getfield('t1','kg_r','cgrp','nal'))
              zenr=round(zenr*1.05,2)
            endif
            svpr=round(zenr*kvpr,2)
            s90ndsr=s90ndsr+svpr

          else
            zenr=0
            svpr=0
            s90ndsr=0
          endif
        endif
        if (vzz=1.or.vzz=3).and.!empty(idr)
          ktlr=val(idr)
        endif

        if len(nat_r)=lnn
          if zcr=0
            if .f. //vzz=3
            else
              if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                  if str(gnEnt,3)$' 20; 21'.and.(vzz=1.or.vzz=3).and.prUpr=1
                    if kopr=169
                      ?space(9)+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(zenr,9,3)+' '+str(svpr,9,2)
                    else
                      ?space(9)+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
                    endif
                  else
                    ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(rs2sertr#0,'C','')
                  endif
                else
                  ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
                endif
              else
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                  ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(vzz=2.and.ktlmr=0.and.int(ktlr/1000000)=507,'*','')+' '+iif(rs2sertr#0,'C','')
                else
                  ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
                endif
              endif
            endif
            kolpos_r=kolpos_r+1
            rsle()
          else
            if .f. //vzz=3
            else
              if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                  ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(opt_r,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(vzz=2.and.ktlmr=0.and.int(ktlr/1000000)=507,'*','')+' '+iif(rs2sertr#0,'C','')
                else
                  ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
                endif
              else
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                  ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(opt_r,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(vzz=2.and.ktlmr=0.and.int(ktlr/1000000)=507,'*','')+' '+iif(rs2sertr#0,'C','')
                else
                  ?space(9)+iif(locr#0,str(locr,6),'')+' '+nat_r+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
                endif
              endif
            endif
            kolpos_r=kolpos_r+1
            rsle()
            ?space(9)+' '+space(48)+' '+space(4)+' '+space(9)+' '+str(zenr-opt_r,9,3)+' '
            rsle()
          endif
        else
           store '' to xxx,yyy
           for i=lnat_r to 1 step -1
               yyy=right(nat_r,lnat_r-i)
               xxx=subs(nat_r,1,i)
               if i<lnn.and.subs(nat_r,i,1)=' '
                  exit
               endif
           next
           if len(xxx)<lnn
              xxx=xxx+space(lnn-len(xxx))
           endif
           if .f. //vzz=3
           else
             if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
               if !(kopr=177.and.vzz=1)
                  ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(vzz=2.and.ktlmr=0.and.int(ktlr/1000000)=507,'*','')+' '+iif(rs2sertr#0,'C','')
               else
                 ?StrKtlr9(Ktlr,KolPos_r)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
               endif
             else
               if !(kopr=177.and.(vzz=1.or.vzz=3))
                  ?space(9)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)+' '+str(zenr,9,3)+' '+iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(vzz=2.and.ktlmr=0.and.int(ktlr/1000000)=507,'*','')+' '+iif(rs2sertr#0,'C','')
               else
                  ?space(9)+iif(locr#0,str(locr,6),'')+' '+xxx+' '+subs(neir,1,4)+' '+str(kvpr,10,3)
               endif
             endif
           endif
           kolpos_r=kolpos_r+1
           rsle()
           ?space(9)+' '+yyy
           rsle()
        endif
        if rtcenr#0.and.roptr#0.and.(vzz=1.or.vzz=3)
           ?space(9)+' '+space(48)+' '+space(5)+' '+space(9)+' '+str(roptr,9,3)+' '
           rsle()
        endif
        natdopr=''
        if sertr#0
           natdopr='����. '+ltrim(str(sertr,10))+' '
        endif
        if srealr#0
           natdopr=natdopr+'��.ॠ�. '+ltrim(str(srealr,10))+' ��'
        endif
        if !empty(natdopr)
           ?NATdopr
           rsle()
        endif
        if vzz=1.or.vzz=3
           lnatbt_r=len(natbtr)
           natbt_r=natbtr+space(lnn-lnatbt_r)
           neibtr='��� '
           if zenbtr#0
              ktlbtr=1000000+mod(ktlr,1000000)
              ?str(ktlbtr,9)+' '+natbt_r+' '+subs(neibtr,1,4)+' '+str(kvpr,10,3)+' '+str(zenbtr,9,3)+' '+str(round(kvpr*zenbtr,2),9,2)
              rsle()
           endif
        endif
     else
        ?StrKtlr9(Ktlr,KolPos_r)+' �� ������ � TOV'
        kolpos_r=kolpos_r+1
        rsle()
     endif
     if skr=157.and.(vzz=1.or.vzz=3).and.(kopr=101.or.kopr=181.or.kopr=121)
        c19r=getfield('t1','sklr,ktlr','tov','c19')
        c20r=getfield('t1','sklr,ktlr','tov','c20')
        c21r=getfield('t1','sklr,ktlr','tov','c21')
        c29r=getfield('t1','sklr,ktlr','tov','c29')
        ?'��� �� '+str(c19r,10,3)+' ��� ��� '+str(c20r,10,3)+' ������ '+str(c21r,10,3)+' ��� '+str(c29r,10,3)
        rsle()
     endif

     //�뢮� �����㯯�
     cNmLocalGrp:=cNmLocalGrp(PRs2->nat, PRs2->Ktl)

     sele PRs2
     skip

     //�뢮� �����㯯�
     If str(kgpr, 7) $ "8000717;8000738;8003520;8003907" //      str(kplr, 7) $ ""
       // �� ����砥�
     else
       If vzz=1 .and. vor=9 .and. PRs2Grp->(LastRec())>1
        // ᬥ�� �����㯯�
        If cNmLocalGrp != cNmLocalGrp(PRs2->nat, PRs2->Ktl)
           PRs2Grp->(__dbLocate({||allt(nat) == cNmLocalGrp}))
           ?padl("",9,"=")+iif(locr#0,padl("",6,"="),'')+' '+padc(cNmLocalGrp,lnn," ")+' '+padl("",4,"=");
           +' '+str(PRs2Grp->kvp,10,3);
           +' '+padl("",9,"=")+' '+padl("",9,"=")
           rsle()
           //iif(svpr<10000000,str(svpr,9,2),str(svpr,12,2))+iif(vzz=2.and.ktlmr=0.and.int(ktlr/1000000)=507,'*','')+' '+iif(rs2sertr#0,'C','')
        EndIf
       EndIf
     EndIf

  enddo

  if vzz=1.or.vzz=3 // TTN ⨯ ��� 1 ��� 3 ���
    if PrnOprnr=1
      If kolposNoPrn <> 0
        sele PRs2
        copy to PRs21
        If file('PRs21.cdx')
          erase PRs21.cdx
        EndIf
        lindx('PRs21','rs2')
        use PRs21 excl new
        dele for NoPrn=1
        kolposRs2r:= kolposr
        tbl2r:='PRs21'
        tbl3r:='rs3'
        pere(2)
        kolposr:= kolposRs2r
        close PRs21
      EndIf
    endif
  endif

  if vzz=1.or.vzz=3
     prosfor=0
  endif
  if itogr=1
     if vzz=2
        ?'����� �� �i��i�� '+str(otr,2)+space(65)+iif(iotr<10000000,str(iotr,10,2),str(iotr,12,2))
        rsle()
     endif
     if vzz=1.or.vzz=2.or.vzz=3
        sele ptara
        if recc()#0
           ?'����� ��:'
           set orde to 2
           go top
           do while !eof()
              ?str(ktl,9)+' '+subs(nat,1,40)+' '+str(kol,10)
              rsle()
              skip
           enddo
           ?''
           rsle()
        endif
     endif
     ?''
     rsle()
     if !((kopr=177.or.kopir=177).and.(vzz=1.or.vzz=3))
        sele rs3
        naitr=' (�����) '
        if netseek('t1','ttnr,12').and.ssf#0
           naitr='(�� �����)'
        endif
        netseek('t1','ttnr')
        pr18r=0
        Do Whil ttn=ttnr
           if prUpr=1
              if ksz#10
                 skip
                 loop
              endif
           endif
           kszr=ksz
           if vzz=5
              ssfr=bssf
           else
              ssfr=ssf
           endif
           if vzz=1.or.vzz=3
              if kszr=18
                 if pstr=0
                    if sm18r#0
                       ssfr=ssfr+sm18r
                    endif
                 endif
              else
                 if kszr>18.and.pr18r=0.and.sm18r#0
                    nszr=getfield('t1','18','dclr','nz')
                    nszr=subs(nszr,1,10)+' (�����.) '
                    ?space(51)+str(18,2)+'-'+nszr+':'+' '+space(5)+space(3)+str(sm18r,10,2)
                    rsle()
                    pr18r=1
                    loop
                 endif
              endif
           endif
           if kszr>=90
              skip
              loop
           endif
           if ssfr#0
              if vzz=5
                 prr=bpr
              else
                 prr=pr
              endif
              nszr=getfield('t1','kszr','dclr','nz')
              DO case
              CASE kszr=19
                nszr=subs(nszr,1,10)+naitr
                ?space(51)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr,10,2),str(ssfr,12,2))
              CASE kszr=18
                IF pstr=0
                  nszr=subs(nszr,1,10)+' (�����.) '
                  pr18r=1
                ELSE
                  nszr=subs(nszr,1,10)+'(�� �����)'
                ENDIF
                ?space(51)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr,10,2),str(ssfr,12,2))
              CASE kszr=10
                if prUpr=0.or.vzz=2
                  if vzz#1
                    ?space(51)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr,10,2),str(ssfr,12,2))
                  else
                    if sm18r=0
                      ?space(51)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr,10,2),str(ssfr,12,2))
                    else
                      ?space(51)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr-sm18r,10,2),str(ssfr-sm18r,12,2))
                    endif
                  endif
                else // prUpr=1 ����� ��祭��� ���
                  // �뢮� �㬬�
                  if kopr=169
                    nszr=space(20)
                    space51=space(51)
                    /* If '":' $ textr
                      space51=padr(allt(textr),51)
                    EndIf */
                    ?space51 + space(2) + ' ' + nszr + ' ' + ' ' + space(5)+space(3)+str(s90ndsr,10,2)
                  endif
                endif
              OTHERWISE
                ?space(51)+str(kszr,2)+'-'+nszr+':'+' '+str(prr,5,2)+space(3)+iif(ssfr<10000000,str(ssfr,10,2),str(ssfr,12,2))
              ENDCASE
              rsle()
           ENDIF
           sele rs3
           skip
        enddo
     endif

     //QOut_forwarder()

     sele rs3
     IF netseek('t1','ttnr,90')
        IF vzz=5
           ssfr=bssf
        ELSE
           if vzz=1.or.vzz=3
              ssfr=ssf //+svpbtr
           else
              ssfr=ssf
           endif
        ENDIF
        sdvprcr=sdvr
        if gnEnt=21
           sele kpl
           if fieldpos('prskpd')#0
              if getfield('t1','nkklr','kpl','prskpd')=1
                 sdvprcr=0
                 sele rs2
                 set orde to tag t3
                 if netseek('t3','ttnr')
                    do while ttn=ttnr
                       sdvprcr=sdvprcr+round(kvp*zenp,2)
                       skip
                    enddo
                    sdvprcr=sdvprcr*1.2
                 endif
              endif
           else
           endif
        endif

        if gnEnt=21.and.sdvprcr#0
           sdvprcr=sdvr-sdvprcr
           if sdvprcr#0
              csdvprcr=strtran(str(sdvprcr,10,2),'.','/')
           else
              csdvprcr=space(10)
           endif
        else
           csdvprcr=space(10)
        endif


        kolposr -= kolposNoPrn
        kolpos_r -= kolposNoPrn
        if (prUpr=0.or.vzz=2).and.!(kopr=177.and.(vzz=1.or.vzz=3))
           if kopr#168.or.!(vzz=1.or.vzz=3)
              if !((kopr=177.or.kopir=177.and.gnEnt=21.and.vvcenr=1).and.(vzz=1.or.vzz=3))
                 ?'�����i� '+str(kolposr,3)+'('+str(kolpos_r,3)+')'+csdvprcr+space(25)+'����� �� ���㬥���  '+space(8)+str(ssfr,15,2) //+' ��.'
                 if gnEnt=21
                    kszr=13
                    ssf13r=getfield('t1','ttnr,kszr','rs3','ssf')
                    if ssf13r#0
                       ?'        '+'   '+' '+'   '+' '+csdvprcr+space(25)+ '�� ���-�� (��� ���) '+space(8)+str(ssfr-ssf13r,15,2) //+' ��.'
                       rsle()
                    endif
                    VtrataTary()
                 endif
              else
                 ?'�����i� '+str(kolposr,3)+'('+str(kolpos_r,3)+')'+csdvprcr+space(25)+'����� �� ���㬥���  '+space(8)

              endif
           else
              if kkr#2
                 if !((kopr=177.or.kopir=177.and.gnEnt=21.and.vvcenr=1).and.(vzz=1.or.vzz=3))
                    ?'�����i� '+str(kolposr,3)+'('+str(kolpos_r,3)+')'+csdvprcr+space(25)+'����� �� ���㬥���  '+space(8)+str(ssfr,15,2) //+' ��.'
                    VtrataTary()
                 else
                    ?'�����i� '+str(kolposr,3)+'('+str(kolpos_r,3)+')'+csdvprcr+space(25)+'����� �� ���㬥���  '+space(8)
                 endif
              else
                    ?space(8)+space(8)+space(35)+'����� �� ���㬥���  '+space(8)+str(ssfr,15,2) //+' ��.'
              endif
           endif
           rsle()
        endif
        if kolposr#kolpos_r
           #ifdef __CLIP__
             outlog(3,__FILE__,__LINE__,"��ᮢ������� ��� ���","PRs2",kolposr,"KOLPOS",kolpos_r,ttnr)
           #endif
        endif
     ENDIF
     IF (vzz=1.or.vzz=3) .and. skr=113
        ?space(10)
        rsle()
        ?'�த��� �஢�७� ______________    ��� ��室� � ���_____________'
     ENDIF
     rsfoot(1)
  ELSE
     IF vzz=2
        if otr#0
           ?'����� �� �i��i�� '+str(otr,2)+space(65)+iif(iotr<10000000,str(iotr,10,2),str(iotr,12,2))
           rsle()
        endif
     ENDIF
     if otkr#0
        ?'�⮣� � ���-䠪��� �� �⤥�� '+str(otkr,2)
        rsle()
     endif
     if kopr#168.or.vzz#1
        rsfoot()
     else
        if kkr#2.or.vzz=1.or.vzz=3
           rsfoot()
        endif
     endif
  ENDIF
  if gnVo=10
     eject
  endif

  if vzz=1.or.vzz=3 // TTN ⨯ ��� 1 ��� 3 ���
    if PrnOprnr=1
      If kolposNoPrn <> 0
        tbl2r:='rs2'
        tbl3r:='rs3'
        pere(2)
      EndIf
    endif
  endif

  // ���⠭���� ��� ����権
  kolpos_r:=nPre_kolpos_r

  RETURN

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  01-16-17 * 07:37:40pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION VtrataTary()
  IF kopr=170
    ?''
    rsle()
    ?"� ࠧi ���� �� � ������୥��� ��ਬ㢠� �����'易���� ᯫ��� ��������i� � ஧�i�i:"
    rsle()
    If dvpr < STOD("20200301")
      ?' - ���� 30� � 50� - 112�� � ��� (� ��. �� ����� ���); - ����� 10�   - 1200��. � ���'
      rsle()
      ?' - ����� 20�       - 1600��. � ���;             - �騪 ������� � �࠭� - 60��. � ���.'
    Else
      ?' - ���� 30� � 50� - 112�� � ��� (� ��. �� ����� ���); - ����� 10�   - 3000��. � ���'
      rsle()
      ?' - ����� 20�       - 3000��. � ���;             - �騪 ������� � �࠭� - 60��. � ���.'
    EndIf
    rsle()
    ?'�i���� ��ਬ㢠� � �i� ��� �i�⢥द�� ����� ��������� ��� ��������i�.'
    rsle()
  ENDIF
  RETURN (NIL)


**************
proc rsfoot()
  **************
  local str,sstr,p_str,p_str1,p_str2
  if prUpr=1
     retu .t.
  endif
  store 0 to p_str,p_str1,p_str2
  if itogr=1  //  .and.(((who=2.or.(who=3.or.who=4).and.vzz=2)).or.((vzz=1.or.vzz=3) .and.gnVo=2))
    if (who=2.or.who=5.or.((who=3.or.who=4).and.vzz=2).or.(vzz=1 .and.gnVo=2))

     sel:=select()
     if select('psgr')#0
        nuse('psgr')
     endif
     if !file('psgr.dbf')
        crtt('psgr','f:kgr c:n(3) f:pzen c:n(7,2)')
     else
        erase psgr.dbf
        erase psgr.cdx
        erase psgr.idx
        erase psgr.ntx
        crtt('psgr','f:kgr c:n(3) f:pzen c:n(7,2)')
     endif
     sele 0
     use psgr
     index on str(kgr,3) to psgr
     sele rs2
     set order to tag t1
     netseek('t1','ttnr')
     do while ttn=ttnr
        ktlr=ktl
        kgrr=int(ktlr/1000000)
        if kgrr<=1
           skip
           loop
        endif
        kgr_r=str(kgrr,3)
        pzenr=pzen
        sele sgrp
        set order to tag t1
        seek kgr_r
        ngrr=ngr
        sele psgr
        seek kgr_r
        if eof()
           appe blank
           repl kgr with kgrr,pzen with pzenr
        else
           if pzen<>0.or.pzenr<>0
              repl pzen with min(pzen,pzenr)
           endif
        endif
        sele rs2
        skip
     enddo
     sele psgr
     count to p_str for pzen<>0
     count to p_str1 for pzen=pzenr
     if p_str=p_str1
        p_str1=1
        p_str2=1
     endif
    endif
  endif
  do case
     case (gnVo=9.and.gnArm#6).or.gnVo=2.or.gnVo=6.or.gnVo=1.or.gnVo=8.or.gnVo=3 // ���㯠⥫�,��������,��ॡ�᪠,�����.����.
          If Who = 2.or.who=5 .Or. ((Who = 3.or.who=4) .And. Vzz = 2)
             for i=1 to 43-rswr-7
                 ?''
             endf
             if p1=2
                 ?'�i���� ��������       '+alltrim(gcName)+'               '+'���㬥�� ��⠢��         '+fktor
             else
                 ?'�i���� ��������      ______________                       ���㬥�� ��⠢�� __________________'
             endif

             ?'�i���� ��㧠 ᮢ��訫    ___________'
             ?' "___" ____________ 20   �. ���� (����)  '+str(svesr,10,3)+' �� �i�.�i��� '+str(vmestr,5)
          EndIf
          if Who = 1 .Or. ((Who = 3.or.who=4) .And. (Vzz = 1.or.vzz=3))
             for i=1 to 43-rswr-6-3 // -2 ������� �����⨪�
                 ?''
             endf

             if l_prUpr(prUpr,kopr,kkr)=0 //prUpr=0

               if kopr#168;
                 .or.(kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1))
                  NVipdr=''
                  do case
                  case gnEnt = 20 //.and.gnSk=228
                    If gnSk = 400
                      NVipdr := getfield('t1', '415', 'speng', 'fio')
                    Else
                      NVipdr := getfield('t1', '60', 'speng', 'fio')
                    EndIf
                    NVipdr := subs(NVipdr, 1, 15)

                  case gnEnt = 21 //.and.gnSk=232
                      NVipdr=subs(getfield('t1','204','speng','fio'),1,15)
                  case gnEnt=21 //.and.gnSk=700
                      NVipdr=+subs(getfield('t1','946','speng','fio'),1,15)
                  OtherWise
                      ?'����____________________________________________________'+'�'+'��ᯥ���� '+padr(necsr,15)+'_______________________________'+space(2)+'���⠦ ���ঠ�_________________'
                  endcase
                  if !(kopr=177.and.(vzz=1.or.vzz=3))
                     if rs1->prZZen=0
                        if gcPath_m='i:\pl\'
                           ?'�i���� �i�⢥न� '+NVipdr+' ___________       '+ iif(!empty(dopr),dtoc(dopr),dtoc(dotr))+' �.'+ '          ������ '+'  ___________ '
                        else
                           if gnEnt=20
                              ?'�i���� �i�⢥न� '+NVipdr+' ___________      '+ iif(przr=0,dtoc(dopr),dtoc(dotr))+' �.'      + '          ������ '+alltrim(gcName)+'  ___________ '
                           else
                              ?'�i���� �i�⢥न� '+NVipdr+' ___________      '+ iif(!empty(dopr),dtoc(dopr),dtoc(dotr))+' �.'+ '(��� ���㧪�) ���� '+alltrim(gcName)+'  ___________ '
                           endif
                        endif
                     else
                        if gcPath_m='i:\pl\'
                           ?'�i���� �i�⢥न� '+NVipdr+' ___________       '+ dtoc(rs1->dot)+' �.'+ '          ������ '+' ___________ '
                        else
                           ?'�i���� �i�⢥न� '+NVipdr+' ___________       '+ dtoc(rs1->dot)+' �.'+ '          ������ '+alltrim(gcName)+' ___________ '
                        endif
                     endif
                  endif
               endif
               if !(kopr=177.and.(vzz=1.or.vzz=3))
                  if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                     ?'                            ���� (����)  '+str(svesr,10,3)+' �� �i�.�i��� '+str(vmestr,5)
                  endif
                  if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                     ?'���⠦ �� ��ॢ������ �਩��  ___________                           ���⠦ ���ঠ� ____________'
                  endif
               else
                     ?'                                       ���⠦ ���ঠ� ___________________________________________'
               endIf

               QOut_forwarder()

               if (kopr=177.and.(vzz=1.or.vzz=3))
                  if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
                     ?repl('-',95)
                  endif
               endif
             endif
          endif
          If Who = 2.or.who=5 .Or. ((Who = 3.or.who=4) .And. Vzz = 2)
             ?'��� ����⢨⥫�� � �祭�� 3-� ������᪨� ���� � ��� �믨᪨.'
             rsle()
          endif
          If (Who = 2.or.who=5 .Or. ((Who = 3.or.who=4) .And. Vzz = 2)).or.((vzz=1.or.vzz=3).and.gnVo=2)
             if itogr=1
                sele psgr
                go top
                str=.t.
                sstr=1
                do while !eof()
                   if pzen<>0 .and. p_str2<>1
                      if str=.t..and.(sstr=1.or.sstr=8.or.sstr=16)
                         ? str(kgr,3)+' - '+alltrim(str(pzen))+'%, '
                         str=.f.
                         sstr=sstr+1
                         rsle()
                      else
                         ?? str(kgr,3)+' - '+alltrim(str(pzen))+'%, '
                         sstr=sstr+1
                         str=.t.
                      endif
                   endif
                   if p_str2=1
                      ?'�� - '+alltrim(str(pzenr))+'% '
                      exit
                   endif
                   skip
                enddo
                sele psgr
                use
                erase psgr.dbf
                erase psgr.cdx
                sele(sel)
             endif
          EndIf
          if who=1.and.(vzz=1.or.vzz=3).and.(rsw_r-rswr)>3.and.entr=13
             ?'�������� ������! ����������� ��� "�㤨���" ���頥��� � ��� � 㡥��⥫쭮� ���졮�'
             rsle()
             ?'���������⥫쭮 ᮮ���� � 䠪�� �����४⭮��,��㡮�� ��������� �ᯥ���஢ � ��� �஡���,'
             rsle()
             ?'���������� � ���⠢��� � ����⢮� ⮢��.��������� ������� �� ⥫�䮭� 24-37-12'
             rsle()
          endif
          if (gnVo=9.or.gnVo=2).and.(vzz=1.or.vzz=3).and.gnEnt=20.and.gnEntRm=0
          endif
          if who=1.and.(vzz=1.or.vzz=3).and.(STR(kplr,7)$"3210425,2842412,3176604,2980308,2070905,1116758").and.prprn6r=1
             ?'���� 㪠���� � ��⮬ �࠭ᯮ���� ��室�� 6%'
             rsle()
          endif
          rswr=42
          rsle(1)
     case gnVo=5  // ��� �� ᯨᠭ��
          if prlkr=0
             ?''
             rsle()
             //?'�����祭�� �����ᨨ:'
             ?'��᭮��� �����i�:'
             rsle()
             ?zak1r
             rsle()
             ?zak2r
             rsle()
             ?zak3r
             rsle()
             ?''
             rsle()
             //?'������ 童��� �����ᨨ                                        ������� �⢥��⢥����� ���'
             ?'�i���� 童�i� ���i�i�                                        �i���� �i����i���쭮� �ᮡ�'
             rsle()
           else
             ?''
             rsle()
             ?'�뤠�� ���ਠ��� ࠧ�訫                                                              ��壠���                 '
             rsle()
             ?''
             rsle()
             ?'                                                                                        "___"_____________200___� '
             rsle()
           endif
      case gnVo=4
             ?' '
             ?'������� � ����� ����� '+alltrim(gcName_c)+' � '+ alltrim(getfield('t1','sklr','kln','nkl'))
             rsle()
             ksr=11
             s1=getfield('t1','ttnr,ksr','rs3','ssf')
             s2=round(int((s1-int(s1))*100),2)
             ?'���᫥���� �㬬� ��� � ࠧ��� '+str(int(s1),6) + ' �� '+str(s2,2)+' ��� '
             rsle()
             ?' '
             rsle()
             ?'�த����                                                            ���㯠⥫�'
             rsle()
             ?alltrim(gcName_c)+space(48)+alltrim(getfield('t1','sklr','kln','nkl'))
     case gnVo=6 // ��ॡ�᪠
     case gnVo=7 // �������
          ?'���� ࠧ�訫:                ����稫:              ����⨫:'
          rsle()
          ?' '
          rsle()
          ?'��砫쭨�:                  ��.��壠���:'
          rsle()
     case gnVo=8  // ������
     case gnVo=10
          if gnEnt=20
   //           ?''
   //           rsle()
             ?'�i���� �i�⢥न� '+NVipdr+' ___________       '+ dtoc(rs1->dop)+' �.'+ '          ������ '+alltrim(gcName)+' ___________ '
             rsle()
             ?'���⠦ �� ��ॢ������ �਩��  ___________                           ���⠦ ���ঠ� ____________'
             rsle()
          endif
          ?''
          rsle()
          ?'�।�⠢���                                  �।�⠢���'
          rsle()
          ?gcName_c+'                         '+getfield('t1','kplr','kln','nkl')
          rsle()
          ?'�.�.                                              �.�.'
          rsle()
  if gnEnt=21
     for i=1 to 4
         ?''
     endf
     ?'��ਬ�� ��� ��ॢ������  __________________________/_______________/'
          rsle()
  endif
  endcase
  if gnArm=6
     ?' '
     rsle()
     ?space(40)+'�i����⨢'
     rsle()
     ?' '
     rsle()
     ?space(40)+'���ঠ�'
     rswr=42
     rsle(1)
     if select('psgr')#0
        sele psgr
        use
        erase psgr.dbf
        erase psgr.cdx
     endif
  endif
  retu

**************
  **************
func RsSh(p1)
  LOCAL cL
  if p1=nil
    if otr#0
      not_r=' �i��i� '+str(otr,2)
    else
      not_r=''
    endif
    navtokklr=''
    svczr=0
    n1:=''
    do case
    case gnVo=9.or.gnVo=2.or.gnVo=1.or.gnVo=3.or.gnVo=10
      if (gnEnt=20.or.gnEnt=21).and.kopr=169 // *01
        dfior=''
        natranr=''
        anomr=''
        AtNomr=''
        navtokklr=''
      else
        if mrshr#0
            sele cmrsh
            if netseek('t2','mrshr')
              dfior=alltrim(dfio)
              katranr=katran
              if fieldpos('svcz')#0
                  svczr=svcz
              else
                  svczr=0
              endif
              if (gnEnt=20.or.gnEnt=21).and.gnEntRm=1.and.svczr=0 // *01
                  dfior=''
                  natranr=''
                  anomr=''
                  AtNomr=''
                  navtokklr=''
              else
                  if katranr#0
                    sele kln
                    if netseek('t1','katranr')
                        natranr=alltrim(nkl)
                        dfior=alltrim(adr)
                        anomr=alltrim(nkls)
                        AtNomr=natranr+' '+anomr+' ��� '+dfior
                        avtokklr=kklp
                        navtokklr=getfield('t1','avtokklr','kln','nkl')
                    endif
                  endif
              endif
            endif
        else
            if gnArnd#0
              if katranr#0
                  sele kln
                  if netseek('t1','katranr')
                    natranr=alltrim(nkl)
                    dfior=alltrim(adr)
                    anomr=alltrim(nkls)
                    AtNomr=natranr+' '+anomr+' ��� '+dfior
                    avtokklr=kklp
                    navtokklr=getfield('t1','avtokklr','kln','nkl')
                endif
              endif
            endif
        endif
      endif
      if vzz=1.or.vzz=3
        if psp=2
          if kkr=2.or.kkr=3 .OR. kkr = 4
            sele rs1
            if empty(ttn1cr)
                n1:='����⪮�� �������� N '+str(ttnr,6)
                if rs1->prZZen=0
                  n1:=n1;
                  +iif(!empty(AtNomr),' N ��� '+AtNomr,'');
                  +iif(!empty(npvr),' '+alltrim(npvr),'')
                endif
            else
                if rs1->prZZen=0
                  n1:='����⪮�� �������� N '+ttn1cr+'('+str(ttnr,6)+')';
                  +iif(!empty(not_r) ,' '+not_r,'');
                  +iif(!empty(kpvr)  ,' '+alltrim(getfield('t1','kpvr','kln','nkl')),'');
                  +iif(!empty(npvr)  ,' '+alltrim(npvr),'')+;
                  +iif(!empty(AtNomr),' N ��� '+AtNomr,'');
                  +' '+str(nndsr,10)
                else
                  n1='����⪮�� �������� N '+str(ttnr,6)
                endif
            endif
          else  //1 2  - �����
            if empty(ttn1cr)
                n1:='����⪮�� �������� N '+str(ttnr,6)
                if rs1->prZZen=0
                n1:=n1;
                  +iif(!empty(not_r),' '+not_r,'');
                  +iif(!empty(AtNomr),' N ��� '+AtNomr,'');
                  +iif(nndsr#0,' HH '+str(nndsr,10),'')
                endif
            else
                n1:='����⪮�� �������� N '+ttn1cr+'('+str(ttnr,6)+')'
                if rs1->prZZen=0
                  n1:=n1;
                  +iif(!empty(not_r),' '+not_r,'');
                  +iif(!empty(AtNomr),' N ��� '+AtNomr,'');
                  +' '+str(nndsr,10)
                endif
            endif
          endif
        else
          if empty(ttn1cr)
              n1:='����⪮�� �������� N '+str(ttnr,6)
            if rs1->prZZen=0
              n1:=n1;
              +iif(!empty(not_r),' '+not_r,'');
              +iif(!empty(kpvr),' #','');
              +iif(!empty(AtNomr),' N ��� '+AtNomr,'');
              +' '+str(nndsr,10)
            endif
          else
            n1:='����⪮�� �������� N '+ttn1cr+'('+str(ttnr,6)+')'
            if rs1->prZZen=0
              n1:=n1;
              +iif(!empty(not_r),' '+not_r,'');
              +iif(kpvr#0,' #','');
              +iif(!empty(AtNomr),' N ��� '+AtNomr,'');
              +' '+str(nndsr,10)
            endif
          endif
        endif
      endif
      if vzz=2 // .or.vzz=3
        sele rs1
        netseek('t1','ttnr',,,1)
        if ppsf#0  //  �����
            if psp=2  // ��⥢�� ���
              if kkr=1
                  n1='���-䠪��� N '+str(ttnr,6);
                  +not_r+' ';
                  +iif(kpvr#0,' '+alltrim(getfield('t1','kpvr','kln','nkl')),' ');
                  +' '+iif(!empty(npvr),alltrim(npvr),' ');
                  +'�����'
              else
                  n1='              ���-䠪��� N ';
                  +str(ttnr,6)+not_r;
                  +'      �����'
              endif
            else
              n1='                 ���-䠪��� N '+str(ttnr,6)+;
              not_r+;
              '      �����'+'        ';
              +iif(kpvr#0,' #',' ')
            endif
        else   // �ਣ����
            if psp=2  // ��⥢�� ���
              if kkr=1
                  n1='���-䠪��� N '+str(ttnr,6);
                  +not_r;
                  +iif(kpvr#0,' '+alltrim(getfield('t1','kpvr','kln','nkl')),'');
                  +iif(!empty(npvr),' '+alltrim(npvr),'')
              else
                  n1='                 ���-䠪��� N '+str(ttnr,6)+not_r
              endif
            else      //  �����쭠� �����
              n1='                 ���-䠪��� N '+str(ttnr,6);
              +not_r+'         '+;
              iif(kpvr#0,' #','')
            endif
        endif
      EndIf
    case gnVo=5
      if prlkr=0
        //n1='��� ᯨᠭ�� ���ਠ���� 業���⥩ N '+str(ttnr,6)+ ' �� '+iif(!empty(dotr),dtoc(dotr),dtoc(dvpr))+space(21)+'���������'
        n1='��� �� ᯨᠭ�� ����i��쭨� �i����⥩ N '+str(ttnr,6)+ ' �i� '+iif(!empty(dotr),dtoc(dotr),dtoc(dvpr))+space(21)+'���������'
      else
        n1='����⭠� ���� N '+str(ttnr,6)+ ' �� '+iif(!empty(dotr),dtoc(dotr),dtoc(dvpr))
      endif
    case gnVo=4
      n1='                             ��⮪��  N' +str(ttnr,6)
    case gnVo=6
      //n1='����७��� ��ॡ�᪠ N '+str(ttnr,6)
      n1='�����i�� ��६i饭�� N '+str(ttnr,6)
      if mrshr#0
        sele cmrsh
        if netseek('t2','mrshr')
            dfior=alltrim(dfio)
            katranr=katran
            if katranr#0
              sele kln
              if netseek('t1','katranr')
                  natranr=alltrim(nkl)
                  dfior=alltrim(adr)
                  anomr=alltrim(nkls)
                  AtNomr=natranr+' '+anomr+' ��� '+dfior
                  avtokklr=kklp
                  navtokklr=getfield('t1','avtokklr','kln','nkl')
              endif
            endif
        endif
      endif
    case gnVo=7
      n1='��������� � ������� N '+str(ttnr,6)
    case gnVo=8
      n1='������ �� ������� N '+str(ttnr,6)
    endcase

     // ����� ����訬� �㪢��� � ���孥� 㣫�.
    aaa1:=""
    if ((!empty(gcPrn), .T.) .and. !(kopr=177 .and. (vzz=1 .or. vzz=3)))
      do case
      case entr=13
        aaa1+=' BUDINF'
      case entr=20
        aaa1 += aaa1_add({'������','RESURS'})
      case entr=21
        aaa1 += aaa1_add({'�����','LODIS'})
      endcase

      if gnEnt=21.and.bsor#0.and.(vzz=1.or.vzz=3)
        aaa1+=' (���)'
      endif

    endif

    //outlog(__FILE__,__LINE__,n1)
    //outlog(__FILE__,__LINE__,aaa1)

    if kopr=177.and.(vzz=1.or.vzz=3)
      aaa:=subs(str(ttnr,6),4,3)
      ?aaa
      IF !EMPTY(aaa1)
        ??SPACE(89 - LEN(aaa) - LEN(aaa1))
        ?? chr(27) + '(s3b10.00h' + chr(27)  // ����
        ?? aaa1
        ?? chr(27) + '(s0p18.00h0s1b4102T' + chr(27)  // �।���
      ENDIF
    else
      aaa:=n1
      IF EMPTY(aaa1) //��� ������ �㪢
        if len(aaa)<90
          ?aaa
        else
          ?subs(aaa,1,89);  rsle()
          ?subs(aaa,90)
        endif
      ELSE  // ������ �㪢
        if len(aaa)+len(aaa1)*2 < 90
          ?aaa
          ??SPACE(89 - LEN(aaa) - LEN(aaa1))
        else
          ?subs(aaa,1,89);         rsle()
          ?subs(aaa,90)
          ??SPACE(89 - LEN(subs(aaa,90)) - LEN(aaa1))
        endif
        ?? chr(27) + '(s3b10.00h' + chr(27)  // ����
        ?? aaa1
        ?? chr(27) + '(s0p18.00h0s1b4102T' + chr(27)  // �।���

      ENDIF
    endif
    rsle()
    do case
    case gnVo=9.or.gnVo=2.or.gnVo=1.or.gnVo=3.or.gnVo=10
      if !(kopr=177.and.(vzz=1.or.vzz=3))
        if psp=2.and.kkr=3 //.AND.Who=2
            aaa='����砫쭨�: '+alltrim(gcName_c)+' '+str(gnKln_c,8)+' '+alltrim(gcAdr_c)+'  �����������'
        else
            aaa='����砫쭨�: '+alltrim(gcName_c)+' '+str(gnKln_c,8)+' '+alltrim(gcAdr_c)
            if gnEnt=21
              if gnRm=0
                  aaa=' '+aaa+'�i�� ᪫������ ���㬥�� �.�㬨 ��.����i��,7'
              else
                  aaa=' '+aaa+'�i�� ᪫������ ���㬥�� �.����⮯ 4-� �஢.��.�ᯥ��쪮-����쪮�,5�'
              endif
            endif
        endif
        if len(aaa)<90
            ?aaa
            rsle()
        else
            ?subs(aaa,1,89)
            rsle()
            ?subs(aaa,90)
            rsle()
        endif

        if brprr=0
          ?alltrim(gcOb1_c)+' ���-'+Right(gnKb1_c,6)+' �/�-'+gcNs1_c //+' �/� ��� -'+gcNs1nds_c
          rsle()
        else
          // �� setup.dbf
          ?alltrim(Nbankr)+' ���-'+str(Bankr,6)+' �/�-'+Schtr
          rsle()
        endif

        kbr=getfield('t1','kplr','kln','kb1')
        rschr=getfield('t1','kplr','kln','ns1')
        kkl1r=getfield('t1','kplr','kln','kkl1')
        if vzz=1.or.vzz=3
            #ifdef __CLIP__
              nklr=getfield('t1','kplr','kln','nkl')
            #else
              sele kln
              netseek('t1','kplr')
              nkler=alltrim(nkle)
              opfhr=opfh
              nopfhr=''
              if opfhr#0
                  nopfhr=alltrim(getfield('t1','opfhr','opfh','nopfh'))
              endif
              nklr=nopfhr+' '+nkler
            #endif
        else
            knaspr=getfield('t1','kplr','kln','knasp')
            nnaspr=getfield('t1','knaspr','knasp','nnasp')
            nkler=getfield('t1','kplr','kln','nkle')
            opfhr=getfield('t1','kplr','kln','opfh')
            nsopfhr=getfield('t1','opfhr','opfh','nsopfh')
            nklr=alltrim(nnaspr)+' '+alltrim(nsopfhr)+' '+alltrim(nkler)
        endif
        if kkl1r=0
          aaa='���⭨�: '+alltrim(nklr)+' ���  '+str(kplr,7)+' ⥫ '+alltrim(getfield('t1','kplr','kln','tlf'))+' '+alltrim(getfield('t1','kplr','kln','adr'))
        else
          aaa='���⭨�: '+alltrim(nklr)+' ���  '+alltrim(str(kkl1r,10))+' ⥫ '+alltrim(getfield('t1','kplr','kln','tlf'))+' '+alltrim(getfield('t1','kplr','kln','adr'))
        endif
        if len(aaa)<90
          if kkl1r=0
            ?'���⭨�: '+alltrim(nklr)+' ���  '+str(kplr,7)+' ⥫ '+alltrim(getfield('t1','kplr','kln','tlf'))+' '+alltrim(getfield('t1','kplr','kln','adr'))
          else
            ?'���⭨�: '+alltrim(nklr)+' ���  '+alltrim(str(kkl1r,10))+' ⥫ '+alltrim(getfield('t1','kplr','kln','tlf'))+' '+alltrim(getfield('t1','kplr','kln','adr'))
          endif
          rsle()
        else
          ?subs(aaa,1,89)
          rsle()
          ?subs(aaa,90)
          rsle()
        endif
        ?alltrim(getfield('t1','kbr','banks','otb'))+' ��� '+alltrim(kbr)+' �/� '+alltrim(rschr)
        rsle()

        aaa:= '����㢠�: '+' �i�-��'
        ?aaa
        rsle()
      endif
      if vzz=1.or.vzz=3 // ���
        if kplr=20034
            if kkr=1
              ngpr=getfield('t1','kplr','kln','nkl')
              knaspr=getfield('t1','kplr','kln','knasp')
              nnaspr=alltrim(getfield('t1','knaspr','knasp','nnasp'))
              outlog(3,__FILE__,__LINE__,"nnaspr", nnaspr,knaspr,kplr )
              if gnEnt=20.or.gnEnt=21 // *01
                  if rs1->prZZen=0
                    ?'�i�� ����: '+alltrim(ngpr)+' ��� '+str(kplr,7)+' ⥫ '+getfield('t1','kplr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kplr','kln','adr'))
                    If !empty(allt(rs1->Npv)) .and. '�����' $ upper(rs1->Npv)
                      ?'�ਬi⪠: '+padl(upper(allt(rs1->Npv)),95-10)
                    EndIf
                  else
                    ?'�i�� ����: '
                  endif
              else
                  ?'�i�� ����: '+alltrim(ngpr)+' ��� '+str(kplr,7)+' ⥫ '+getfield('t1','kplr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kplr','kln','adr'))
              endif
            else
              if kpvr#0
                  ngpr=getfield('t1','kpvr','kgp','ngrpol')
                  if empty(ngpr)
                    ngpr=getfield('t1','kpvr','kln','nkl')
                  endif
                  knaspr=getfield('t1','kvpr','kln','knasp')
              else
                  ngpr=getfield('t1','kgpr','kgp','ngrpol')
                  if empty(ngpr)
                    ngpr=getfield('t1','kgpr','kln','nkl')
                  endif
                  knaspr=getfield('t1','kgpr','kln','knasp')
              endif
              nnaspr=alltrim(getfield('t1','knaspr','knasp','nnasp'))
              if kpvr#0
                  ?'�i�� ����: '+alltrim(ngpr)+' ��� '+str(kpvr,7)+' ⥫ '+getfield('t1','kpvr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kpvr','kln','adr'))
              else
                  ?'�i�� ����: '+alltrim(ngpr)+' ��� '+str(kgpr,7)+' ⥫ '+getfield('t1','kgpr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kgpr','kln','adr'))
              endif
            endif
        else // �� 20034
          ngpr=getfield('t1','kpvr','kgp','ngrpol')
          if empty(ngpr)
            ngpr=getfield('t1','kpvr','kln','nkl')
          endif
          knaspr=getfield('t1','kpvr','kln','knasp')
          nnaspr=alltrim(getfield('t1','knaspr','knasp','nnasp'))
          if gnEnt=20.or.gnEnt=21 // *01
            if rs1->prZZen=0
              ?'�i�� ����: '+alltrim(ngpr)+' ��� '+str(kpvr,7)+' ⥫ '+getfield('t1','kpvr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kpvr','kln','adr'))
              If !empty(allt(rs1->Npv)) .and. '�����' $ upper(rs1->Npv)
                ?'�ਬi⪠: '+padl(upper(allt(rs1->Npv)),95-10)
              EndIf
            else
              ?'�i�� ����: '
            endif
          else
            ?'�i�� ����: '+alltrim(ngpr)+' ���  '+str(kpvr,7)+' ⥫ '+getfield('t1','kpvr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kpvr','kln','adr'))
          endif
          rsle()
        endif
      else // ��� 䠪���
        if kpvr#0
            ngpr=getfield('t1','kpvr','kgp','ngrpol')
            if empty(ngpr)
              ngpr=getfield('t1','kpvr','kln','nkl')
            endif
            knaspr=getfield('t1','kpvr','kln','knasp')
        else
            ngpr=getfield('t1','kgpr','kgp','ngrpol')
            if empty(ngpr)
              ngpr=getfield('t1','kgpr','kln','nkl')
            endif
            knaspr=getfield('t1','kgpr','kln','knasp')
        endif
        nnaspr=alltrim(getfield('t1','knaspr','knasp','nnasp'))
        if kpvr#0
            ?'�i�� ����: '+alltrim(ngpr)+' ���  '+str(kpvr,7)+' ⥫ '+getfield('t1','kpvr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kpvr','kln','adr'))
        else
            ?'�i�� ����: '+alltrim(ngpr)+' ���  '+str(kgpr,7)+' ⥫ '+getfield('t1','kgpr','kln','tlf')+' '+nnaspr+' '+alltrim(getfield('t1','kgpr','kln','adr'))
        endif
      endif
          kbr=getfield('t1','kgpr','kln','kb1')
          rschr=getfield('t1','kgpr','kln','ns1')
          if vzz=1.or.vzz=3
            ngpr=getfield('t1','kgpr','kgp','ngrpol')
            if empty(ngpr)
                ngpr=getfield('t1','kgpr','kln','nkl')
            endif
          else
            ngpr=getfield('t1','kgpr','kln','nkl')
          endif
          if !((vzz=1.or.vzz=3).and.kopr=177)
            if gnEnt=20.and.(vzz=1.or.vzz=3)
              fkto_r=''
              if getfield('t1','ktar','s_tag','ktakkl')#0
                if przr=0
                  if rs1->prZZen=0
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dvpr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r);
                      +'  '+iif(Show_Kta(ktar,kopr),'���.�����  '+getfield('t1','ktar','s_tag','fio'),'')
                  else
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dvpr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r)
                  endif
                else
                  if rs1->prZZen=1.and.(gnEnt=20.or.gnEnt=21) // *01
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dotr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r)
                  else
                      if gnEnt=20
                        ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dotr);
                        +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r)+'  '+iif(Show_Kta(ktar,kopr),'���.�����  '+getfield('t1','ktar','s_tag','fio'),'')
                      else
                        ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dopr);
                        +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r)+'  '+iif(Show_Kta(ktar,kopr),'���.�����  '+getfield('t1','ktar','s_tag','fio'),'')
                      endif
                  endif
                endif
              else
                if przr=0
                  if rs1->prZZen=0
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dvpr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r);
                      +'  '+iif(Show_Kta(KtaSr,kopr),'���.�����  '+getfield('t1','KtaSr','s_tag','fio'),'')
                  else
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dvpr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r)
                  endif
                else
                  if rs1->prZZen=1.and.(gnEnt=20.or.gnEnt=21) // *01
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dotr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r)
                  else
                      if gnEnt=20
                        ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dotr);
                        +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r);
                        +'  '+iif(Show_Kta(KtaSr,kopr),'���.�����  '+getfield('t1','KtaSr','s_tag','fio'),'')
                      else
                        ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dopr);
                        +' ����஧������ '+iif(gcPath_m='i:\pl\','',fkto_r);
                        +'  '+iif(Show_Kta(KtaSr,kopr),'���.�����  '+getfield('t1','KtaSr','s_tag','fio'),'')
                      endif
                  endif
                endif
              endif
            else
              if przr=0

                if rs1->prZZen=0
                  ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dvpr);
                  +' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor);
                  +'  '+iif(Show_Kta(ktar,kopr),'���.�����  '+getfield('t1','ktar','s_tag','fio'),'')
                else
                  ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dvpr);
                  +' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
                endif
              else
                if rs1->prZZen=1.and.(gnEnt=20.or.gnEnt=21) // *01
                  ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dotr);
                  +' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
                else
                  if gnEnt=20
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dotr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor);
                      +'  '+iif(Show_Kta(ktar,kopr),'���.�����  '+getfield('t1','ktar','s_tag','fio'),'')
                  else
                      ?'����� ���५�  '+alltrim(gcNskl)+' �i� '+dtoc(dopr);
                      +' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor);
                      +'  '+iif(Show_Kta(ktar,kopr),'���.�����  '+getfield('t1','ktar','s_tag','fio'),'')
                  endif
                endif
              endif
            endif
          endif
          rsle()
    case gnVo=5
          if prlkr=0
            //?'��� ᯨᠭ�� '+str(kplr,6)+' '+getfield('t1','kplr','bs','nbs')+' '+'���ࠧ������� '+ getfield('t1','kgpr','podr','npod')  // nkgpr
            ?'���㭮� ᯨᠭ�� '+str(kplr,6)+' '+getfield('t1','kplr','bs','nbs')+' '+'�i�஧�i� '+ getfield('t1','kgpr','podr','npod')  // nkgpr
            rsle()
            ?'����� ���५�  '+alltrim(gcNskl);
            +' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
            rsle()
            if gnMskl=1
                ?'������⭨� '+alltrim(getfield('t1','sklr','kln','nkl'))+' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
                rsle()
            endif
          else
            ?'��⮬�����     '+str(kpsr,7)+' '+getfield('t1','kpsr','kln','nkl') // nkgpr
            rsle()
            ?'����� ���५�  '+alltrim(gcNskl)+' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
            rsle()
          endif
    case gnVo=4
            ?space(15)+'� �஢������ ���⮢ �� �����⭮� ��'
            rsle()
            netuse('knasp')
            gg=getfield('t1','sklr','kln','knasp')
            ngg=getfield('t1','gg','knasp','nnasp')
            ?'�.'+getfield('t1','gg','knasp','nnasp')
            ??space(30)+iif(!empty(dotr),dtoc(dotr),dtoc(dvpr))
            rsle()
            ?space(48)+'----------------'
            rsle()
            ?'  � �裡 � ������⢨�� ���������� � ���㯠⥫�'
            rsle()
            ?alltrim(getfield('t1','sklr','kln','nkl'))+' '+alltrim(getfield('t1','sklr','kln','adr'))+' ��� '+alltrim(getfield('t1','sklr','kln','kb1'))+'(��� '+str(sklr,7)+')'+' �������� �த����'
            rsle()
            ?alltrim(gcName_c)+' '+alltrim(gcAdr_c)+' ���-'+Right(gnBank_c,6)+'(��� '+ str(gnKln_c,8)+'), ᮣ��᭮ �������,'
            rsle()
            ?'�������� ���, �த���� � ���㯠⥫� ��諨 � ᮣ��襭��'
            rsle()
            ?'����� ᫥������ ��� �த���� '+alltrim(gcName_c)+' ���㯠⥫� '+alltrim(getfield('t1','sklr','kln','nkl'))
    case gnVo=6
          if sktr#0
            ?'����� ��ਬ㢠�  '+getfield('t1','sktr','cskl','nskl')+' '+AtNomr
            rsle()
          endif
          ?'����� ���५�  '+alltrim(gcNskl)+' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
          rsle()
    case gnVo=7
          ?'����� ��ਬ㢠�  '+getfield('t1','sktr','cskl','nskl')
          rsle()
          ?'������⭨� �����⥫�'+' '+str(kplr,4)+' '+getfield('t1','kplr','kln','nkl')
          rsle()
          ?'����� ���५�  '+alltrim(gcNskl)+' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
          rsle()
          if gnMskl=1
            ?'������⭨� ���筨� '+alltrim(getfield('t1','sklr','kln','nkl'))
            rsle()
          endif
          if przr=1
            vzz=1
          else
            vzz=2
          endif
    case gnVo=8
          ?'����� ��ਬ㢠�  '+getfield('t1','sktr','cskl','nskl')
          rsle()
          ?'����� ���५�  '+alltrim(gcNskl)+' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
          rsle()
          if gnMskl=1
            ?'������⭨� ���筨� '+alltrim(getfield('t1','sklr','kln','nkl'))+' ����஧������ '+iif(gcPath_m='i:\pl\','',fktor)
            rsle()
          endif
     endcase

     If kopr=169 .and. '/169-2-160' $ ALLT(UPPER(DOSPARAM()))
      // ������ ���� ����樨 �� �����
      kop1r:=kopr
      nop1r:=nopr
      kopr:=160
      nopr:=getfield('t1','0,1,gnVo,kopr-100','soper','nop')
     EndIf
     if gnVo#4
      //!!
        if kplr#3210425
          sele klndog
          if fieldpos('cndog')=0
             if gcPath_m='i:\pl\'
                ?'��� ���p��i� - '+str(kopr,3)+' '+allt(nopr) + Say_Dogvir(0,0,kopr)
             else
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                   ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+ Say_Dogvir(ttnpr,ttncr,kopr)
                   //' �����i� '+str(getfield('t1','kplr','klndog','ndog'),6);
                   //+' �� '+dtoc(getfield('t1','kplr','klndog','dtdogb'));
                   //+iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                else
                   ?'��� ���p��i� - '+str(kopr,3)
                endif
             endif
          else
             if empty(getfield('t1','kplr','klndog','cndog'))
                if gcPath_m='i:\pl\'
                   ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+ Say_Dogvir(0,0,kopr)
                   //' �����i� '+str(getfield('t1','kplr','klndog','ndog'),6);
                   //+' �� '+dtoc(getfield('t1','kplr','klndog','dtdogb'))
                else
                   if !(kopr=177.and.(vzz=1.or.vzz=3))
                     ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+ Say_Dogvir(ttnpr,ttncr,kopr)
                     //' �����i� '+str(getfield('t1','kplr','klndog','ndog'),6);
                     //+' �� '+dtoc(getfield('t1','kplr','klndog','dtdogb'));
                     //+iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                   else
                      ?'��� ���p��i� - '+str(kopr,3)
                   endif
                endif
             else
                if gnEnt=20.and.kplr=3229492.and.prmk17r=1.and.!(kopr=177.and.(vzz=1.or.vzz=3))
                   if gcPath_m='i:\pl\'
                      ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+' �����i� '+'383/��/11-��'+' �i� '+dtoc(getfield('t1','kplr','klndog','dtdogb'))
                   else
                      if !(kopr=177.and.(vzz=1.or.vzz=3))
                         ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+' �����i� '+'383/��/11-��'+' �i� '+dtoc(getfield('t1','kplr','klndog','dtdogb'))+iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                      else
                         ?'��� ���p��i� - '+str(kopr,3)
                      endif
                   endif
                else
                  if gcPath_m='i:\pl\'
                    ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+ Say_Dogvir(0,0,kopr)
                    //' �����i� '+alltrim(getfield('t1','kplr','klndog','cndog'));
                    //+' �� '+dtoc(getfield('t1','kplr','klndog','dtdogb'))
                  else
                    if !(kopr=177.and.(vzz=1.or.vzz=3))
                      ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+ Say_Dogvir(ttnpr,ttncr,kopr)
                      //' �����i� '+alltrim(getfield('t1','kplr','klndog','cndog'));
                      //+' �� '+dtoc(getfield('t1','kplr','klndog','dtdogb'));
                      //+iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                    else
                        ?'��� ���p��i� - '+str(kopr,3)
                    endif
                  endif
                endif
             endif
          endif
        else
          if fieldpos('cndog')=0
             if gcPath_m='i:\pl\'
                ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)
             else
                if !(kopr=177.and.(vzz=1.or.vzz=3))
                   ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+' ';
                   +iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                else
                   ?'��� ���p��i� - '+str(kopr,3)
                endif
             endif
          else
             if empty(getfield('t1','kplr','klndog','cndog'))
                if gcPath_m='i:\pl\'
                   ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)
                else
                   ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+' ';
                   +iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                endif
             else
                if gcPath_m='i:\pl\'
                   ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)
                else
                   if !(kopr=177.and.(vzz=1.or.vzz=3))
                      ?'��� ���p��i� - '+str(kopr,3)+' '+allt(NOpr)+' ';
                      +iif(ttnpr#0,' '+str(ttnpr,6),'')+iif(ttncr#0,' '+str(ttncr,6),'')
                   else
                      ?'��� ���p��i� - '+str(kopr,3)
                   endif
                endif
             endif
          endif
        endif
        rsle()
     endif
     If kopr = 160 .and. '/169-2-160' $ ALLT(UPPER(DOSPARAM()))
      kopr:=kop1r
      nopr:=nop1r
     EndIf

     if vzz=2.or.who=2.or.who=5
        ?'�����ᮢ�� ���ﭨ� ������:' + symklr+alltrim(str(symkl,14,2))+' '+time()+' '+alltrim(gcName)
        rsle()
     else
        if !(kopr=177.and.(vzz=1.or.vzz=3))
           ?time()+' '+str(kplr,7)
           rsle()
        endif
     endif

     if rs1->prZZen=0.and.!(kopr=177.and.(vzz=1.or.vzz=3))
        if (gnEnt=20.or.gnEnt=21).and.(kopr=169.or.gnEntRm=1.and.svczr=0) // *01
           ?'                             '+'  '+'                                                         ���� '+str(lstr,1)
        else
           ?'������� '+str(mrshr,6)+' ��� '+str(mrshnppr,2)+' ��ॢi���� '+subs(navtokklr,1,30)+'                         ���� '+str(lstr,1)
        endif
     else
        ?'                             '+'  '+'                                                          ���� '+str(lstr,1)
     endif
     rsle()
  else
     do case
      case p1=1 .and. kopr=177.and.(vzz=1.or.vzz=3)
        ?subs(str(ttnr,6),4,3)
        rsle()
      case p1=1
        ?'���㬥�� '+str(ttnr,6)+' �i��i� '+str(otr,1)+'                                                                ���� '+str(lstr,1)
        rsle()
      case p1=2 // 168
        ?subs(str(ttnr,6),4,3)
        rsle()
     endcase
  endif

  if gnVo=5.and.prlkr=0
        //?'���⠢ �����ᨨ:'
        ?'����� ���i��i�:'
        rsle()
        ?kom1r
        rsle()
        ?kom2r
        rsle()
        ?kom3r
        rsle()
  endif

  *if vzz#3
     if kopr#168
        if gnEnt=21.and.vor=9.and.nkklr#0.and.nkklr#20034.and.p1=nil.and..f.
           ?'������������� �� ��'
           rsle()
           sele cskl
           locate for ent=gnEnt.and.tpstpok=2
           if foun()
              pathr=gcPath_d+alltrim(path)
              if netfile('tov',1)
                 netuse('tov','tovpok','',1)
                 if netseek('t1','nkklr')
                    crtt('ttara','f:mntov c:n(7) f:nat c:c(40) f:kol c:n(10)')
                    sele 0
                    use ttara
                    sele tovpok
                    do while skl=nkklr
                       if kg=1
                          skip
                          loop
                       endif
                       mntovr=mntov
                       mntovtr=getfield('t1','mntovr','ctov','mntovt')
                       if mntovtr#0
                          mntovr=mntovtr
                       endif
                       natr=subs(getfield('t1','mntovr','ctov','nat'),1,40)
                       if empty(natr)
                          natr=subs(nat,1,40)
                       endif
                       kolr=osf
                       sele ttara
                       locate for mntov=mntovr
                       if !foun()
                          appe blank
                          repl mntov with mntovr,;
                               nat with natr
                       endif
                       repl kol with kol+kolr
                       sele tovpok
                       skip
                    enddo
                    sele ttara
                    go top
                    do while !eof()
                       mntovr=mntov
                       natr=nat
                       kolr=kol
                       if kolr>0
                          ?str(mntovr,7)+' '+natr+' '+str(kolr,10)
                          rsle()
                       endif
                       sele ttara
                       skip
                    enddo
                    sele ttara
                    use
                    erase ttara.dbf
                 endif
                 nuse('tovpok')
              endif
           endif
        endif
        if !(kopr=177.and.(vzz=1.or.vzz=3))
           if prlkr=0
              ?repl('-',94)
           else
              ?repl('-',118)
           endif
           rsle()
           do case
              case Who = 2.or.who=5.or.vzz=2
                   ?'| ���  |                 ������㢠���                     |����|         ����ᠭ�            |'
                   rsle()
              case Who = 1.or.vzz=1.or.vzz=3
                   ?'| ���  |                 ������㢠���                     |����|    ����筮  �i���饭�      |'
                   rsle()
              case gnVo=5
                   if prlkr=0
                      ?'| ���  |                 ������㢠���                     |����|        �� ᯨᠭ��          |'
                   else
                      ?'| ���  |                 ������㢠���                     |����|        �� ६���            |  ���ঠ�  | ������騪 |'
                   endif
              case gnVo=4
                   ?'| ���  |                 ������㢠���                     |����|         ����ᠭ�            |'
           endcase
           if prlkr=0
              ?'|      |                                                  |���|-----------------------------|'
           else
              ?'|      |                                                  |���|-----------------------------------------------------|'
           endif
           rsle()
           if gnEnt#8
              if prlkr=0
                 ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |'
              else
                 ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |           |           |'
              endif
              rsle()
           else
              ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |'
              rsle()
           endif
           if prlkr=0
              ?repl('-',94)
           else
              ?repl('-',118)
           endif
           rsle()
        endif
     else // 168
        if (vzz=1.or.vzz=3).and.kkr#2.or.!(vzz=1.or.vzz=3)
           if prlkr=0
              ?repl('-',94)
           else
              ?repl('-',118)
           endif
           rsle()
           do case
              case Who = 2.or.who=5.or.vzz=2
                   ?'| ���  |                 ������㢠���                     |����|         ����ᠭ�            |'
                   rsle()
              case Who = 1.or.(vzz=1.or.vzz=3)
                   ?'| ���  |                 ������㢠���                     |����|    ����筮  �i���饭�      |'
                   rsle()
              case gnVo=5
                   if prlkr=0
                      ?'| ���  |                 ������㢠���                     |����|        �� ᯨᠭ��          |'
                   else
                      ?'| ���  |                 ������㢠���                     |����|        �� ६���            |  ���ঠ�  | ������騪 |'
                   endif
              case gnVo=4
                   ?'| ���  |                 ������㢠���                     |����|         ����ᠭ�            |'
           endcase
           if prlkr=0
              ?'|      |                                                  |���|-----------------------------|'
           else
              ?'|      |                                                  |���|-----------------------------------------------------|'
           endif
           rsle()
           if gnEnt#8
              if prlkr=0
                 ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |'
              else
                 ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |           |           |'
              endif
              rsle()
           else
              ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |'
              rsle()
           endif
           if prlkr=0
              ?repl('-',94)
           else
              ?repl('-',118)
           endif
           rsle()
        endif
     endif

  retu .t.

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  08-19-16 * 03:56:23pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
proc rsle(p1)
  rswr++
  //if vzz#3
  if prUpr=0
    rsw_r=42
  else
    rsw_r=42
  endif
  //else
   //   rsw_r=92
  //endif
  if rswr>=rsw_r.and.prUpr=0
     rswr=1
     lstr++
     eject
     if p1=nil
       if psp<>2.and.atrcr=0 //who#5
        wmess('��⠢� ���� � ������ �஡��',0)
       endif
        if vzz=5
           if prUpr=0
              rsnsh(1)
           endif
        else
           if vzz=1.or.vzz=3
              if kopr#168
                 if prUpr=0
                    RsSh(1)
                 endif
              else
                 if kkr=1
                    if prUpr=0
                       RsSh(1)
                    endif
                 endif
              endif
           else
              if prUpr=0
                 RsSh(1)
              endif
           endif
        endif
     endif
  endif
  retu

proc rsnsh()
  para p1
  if p1=nil
     ?space(30)+'�������� N_______'
     rsle()
     ?space(20)+'"_____"______________________200__�'
     rsle()
     ?'�i� ����_________________________________________________________________'
     rsle()
   //   ?'����_____________________________________________________________________'
     ?'����   ' +alltrim(getfield('t1','kpvr','kln','nkl'))
     rsle()
     ?'��१____________________________________________________________________'
     rsle()
     ?'�i��⠢�_________________________________________________________________'
     rsle()
     ?''
     rsle()
  endif
  ?space(8)+right(str(ttnr,6),3)+space(70)+dtoc(date())
  rsle()
  ?repl('-',94)
  rsle()
  ?'| ���  |                 ������㢠���                     |����|         ����ᠭ�            |'
  rsle()
  ?'|      |                                                  |���|-----------------------------|'
  rsle()
  ?'| �.�  |                                                  |��.�| � - ��� |  �i��   |  �㬠   |'
  rsle()
  ?repl('-',94)
  rsle()

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  12-28-04 * 01:17:28pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION Seek_Tov_Ot(nSkl,nKtlp,nTtn)
  LOCAL lRet,i, nRecNo, lFound, cKeySeek
  STATIC aKtl
  IF kkr=1
    aKtl:={}
  ENDIF
  lRet:=.F.
  FOR i:=1 TO 2
    IF netseek('t1','sklr,ktlpr',,,1)
      lRet:=.T.
      IF i>1
      #ifdef __CLIP__
        outlog(__FILE__,__LINE__,"Tov_OtStep",STR(i,1),"netseek OK",sklr,ktlpr,nTtn, kkr)
      #endif
      ENDIF
      EXIT
    ELSE
      #ifdef __CLIP__
        outlog(__FILE__,__LINE__,"Tov_OtStep",STR(i,1),"netseek",sklr,ktlpr,nTtn, kkr)
      #endif
        IF kkr=1
          AADD(aKtl,{sklr,ktlpr,nTtn, kkr})
        ENDIF
      IF .T. .AND. (oldtr:=ordsetfocus("T1"),;
            cKeySeek:=str(nSkl,7)+str(nKtlp,9),;
            dbseek(cKeySeek),;
            ordsetfocus(oldtr),;
           found();
          )
           lRet:=.T.

        #ifdef __CLIP__
          outlog(__FILE__,__LINE__,"Tov_OtStep",STR(i,1),"dbseek OK!",cKeySeek,LEN(cKeySeek),nSkl,nKtlp,nTtn, kkr)
        #endif
        EXIT
      ELSE
        #ifdef __CLIP__
          outlog(__FILE__,__LINE__,"Tov_OtStep",STR(i,1),"dbseek :-(",cKeySeek,LEN(cKeySeek),nSkl,nKtlp,nTtn, kkr)
        #endif
        IF kkr=1
          AADD(aKtl,{sklr,ktlpr,nTtn, kkr})
        ENDIF
      ENDIF
    ENDIF
  NEXT
  IF lRet .AND. kkr#1 .AND. !EMPTY(aKtl) .AND. !EMPTY(ASCAN(aKtl,{|aElem| aElem[2]=ktlpr }))
    #ifdef __CLIP__
      AEVAL(aKtl,{|aElem|outlog(__FILE__,__LINE__,aElem)})
    #endif
  ENDIF
  IF !lRet
      oldtr:=ordsetfocus(0)

      //��᫥���� �������!!!
      LOCATE  FOR str(nSkl,7)=str(_FIELD->Skl,7) .AND. str(nKtlp,9)=str(_FIELD->Ktl,9)
      IF found()
        #ifdef __CLIP__
          outlog(__FILE__,__LINE__,"LOCATE OK!")
        #endif
        /*
        //�������� ����� �����
        nRecNo:=RECNO()
        ordsetfocus("T1")
            cKeySeek:=str(nSkl,7)+str(nKtlp,9)
            lFound:=dbseek(cKeySeek)
            #ifdef __CLIP__
              outlog(__FILE__,__LINE__,"dbseek ",FOUND(), lFound)
            #endif
        DBGOTO(nRecNo)
        //
        */
        lRet:=.T.
        lSeekError:=.F.
      ELSE
        set deleted off

        LOCATE  FOR str(nSkl,7)=str(_FIELD->Skl,7) .AND. str(nKtlp,9)=str(_FIELD->Ktl,9)
        IF found()
          #ifdef __CLIP__
            outlog(__FILE__,__LINE__,DELETED(),"LOCATE OK! set deleted off")
          #endif
          IF RecLock()
            RECALL
            #ifdef __CLIP__
              outlog(__FILE__,__LINE__,DELETED(),"RECALL OK!")
            #endif
          ENDIF
          lRet:=.T.
          lSeekError:=.F.
        ELSE
          #ifdef __CLIP__
            outlog(__FILE__,__LINE__,"LOCATE NO!")
          #endif
          lSeekError:=.T.
        ENDIF
        set deleted on
      ENDIF

      ordsetfocus(oldtr)
  ENDIF

  RETURN (lRet)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  08-19-16 * 03:56:34pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION Seek_Tov___(nSkl,nKtl,nTtn)
  LOCAL lRet,i, nRecNo, lFound, cKeySeek
  lRet:=.F.
  FOR i:=1 TO 2
    IF netseek('t1','sklr,ktlr',,,1)
      lRet:=.T.
      IF i>1
      #ifdef __CLIP__
        outlog(__FILE__,__LINE__,"Tov___Step",STR(i,1),"netseek OK",sklr,ktlpr,nTtn, kkr)
      #endif
      ENDIF
      EXIT
    ELSE
      #ifdef __CLIP__
        outlog(__FILE__,__LINE__,"Tov___Step",STR(i,1),"netseek",sklr,ktlr,nTtn, kkr)
      #endif
      IF .T. .AND. (oldtr:=ordsetfocus("T1"),;
            cKeySeek:=str(nSkl,7)+str(nKtl,9),;
            dbseek(cKeySeek),;
            ordsetfocus(oldtr),;
           found();
          )
           lRet:=.T.

        #ifdef __CLIP__
          outlog(__FILE__,__LINE__,"Tov___Step",STR(i,1),"dbseek OK!",cKeySeek,LEN(cKeySeek),nSkl,nKtl,nTtn, kkr)
        #endif
        EXIT
      ELSE
        #ifdef __CLIP__
          outlog(__FILE__,__LINE__,"Tov___Step",STR(i,1),"dbseek :-(",cKeySeek,LEN(cKeySeek),nSkl,nKtl,nTtn, kkr)
        #endif
      ENDIF
    ENDIF
  NEXT
  IF !lRet
      oldtr:=ordsetfocus(0)
      //��᫥���� �������!!!
      LOCATE  FOR str(nSkl,7)=str(_FIELD->Skl,7) .AND. str(nKtl,9)=str(_FIELD->Ktl,9)
      IF found()
        #ifdef __CLIP__
          outlog(__FILE__,__LINE__,"LOCATE OK!")
        #endif
        /*
        //�������� ����� �����
        nRecNo:=RECNO()
        ordsetfocus("T1")
            cKeySeek:=str(nSkl,7)+str(nKtl,9)
            lFound:=dbseek(cKeySeek)
            #ifdef __CLIP__
              outlog(__FILE__,__LINE__,"dbseek ",FOUND(), lFound)
            #endif
        DBGOTO(nRecNo)
        //
        */
        lRet:=.T.
        lSeekError:=.F.
      ELSE

        set deleted off
        ///Seek_Tov___(nSkl,nKtl,nTtn)

        LOCATE  FOR str(nSkl,7)=str(_FIELD->Skl,7) .AND. str(nKtl,9)=str(_FIELD->Ktl,9)
        IF found()
          #ifdef __CLIP__
            outlog(__FILE__,__LINE__,DELETED(),"LOCATE OK! set deleted off")
          #endif
          IF RecLock()
            RECALL
            #ifdef __CLIP__
              outlog(__FILE__,__LINE__,DELETED(),"RECALL OK!")
            #endif
          ENDIF
          lRet:=.T.
          lSeekError:=.F.
        ELSE
          #ifdef __CLIP__
            outlog(__FILE__,__LINE__,"LOCATE NO!")
          #endif
          lSeekError:=.T.
        ENDIF
        set deleted on
      ENDIF

      ordsetfocus(oldtr)
  ENDIF
  RETURN (lRet)

**************
func prn1tn()
  **************
  outlog(__FILE__,__LINE__,procname(1),procline(1))
  if gnKto=934
     retu .t.
  endif
  if !(vzz=1.or.vzz=4.or.vzz=3)
     retu .t.
  endif
  if kplr=20034
     retu .t.
  endif
  if !(kopr=160.or.kopr=161.or.kopr=183.or.kopr=193.or.kopr=188)
     retu .t.
  endif
  svczr=0
  if mrshr#0.and.(gnEnt=20.or.gnEnt=21).and.gnEntRm=1 // *01
     sele cmrsh
     if fieldpos('svcz')#0
        svczr=getfield('t2','mrshr','cmrsh','svcz')
     else
        svczr=0
     endif
     if svczr=0
        retu .t.
     endif
  endif
  /*if gnEnt=21
  *   sele kln
  *   if netseek('t1','kplr')
  *      if nn#0 //.and.!empty(nsv)
  *      else
  *         if !(gnKto=331.or.gnKto=882.or.gnKto=217)
  *            retu .t.
  *         endif
  *      endif
  *   else
  *      retu .t.
  *   endif
  *endif
  */
  adrnvr=gcAdr_c
  if gnRmsk#0
     if gnEnt=21
        do case
           case gnRmsk=4
                 knvr=9000000
        endcase
     endif
     if gnEnt=20
        do case
           case gnRmsk=3
                 knvr=8000000
           case gnRmsk=4
                 knvr=9000000
           case gnRmsk=5
                 knvr=7000000
        endcase
     endif
     adrnvr=getfield('t1','knvr','kln','adr')
  endif


  ??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p19.00h0s1b4102T'+chr(27)
  *??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
  *??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p20.00h0s1b4102T'+chr(27)
  *??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p25.00h0s1b4102T'+chr(27)
  *??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p29.00h0s1b4102T'+chr(27)
  *nrowr=76
  *ncolr=166
  navtokklr=''
  avtokkl1r=0
  avtokklr=0
  svczr=0
  if mrshr#0
     sele cmrsh
     if netseek('t2','mrshr')
        dfior=alltrim(dfio)
        katranr=katran
        vsvbr=vsvb
        kecsr=kecs
        if fieldpos('svcz')#0
           svczr=svcz
        else
           svczr=0
        endif
        if (gnEnt=20.or.gnEnt=21).and.(kopr=169.or.gnEntRm=1.and.svczr=0) // *01
           dfior=''
           AtNomr=''
           vsvbr=0
           anomr=''
           avtokklr=0
           navtokklr=''
           avtokkl1r=0
           mrshr=0
           necsr=''
        else
           if katranr#0
              sele kln
              if netseek('t1','katranr')
                 natranr=alltrim(nkl)
                 dfior=alltrim(adr)
                 anomr=alltrim(nkls)
                 AtNomr=natranr+' '+anomr
                 avtokklr=kklp
                 navtokklr=''
                 avtokkl1r=0
              else
                 dfior=''
                 AtNomr=''
                 vsvbr=0
                 anomr=''
                 avtokklr=0
                 navtokklr=''
                 avtokkl1r=0
              endif
           endif
        endif
     else
        dfior=''
        AtNomr=''
        vsvbr=0
        anomr=''
        avtokklr=0
        navtokklr=''
        avtokkl1r=0
     endif
  else
     if gnArnd#0
        kecsr=rs1->kecs
        if katranr=0
           dfior=''
           AtNomr=rs1->AtNom
           vsvbr=0
           anomr=''
           avtokklr=0
           navtokklr=''
           avtokkl1r=0
        else
           sele kln
           if netseek('t1','katranr')
              natranr=alltrim(nkl)
              dfior=alltrim(adr)
              anomr=alltrim(nkls)
              AtNomr=natranr+' '+anomr
              avtokklr=kklp
              navtokklr=''
              avtokkl1r=0
           else
              dfior=''
              AtNomr=''
              vsvbr=0
              anomr=''
              avtokklr=0
              navtokklr=''
              avtokkl1r=0
           endif
        endif
     else
        dfior=''
        AtNomr=''
        vsvbr=0
        kecsr=0
        anomr=''
        avtokklr=0
        navtokklr=''
        avtokkl1r=0
     endif
  endif


  if !((gnEnt=20.or.gnEnt=21).and.(kopr=169.or.gnEntRm=1.and.svczr=0)) // *01
     necsr=getfield('t1','kecsr','s_tag','fio')
     navtokklr=alltrim(getfield('t1','avtokklr','kln','nkl'))
     avtokkl1r=getfield('t1','avtokklr','kln','kkl1')
  endif

  ??space(97)+'��⢥द��� ������� �i��࠭��, �i����� ������'
  ?'1 �ਬ. - ���⠦�����ࠢ����'+space(20)+        '���������������������������Ŀ'
  ?space(28)+space(20)                     +        '�   �   �   �   �   �   �   �'+space(20)+'29.12.1995 �. � 488/346'
  ?'2 �ਬ. - ���⠦�����㢠�� '+space(15)+'���� '+'���������������������������Ĵ'
  ?space(28)+space(20)                     +        '�   �   �   �   �   �   �   �'+space(20)+'������ �ଠ � 1-��'
  ?'3 �ਬ. - ��⮯i�������  '+space(20)+        '�����������������������������'
  ?space(130)+                                                                                      '������������Ŀ'
  ?space(43)+'������ - ����������� �������� '+space(10)+'���i�___________________'+space(20)+' � '+ '�'+space(6)+str(ttnr,6)+'�'
  ?space(130)+                                                                                      '��������������'
  ?dtous(dopr)
  ?space(130)+                                                                                      '������������Ŀ'
  ?space(30)+'��⮬��i��'+padc(AtNomr,20)+space(46)+'�� ����஦�쮣� ���� � '+                     '�'+space(6)+str(mrshr,6)+'�'
  ?space(130)+                                                                                      '������������Ĵ'
  vprvr='�� �i�����஢�� ��䮬'
  if empty(navtokklr)
     ?'��⮯i�����⢮ '+padr(gcName_c,37)+space(7)+'���i� '+padr(dfior,15)+space(5)+'��� ��ॢ����� '+vprvr+' ��� '+'�  '+space(10)+'�'
  else
     ?'��⮯i�����⢮ '+padr(navtokklr,37)+space(7)+'���i� '+padr(dfior,15)+space(5)+'��� ��ॢ����� '+vprvr+' ��� '+'�  '+str(avtokkl1r,10)+'�'
  endif
  ?space(130)+                                                                                      '������������Ĵ'
  ?'��������(���⭨�) '+padr(gcName_c,107)+                                                 ' ��� '+'�            �'
  ?space(130)+                                                                                      '������������Ĵ'
  ?'���⠦��i��ࠢ��� '+padr(gcName_c,107)+                                                 ' ��� '+'�            �'
  ?space(130)+                                                                                      '������������Ĵ'
  ?'���⠦�����㢠� '+padr(getfield('t1','kplr','kln','nkl'),108)+                         ' ��� '+'�            �'
  ?space(130)+                                                                                      '������������Ĵ'
  // ?'�㭪� �����⠦���� '+padr(gcAdr_c,50)+space(2)+'�㭪� ஧���⠦���� '+padr(getfield('t1','kgpr','kln','adr'),26)+space(2)+' ������� � '+'�            �'
  ?'�㭪� �����⠦���� '+padr(adrnvr,50)+space(2)+'�㭪� ஧���⠦���� '+padr(getfield('t1','kgpr','kln','adr'),26)+space(2)+' ������� � '+'�            �'
  ?space(130)+                                                                                      '������������Ĵ'
  ?'��ॠ���㢠��� '+'_______________________________________________________'+space(5)+'1.��祯______________________________________'+' ���. � '+'�            �'
  ?space(130)+                                                                                      '������������Ĵ'
  ?'_______________________________________________________________________'+space(5)+'2.��祯______________________________________'+' ���. � '+'�            �'
  ?space(130)+                                                                                      '��������������'
  ?space(53)+'�I������I ��� ������'
  ?''
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ŀ'
  ?'��������.�   �   �  ����� �த��i�, ⮢��� � ����.��i��i���  �i��   �  �㬠   �� ���⠦���  ���    ��i��-�   ����i�   �  ���  � ����  � ��� �'
  ?'�        �       �                          �      �         �         �         �          �         �     �            �       �       �      �'
  ?'� �, ��� ��३�.�(���⠦�) ��� � ���⥩��࠳���i�.�         �         �         � �i����� ����㢠��ﳪi��� �����祭�� ����⠦㳢��⠦㳡���⮳'
  ?'�        �       �                          �      �         �         �         �          �         �     �            �       �       �      �'
  ?'�        ������i�                          �      �         �         �         ����㬥�� �         ��i���    ���    �       �       �   �  �'
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�   1    �   2   �             3            �   4  �    5    �    6    �    7    �    8     �    9    �  10 �     11     �   12  �   13  �  14  �'
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�        �       ���i��� i� ᯥ�i��i������� �      �         �         �         �          �         �     �            �       �       �      �'
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�        �       ���� � '+str(ttnr,6)+space(14)+'�      �         �         �         �          �         �     �            �       �       �      �'
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�        �       �                          �      �         �         �         �          �         �     �            �       �       �      �'
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�        �       �                          �      �         �         �         �          �         �     �            �       �       �      �'
  ?'�����������������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�                 ��쮣�                    �      �         �         �         �          �         �     ��i��.�����,�       �       �      �'
  ?'�                                           �      �         �         �         �          �         �     �   �����i�  �       �       �      �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������������������'
  ?''
  ?''
  do case
     case gnEnt=20.and.gnSk=228
          komir=subs(getfield('t1','60','speng','fio'),1,15)
     case gnEnt=21.and.gnSk=232
          komir=subs(getfield('t1','204','speng','fio'),1,15)
     case gnEnt=21.and.gnSk=700
          komir=subs(getfield('t1','946','speng','fio'),1,15)
     othe
          komir=space(15)
  endcase
  ?'��쮣� �i���饭� �� ��� '+padr(numstr(sdvr),55)+space(5)+'�i���� �������� ���i୨� '+komir+'__________________'
  ?''
  ?''
  ?'�����祭�� ���⠦ �� �ࠢ�. �������, ���'+space(2)+'�i��      '+'�'+'�����祭�� ���⠦ �� �ࠢ�. �������, ���'+space(2)+'�i��      '+space(2)+'�� ����祭�� � __________'
  ?space(56)+'�'
  ?space(56)+'�'
  ?'� ���㢠���______________________________'+space(2)+'�i��� ____ '+'�'+'� ���㢠���______________________________'+space(2)+'�i��� ____ '
  ?space(56)+'�'
  ?space(56)+'�'
  ?space(56)+'�'+space(58)+'�i� "____"______________20   �.'
  ?space(56)+'�'
  ?space(56)+'�'
  ?'��ᮩ �����, � '+padr(str(vsvr/1000,15,3),25)+'��� ��ॢ������'+          '�'+'��ᮩ �����, � '+padr(str(vsvr/1000,15,3),35)+'����'+space(3)+'�������_______________________'
  ?space(56)+'�'
  ?space(56)+'�'
  do case
     case gnEnt=20.and.gnSk=228
          ?'���� ���i୨� '+subs(getfield('t1','60','speng','fio'),1,15)+ '___________________________'+'�'+'��ᯥ���� '+padr(necsr,15)+'_______________________________'+space(2)+ '���⠦ ���ঠ�________________'
     case gnEnt=21.and.gnSk=232
          ?'���� ���i୨� '+subs(getfield('t1','204','speng','fio'),1,15)+'___________________________'+'�'+'��ᯥ���� '+padr(necsr,15)+'_______________________________'+space(2)+ '���⠦ ���ঠ�________________'
     case gnEnt=21.and.gnSk=700
          ?'���� ���i୨� '+subs(getfield('t1','946','speng','fio'),1,15)+'____________________________'+'�'+'��ᯥ���� '+padr(necsr,15)+'_______________________________'+space(2)+'���⠦ ���ঠ�________________'
     othe
         ?'����____________________________________________________'+'�'+'��ᯥ���� '+padr(necsr,15)+'_______________________________'+space(2)+'���⠦ ���ঠ�_________________'
  endcase
  ?space(56)+'�'
  ?space(56)+'�'
  ?space(56)+'�'
  ?'�਩�� ��ᯥ���� '+padr(necsr,15)+'______________________'+'�'+'�਩��_________________________________________________'+space(2)+'______________________________'
  ?space(56)+'�'
  ?space(56)+'�'
  ?''
  ?'���i�              '+padr(dfior,15)+'______________________'
  eject

  retu .t.

**************
func prntrl()
  /**************
  *clbsor=setcolor('gr+/b,n/bg')
  *wbso=wopen(10,10,15,70)
  *wbox(1)
  *store space(30) to prvzr,avtor,vodr
  *do while .t.
  *   @ 0,1 say '��ॢi���� ' get prvzr
  *   @ 1,1 say '��⮬��i�� ' get avtor
  *   @ 2,1 say '���i�      ' get vodr
  *   read
  *   if lastkey()=K_ESC.or.lastkey()=K_ENTER
  *      exit
  *   endif
  *enddo
  *wclose(wbso)
  *setcolor(clbsor)
  */
  sele PRs2m
  coun to cnt0r for kg=0
  coun to cnt1r for kg=1
  ??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p19.00h0s1b4102T'+chr(27)
  *nrowr=76
  *ncolr=166
  ?'���㯥��:  '+space(20)+getfield('t1','kplr','kln','nklprn')
  ?''
  ?'           '+space(20)+getfield('t1','kplr','kln','adr')
  ?''
  ?'�த�����: '+space(20)+getfield('t1','gnKkl_c','kln','nklprn')
  ?''
  ?'           '+space(20)+getfield('t1','gnKkl_c','kln','adr')
  ?''
  ndogtr=getfield('t1','kplr','kps','ndogt')
  ddogtr=getfield('t1','kplr','kps','ddogt')
  ?'�i��⠢�:  '+space(20)+'�����i� ��i��i-�த��� N '+ndogtr+' �i� '+space(20)+'��ॢi����: '+prvzr
  ?''
  ?'           '+space(20)+padr(dtous(ddogtr),41)                     +space(20)+'��⮬��i��: '+avtor
  ?''
  ?'           '+space(20)+space(41)                                  +space(20)+'���i�     : '+vodr
  ?''
  ?''
  ?''
  *if gnEnt=21
     ?space(40)+'����⪮�� �������� N '+str(ttnr,6)+' �i� '+dtous(dotr)
  *else
   //   ?space(40)+'���a�-�࠭ᯮ�⭠ �������� N '+str(ttnr,6)+' �i� '+dtous(dotr)
  *endif
  ?''
  ?'������������������������������������������������������������������������������������������������������������������������������Ŀ'
  ?'� N �                  ���                  ���.���i�㳊i��i��쳖i�� ��� �����i�� � �����㬠 �� ��� ���� ��� �� ���쮣� �୳'
  ?'������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�                                        �������誠, � �㫠 � ������⠭�i                                                    �'
  ?'������������������������������������������������������������������������������������������������������������������������������Ĵ'
  sele PRs2m
  go top
  nsnr=1
  store 0 to skvpr,smbndsr,smndsr,smvsr
  do while !eof()
     if kg#1
        skip
        loop
     endif
     skvpr=skvpr+kvp
     smbndsr=smbndsr+round(kvp*zen,2)
     smndsr=smndsr+round(kvp*zen/5,2)
     smvsr=smvsr+round(kvp*zen*1.2,2)
     ?'�'+str(nsnr,3)+'�'+subs(nat,1,40)+'�'+padr(nei,9)+'�'+str(kvp,9)+'�'+str(zen,12,3)+'�'+str(zen*1.2,10,2)+'�'+str(round(kvp*zen,2),16,2)+'�'+str(round(kvp*zen/5,2),9,2)+'�'+str(round(kvp*zen*1.2,2),10,2)+'�'
     if nsnr#cnt1r
        ?'������������������������������������������������������������������������������������������������������������������������������Ĵ'
     endif
     nsnr=nsnr+1
     skip
  enddo

  ?'������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�                    ��쮣�                  �         �'+str(skvpr,9)+'�'+space(12)+'�'+space(10)+'�'+str(smbndsr,16,2)+'�'+str(smndsr,9,2)+'�'+str(smvsr,10,2)+'�'
  ?'��������������������������������������������������������������������������������������������������������������������������������'
  ?''
  if cnt0r#0
     ?'����������������������������������������������������������������������������������������������Ŀ'
     ?'� N �                  ���                  ���.���i�㳊i��i��쳖i�� ��� �����㬠 �� ��� ����'
     ?'����������������������������������������������������������������������������������������������Ĵ'
     ?'�                                        �騪�, �i�����, ���� � ������                        �'
     ?'����������������������������������������������������������������������������������������������Ĵ'
     sele PRs2m
     go top
     nsnr=1
     store 0 to skvpr,smbndsr,smndsr,smvsr
     do while !eof()
        if kg#0
           skip
           loop
        endif
        skvpr=skvpr+kvp
        smbndsr=smbndsr+round(kvp*zen,2)
        ?'�'+str(nsnr,3)+'�'+subs(nat,1,40)+'�'+padr(nei,9)+'�'+str(kvp,9)+'�'+str(zen,12,3)+'�'+str(round(kvp*zen,2),16,2)+'�'
        if nsnr#cnt0r
           ?'����������������������������������������������������������������������������������������������Ĵ'
        endif
        nsnr=nsnr+1
        skip
     enddo

     ?'����������������������������������������������������������������������������������������������Ĵ'
     ?'�                    ��쮣�                  �         �'+str(skvpr,9)+'�            �'+str(smbndsr,16,2)+'�'
     ?'������������������������������������������������������������������������������������������������'
  endif
  ?''
  ?''
  ?''
  ?'�i����⠦�� (�i� �த���� ) '+getfield('t1','rs1->kto','speng','fio')+' �� �i��⠢i '+repl('_',40)
  ?''
  ?'��� '+dtous(dotr)
  ?''
  ?'�਩��     (�i� ��ॢi�����) '+padr(vodr,40)+' �� �i��⠢i '+repl('_',40)
  ?''
  ?'��� '+dtous(dotr)
  ?''
  ?'��ਬ��     (�i� �த���� ) '+repl('_',40)+' �� �i��⠢i '+repl('_',40)
  ?''
  ?'���'
  eject
  retu .t.

****************
func prnlvz()
  ****************
  LOCAL KolPos_r
  //??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
  ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p19.00h0s1b4102T'+chr(27)
  ?space(30)+'                              '+'������Ŀ'
  ?space(30)+'        ����⪮��  �������� N '+'�'+str(ttnr,6)+'�'
  ?space(30)+'                              '+'��������'
  ?''
  ?'�i��ࠢ��� ���⠦� '+getfield('t1','gnKkl_c','kln','nklprn')
  ?''
  ?'��ਬ㢠� ���⠦�  '+getfield('t1','kplr','kln','nklprn')
  ?''
  ?'��⮬��i��         '+space(1)+avtor+space(5)+'���i� '+vodr
  ?''
  ?'���                '+space(1)+prvzr+space(5)+'�� �����.���� N'+str(mrshr,6)
  ?''
  ?'                   '+space(1)+space(30)+space(5)+'����୥��� �ࠪ������ �த��i� ��i��� ����'
  ?''
  ?'                   '+space(1)+space(30)+space(5)+'N'+'_______________'+'�i�'+'"'+'_______'+'"'+'_______20'+'____�.'
  ?''
  ?'�㭪�              '
  ?'஧���⠦����      '+getfield('t1','kplr','kln','adr')
  ?''
  ?''
  ?'���������������������������������������������������������������������������������������������������Ŀ'
  ?'�         �          ������㢠���             � �i�� ��  �  �i�� ��   ��i��i��� �����i��� � ���   �'
  ?'�   ���   �            ���⠦�                � �������  �  �������   ����������Ĵ   ��   �஧���� �'
  ?'�         �                                   ���(� ���)���(��� ���)�㯠����� �(��� ���)�        �'
  ?'�����������������������������������������������������������������������������������������������������'
  ?''
  store 0 to smpr,smtr
  sele PRs2
  go top
  KolPos_r:=0
  do while !eof()
     ktlr=ktl
     if int(ktlr/1000000)=0
        skip
        loop
     endif
     natr=alltrim(nat)
     zenr=zen
     zen20r=round(zenr*1.2,2)
     kvpr=kvp
     svpr=svp
     smpr=smpr+svpr
     if len(natr)<=34
        ?' '+StrKtlr9(Ktlr,KolPos_r)+' '+natr+'  '+str(zen20r,10,2)+'   '+str(zenr,10,2)+space(4)+'  '+str(kvpr,5)+' '+str(svpr,9,2)
     else
        ?' '+StrKtlr9(Ktlr,KolPos_r)+' '+subs(natr,1,34)+'  '+str(zen20r,10,2)+'   '+str(zenr,10,2)+space(4)+'  '+str(kvpr,5)+' '+str(svpr,9,2)
        ?''
        ?' '+space(9)+' '+subs(natr,35)
     endif
     ?''
     sele PRs2
     skip
     KolPos_r++
  enddo
  ?'��쮣� �� �த��i�   : '+space(35)+str(smpr,10,2)
  ?'����������������������������������������������������������������������������������������������������'
  ?''
  ?'���                  :'
  ?''
  sele PRs2
  go top
  KolPos_r:=0
  do while !eof()
     ktlr=ktl
     if int(ktlr/1000000)#0
        skip
        loop
     endif
     natr=alltrim(nat)
     zenr=zen
     zen20r=0
     kvpr=kvp
     svpr=svp
     smtr=smtr+svpr
     if len(natr)<=34
        ?' '+StrKtlr9(Ktlr,KolPos_r)+' '+natr+'  '+str(zen20r,10,2)+'   '+str(zenr,10,2)+space(4)+'  '+str(kvpr,5)+' '+str(svpr,9,2)
     else
        ?' '+StrKtlr9(Ktlr,KolPos_r)+' '+subs(natr,1,34)+'  '+str(zen20r,10,2)+'   '+str(zenr,10,2)+space(4)+'  '+str(kvpr,5)+' '+str(svpr,9,2)
        ?''
        ?' '+space(9)+' '+subs(natr,35)
     endif
     ?''
     sele PRs2
     skip
     KolPos_r++
  enddo
  ?'��쮣� �� ������ ���: '+space(35)+str(smtr,10,2)
  ?''
  ?'����������������������������������������������������������������������������������������������������'
  ?''
  ?'�࠭ᯮ��i �����   : '+space(35)+str(getfield('t1','ttnr,61','rs3','ssf'),10,2)
  ?''
  ?'��i� ⮣� ���         : '+space(35)+str(getfield('t1','ttnr,11','rs3','ssf'),10,2)
  ?''
  ?'��쮣�                : '+space(35)+str(getfield('t1','ttnr,90','rs3','ssf'),10,2)
  ?''
  ?'��樧��� ��i�           '+'__________________________'+'���⠦��� __________________________________'
  ?''
  ?'�������� �i����        '+subs(getfield('t1','rs1->kto','speng','fio'),1,15)+'������臘���� N '+'_________�i�____________'
  ?''
  if gnEntRm=0
     ?'���⠦ �i����⨢        '+subs(getfield('t1','204','speng','fio'),1,15)+'              �i����    _________ ______________'
  else
     ?'���⠦ �i����⨢        '+subs(getfield('t1','946','speng','fio'),1,15)+'              �i����    _________ ______________'
  endif
  ?''
  ?'                        '+'        �.�.'
  ?'���⠦ �਩�� ���i�-��ᯥ���� '+vodr+' �i����    _______ ______ ____________'
  ?''
  ?'����������������������������������������������������������������������������������������������������'
  ?''
  ?'�i��i⪨ ��ਬ㢠� ���⠦�:'
  ?''
  ?'���⠦ ���ঠ�  ___________________________________ ________________________ _______________________'
  ?''
  ?'                            �i� �ᮡ�                        �i����                  ���       '
  ?''
  ?'�� ����祭�� N '+'______________�i�______________________     �.�.'
  ?''
  ?'�i��i��� �i��� '+'______________⮭�� '+str(vsvr/1000,10,3)+'�'

  eject
  retu .t.
***************************
func nofprz(p1)
   // p1 0 - ����; 1- ���
  ***************************
  local otgr
  if empty(p1)
    otgr=0
  else
    otgr=1
  endif
  sele rs1
  if kop#169
     retu .t.
  endif
  if ttn=ttnr
     if gnArm=25
        reclock()
        if prz=0
           if empty(dop)
               // ���㧪�
              sele rs2
              set orde to tag t3
              if netseek('t3','ttnr')
                 do while ttn=ttnr
                    mntovr=mntov
                    ktlr=ktl
                    kvpr=kvp
                    sele tov
                    set orde to tag t1
                    if netseek('t1','sklr,ktlr')
                       netrepl('osfo','osfo-kvpr')
                    endif
                    if gnCtov=1
                       sele tovm
                       set orde to tag t1
                       if netseek('t1','sklr,mntovr')
                          netrepl('osfo','osfo-kvpr')
                       endif
                    endif
                    sele rs2
                    netrepl('prosfo','1')
                    skip
                 enddo
              endif
              sele rs1
              netrepl('dop','date()',1)
              dopr=dop
           endif
           if otgr=0
               // ���⢥ত����
              sele rs2
              set orde to tag t3
              if netseek('t3','ttnr')
                 do while ttn=ttnr
                    mntovr=mntov
                    ktlr=ktl
                    kvpr=kvp
                    sele tov
                    set orde to tag t1
                    if netseek('t1','sklr,ktlr')
                       netrepl('osf','osf-kvpr')
                    endif
                    if gnCtov=1
                       sele tovm
                       set orde to tag t1
                       if netseek('t1','sklr,mntovr')
                          netrepl('osf','osf-kvpr')
                       endif
                    endif
                    sele rs2
                    skip
                 enddo
                 sele rs1
                 netrepl('dot,prz','date(),1')
                 dopr=dop
              endif
           endif
        endif
     endif
  endif
  retu .t.

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-05-18 * 01:39:26pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION aaa1_add(aMess)
  LOCAL aaa1
  aaa1:=''
  if prUpr=1
    aaa1+=' '+ aMess[1] //'������'
  else
    if PrnOprnr=1
      aaa1+=' '+aMess[2]//'RESURS'
    else
      if 'U' $ TYPE('NoPrnr') .or. NoPrnr=0
        aaa1+=' '+aMess[2]//'RESURS'
      else
        aaa1+=''
      endif
    endif
  endif
  RETURN (aaa1)


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  09-12-18 * 02:08:43pm
 ����������......... �ਧ��� �१���� ����
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION prUpr(prUpr)
  DEFAULT prUpr TO 0
  do case
  case gnRasc=2
    prUpr:=1
  case gnRasc=1
    do case
    case kopr=169
      if mk169r#0.and.pr169r#2
        prUpr:=1
      endif
    case kopr=129
      if mk129r#0.and.pr129r#2
        prUpr:=1
      endif
    case kopr=139
      if mk139r#0.and.pr139r#2
         prUpr:=1
      endif
    endcase
  endcase
  RETURN (prUpr)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  01-14-19 * 04:32:41pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION StrKtlr9(ktlr,kolpos_r)
  // .F. - �뢮� 9-� ���筮�� ��
  // .�. - �뢮� �� ����� ���. ����樨 � ���� ��᫥���� ��� ��
  RETURN (Iif(.F.,str(ktlr,9),PadR(allt(str(kolpos_r+1,3)),3)+substr(str(ktlr,9),4,6)))


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  06-26-19 * 10:34:56am
 ����������......... �஢�ઠ ����� �뢮���� ��
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION Show_Kta(nl_ktar,nl_kopr)
  LOCAL lShow:=.T.
  // outlog(__FILE__,__LINE__,nl_ktar,nl_kopr,ProcName(-1),ProcLine(-1))
  Do Case
  Case nl_kopr=169
    lShow:=.F.
  Case rs1->(pr177_or('2;'))
    lShow:=.F.
  Case nl_ktar#0 // �� ࠢ�� ���
    lShow:=.T.
  OtherWise
    lShow:=.F.
  EndCase

  RETURN (lShow)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  06-26-19 * 11:00:36am
 ����������......... �뢮� ������� � �易���� ���
 ���������..........
 �����. ��������....
 ����������.........
 */
static Function Say_Dogvir(nl_ttnpr,nl_ttncr,nl_kopr)
  LOCAL  cSay_Dogvir:=;
  ' �����i� '+str(getfield('t1','kplr','klndog','ndog'),6);
  +' �i� '+dtoc(getfield('t1','kplr','klndog','dtdogb'));
  +iif(nl_ttnpr#0,' '+str(ttnpr,6),'')+iif(nl_ttncr#0,' '+str(ttncr,6),'')

  Do Case
  Case nl_kopr=169
    cSay_Dogvir:=''
  Case rs1->(pr177_or('2;'))
    cSay_Dogvir:=''
  EndCase

  Return (cSay_Dogvir)

FUNCTION PrnFToken(cFile)
  LOCAL nError, cLine
    nError := FTOKENINIT(cFile, CRLF, 2)
    IF (!(nError < 0))
        WHILE (! FTOKENEND())
          cLine:=FTOKENNEXT()
          IF RIGHT(cLine,1)=CHR(13)
            outlog(3,__FILE__,__LINE__,"CHR(13)")
            ??LEFT(cLine,LEN(cLine)-1);?
          ELSE
            outlog(3,__FILE__,__LINE__,"NOT CHR(13)")
            ??cLine;?
          ENDIF
        ENDDO
    ENDIF
    FTOKENCLOS()
    RETURN (NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  01-29-20 * 03:05:19pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION l_prUpr(prUpr,kopr,kkr)
  LOCAL l_prUpr
  If prUpr=0
    If (kopr=126 .and. kkr>1)
      l_prUpr:=1 //��祭��
    Else
      l_prUpr:=prUpr
    EndIf
  Else
    l_prUpr:=prUpr
  EndIf
  RETURN (l_prUpr)


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  02-10-20 * 02:00:20pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION UpdateNat()
  RETURN ( NIL) // ��६ �� ��ࠢ�稪� ��� ������

  // ������� �� ���
  DBGoTop()
  Do While !eof()
    natr:=natr(natr, dvpr)
    If !Empty(natr)
      netrepl('nat',{natr})
    EndIf
    DBSkip()
  EndDo

  RETURN ( NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  02-10-20 * 02:45:00pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION natr(natr, dvpr)
  If gnEnt = 20
    If "/NatCros" $ DOSPARAM() .or. dvpr >= STOD("20200701")
      MnTovr=_FIELD->mntov
      MnTovTr:=getfield('t1','MnTovr','ctov','MnTovT')
      mkcrosr:=getfield('t1','MnTovTr','ctov','mkcros')
      If !Empty(mkcrosr)
        natr:=getfield('t1','mkcrosr','mkcros','NmKId')
      EndIf
    Else
      //
    EndIf
  Else
    //
  EndIf

  RETURN (allt(Upper(natr)))


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  06-25-20 * 11:05:49am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION nat_r(nat_r,dvpr)
  If gnEnt = 20
    nat_r:=natr(natr,dvpr)
  else
    //
  EndIf

  RETURN (nat_r)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  02-11-20 * 03:59:04pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION Uktr()
  RETURN ( iif(!empty(Uktr) .and. prUpr=0,;
            ' /'+alltrim(Uktr)+' / '+LTRIM(STR(KProdr)),;
               ''))
/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  06-29-20 * 10:32:37am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION Create_PRs2Grp()
  LOCAL cSel:=Select()
  LOCAL cNmLocalGrp
  if select('PRs2grp')#0
    sele PRs2grp
    use
    Select (cSel)
  endif

  copy stru to PRs2Grp
  use PRs2Grp new Exclusive

  sele PRs2
  go top
  Do While !eof()

    cNmLocalGrp:=cNmLocalGrp(nat,ktl)

    sele PRs2Grp
    //LOCATE FOR Left(nat,nPosLocalGrp-1) == cNmLocalGrp
    LOCATE FOR allt(nat) == cNmLocalGrp
    If !found()
      PRs2Grp->(DBAppend(),_Field->Nat := cNmLocalGrp)
    EndIf
    PRs2Grp->kvp += PRs2->kvp

    sele PRs2
    DBSkip()
  EndDo
  sele PRs2Grp
  //Browse()
  //zap
  Select (cSel)
  RETURN ( NIL )

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  06-29-20 * 10:35:08am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION cNmLocalGrp(nat, ktl)
  LOCAL cNmLocalGrp

  nPosLocalGrp:=AT("_", nat)
  If nPosLocalGrp = 0
    cNmLocalGrp := "����� �����쭮� ��㯨 " + allt(str(int(ktl/1000000)))
  Else
    cNmLocalGrp := Left(nat, nPosLocalGrp-1)
  EndIf

  outlog(3,__FILE__,__LINE__,nat)
  outlog(3,__FILE__,__LINE__,nPosLocalGrp,cNmLocalGrp)
  RETURN (cNmLocalGrp)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  02-13-21 * 09:54:02am
 ����������......... �뢮� �ᯥ����
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION QOut_forwarder()
  IF vzz#3.and.!(kopr=177.and.(vzz=1.or.vzz=3))
    IF kecsr#0
        if kopr#168.or.kopr=168.and.((vzz=1.or.vzz=3).and.kkr#2.or.vzz#1)
          if rs1->prZZen=0
              if .t.
                if str(kopr,3) $ '169;126'.or.gnEntRm=1.and.svczr=0
                    ?''
                else
                    ?''
                    ?'��ᯥ����  ' +getfield('t1','kecsr','s_tag','fio') + '   _____________________'
                    ?''
                    ?'�������� �� ���i���i:____________________________    _______________________'
                endif
              else
                ?''
                ?'��ᯥ����: ' +getfield('t1','kecsr','s_tag','fio')
                ?''
                ?'�������� �� ���i���i:____________________________    _______________________'
              endif
          else
              ?''
          endif
          rsle()
        endif
    ENDIF
    ?textr
    rsle()
  endif
  RETURN ( NIL )
