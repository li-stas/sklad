// ����㧪� ����࠭ᯮ��
#include "common.ch"
#include "inkey.ch"
LOCAL lAccDeb
set colo to g/n, n/g,,,
clea
if (!netuse('cMrsh'))
  return
endif

prnppr=0
fopr=1                      // ��� ����⭮� ���� ��

if (!netfile('cMrsho'))
  crddop('cMrsho')
  netuse('cMrsho')
  netadd()
  nuse('cMrsho')
endif

netuse('atran')
netuse('czg')
netuse('kln')
netuse('speng')
netuse('s_tag')
netuse('atvm')
netuse('atvme')
netuse('cskl')
netuse('cskle')
netuse('mkeep')
netuse('mkeepe')
netuse('kpl')
netuse('kgp')
netuse('krn')
netuse('knasp')
netuse('ctov')
netuse('cgrp')
netuse('banks')
netuse('klndog')
netuse('klnnac')
netuse('GrpE')
netuse('dclr')
netuse('mvz')
netuse('dkkln')
netuse('dknap')
netuse('bs')
netuse('nnds')
netuse('dokk')
netuse('fop')
netuse('kspovo')
netuse('tov')
netuse('sgrp')
    if (file(gcPath_ew+"deb\accord_deb"+".dbf"))
      netuse('dkkln')
      use (gcPath_ew+"deb\accord_deb") ALIAS skdoc NEW SHARED READONLY
      SET ORDER to TAG t1
      lAccDeb:=.T.
    endif


crtt('ATtnTemp', "f:ent c:n(2) f:sk c:n(3) f:ttn c:n(6) f:Mrsh c:n(6) f:kecs c:n(3) f:necs c:c(12) f:kta c:n(4) f:nkta c:c(12) f:dtpoe c:d(8) f:dop c:d(8) dvzttn c:d(8) f:kop c:n(3) f:sdv c:n(12,2) f:sdvu c:n(12,2)")
sele 0
use ATtnTemp excl
inde on str(ent, 2)+str(sk, 3)+str(ttn, 6)+str(Mrsh, 6) tag t1
inde on dtos(dtpoe)+str(Mrsh, 6)+str(ent, 2)+str(sk, 3)+str(ttn, 6) tag t2
set orde to tag t1

crtt('AtTemp', "f:Mrsh c:n(6)")
sele 0
use AtTemp excl
inde on str(Mrsh, 6) tag t1

crtt('AtDocs', "f:Mrsh c:n(6) f:ent c:n(2) f:sk c:n(3) f:ttn c:n(6) f:vo c:n(2) f:kop c:n(3) f:kkl c:n(7) f:nkl c:c(30) f:vsv c:n(11,3) f:vsvb c:n(11,3) f:sdvu c:n(15,2) f:sdv c:n(15,2) f:dsp c:d(10) f:dot c:d(10) f:tot c:c(8) f:pri c:n(1) f:tsp c:c(8) f:vMrsh c:n(2) f:dtro c:d(10) f:vts c:c(1) f:mppsf c:n(2) f:pvt c:n(1) f:kta c:n(4) f:vz c:n(2) f:ttnp c:n(6) f:ttnc c:n(6) f:kpl c:n(7) f:ktas c:n(4) f:ztxt c:c(200) f:pl c:n(7) f:gp c:n(7) f:d0k1 c:n(1)")
sele 0
use AtDocs excl
inde on str(ent, 2)+str(sk, 3)+str(ttn, 6) tag t1
inde on str(Mrsh, 6)+str(ent, 2)+str(sk, 3)+str(ttn, 6) tag t2
inde on str(pri, 1)+nkl tag t3
inde on str(ent, 2)+str(sk, 3)+str(d0k1, 1)+str(ttn, 6) tag t4
inde on str(Mrsh, 6)+str(ent, 2)+str(sk, 3)+str(d0k1, 1)+str(ttn, 6) tag t5
set orde to tag t1

sele cMrsh
set orde to tag t1
go top

atrcr=1
while (.t.)
  /*if gnAdm=0 */
  //   arcr:={'�����','��த','��⠫��'}
  /*else */
  if (gnEnt=20)
    arcr:={ '�����', '��த', '��⠫��', '�������' }
  else
    arcr:={ '�����', '��த', '��⠫��' }
  endif

  /*endif */
  atrcr=alert('�롮�', arcr)
  if (lastkey()=K_ESC)
    exit
  endif

  if (atrcr=3)
    atrcr=0
  endif

  if (select('sl')=0)
    sele 0
    use _slct alias sl excl
  endif

  sele sl
  zap
  prAllr=0
  AtTempr=1
  if (gdTd=date())
    if (prAllr=0)
      forr='(dMrsh>date()-15.or.prZ=0)'
      for_r='(dMrsh>date()-15.or.prZ=0)'
    else
      forr='.t.'
      for_r='.t.'
    endif

  else
    forr='.t.'
    for_r='.t.'
  endif

  anom_r=space(10)
  afor_r='.t.'
  save scre to scczg
  sele cMrsh
  set orde to tag t3
  netseek('t3', 'atrcr')
  rcMrshr=recn()
  rcMrsh1r=recn()
  rcMrsh2r=recn()
  prAndr=0
  nrzasdvr=0
  MrshDelr=0
  prDelr=0
  fldnomr=1
  while (.t.)
    sele cMrsh
    dbunlock()
    if (prAndr=0.or.prAndr=2.or.prAndr=3)
      set orde to tag t3
      rcMrshr=rcMrsh1r
      if (rcMrshr=0)
        sele cMrsh
        set orde to tag t3
        netseek('t3', 'atrcr')
        rcMrshr=recn()
      endif

      go rcMrshr
    else
      set orde to tag t4
      rcMrshr=rcMrsh2r
      go rcMrshr
    endif

    set cent off
    do case
    case (prAndr=0.and.atrcr=4)
      foot('F2,F3,F4,F5,F6,F7,F8,F9,F10', '�� 䠩��,����,����,��猠�,����,�����,����,��燠��,�����')
      //              rcMrshr=slce('cMrsh',1,,18,,"e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�����. ' c:c(7) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:vsvb h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ���' c:c(8) e:dfio h:'����⥫�' c:c(8) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1)",,,1,'atrc=atrcr',forr,,'�������� ����� 3 �������')
      rcMrshr=slce('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�����. ' c:c(7) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:vsvb h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ���' c:c(8) e:dfio h:'����⥫�' c:c(8) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1) e:anom h:'�����' c:c(10)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 3 �������')
      rcMrsh1r=rcMrshr
    case (prAndr=0.and.atrcr#4)
      foot('F2,F3,F4,F5,F6,F7,F8,F9,F10', '���,����,����,��猠�,����,�����,����,��燠�,�����')

      if (MrshDelr=0)
        if (fieldpos('vsvb')=0)
          rcMrshr=;
          slcf('cMrsh', 1,, 18,, ;
          "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�������' c:c(8) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(9) e:dfio h:'����⥫�' c:c(9) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 3 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
        else
          //                    rcMrshr=slce('cMrsh',1,,18,,"e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�������' c:c(8) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:vsvb h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(9) e:dfio h:'����⥫�' c:c(9) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1)",,,1,'atrc=atrcr',forr,,'�������� ����� 3 '+iif(atrcr=1,'ࠩ��',iif(atrcr=2,'��த','��⠫��')))
          if (fieldpos('sdvu')=0)
            rcMrshr=slce('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�����. ' c:c(7) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:vsvb h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ���' c:c(8) e:dfio h:'����⥫�' c:c(8) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 3 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
          else
            if (gnEnt=20)
              rcMrshr=slce('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�����.' c:c(6) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5)  e:vsvb h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ���' c:c(8) e:dfio h:'����⥫�' c:c(8) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1) e:sdvu h:'�� ��' c:n(6)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 3 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
            else
              rcMrshr=slce('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�����.' c:c(6) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:sdvu h:'�� ��' c:n(6) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ���' c:c(8) e:dfio h:'����⥫�' c:c(8) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1) e:prZo h:'�' c:n(1) e:vsvb h:'���' c:n(5)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 3 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
            endif

          endif

        endif

      else
        rcMrshr=slcf('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�������' c:c(8) e:iif(deleted(),'��','  ') h:'��' c:c(2) e:anom h:'�����' c:c(6) e:ogrpod h:'��' c:n(4,1) e:vsv h:'���' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(9) e:dfio h:'����⥫�' c:c(9) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 3 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��'))+' � 㤠����묨')
      endif

      rcMrsh1r=rcMrshr
    case (prAndr=1)
      foot('F2,F3,F4,ENTER', '���,������,����,����')
      rcMrshr=slcf('cMrsh', 1,, 18,, "e:anom h:'�����' c:c(6) e:dMrsh h:'���' c:d(8) e:msdv h:'�㬬���' c:n(10,2) e:Mrsh h:' N' c:n(6) e:nMrsh h:'�������' c:c(10) e:cntkkl h:'KM' c:n(2) e:getfield('t1','cMrsh->atran','atran','natran') h:'�࠭ᯮ��' c:c(10) e:atrc h:'  ' c:n(2) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(14) e:prZ h:'�' c:n(1)",,, 1,, forr,, '�������� ����� 1 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
      rcMrsh2r=rcMrshr
    case (prAndr=2)
      foot('INS,DEL,ENTER,F2,F4,F5,F6,F7,F8,F9,F10', '���,����,����,���,����,���.�����,����,���.���,����,��燠��,�����')
      rcMrshr=slcf('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'���ࠢ�����' c:c(20) e:getfield('t1','cMrsh->katran','kln','nkl') h:'�࠭ᯮ��' c:c(19) e:getfield('t1','cMrsh->katran','kln','tlf') h:'��' c:c(4) e:vsv h:'��� ��' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(10) e:prZ h:'�' c:n(1) e:dMrsh h:'���' c:d(8)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 2 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
      rcMrsh1r=rcMrshr
    case (prAndr=3)
      foot('INS,DEL,ENTER,F2,F4,F5,F6,F7,F8,F9,F10', '���,����,����,���,����,���.�����,����,���.���,����,��燠��,�����')
      rcMrshr=slcf('cMrsh', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:nMrsh h:'�������' c:c(10) e:cntkkl h:'KM' c:n(2) e:anom h:'�����' c:c(6) e:getfield('t1','cMrsh->atran','atran','natran') h:'�࠭ᯮ��' c:c(10) e:getfield('t1','cMrsh->atran','atran','grpod') h:'��' c:n(2) e:vsv h:'��� ��' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(11) e:prZ h:'�' c:n(1) e:dMrsh h:'���' c:d(8)",,, 1, 'atrc=atrcr', forr,, '�������� ����� 0 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��')))
      rcMrsh1r=rcMrshr
    endcase

    set cent on
    sele cMrsh
    go rcMrshr
    Mrshr=Mrsh
    mrc_r=recn()
    nMrshr=nMrsh
    premr=prem

    prZor=iif(fieldpos('prZo')#0 ,prZo,0) // �ਧ��� �⡮ન
    Mrshpr=iif(fieldpos('Mrshp')#0,Mrshp,0)
    vsvbr=iif(fieldpos('vsvb')#0,vsvb,0)
    sdvur=iif(fieldpos('sdvu')#0,sdvu,  0)
    svczr=iif(fieldpos('svcz')#0,svcz,0)  // �����뢮�/����஧����

    ogrpodr=ogrpod
    katranr=katran
    katranpr=katranp
    atranr=atran
    if (katranr=0)
      natranr=space(20)
      grpodr=0
      kmr=0
    else
      natranr=getfield('t1', 'katranr', 'kln', 'nkl')
      grpodr=val(getfield('t1', 'katranr', 'kln', 'tlf'))
      kmr=val(getfield('t1', 'katranr', 'kln', 'ns1'))
      natranr=alltrim(natranr)+' '+str(grpodr, 4, 1)+' �'
    endif

    if (katranpr=0)
      natranpr=''
      grpodpr=0
      kmpr=0
    else
      natranpr=getfield('t1', 'katranpr', 'kln', 'nkl')
      grpodpr=val(getfield('t1', 'katranpr', 'kln', 'tlf'))
      kmpr=val(getfield('t1', 'katranpr', 'kln', 'ns1'))
      natranpr=alltrim(natranpr)+' '+str(grpodpr, 4, 1)+' �'
    endif

    anomr=anom
    dfior=dfio
    ktor=kto
    ktar=kta
    kecsr=kecs
    if (deleted())
      prDelr=1
    else
      prDelr=0
    endif

    mvsvr=vsv
    msdvr=sdv
    asdvr=msdv
    mrstr=mrst
    dtpoer=dtpoe
    prZr=prZ
    dMrshr=dMrsh
    vMrshr=vMrsh
    nvMrshr=getfield('t1', 'vMrshr', 'atvm', 'nvMrsh')
    necsr=getfield('t1', 'kecsr', 's_tag', 'fio')
    nktar=getfield('t1', 'ktar', 'speng', 'fio')
    nktor=getfield('t1', 'ktor', 'speng', 'fio')

    //outlog(__FILE__,__LINE__,prAndr,prZr,prZor,'prAndr,prZr,prZor')
    do case
    case (lastkey()=K_ESC)   // ��室
      set dele on
      exit
    case (lastkey()=K_LEFT)   // Left
      fldnomr=fldnomr-1
      if (fldnomr=0)
        fldnomr=1
      endif

    case (lastkey()=K_RIGHT)    //
      fldnomr=fldnomr+1
    case (lastkey()=K_F2)   // ���
      if (atrcr#4)
        do case
        case (prAndr=0)
          prAndr=1
          forr=afor_r
          set orde to tag t4
          go top
        case (prAndr=1)
          prAndr=2
          forr=for_r
          set orde to tag t3
          netseek('t3', 'atrcr')
        case (prAndr=2)
          prAndr=3
        case (prAndr=3)
          prAndr=0
        endcase

      else
        Mrsh19i()           // ����㧨�� ��⮢� �������� �� �������
      endif

      rcMrshr=recn()
    case (lastkey()=K_ALT_F2) // =-31  // �뫮���� �� ��� ������⮢ ��������
      //         Mrsh19o()
    case (lastkey()=K_ALT_F3.and.MrshDelr=0.and.prAndr#1) // =-32
      sele AtTemp
      if (recc()#0)
        zap
      endif

      AtTempr=1
      atemp:={ '��', '�� ���㦥���', '�� �����饭��' }
      AtTempr=alert('��������', atemp)
      if (lastkey()=K_ESC)
        loop
      endif

      do case
      case (AtTempr=1)    // ��
        if (recc()#0)
          sele AtTemp
          zap
        endif

        forr=for_r
        sele cMrsh
        set orde to tag t3
        netseek('t3', 'atrcr')
        rcMrshr=recn()
        rcMrsh1r=recn()
        rcMrsh2r=recn()
      case (AtTempr=2)    // �� ���㦥���
        sele czg
        if (fieldpos('dop')#0)
          set orde to tag t1
          sele cMrsh
          if (netseek('t3', 'atrcr'))
            while (atrc=atrcr.and.prZ#2)
              Mrsh_r=Mrsh
              sele czg
              if (netseek('t1', 'Mrsh_r'))
                while (Mrsh=Mrsh_r)
                  if (empty(dop))
                    sele AtTemp
                    appe blank
                    repl Mrsh with Mrsh_r
                  endif

                  sele czg
                  skip
                enddo

              endif

              sele cMrsh
              skip
            enddo

            sele AtTemp
            if (recc()#0)
              sele cMrsh
              if (netseek('t3', 'atrcr'))
                rcMrsh1r=recn()
                forr=for_r+".and.netseek('t1','cMrsh->Mrsh','AtTemp')"
                loop
              endif

            endif

          endif

        endif

      case (AtTempr=3)    // �� �����饭��
        sele czg
        if (fieldpos('dvzttn')#0)
          set orde to tag t1
          sele cMrsh
          if (netseek('t3', 'atrcr,2'))
            while (atrc=atrcr.and.prZ=2)
              Mrsh_r=Mrsh
              sele czg
              if (netseek('t1', 'Mrsh_r'))
                while (Mrsh=Mrsh_r)
                  if (empty(dvzttn))
                    sele AtTemp
                    appe blank
                    repl Mrsh with Mrsh_r
                  endif

                  sele czg
                  skip
                enddo

              endif

              sele cMrsh
              skip
            enddo

            sele AtTemp
            if (recc()#0)
              sele cMrsh
              if (netseek('t3', 'atrcr'))
                rcMrsh1r=recn()
                forr=for_r+".and.netseek('t1','cMrsh->Mrsh','AtTemp')"
                loop
              endif

            endif

          endif

        endif

      endcase

    case (lastkey()=K_ALT_F4.and.MrshDelr=0.and.prAndr#1)// =-33
      store gdTd to dt1r, dt2r
      cldtpoe=setcolor('gr+/b,n/w')
      wdtpoe=wopen(7, 10, 10, 60)
      wbox(1)
      @ 0, 1 say '��ਮ� ������� '
      @ 0, col()+1 get dt1r
      @ 0, col()+1 get dt2r
      read
      wclose(wdtpoe)
      setcolor(cldtpoe)
      if (lastkey()=K_ESC)
        loop
      endif

      sele ATtnTemp
      if (recc()#0)
        zap
      endif

      ATtnTempr=1
      atemp:={ '�� ���㦥���', '�� ����� 2', '���.�� �����.' }
      ATtnTempr=alert('���', atemp)
      if (lastkey()=K_ESC)
        loop
      endif

      do case
      case (ATtnTempr=1)  // �� ���㦥���
        sele czg
        if (fieldpos('dop')#0)
          set orde to tag t1
          sele cMrsh
          if (netseek('t3', 'atrcr'))
            while (atrc=atrcr.and.prZ#2)
              if (dtpoe<dt1r.or.dtpoe>dt2r)
                sele cMrsh
                skip
                loop
              endif

              dtpoe_r=dtpoe
              Mrsh_r=Mrsh
              kecs_r=kecs
              necs_r=getfield('t1', 'kecs_r', 's_tag', 'fio')
              sele czg
              if (netseek('t1', 'Mrsh_r'))
                while (Mrsh=Mrsh_r)
                  if (!empty(dop))
                    sele czg
                    skip
                    loop
                  endif

                  sk_r=sk
                  ttn_r=ttn
                  if (fieldpos('kta')#0)
                    kta_r=kta
                  else
                    kta_r=0
                  endif

                  nkta_r=getfield('t1', 'kta_r', 's_tag', 'fio')
                  sele ATtnTemp
                  appe blank
                  repl Mrsh with Mrsh_r, ;
                   sk with sk_r,         ;
                   ttn with ttn_r,       ;
                   kecs with kecs_r,     ;
                   necs with necs_r,     ;
                   kta with kta_r,       ;
                   nkta with nkta_r,     ;
                   dtpoe with dtpoe_r
                  sele czg
                  skip
                enddo

              endif

              sele cMrsh
              skip
            enddo

            sele ATtnTemp
            go top
            rctnr=slcf('ATtnTemp', 1,, 18,, "e:sk h:'SK' c:n(3) e:ttn h:'���' c:n(6) e:Mrsh h:' N' c:n(6) e:dtpoe h:'��� �' c:d(10) e:kecs h:'��' c:n(3) e:necs h:'��ᯥ����' c:c(11) e:kta h:'���' c:n(4) e:nkta h:'�����' c:c(11) ",,,,,, 'n/bg,n/w', '��� �� ���㦥��� '+dtoc(dt1r)+' '+dtoc(dt2r))
            sele cMrsh
          endif

        endif

      case (ATtnTempr=2)  // �� �����饭�� 2
        sele czg
        if (fieldpos('dop')#0)
          set orde to tag t1
          sele cMrsh
          set orde to tag t3
          if (netseek('t3', 'atrcr,2'))
            while (atrc=atrcr)
              if (dtpoe<dt1r.or.dtpoe>dt2r)
                sele cMrsh
                skip
                loop
              endif

              Mrsh_r=Mrsh
              dtpoe_r=dtpoe
              kecs_r=kecs
              necs_r=getfield('t1', 'kecs_r', 's_tag', 'fio')
              sele czg
              if (netseek('t1', 'Mrsh_r'))
                while (Mrsh=Mrsh_r)
                  if (!empty(dvzttn))
                    sele czg
                    skip
                    loop
                  endif

                  sk_r=sk
                  ttn_r=ttn
                  if (fieldpos('kta')#0)
                    kta_r=kta
                  else
                    kta_r=0
                  endif

                  nkta_r=getfield('t1', 'kta_r', 's_tag', 'fio')
                  sele ATtnTemp
                  appe blank
                  repl Mrsh with Mrsh_r, ;
                   sk with sk_r,         ;
                   ttn with ttn_r,       ;
                   kecs with kecs_r,     ;
                   necs with necs_r,     ;
                   kta with kta_r,       ;
                   nkta with nkta_r,     ;
                   dtpoe with dtpoe_r
                  sele czg
                  skip
                enddo

              endif

              sele cMrsh
              skip
            enddo

            sele ATtnTemp
            go top
            set cent off
            rctnr=slcf('ATtnTemp', 1,, 18,, "e:sk h:'SK' c:n(3) e:ttn h:'���' c:n(6) e:Mrsh h:' N' c:n(6) e:dtpoe h:'��� �' c:d(8) e:kecs h:'��' c:n(3) e:necs h:'��ᯥ����' c:c(11) e:kta h:'���' c:n(4) e:nkta h:'�����' c:c(11) ",,,,,, 'n/bg,n/w', '��� �� �����饭�� '+dtoc(dt1r)+' '+dtoc(dt2r))
            set cent on
            sele cMrsh
          endif

        endif

      case (ATtnTempr=3)  // ���㦥��� �� �����饭��
        sele czg
        if (fieldpos('dop')#0)
          set orde to tag t1
          sele cMrsh
          set orde to tag t3
          if (netseek('t3', 'atrcr'))
            while (atrc=atrcr)
              if (dtpoe<dt1r.or.dtpoe>dt2r)
                sele cMrsh
                skip
                loop
              endif

              Mrsh_r=Mrsh
              dtpoe_r=dtpoe
              kecs_r=kecs
              necs_r=getfield('t1', 'kecs_r', 's_tag', 'fio')
              sele czg
              if (netseek('t1', 'Mrsh_r'))
                while (Mrsh=Mrsh_r)
                  if (empty(dop))
                    sele czg
                    skip
                    loop
                  endif

                  if (!empty(dvzttn))
                    sele czg
                    skip
                    loop
                  endif

                  sk_r=sk
                  ttn_r=ttn
                  kop_r=kop
                  sdv_r=sdv
                  if (fieldpos('sdvu')#0)
                    sdvu_r=sdvu
                  else
                    sdvu_r=0
                  endif

                  if (fieldpos('kta')#0)
                    kta_r=kta
                  else
                    kta_r=0
                  endif

                  dop_r=dop
                  nkta_r=getfield('t1', 'kta_r', 's_tag', 'fio')
                  sele ATtnTemp
                  appe blank
                  repl Mrsh with Mrsh_r, ;
                   sk with sk_r,         ;
                   ttn with ttn_r,       ;
                   kecs with kecs_r,     ;
                   necs with necs_r,     ;
                   kta with kta_r,       ;
                   nkta with nkta_r,     ;
                   dtpoe with dtpoe_r,   ;
                   dop with dop_r,       ;
                   kop with kop_r,       ;
                   sdv with sdv_r,       ;
                   sdvu with sdvu_r
                  sele czg
                  skip
                enddo

              endif

              sele cMrsh
              skip
            enddo

            sele ATtnTemp
            set orde to tag t2
            go top
            set cent off
            rctnr=slcf('ATtnTemp', 1,, 18,, "e:sk h:'SK' c:n(3) e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:sdv h:'�㬬�' c:n(9,2) e:Mrsh h:' N' c:n(6) e:dop h:'��� O' c:d(8) e:dtpoe h:'��� �' c:d(8) e:kecs h:'��' c:n(3) e:necs h:'��ᯥ����' c:c(10) e:kta h:'���' c:n(4) e:nkta h:'�����' c:c(10) ",,,,,, 'n/bg,n/w', '���㦥��� �� �����饭�� '+dtoc(dt1r)+' '+dtoc(dt2r))
            set cent on
            sele cMrsh
          endif

        endif

      endcase

    case (lastkey()=K_F3.and.MrshDelr=0)
      if (prAndr=1)       // ������
        clmflt=setcolor('gr+/b,n/w')
        wmflt=wopen(7, 20, 11, 50)
        wbox(1)
        @ 0, 1 say '��ࠧ��ᥭ��' get nrzasdvr pict '9'
        @ 1, 1 say '�����        ' get anom_r
        read
        wclose(wmflt)
        setcolor(clmflt)
        if (nrzasdvr=0)
          forr=afor_r
        endif

        if (nrzasdvr=1)
          forr=afor_r+'.and.msdv=0'
        endif

        if (!empty(anom_r))
          anom_rr=alltrim(anom_r)
          forr=forr+'.and.at(anom_rr,anom)#0'
        endif

        go top
        rcMrshr=recn()
      else
        clmflt=setcolor('gr+/b,n/w')
        wmflt=wopen(7, 20, 11, 50)
        wbox(1)
        store 0 to Mrsh_r, ttn_r
                 mrsh_r:=50532
        @ 0, 1 say '�����.����' get Mrsh_r pict '@K 999999'
        @ 1, 1 say '���       ' get ttn_r pict '@K 999999'
        read
        wclose(wmflt)
        setcolor(clmflt)
        do case
        case (Mrsh_r#0.and.ttn_r#0)
          wmess('���쪮 ���� ���祭��')
        case (Mrsh_r#0.and.ttn_r=0)
          sele cMrsh
          locate for Mrsh=Mrsh_r
          if (foun())
            if (atrc#atrcr)
              wmess('� ���ࠢ����� '+str(atrc, 1))
            else
              rcMrshr=recn()
              rcMrsh1r=recn()
              rcMrsh2r=recn()
            endif

          else
            wmess('�� ������', 2)
          endif

        case (Mrsh_r=0.and.ttn_r#0)
          sele czg
          locate for ttn=ttn_r
          if (foun())
            Mrsh_r=Mrsh
            sele cMrsh
            locate for Mrsh=Mrsh_r
            if (foun())
              if (atrc#atrcr)
                wmess('� ���ࠢ����� '+str(atrc, 1))
              else
                rcMrshr=recn()
                rcMrsh1r=recn()
                rcMrsh2r=recn()
              endif

            else
              wmess('�� ������ ����.���� '+str(Mrsh_r, 6), 2)
            endif

          else
            wmess('�� �������', 2)
          endif

        otherwise
          loop
        endcase

        sele cMrsh
      endif

    case (lastkey()=K_ENTER.and.premr=0)// ����㧪�
      if !ChkAccessMrsh()
        sele cMrsh
        dbgoto(rcMrshr);    dbunlock()
        loop
      endif
      sele cMrsh
      if (!reclock(1))
        wmess('�������� ���� ����� '+getfield('t1', 'cMrsh->ktoblk', 'speng', 'fio'), 2)
        loop
      endif

      czg()
      if (prDelr=0)
        czgend()
      endif

      sele cMrsh
      go rcMrshr
      dbunlock()
    case (lastkey()=K_F6.and.prAndr=0)//.and.gnAdm=1.and.prDelr=0.and.prZor=0 // ���⢥द�����
      // ��⢥ত���� prZ
      if (prZor=0)
        if (prZr=0)
          if (!reclock(1))
            wmess('�������� ���� �����', 2)
            loop
          endif

          netrepl('prZ', {1})
        endif

      else
        if (gnRml#0.or.gnAdm=1)
          netrepl('prZo', {0})
        endif

      endif

    case (lastkey()=K_INS.and.prAndr=0)// ��������
      MrshIns()
    case (lastkey()=K_F4.and.prDelr=0)// ���४��
      if (!reclock(1))
        wmess('�������� ���� �����', 2)
        loop
      endif

      MrshIns(1)
      sele cMrsh
      go rcMrshr
      dbunlock()
    case (lastkey()=K_DEL.and.prZr#2.and.prAndr=0.and.prDelr=0.and.prZor=0)// �������
      if (prZr=0)
        if (!reclock(1))
          wmess('�������� ���� �����', 2)
          loop
       endif

        cMrsho(1)
        sele AtDocs
        repl all Mrsh with 0 for Mrsh=Mrshr
        sele czg
        set orde to tag t1
        if (netseek('t1', 'Mrshr'))
          sk_r=0
          while (Mrsh=Mrshr)
            skr=sk
            entr=ent
            ttnr=ttn
            if (skr#sk_r)
              nuse('rs1')
              sele cskl
              if (netseek('t1', 'skr'))
                entr=ent
                sele setup
                locate for ent=entr
                pathdr=gcPath_m+alltrim(nent)+'\'+gcDir_g+gcDir_d
                sele cskl
                pathr=pathdr+alltrim(path)
                netuse('rs1',,, 1)
                sk_r=skr
              endif

            endif

            if (select('rs1')#0)
              sele rs1
              if (netseek('t1', 'ttnr',,, 1))
                netrepl('Mrsh', '0')
              endif

            endif

            sele czg
            netdel()
            skip
          enddo

          nuse('rs1')
        //                    nuse('tovpt')
        endif

        sele cMrsh
        set orde to tag t3
        netdel()
        skip -1
        if (!bof())
          while (atrc#atrcr)
            skip -1
            if (bof())
              netseek('t3', 'atrcr')
              exit
            endif

          enddo

        else
          netseek('t3', 'atrcr')
        endif

        rcMrshr=recn()
        rcMrsh1r=recn()
        rcMrsh2r=recn()
      endif

      if (prZr=1)         //.and.gnAdm=1
        if (!reclock(1))
          wmess('�������� ���� �����', 2)
          loop
        endif

        netrepl('prZ', '0')
      endif

    case (lastkey()=K_F5.and.prAndr=0.and.prDelr=0)// ����� �����. ����

      if !ChkAccessMrsh()
        sele cMrsh
        dbgoto(rcMrshr);    dbunlock()
        loop
      endif

      sele cMrsh
      if (!reclock(1))
        wmess('�������� ���� �����', 2)
        loop
      endif

      MrshList(prZr)


    case (lastkey()=K_ALT_F5 .and. gnAdm=1)
      // 㤠����� (���⠭�������) ᢥ����� ���
      outlog(__FILE__,__LINE__)
      sele cMrsh
      if (!reclock(1))
        wmess('�������� ���� ����� '+getfield('t1', 'cMrsh->ktoblk', 'speng', 'fio'), 2)
        loop
      endif

      TtnUcDel4Mrsh(cMrsh->Mrsh) // ListTtn

      sele cMrsh;      go rcMrshr;      dbunlock()

      loop
      //����⠭������� �������
      // ���� ���� � ������� � �ਧ����� =2
    case (lastkey()=K_ALT_F5)  // ����� �� � �����. ����� // =-34
      // MrshNds()
      outlog(__FILE__,__LINE__)
      loop

    case (lastkey()=K_F7.and.prAndr=0.and.MrshDelr=0)// ����� ���� -6
      marshotch()
    case (lastkey()=K_F8.and.(prZr=1.or.prZr=2);
      .and.(gnAdm=1.or.gnatMrsh=1).and.prAndr=0.and.prDelr=0)
      // ���⢥ত���� ��� ��⨥ "���⠢��" ०�� 2
      if (!reclock(1))
        wmess('�������� ���� �����', 2)
        loop
      endif

      if (prZr=1)
        netrepl('prZ', '2')
      else
        netrepl('prZ', '1')
      endif

      prZr=prZ
      if (prZr=2)
        dvzttnr=date()
      else
        dvzttnr=ctod('')
      endif

      sele czg
      if (.f..and.fieldpos('dvzttn')#0)
        set orde to tag t4
        if (netseek('t4', 'Mrshr'))
          sk_r=0
          while (Mrsh=Mrshr)
            netrepl('dvzttn', 'dvzttnr')
            ttnr=ttn
            entr=ent
            skr=sk
            if (skr#sk_r)
              pathrr=getfield('t1', 'skr', 'cskl', 'path')
              if (!empty(pathrr))
                sele setup
                locate for ent=entr
                pathdr=gcPath_m+alltrim(nent)+'\'+gcDir_g+gcDir_d
                pathr=pathdr+alltrim(pathrr)
                nuse('rs1')
                //                             nuse('tovpt')
                //                             netuse('tovpt',,,1)
                netuse('rs1',,, 1)
                sk_r=skr
              endif

            endif

            sele rs1
            if (fieldpos('dvzttn')#0)
              if (netseek('t1', 'ttnr',,, 1))
              //                             netrepl('dvzttn','dvzttnr')
              endif

            endif

            sele czg
            skip
          enddo

          nuse('rs1')
        //                    nuse('tovpt')
        endif

      endif

      sele cMrsh
    case (lastkey()=K_F9)   //����� �� ����㧪� ��設�
      MrshZag()
    case (lastkey()=K_ALT_F9)   // �����/��⠭����� 䨫���
      if (prAllr=0)
        prAllr=1
      else
        prAllr=0
      endif

      if (prAllr=0)
        forr='(dMrsh>date()-15.or.prZ=0)'
        for_r='(dMrsh>date()-15.or.prZ=0)'
      else
        forr='.t.'
        for_r='.t.'
      endif

    case (lastkey()=K_ALT_F9)  // ��������
      if (MrshDelr=0)
        MrshDelr=1
        set dele off
      else
        MrshDelr=0
        set dele on
      endif

    case (lastkey()=K_ALT_F8)  //.and.gnAdm=1 // ����⠭������� �� ��娢�
      PathDelr='j:\budinf\MrshDel\'+space(30)
      cldel=setcolor('gr+/b,n/w')
      wdel=wopen(7, 10, 10, 60)
      wbox(1)
      @ 0, 1 say '����' get PathDelr
      read
      PathDelr=alltrim(PathDelr)
      erase (PathDelr+'cMrsh.dbf')
      erase (PathDelr+'cMrsh.cdx')
      erase (PathDelr+'czg.dbf')
      erase (PathDelr+'czg.cdx')
      set dele off
      sele cMrsh
      copy to (PathDelr+'cMrsh.dbf') for deleted()
      sele czg
      copy to (PathDelr+'czg.dbf') for deleted()
      set dele on
      wclose(wdel)
      setcolor(cldel)
      if (!file(PathDelr+'cMrsh.dbf'))
        wmess('��� 䠩��'+' '+PathDelr+'cMrsh.dbf')
      else
        if (!file(PathDelr+'czg.dbf'))
          wmess('��� 䠩��'+' '+PathDelr+'czg.dbf')
        else
          set dele off
          sele 0
          use (PathDelr+'cMrsh.dbf') alias atm excl
          recall all
          if (recc()=0)
            wmess('��� 㤠������')
            CLOSE
          else
            sele 0
            use (PathDelr+'czg.dbf') alias atz excl
            recall all
            set dele on
            inde on str(Mrsh, 6) tag t1
            go top
            sele atm
            inde on str(Mrsh, 6) tag t1
            go top
            while (.t.)
              set cent off
              foot('F10', '����⠭�����')
              sele atm
              rcmr=slcf('atm', 1,, 18,, "e:Mrsh h:' N' c:n(6) e:dtpoe h:'���' c:d(8) e:getfield('t1','cMrsh->vMrsh','atvm','nvMrsh') h:'�������' c:c(7) e:iif(deleted(),'��','  ')  h:'��' c:c(2) e:anom h:'�����' c:c(6) e:val(getfield('t1','cMrsh->katran','kln','tlf')) h:'��' c:n(2) e:vsv h:'��� ��' c:n(5) e:sdv h:'�㬬�' c:n(6) e:getfield('t1','cMrsh->kecs','s_tag','fio') h:'��ᯥ����' c:c(11) e:dfio h:'����⥫�' c:c(10) e:cntkkl h:'KM' c:n(2) e:prZ h:'�' c:n(1)",,, 1,, "atrc=atrcr.and.!netseek('t2','atm->Mrsh','cMrsh')",, '�������� ����� 3 '+iif(atrcr=1, 'ࠩ��', iif(atrcr=2, '��த', '��⠫��'))+' ��娢')
              set cent on
              sele atm
              go rcmr
              Mrshr=Mrsh
              do case
              case (lastkey()=-9)
                sele cMrsh
                if (netseek('t2', 'Mrshr'))
                  wmess('������� �������', 1)
                else
                  sele atz
                  if (netseek('t1', 'Mrshr'))
                    while (Mrsh=Mrshr)
                      skr=sk
                      ttnr=ttn
                      entr=ent
                      nuse('rs1d')
                      sele cskl
                      locate for sk=skr
                      prrclr=0
                      if (foun())
                        sele setup
                        locate for ent=entr
                        pathdr=gcPath_m+alltrim(nent)+'\'+gcDir_g+gcDir_d
                        sele cskl
                        pathr=pathdr+alltrim(path)
                        netuse('rs1', 'rs1d',, 1)
                        if (netseek('t1', 'ttnr',,, 1))
                          if (!deleted())
                            if (Mrsh=0)
                              prrclr=1
                            else
                              if (Mrsh=Mrshr)
                                prrclr=1
                              endif

                            endif

                          endif

                        endif

                      endif

                      if (prrclr=1)
                        sele czg
                        set orde to tag t3
                        if (!netseek('t3', 'skr,ttnr'))
                          sele atz
                          arec:={}
                          getrec()
                          sele czg
                          netadd()
                          putrec()
                        endif

                        sele rs1d
                        netrepl('Mrsh,kecs', 'Mrshr,kecsr')
                        nuse('rs1d')
                      endif

                      sele atz
                      skip
                    enddo

                    nuse('rs1d')
                  endif

                  sele atm
                  arec:={}
                  getrec()
                  sele cMrsh
                  netadd()
                  putrec()
                endif

              case (lastkey()=K_ESC)
                exit
              endcase

            enddo

            sele atm
            CLOSE
            sele atz
            CLOSE
          endif

        endif

      endif

      set dele on
    case (lastkey()=K_F10.and.prAndr=0.and.prDelr=0)// ����� �������
      if (!reclock(1))
        wmess('�������� ���� �����', 2)
        loop
      endif

      MrshZad()
      sele cMrsh
      go rcMrshr
      dbunlock()
    endcase

  enddo

  rest scre from scczg
enddo

if (select('skdoc')#0)
  sele skdoc
  CLOSE
endif

if (select('AtDocs')#0)
  sele AtDocs
  CLOSE
endif

if (select('AtOtch')#0)
  sele AtOtch
  CLOSE
endif

if (select('AtTemp')#0)
  sele AtTemp
  CLOSE
  erase AtTemp.dbf
  erase AtTemp.cdx
endif

if (select('ATtnTemp')#0)
  sele ATtnTemp
  CLOSE
  erase ATtnTemp.dbf
  erase ATtnTemp.cdx
endif

nuse()

function MrshNds()
  clea
  crtt('tkkl', 'f:kkl c:n(7)')
  sele 0
  use tkkl excl
  sele czg
  if (netseek('t1', 'Mrshr'))
    while (Mrsh=Mrshr)
      skr=sk
      d0k1r=d0k1
      docr=ttn
      nuse('rs1')
      nuse('pr1')
      sele cskl
      locate for sk=skr
      if (foun())
        pathr=gcPath_d+alltrim(path)
        if (d0k1r=0)
          if (netfile('rs1', 1))
            netuse('rs1',,, 1)
            if (netseek('t1', 'docr'))
              //                  if prZ=1
              kklr=kpl
              pr1ndsr=getfield('t1', 'kklr', 'kpl', 'pr1nds')
              if (pr1ndsr=1)
                sele czg
                skip
                loop
              endif

              sele kln
              if (netseek('t1', 'kklr'))
                if (nn#0) //.and.!empty(nsv)
                  sele tkkl
                  locate for kkl=kklr
                  if (!foun())
                    appe blank
                    repl kkl with kklr
                  endif

                endif

              endif

            //                  endif
            endif

            nuse('rs1')
          endif

        else
          if (netfile('pr1', 1))
            netuse('pr1',,, 1)
            if (netseek('t2', 'docr'))
              //                  if prZ=1
              kklr=kps
              kopr=kop
              vor=vo
              pr1ndsr=getfield('t1', 'kklr', 'kpl', 'pr1nds')
              if (pr1ndsr=1.and.vor=1.and.kopr=110)
                sele czg
                skip
                loop
              endif

              ndr=nd
              sele kln
              if (netseek('t1', 'kklr'))
                if (nn#0) //.and.!empty(nsv)
                  sele tkkl
                  locate for kkl=kklr
                  if (!foun())
                    appe blank
                    repl kkl with kklr
                  endif

                endif

              endif

            //                  endif
            endif

            nuse('pr1')
          endif

        endif

      endif

      sele czg
      skip
    enddo

    sele tkkl
    rcctkklr=recc()
    if (rcctkklr#0)

      lpt_r=2
      alpt={ 'lpt1', 'lpt2', 'lpt3', '����' }
      lpt_r=alert('������'+'('+str(rcctkklr, 3)+')', alpt)

      sele nnds
      go top
      while (!eof())
        if (nn#0.and.empty(dprn))//.and.!empty(nsv)
          kklr=kkl
          dnnr=dnn
          if (kklr#0)
            sele tkkl
            locate for kkl=kklr
            if (foun())
              sele nnds
              if (nnds->dnn<ctod('16.12.2011'))
                prnnn(nnds->mn, nnds->rnd, nnds->sk, nnds->rn, nnds->mnp, lpt_r, 1)
              else
                prnds(nnds->mn, nnds->rnd, nnds->sk, nnds->rn, nnds->mnp, lpt_r, 1)
              endif

            endif

          endif

        endif

        sele nnds
        skip
      enddo

    endif

  endif

  sele tkkl
  CLOSE
  /*erase tkkl.dbf */
  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  10-31-17 * 12:40:25pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION MrshZag()

  MrshLkkl() // ����稬 ᯨ᮪ �祪

  sk_r:=0
  sele czg
  set orde to tag t5
  netseek('t5', 'Mrshr')
  while (Mrsh=Mrshr)
    // �������� ᪫� � ���
    skr=sk;    ttnr=ttn
    // ���뫨 ⠡����
    if skr#sk_r
      nuse('tov')
      nuse('rs2')
      sele cskl
      if netseek('t1','skr')
          pathr=gcPath_d+alltrim(path)
          netuse('tov',,,1)
          netuse('rs2',,,1)
          sk_r=skr
      endif
    endif
    // ���� �� � ��ன ����
    sele rs2
    if netseek('t1','ttnr')
      Do While ttnr=ttn
        // ��।������ �⤥��
        sklr=skl
        ktlr=ktl
        otr=getfield('t1','sklr,ktlr','tov','ot')
        If Empty(otr)
          otr=getfield('t1','int(ktlr/1000000)','sgrp','ot')
        EndIf
        // �஢�ઠ � ��������� ᯨ᪠ �⤥���
        otr:=padl(allt(str(otr,2)),2,'0')
        sele lkkl
        locate for czg->kkl = kkl
        If !(otr $ list_ot)
          repl list_ot with allt(list_ot)+otr+';'
        EndIf

        sele rs2
        DBSkip()
      EndDo
    endif

    sele czg
    skip
  enddo
  nuse('rs2')



  sele lkkl
  inde on descend(npp) tag DescNpp



    alpt={ 'lpt1', 'lpt2', 'lpt3', '����' }
    vlpt=alert('������ ����� �������� ����������� �����', alpt)
    ovlptr=vlpt
    do case
    case (vlpt=1)
      vlpt1='lpt1'
      set prin to &vlpt1
    case (vlpt=2)
      vlpt1='lpt2'
      set prin to &vlpt1
    case (vlpt=3)
      vlpt1='lpt3'
      set prin to &vlpt1
    case (vlpt=4)
      vlpt=1
      set prin to plzgr.txt
    endcase

  set prin on
  set cons off
  if (vlpt=1)
    if (empty(gcPrn))
      ??chr(27)+chr(80)+chr(15)
      rListr=62
    else
      ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
      rListr=40
    endif

  else
    ??chr(27)+'E'+chr(27)+'&l4h25a0O'+chr(27)+'&k2S'+chr(27)+'(3R'+chr(27)+'(s0p18.00h0s1b4102T'+chr(27)
    rListr=40
  endif

  rswr=1 // ��ப�
  lstr=1 // ��࠭���
  AtSh() // ���������
  sele lkkl
  DBGoTop()
  Do While !eof()

    ?'�'+padl(left(list_ot,36),36,' ')+'�'+padc(allt(str(npp)),5,' ')+'�'+str(kkl,7)+'�'+left(ngp,34)+'�';rslea()
    ?'�'+'                                    '+'�'+space(5)+'�'+space(7)+'�'+left(agp,34)+'�';rslea()
    DBSkip()
    If !eof()
      ?'�������������������������������������������������������������������������������������Ĵ';rslea()
    EndIf
  EndDo

  ?'���������������������������������������������������������������������������������������';rslea()

  set prin off
  set prin to
  set cons on

  RETURN (NIL)

static proc rslea()
  rswr++
  if rswr>=rlistr
     rswr=1
     lstr++
     eject
     AtSh()
  endif
  retu

/*****************************************************************
 
 PROCEDURE:
 �����..����..........�. ��⮢��  11-01-17 * 10:08:21am
 ����������.........
 ���������..........
 ����������.........
 */
static Procedure AtSh()
  ??'���� �������� ���������� � ����������� ����� N'+' '+str(Mrshr, 6)+padl(iif(lstr>1,'���.'+str(lstr,2),''),30);rslea()
  ?'�������������������������������������������������������������������������������������Ŀ';rslea()
  ?'�                                    �N �.��  ���  �   �������� ����� -  ����������   �';rslea()
  ?'�                                    �     �   ��  �         ����� ��������           �';rslea()
  ?'�������������������������������������������������������������������������������������Ĵ';rslea()

  Return


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  11-19-18 * 12:33:31pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION  ChkAccessMrsh()
  LOCAL lRet:=.T.
  If .T. ;
    .and.str(gnEnt,3)$' 20; 21';
    .and.(gnAdm=1.or.str(gnKto,4)$' 966; 129; 160; 117') //������� ���� ��࠭�� �饭�� 169

    // �த�����
    lRet:=.T.

  Else
    // ����ઠ �� ����稥 ��� �業��
    skr := -99
    sele czg
    set orde to tag t5

    if netseek('t5', 'Mrshr')
      while (Mrsh=Mrshr)
        ttnr=ttn

        If skr=sk
          sele rs1fp
        Else
          skr:=sk
          dir_rr=getfield('t1', 'skr', 'cskl', 'path')
          pathr=gcPath_d+alltrim(dir_rr)
          netuse('rs1', 'rs1fp',, 1)
        EndIf

        if netseek('t1', 'ttnr')
          If rs1fp->ttn169#0  //.or. rs1fp->ttn139#0 .or. rs1fp->ttn129#0
            ttnr := ttn169
            dvpr := dvp
            netseek('t1', 'ttnr')
            If date() - dvp >= 5 // ��� ᮧ����� ��.��� >= 5 ����
              close rs1fp
              wmess('�������� ���� ����� >=5', 2)
              exit
            EndIf
          endif
        endif

        sele czg
        skip
      enddo

      If empty(select('rs1fp')) // ����뫨 � ����襭� ��ୠ��祭��
        lRet:=.F.
        Mrsh169r2Email(ttnr, dvpr)
      Else
        close rs1fp
        lRet:=.T.
      EndIf
    EndIf

  EndIf
  RETURN (lRet)


STATIC FUNCTION  Mrsh169r2Email(ttnr, dvpr)
  STATIC nRunTime, sFull
  LOCAL cMess, cFlMess, cMessErr,cPRINTER_CHARSET
  LOCAL cListEMail:="oleg_ta@rambler.ru,lista@bk.ru"
  if gnEnt=21
    cListEMail:='vadim_5@rambler.ru,lista@bk.ru'
  endif

  If (gnAdm=1) //.or.str(gnKto,4)$' 129; 160; 117') // ���� ��࠭�� �饭�� 169
    return nil
  EndIf

  cMess:='������� � �-⠬� prXXX=2 >=5 ����'

  cFlMess:='uc_mess'+'.txt'

  cPRINTER_CHARSET:=set("PRINTER_CHARSET","koi8-u")
  set console off
  set print on
  set print to (cFlMess)

  ?cMess, date(), time()
  ?
  ?'�����.N'+str(mrshr,6)
  ?'��� ���.', ttnr,' �� ', dvpr
  ?'��:', gnKto, gcName //getfield('t1','gnKto','speng','fio')
  ?
  ?'�⥢�� ��� ��設�',gcNNETNAME,"����� �室�",atrepl('\',gcUname,'_')

  set print to
  set print off
  set("PRINTER_CHARSET",cPRINTER_CHARSET)

  cMessErr:=memoread(cFlMess)

  SendingJafa(cListEMail, {{ "",'�����.N'+str(mrshr,6)+" ����襭�� ��࠭�祭�� ("+str(gnEnt,3);
  +") "+gcName_c+' '+DTOC(date(),"YYYYMMDD")}},;
  cMessErr,;
  228)

  RETURN (NIL)
