/***********************************************************
 * �����    : crrso.prg
 * �����    : 0.0
 * ����     :
 * ���      : 02/05/18
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

#include "common.ch"
#include "inkey.ch"
// �������� rso1 � rso2 (��⮪�� 㤠������ ���㦥���� ���㬥�⮢)
if (!netfile('rso1'))
  crddop('rso1')
  netuse('rso1')
  netadd()
  nuse('rso1')
endif

if (!netfile('rso2'))
  crddop('rso2')
  nuse('rso2')
endif

/********************************
 *�業��
 ********************************
 **************
 */
function TtnUc()
  /************** */
  clea
  netuse('tov')
  netuse('sgrp')
  netuse('cgrp')
  netuse('rs1')
  netuse('rs2')
  netuse('rs3')
  netuse('soper')
  netuse('kln')
  netuse('mkeep')
  netuse('s_tag')
  netuse('cskl')
  netuse('ctov')
  netuse('mkeep')

  sklr=gnSkl
  outlog(__FILE__, __LINE__, 'sklr', sklr)

  if (select('sl')=0)
    sele 0
    use _slct alias sl excl
    zap
  else
    sele sl
    zap
  endif

  sele soper
  set filt to d0k1=0.and.vo=9.and.(kop=29.or.kop=39.or.kop=69)
  go top
  rcsoperr=recn()
  while (.t.)
    clea
    sele soper
    go rcsoperr
    rcsoperr=slcf('soper',,,,, "e:kop h:'���' c:n(2) e:nop h:'������' c:c(40)")
    sele soper
    go rcsoperr
    kopr=100+kop
    nopr=alltrim(nop)
    if (lastkey()=K_ESC)
      exit
    endif

    do case
    case (lastkey()=K_ENTER)
      UcTtn()
    endcase

  enddo

  nuse()
  return (.t.)

/**************** */
function UcTtn()
  /**************** */
  store 0 to mkeep_r, pruc_r, kta_r, mrsh_r, SdvEq0r
  ddc_r=gdTd
  KolUcr=0
  fldnomr=1
  cKopr=str(kopr, 3)
  cTtnUcr='ttn'+ckopr
  cMkUcr='mk'+ckopr
  cPrUcr='pr'+ckopr

  pTtnUcr:=rs1->(FIELDPOS(cTtnUcr))
  pMkUcr :=rs1->(FIELDPOS(cMkUcr))
  pPrUcr :=rs1->(FIELDPOS(cPrUcr))

  sele rs1
  go top
  rcrs1r=recn()

  do case
  case (kopr=169)
    ForTtn_r='kop=169.and.mk'+ckopr+'#0.and.sdv#0'
  case (kopr=129)
    ForTtn_r='(kop=129.or.kop=169).and.mk'+ckopr+'#0.and.sdv#0'
  case (kopr=139)
    ForTtn_r='(kop=139.or.kop=169).and.mk'+ckopr+'#0.and.sdv#0'
  endcase

  ForTtnr=ForTtn_r

  cFor_1 := "{||"+ForTtnr                     ;
   +" .and. FIELDGET("+STR(pPrUcr)+")==1 "  ;
   +" .and. FIELDGET("+STR(pTtnUcr)+")==0 " ;
   +"}"
  bFor:=&cFor_1
  o_sdvr:=0; DBEVAL({||o_sdvr+=sdv}, bFor)
  goto rcrs1r
  osdvr=0

  while (.t.)
    set cent off
    sele rs1
    go rcrs1r
    @ 23, 45 say str(o_sdvr, 12, 2)
    @ 23, 65 say str(osdvr, 12, 2)
    do case
    case (kopr=169)
      foot('SPACE,F2,F3,F8,F9,F10,ENTER',                      ;
            '� ���,���,������,����.���,����� ��,��� ��,���' ;
         )
      rcrs1r=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:prz h:'�' c:n(1) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:kta h:'KTA' c:n(4) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:pr169 h:'O' c:n(1) e:mk169 h:'MK' c:n(3) e:ttn169 h:'����' c:n(6) e:dfp h:'��� ��' c:d(8) e:kop h:'kop' c:n(3) e:kopi h:'kopi' c:n(3) e:ddc h:'��⠑�' c:d(10)",,, 1,, ForTtnr,, str(kopr, 3)+' '+nopr, 1, 2)
    case (kopr=129)
      foot('SPACE,F2,F3,F6,F7,F8,F9,F10', '� ���,���,������,���,���,� ���,����� ��,��� ��')
      rcrs1r=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:kta h:'KTA' c:n(4) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:pr129 h:'O' c:n(1) e:prfp h:'��' c:n(1) e:mk129 h:'MK' c:n(3) e:ttn129 h:'����' c:n(6) e:dop h:'���  O' c:d(8) e:kop h:'kop' c:n(3) e:kopi h:'kopi' c:n(3) e:ddc h:'��⠑�' c:d(10)",,, 1,, ForTtnr,, str(kopr, 3)+' '+nopr, 1, 2)
    case (kopr=139)
      foot('SPACE,F2,F3,F6,F7,F8,F9,F10', '� ���,���,������,���,���,� ���,����� ��,��� ��')
      rcrs1r=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:ktofp h:'��' c:n(4) e:sdv h:'�㬬�' c:n(7,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:kta h:'KTA' c:n(4) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:pr139 h:'O' c:n(1) e:prfp h:'��' c:n(1) e:mk139 h:'MK' c:n(3) e:ttn139 h:'����' c:n(6) e:dop h:'��� O ' c:d(8) e:kop h:'kop' c:n(3) e:kopi h:'kopi' c:n(3) e:ddc h:'��⠑�' c:d(10)",,, 1,, ForTtnr,, str(kopr, 3)+' '+nopr, 1, 2)
    endcase

    sele rs1
    go rcrs1r
    ttnr=ttn
    sdvr=sdv
    TtnUcr=FIELDGET(pTtnUcr)
    PrUcr=FIELDGET(pPrUcr)
    MkUcr=FIELDGET(pMkUcr)
    prfpr=prfp
    do case
    case (lastkey()=K_ESC)
      exit
    case (lastkey()=K_LEFT)// Left
      fldnomr=fldnomr-1
      if (fldnomr=0)
        fldnomr=1
      endif

    case (lastkey()=K_RIGHT)// Right
      fldnomr=fldnomr+1
    case (lastkey()=K_F3)   // ������
      clttncr=setcolor('gr+/b,n/bg')
      wttncr=wopen(10, 20, 17, 60)
      wbox(1)
      @ 0, 1 say '��મ��ঠ⥫�' get mkeep_r pict '999'
      @ 1, 1 say '�ਧ���       ' get pruc_r pict '9'
      @ 2, 1 say '��� ᮧ����� ' get ddc_r
      @ 3, 1 say '��� �����    ' get kta_r pict '9999'
      @ 4, 1 say '���.�������  ' get mrsh_r pict '999999'// when pruc_r
      @ 5, 1 say '�㬬� � 0     ' get SdvEq0r pict '9'// when pruc_r
      read
      if (lastkey()=K_ESC)
        mkeep_r=0
        ForTtnr=ForTtn_r
      endif

      if (lastkey()=K_ENTER)
        if (mkeep_r#0)
          ForTtnr=ForTtn_r+'.and.mk'+ckopr+'=mkeep_r'
        else
          ForTtnr=ForTtn_r
        endif

        if (pruc_r#0)
          ForTtnr=ForTtnr+'.and.pr'+ckopr+'=pruc_r'
        endif

        if (!empty(ddc_r))
          ForTtnr=ForTtnr+'.and.ddc=ddc_r'
        endif

        if (!empty(kta_r))
          ForTtnr=ForTtnr+'.and.kta=kta_r'
        endif

        if (!empty(mrsh_r)) .and. pruc_r=2;
          .or. SdvEq0r=1
          // ����� �����뢠�� #0 �㬬�
          ForTtnr=STUFF(ForTtnr, ;
          AT('.and.sdv#0', ForTtnr),;
           len('.and.sdv#0'), '')

          ForTtnr=ForTtnr+'.and.mrsh=mrsh_r'
        endif

      endif

      wclose(wttncr)
      setcolor(clttncr)

      t1:=SECONDS()
      sele rs1
      go top
      cFor_1 := "{||"+                                                       ;
       "(kop=169.or.kop=129.or.kop=139)"                                     ;
       +".and.kopi="+LTRIM(STR(kopr))                                    ;
       +".and.FIELDGET("+LTRIM(STR(pMkUcr))+")="+LTRIM(STR(mkeep_r)) ;
       +".and.FIELDGET("+LTRIM(STR(pPrUcr))+")=1"                        ;
       +".and.FIELDGET("+LTRIM(STR(pTtnUcr))+")=0"                       ;
       +"}"
      bFor:=&cFor_1
      osdvr:=0; DBEVAL({||osdvr+=sdv}, bFor)
      @ 23, 0 say str(t1-SECONDS(), 9)

      /*
      t1:=SECONDS()
      sele rs1
      go top
      osdvr=0
      do while !eof()
         if (kop=169.or.kop=129.or.kop=139).and.kopi=kopr.and.FIELDGET(pMkUcr)=mkeep_r.and.FIELDGET(pPrUcr)=1.and.FIELDGET(pTtnUcr)=0
            osdvr=osdvr+sdv
         endif
         sele rs1
         skip
      enddo
      @ 23,10 say str(t1-SECONDS(),9)
      */
      go top
      rcrs1r=recn()
      @ 23, 45 say str(o_sdvr, 12, 2)
      @ 23, 65 say str(osdvr, 12, 2)
    case (lastkey()=K_SPACE)// �⡮�
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      if (mkeep_r#0)
        sele rs1
        if (fieldpos(cPrUcr)#0)
          if (FIELDGET(pTtnUcr)=0.and.FIELDGET(pPrUcr)#2)
            if (FIELDGET(pPrUcr)=0)
              netrepl(cPrUcr, {1})
              osdvr=osdvr+sdv
            else
              netrepl(cPrUcr, {0})
              osdvr=osdvr-sdv
            endif

          endif

          @ 23, 45 say str(o_sdvr, 12, 2)
          @ 23, 65 say str(osdvr, 12, 2)
          sele rs1
          netrepl('dtmod,tmmod', {date(), time()})
        endif

      else
        wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
      endif

    case (lastkey()=K_F10)// ����� ��
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      sele rs1
      if (fieldpos(cPrUcr)=0)
        wmess('������� �������� Rs1', 3)
        loop
      endif

      if (mkeep_r#0)
        cForTtn_r:='{||'+ForTtn_r+'}'
        bForTtn_r := &cForTtn_r
        osdvr=0
        sele rs1
        go top
        while (!eof())
          if (! Eval(bForTtn_r))//(!&(ForTtn_r))
            skip
            loop
          endif

          //if (kop=169.or.kop=129.or.kop=139).and.kopi=kopr.and.FIELDGET(pMkUcr)=mkeep_r
          if (FIELDGET(pMkUcr)=mkeep_r)
            if (FIELDGET(pTtnUcr)=0.and.FIELDGET(pPrUcr)#2)
              netrepl(cPrUcr, {1})
              osdvr=osdvr+sdv
              sele rs1
              netrepl('dtmod,tmmod', {date(), time()})
            endif

          endif

          sele rs1
          skip
        enddo

        @ 23, 45 say str(o_sdvr, 12, 2)
        @ 23, 65 say str(osdvr, 12, 2)
        sele rs1
        go rcrs1r
      else
        wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
      endif

    case (lastkey()=K_F8) // ������� �����
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      if (mkeep_r#0)

        aTypeUc:=nil
        aTypeUc:=TypeUc()
        if (empty(aTypeUc))
          wmess('�⪠�')
          loop
        endif

        sdv_r=0
        TtnUcr=0

        TtnUcO(aTypeUc)

        ttnr=TtnUcr

        go rcrs1r
        @ 23, 65 say str(0, 12, 2)
      else
        wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
      endif

    case (lastkey()=K_F9) // ����� �ਧ���
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      if (FIELDGET(pMkUcr)#0.and.FIELDGET(pPrUcr)=0)
        netrepl(cMkUcr, {0})
      endif

    case (lastkey()=K_F2) // ����
      OtUc()
    case (lastkey()=K_ENTER)// .and.pr169=2 // ��ᬮ��
      prsmuc()
    case (lastkey()=K_F6)   // �⡮� ��
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      if (mkeep_r#0)
        sele rs1
        if (fieldpos('prfp')#0)
          if (FIELDGET(pTtnUcr)=0.and.FIELDGET(pPrUcr)#2)
            if (prfp=0)
              netrepl('prfp', {1})
              osdvr=osdvr+sdv
            else
              netrepl('prfp', {0})
              osdvr=osdvr-sdv
            endif

          endif

          @ 23, 45 say str(o_sdvr, 12, 2)
          @ 23, 65 say str(osdvr, 12, 2)
        endif

      else
        wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
      endif

    case (lastkey()=K_ALT_F6)// �⡮� �� ��
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      sele rs1
      if (fieldpos('prfp')=0)
        wmess('������� �������� Rs1', 3)
        loop
      endif

      if (mkeep_r#0)
        osdvr=0
        cForTtn_r:='{||'+ForTtn_r+'}'
        bForTtn_r := &cForTtn_r
        sele rs1
        go top
        while (!eof())
          if (! Eval(bForTtn_r))//(!&(ForTtn_r))
            skip
            loop
          endif

          if (FIELDGET(pMkUcr)=mkeep_r)
            if (FIELDGET(pTtnUcr)=0.and.FIELDGET(pPrUcr)#2)
              netrepl('prfp', {1})
              osdvr=osdvr+sdv
              sele rs1
              netrepl('dtmod,tmmod', {date(), time()})
            endif

          endif

          sele rs1
          skip
        enddo

        @ 23, 45 say str(o_sdvr, 12, 2)
        @ 23, 65 say str(osdvr, 12, 2)
        sele rs1
        go rcrs1r
      else
        wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
      endif

    case (lastkey()=K_F7) // ��⠭����� ��
      if (gnEntRm=0.and.gnRm#0)
        wmess('�������� ᪫��.�����!!!')
        loop
      endif

      if (mkeep_r#0)
        set cent on
        dfpr=date()
        tfpr:=time()
        clttncr=setcolor('gr+/b,n/bg')
        wttncr=wopen(10, 25, 13, 50)
        wbox(1)
        @ 0, 1 say '��� ��' get dfpr
        read
        tfpr:=time()
        set cent off
        wclose(wttncr)
        setcolor(clttncr)
        if (lastkey()=K_ESC)
          loop
        endif

        cForTtn_r:='{||'+ForTtn_r+'}'
        bForTtn_r := &cForTtn_r
        osdvr=0
        sele rs1
        go top
        while (!eof())
          if (! Eval(bForTtn_r))//(!&(ForTtn_r))
            skip
            loop
          endif

          if (prfp=1.and.empty(dfp))
            netrepl('dfp,tfp', {dfpr, tfpr})
            //netrepl('dfp,tfp,ktofp','dfpr,tfpr,gnKto',1)
            prnppr=0        // ��� ����⢨� ॣ�����㥬��� � ��⮪���
            rso(23)
          endif

          sele rs1
          skip
        enddo

        @ 23, 45 say str(o_sdvr, 12, 2)
        @ 23, 65 say str(osdvr, 12, 2)
        sele rs1
        go rcrs1r
      else
        wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
      endif

    endcase

  enddo

  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  08-04-16 * 01:15:59pm
 ����������.........  * ������� �� �⬥祭��� (PrUcr) ����� ���
 ���������.......... aTypeUc  - ���ᨢ ���� 業�
 �����. ��������....
 ����������.........
 */
function TtnUcO(aTypeUc, aListTtn)
  local aListRecNoTtn
  local nPrcnt
  pTtnUcr:=rs1->(FIELDPOS(cTtnUcr))
  pMkUcr :=rs1->(FIELDPOS(cMkUcr))
  pPrUcr :=rs1->(FIELDPOS(cPrUcr))

  aListRecNoTtn:={}

  if (empty(aListTtn))

    sele rs1
    set filt to
    go top
    while (!eof())

      if (kop # kopr)
        skip; loop
      endif

      if (FIELDGET(pPrUcr) # 1)// &cPrUcr # 1
        skip; loop
      endif

      if (FIELDGET(pTtnUcr) # 0)// &cTtnUcr # 0
        skip; loop
      endif

      if (FIELDGET(pMkUcr) # mkeep_r)// &cMkUcr # mkeep_r
        skip; loop
      endif

      aadd(aListRecNoTtn, rs1->(RecNo()))

      sele rs1
      skip
    enddo

    if (!OtvProtTest(aListRecNoTtn))// �஢�ઠ �� �⢥� �࠭����
      return (nil)
    endif

  else

    for i:=1 to len(aListTtn)
      sele rs1
      ttn_r=aListTtn[ i ]
      netseek('t1', 'ttn_r')
      aadd(aListRecNoTtn, rs1->(RecNo()))
    next

    mkeep_r=169             // ��� ��࠭�� ���� ���⪨

  endif

  sele cskl
  netseek('t1', 'gnSk',,, 1)//  locate for sk=gnSk
  NextNumTtn('TtnUcr')

  sele rs1
  if (empty(aListTtn))
    locate for FIELDGET(pPrUcr)=1.and.kop=kopr
    lFound:=found()
  else
    DBGoTo(aListRecNoTtn[ 1 ])
    lFound:=.T.
  endif

  if (lFound)
    arec:={}; getrec()
    netadd()
    putrec()
    docguidr=''
    netrepl("ttn,kop,kpl,nkkl,kgp,kpv,prz,vo,docguid,kto,ddc,tdc,dfp,dop,dvp,sdv",                                                ;
             {TtnUcr, 169, 20034, 20034, 20034, 20034, 0, 9, docguidr, gnKto, date(), time(), ctod(''), ctod(''), date(), 0};
          )
    netrepl(cTtnUcr, {0})
    netrepl(cPrUcr, {2})// ⨯ ��� 1��� ��� %  - 2 ��� 3 // {aTypeUc[1]}
                            // ��� �� ������ �� 1 ���.
      netrepl('RndSdv',{;
      getfield('t1', '0,gnVu,9,169-100';
      , Iif(!Empty(select("soper")),'soper','soper_uc');
      , 'RndSdv');
     },1)
      If Empty(RndSdv)
        outlog(__FILE__,__LINE__,'TtnUcr,0,gnVu,gnVo,169-100',TtnUcr,0,gnVu,gnVo,169-100)
        outlog(__FILE__,__LINE__,'select("soper")',Iif(!Empty(select("soper")),'soper','soper_uc'))
      EndIf



    if (kopr=169)
      netrepl('dop', {date()})
    endif

    ttnUc_kta_ktas_kgp_kpv()

    netrepl('dtmod,tmmod', {date(), time()})
    if (fieldpos('mntov177')#0)
      mntov177r:=mntov177r(gnEnt, mkeep_r)
      prc177r=getfield('t1', 'mntov177r', 'ctov', 'cenpr')
      netrepl('mntov177,prc177', {mntov177r, prc177r})
    endif

    gcPath_mUcr=&('gcPath_m'+cKopr)

    dir_r=gcPath_mUcr+subs(gcDir_t, 1, len(gcDir_t)-1)
    if (dirchange(dir_r)#0)
      dirmake(dir_r)
    endif
    dirchange(gcPath_l)

    dir_r=gcPath_mUcr+gcDir_t+'t'+alltrim(str(TtnUcr))
    if (dirchange(dir_r)#0)
      dirmake(dir_r)
    endif
    dirchange(gcPath_l)

    pathTtnUcr=gcPath_mUcr+gcDir_t+'t'+alltrim(str(TtnUcr))+'\'
    pathr=pathTtnUcr
    if (!netfile('rs1', 1))
      copy file (gcPath_a+'rs1.dbf') to (pathTtnUcr+'trsho14.dbf')
      copy file (gcPath_a+'rs2.dbf') to (pathTtnUcr+'trsho15.dbf')
      lindx('trsho14', 'rs1', 1)
      lindx('trsho15', 'rs2', 1)
    endif

    netuse('rs1', 'Rs1Uc',, 1)
    netuse('rs2', 'Rs2Uc',, 1)
    sdv_r=0

    sele rs1
    set filt to

    for i:=1 to len(aListRecNoTtn)
      sele rs1
      DBGoTo(aListRecNoTtn[ i ])

      sdv_r=sdv_r+sdv
      ttn_r=ttn
      sklr=skl

      sele rs2
      if (netseek('t1', 'ttn_r'))
        sele rs1
        reclock()
        arec:={}; getrec()
        sele Rs1Uc
        netadd()
        putrec()
        sele rs2
        while (ttn=ttn_r)
          rcucr=recn()
          mntovr=mntov
          ktlr=ktl
          kvpr=kvp

          arec:={}; getrec()
          sele Rs2Uc
          netadd()
          putrec()

          sele rs2
          if (!netseek('t1', 'TtnUcr,ktlr'))
            netadd()
            putrec()
            netrepl('ttn', {TtnUcr})
          else
            netrepl('kvp', {kvp+kvpr})
          endif

          //!! - ���� 業�
          TtnUcCalcZen(aTypeUc, ktlr)

          sele rs2
          go rcucr
          netdel()
          skip
        enddo

      endif

      // ���㫥��� �㬬�
      sele rs1
      netrepl(cTtnUcr+',sdv', {TtnUcr, 0})
      // ���㫥��� �⮣��
      sele rs3
      ordsetfocus('t1')
      netseek('t1','ttn_r')
      DBEval({||netdel()},,{||ttn = ttn_r})

    next i

    sele rs2
    rznst2r=0
    rc_r=0
    if (netseek('t1', 'TtnUcr'))
      // ���४�� �-�� � 業�
      Zen4KolUc(TtnUcr, aTypeUc)

    endif

    nuse('Rs1Uc')
    nuse('Rs2Uc')

    // ������ ��ப ���㬥��
    ttnr=TtnUcr
    sele rs1
    if (ttnr#0)
      if (netseek('t1', 'ttnr'))
        netrepl('sdv,'+cMkUcr, {sdv_r, mkeep_r})
        rcrs1r=recn()
        sele rs2
        if (netseek('t1', 'ttnr'))
          while (ttn=ttnr)
            svpr=round(kvp*zen, 2)
            netrepl('svp', {svpr})
            sele rs2
            skip
          enddo

        endif

      endif

    endif

  endif

  return (TtnUcr)

/*************** */
static function OtUc()
  /*************** */
  local smlnr, nPosScn, aSmMkpRs1, aSmMkp, aSmMrsh
  local nSumUc, nSumRs2Uc

  aSmMrsh:={{-99999, 0}}

  if (select('OtUc')#0)
    sele OtUc
    close
  endif

  sele rs1
  copy stru to sOtUc exte
  sele 0
  use sOtUc excl
  zap
  appe blank
  repl field_name with 'mkeep', ;
   field_type with 'n',         ;
   field_len with 3
  appe blank
  repl field_name with 'nmkeep', ;
   field_type with 'c',          ;
   field_len with 20
  appe blank
  repl field_name with 'd00', ;
   field_type with 'n',       ;
   field_len with 12,         ;
   field_dec with 2
  for i:=1 to 31            //eom(gdTd)
    appe blank
    repl field_name with 'd'+iif(i<10, '0'+str(i, 1), str(i, 2)), ;
     field_type with 'n',                                               ;
     field_len with 12,                                                 ;
     field_dec with 2
  next

  close
  create OtUc from sOtUc
  erase sOtUc.dbf

  sele 0
  use OtUc

  sele OtUc
  appe blank
  repl mkeep with 000, nmkeep with '�⮣�'

  do case
  case (kopr=169)
    cPrUcr='pr169'
    cMkUcr='mk169'
    PathTtn169r=gcPath_m169+gcDir_t
  case (kopr=129)
    cPrUcr='pr129'
    cMkUcr='mk129'
    PathTtn169r=gcPath_m129+gcDir_t
  case (kopr=139)
    cPrUcr='pr139'
    cMkUcr='mk139'
    PathTtn169r=gcPath_m139+gcDir_t
  endcase

  sele rs1
  go top
  while (!eof())
    if (FIELDGET(pPrUcr)#2)
      skip; loop
    endif

    TtnUcr=ttn
    mkeepr=FIELDGET(pMkUcr)
    nmkeepr=getfield('t1', 'mkeepr', 'mkeep', 'nmkeep')
    ddcr=ddc
    Mrshr:=Mrsh

    pathr=PathTtn169r+'t'+alltrim(str(TtnUcr))+'\'
    if (netfile('rs1', 1))
      netuse('rs1', 'Rs1Uc',, 1)
      netuse('rs2', 'Rs2Uc',, 1)

      sele Rs1Uc
      sum sdv to smr        // �㬬� ��� ���, ����� ᢥ�⥪

      nSumRs2Uc:=0
      aSmMkpRs1:={{mkeepr, smr, nmkeepr, 'Rs1Uc'}}
      aSmMkp:={{mkeepr, 0, nmkeepr}}

      sele Rs2Uc
      DBGoTop()
      aSmMkpUc('Rs2Uc', {||!eof()}, @aSmMkpRs1, @aSmMkp, @nSumRs2Uc)// ���������� ���ᨢ� ����묨

      nuse('Rs2Uc')
      nuse('Rs1Uc')

      outlog(3, __FILE__, __LINE__, 'UC', TtnUcr)
      UpDateOtUc(@aSmMkpRs1, @aSmMkp)
      outlog(3, __FILE__, __LINE__, ddcr, nSumRs2Uc, aSmMkpRs1)

      // ����� 㬥��蠥� -1
      sele Rs1
      smr:=sdv * (-1)

      nSumRs2:=0
      aSmMkpRs1:={{mkeepr, smr, nmkeepr}}
      aSmMkp:={{mkeepr, 0, nmkeepr}}

      sele Rs2
      set order to tag t1   // ordSetFocus("t1 ")
      netseek('t1', 'TtnUcr')
      aSmMkpUc('Rs2', {|| ttn = TtnUcr}, @aSmMkpRs1, @aSmMkp, @nSumRs2)// ���������� ���ᨢ� ����묨

      for i:=1 to len(aSmMkp)
        aSmMkp[ i, 2 ] := ROUND(aSmMkp[ i, 2 ] * (-1), 2)
      next

      UpDateOtUc(@aSmMkpRs1, @aSmMkp)

      // ���������� �㬬� ����
      pMrsh:=ASCAN(aSmMrsh, {| aElem | aElem[ 1 ] = Mrshr})
      if (Empty(pMrsh))
        aadd(aSmMrsh, {Mrshr, nSumRs2Uc - nSumRs2})
      else
        aSmMrsh[ pMrsh, 2 ] += (nSumRs2Uc - nSumRs2)
      endif

      outlog(3, __FILE__, __LINE__, ddcr, nSumRs2, aSmMkpRs1)
      outlog(3, __FILE__, __LINE__)
    endif

    sele rs1
    skip
  enddo

  // ���������� �㬬� ������⮢
  ASORT(aSmMrsh,,, {| x, y | x[ 1 ] < y[ 1 ]})
  for i:=2 to LEN(aSmMrsh)
    outlog(__FILE__, __LINE__, aSmMrsh[ i ])
  next

  sele OtUc
  go top
  rcOtUcr=recn()
  fldnomr=1
  while (.t.)
    sele OtUc
    go rcOtUcr
    rcOtUcr=slce('OtUc',,,,, "e:mkeep h:'TM' c:n(3) e:nmkeep h:'������������' c:c(20) e:d00 h:'�⮣' c:n(10,2) e:d01 h:'01' c:n(10,2) e:d02 h:'02' c:n(10,2) e:d03 h:'03' c:n(10,2) e:d04 h:'04' c:n(10,2) e:d05 h:'05' c:n(10,2) e:d06 h:'06' c:n(10,2) e:d07 h:'07' c:n(10,2) e:d08 h:'08' c:n(10,2) e:d09 h:'09' c:n(10,2) e:d10 h:'10' c:n(10,2) e:d11 h:'11' c:n(10,2) e:d12 h:'12' c:n(10,2) e:d13 h:'13' c:n(10,2) e:d14 h:'14' c:n(10,2) e:d15 h:'15' c:n(10,2) e:d16 h:'16' c:n(10,2) e:d17 h:'17' c:n(10,2) e:d18 h:'18' c:n(10,2) e:d19 h:'19' c:n(10,2) e:d20 h:'20' c:n(10,2) e:d21 h:'21' c:n(10,2) e:d22 h:'22' c:n(10,2) e:d23 h:'23' c:n(10,2) e:d24 h:'24' c:n(10,2) e:d25 h:'25' c:n(10,2) e:d26 h:'26' c:n(10,2) e:d27 h:'27' c:n(10,2) e:d28 h:'28' c:n(10,2) e:d29 h:'29' c:n(10,2) e:d30 h:'30' c:n(10,2) e:d31 h:'31' c:n(10,2)",,,,,,,, 1, 2)
    sele OtUc
    go rcOtUcr
    do case
    case (lastkey()=K_ESC)
      exit
    case (lastkey()=K_LEFT)// Left
      fldnomr=fldnomr-1
      if (fldnomr=0)
        fldnomr=1
      endif

    case (lastkey()=K_RIGHT)// Right
      fldnomr=fldnomr+1
    endcase

  enddo

  sele OtUc
  close
  // ����஢��� ⠬ ��� ����� ࠧ������ ���
  outlog(__FILE__, __LINE__, kopr, gcPath_m169+gcDir_t+'ot169.dbf')
  do case
  case (kopr=169)
    copy file OtUc.dbf to (gcPath_m169+gcDir_t+'ot169.dbf')
  case (kopr=129)
    copy file OtUc.dbf to (gcPath_m129+gcDir_t+'ot129.dbf')
  case (kopr=139)
    copy file OtUc.dbf to (gcPath_m139+gcDir_t+'ot139.dbf')
  endcase

  return (.t.)

/*************** */
static function PrsmUc()
  /*************** */
  do case
  case (kopr=169)
    pathTtnUcr=gcPath_m169+gcDir_t+'t'+alltrim(str(ttnr, 6))+'\'
  case (kopr=129)
    pathTtnUcr=gcPath_m129+gcDir_t+'t'+alltrim(str(ttnr, 6))+'\'
  case (kopr=139)
    pathTtnUcr=gcPath_m139+gcDir_t+'t'+alltrim(str(ttnr, 6))+'\'
  endcase

  pathr=pathTtnUcr
  if (netfile('rs1', 1))
    netuse('rs1', 'Rs1Uc',, 1)
    sele Rs1Uc
    sum sdv to sdvor
    go top
    rcRs1Ucr=recn()
    while (.t.)
      sele Rs1Uc
      go rcRs1Ucr
      foot('', '')
      rcRs1Ucr=slcf('Rs1Uc', 1,, 18,, "e:ttn h:'���' c:n(6) e:prz h:'�' c:n(1) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','Rs1Uc->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','Rs1Uc->kta','s_tag','fio') h:'�����' c:c(8) ",,, 1,,,, str(ttnr, 6)+' '+str(MkUcr, 3)+' '+getfield('t1', 'MkUcr', 'mkeep', 'nmkeep')+' '+str(sdvor, 12, 2))
      if (lastkey()=K_ESC)
        exit
      endif

    enddo

    nuse('Rs1Uc')
  endif

  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  04-23-18 * 03:24:37pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
function Zen4KolUc(TtnUcr, aTypeUc)
  local nRec
  DEFAULT aTypeUc to {2, 0.01, nil, nil}
  do case
  case (aTypeUc[ 1 ]=2)
    kolr:=9999999
    smr:=0
    rc_r:=0
    while (ttn=TtnUcr)
      // ��ப� � ��� �-��
      if (kvp<kolr)
        kolr:=kvp
        rc_r:=recn()
      endif

      // �㬬� �-�
      smr:=smr+round(kvp*zen, 2)
      sele rs2
      skip
    enddo

    outlog(__FILE__, __LINE__,'TtnUcr,kolr, smr, rc_r', TtnUcr,kolr, smr, rc_r)
    if (Prc177r#0)
      // ����������......... ���� �-�� � �⪫������ �� �㬬� ���㬥�� smr
      if (gnEnt=21 .or. (gnEnt=20 .and. mkeep_r = 69))// ����� ⮢��

        kol_rrr=int(smr/round(Prc177r, 2))
        if (mod(smr, round(prc177r, 2))#0)
          rznst2r=(kol_rrr+1)*round(prc177r, 2)-smr
        endif

      else
        kol_rrr=round(smr/round(Prc177r, 2), 2)
        if (kol_rrr<0.10)
          kol_rrr=0.10
        endif

        rznst2r=kol_rrr*round(Prc177r, 2)-smr
      endif

    endif

    outlog(__FILE__, __LINE__, '  mntov177r, prc177r, kol_rrr, rznst2r', mntov177r, prc177r, kol_rrr, rznst2r)

    if (str(gnEnt, 3)$' 20; 21')
      // ���४�� 業�, �⮡� ��� �� �㬬�
      if (rznst2r#0)
        sele rs2
        go rc_r             // ��ப� � ��� �-��
        svp_r=round(kolr*zen, 2)+rznst2r
        zenr=round(svp_r/kolr, 2)
        if (zenr<0.01)
          zenr=0.01
        endif

        netrepl('zen', {zenr})
        svpr=round(kvp*zen, 2)
        netrepl('svp', {svpr})
      endif

    endif

  case (aTypeUc[ 1 ]=3)
    // �ਢ��� ��������� ⮢�� � ����� 業�
    while (ttn=TtnUcr)
      nRec:=RecNo()
      MnTovr:=MnTov
      nPriceMax:=zen
      while (MnTovr=MnTov)
        if (zen > nPriceMax)// ������� 業� �����
          nPriceMax:=zen
        endif

        sele rs2; skip
      enddo

      // ������� �� ���� 業�
      DBGoTo(nRec)
      while (MnTovr=MnTov)
        netrepl('zen', {nPriceMax})
        sele rs2; skip
      enddo

    enddo

  endcase

  return (nil)



/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  09-22-18 * 06:19:55pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
function OtvProtTest(aListRecNoTtn, aListTtn)

  // ᯨ᮪ ����஢ ����ᥩ ������
  if (Empty(aListRecNoTtn))
    aListRecNoTtn:={}
    for i:=1 to len(aListTtn)
      sele rs1
      ttn_r=aListTtn[ i ]
      netseek('t1', 'ttn_r')
      aadd(aListRecNoTtn, rs1->(RecNo()))
    next

  endif

  //outlog(__FILE__,__LINE__,aListTtn)
  //outlog(__FILE__,__LINE__,aListRecNoTtn)

  sele rs1
  set filt to
  PrTtnUcr := 0; aNnt:={}

  // ��ப� � ��⮪��� ���� � �⢥��࠭��
  for i:=1 to len(aListRecNoTtn)
    sele rs1
    DBGoTo(aListRecNoTtn[ i ])
    ttn_r=ttn

    if (empty(rs1->sdv))// �㬬� �-� = 0
      AADD(aNnt, STR(ttn_r, 6) + '�' + DTOC(rs1->Dvp) + '�' + '�㬬� �-� = 0 (SVD)')
    EndIf

    if (empty(rs1->dop))// ����� ��� ���㧪�
      AADD(aNnt, STR(ttn_r, 6) + '�' + DTOC(rs1->Dvp) + '�' + '��� ���㧪� (DOP)')
    endif

    sele rs2
    //browse()
    set order to tag t1
    if (!netseek('t1', 'ttn_r'))
      sele rs1
      skip; loop
    else
      netseek('t1', 'ttn_r')
      LOCATE while ttn_r = ttn ;
      for getfield('t1', 'rs1->skl,rs2->ktl', 'tov', 'opt') = 0
      // ��� ���⮩
      if (FOUND())
        AADD(aNnt, STR(ttn_r, 6) + '�' + DTOC(rs1->Dvp) + '�' + 'opt 業� = 0 '+ STR(rs2->skl,3) +' '+ str(rs2->ktl,9))
      else
        PrTtnUcr=1
      endif

      netseek('t1', 'ttn_r')
      LOCATE while ttn_r = ttn for otv # 0   // ��ப� � ��⮪���
      if (FOUND())
        //PrTtnUcr = 0
        AADD(aNnt, STR(ttn_r, 6) + '�' + DTOC(rs1->Dvp) + '�' + '�� ��� � O��.��')
      else
        PrTtnUcr=1
      //exit
      endif


    endif

  next i

  if (EMPTY(aNnt))      //  ��� �訡�� � ���
    if (PrTtnUcr = 0)
      wmess('��� ��� ��� ��ꥤ������', 3)
      return (.F.)
    endif

  else
    wmess('���祭� ��� � �஡������', 3)
    fnnt()                  // �������� ���ᨢ
    return (.F.)
  endif

  return (.T.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  09-24-18 * 02:55:08pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
static function aSmMkpUc(Rs2Uc, bWhile, aSmMkpRs1, aSmMkp, nSumMrsh)
  local zenr
  if (.F.)
    // �� 蠯��� ���
    aSmMkpRs1:={{mkeepr, smr, nmkeepr}}
    aSmMkp:={{mkeepr, smr, nmkeepr}}
  else
    // �� ��ப�� ���
    //outlog(__FILE__,__LINE__,ddcr,aSmMkpRs1)

    sele (Rs2Uc)
    // DBGoTop()
    while (eval(bWhile))//(!eof())
      mntovr:=mntov
      zenr:=zen

      kg_r:=int(mntovr/10000)
      if (!empty(getfield('t1', 'kg_r', 'cgrp', 'nal')))
        zenr=round(zenr*1.05, 2)
      endif

      SmLnr:=round(kvp*zenr, 2)// �㬬� ��ப�
      nSumMrsh += SmLnr

      mkeepr:=getfield('t1', 'mntovr', 'ctov', 'mkeep')
      nmkeepr:=getfield('t1', 'mkeepr', 'mkeep', 'nmkeep')

      nPosScn:=ascan(aSmMkp, {| aElem | aElem[ 1 ] = mkeepr})// ������ � ����
      if (!Empty(nPosScn))
        aSmMkp[ nPosScn, 2 ] += smlnr
      else
        aadd(aSmMkp, {mkeepr, smlnr, nmkeepr})
      endif

      sele (Rs2Uc)
      skip
    enddo

    // ������� ���
    for i:=1 to len(aSmMkp)
      aSmMkp[ i, 2 ] := ROUND(aSmMkp[ i, 2 ] * 1.20, 2)
    next

    nSumMrsh := ROUND(nSumMrsh * 1.20, 2)

  endif

  return (nil)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  09-24-18 * 03:06:18pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
static function UpDateOtUc(aSmMkpRs1, aSmMkp)

  for i:=1 to len(aSmMkp)
    mkeepr :=aSmMkp[ i, 1 ]
    smr := aSmMkp[ i, 2 ]
    nmkeepr := aSmMkp[ i, 3 ]
    if (smr#0)
      sele OtUc
      locate for mkeep=mkeepr
      if (!found())
        appe blank
        repl mkeep with mkeepr, nmkeep with nmkeepr
      endif

      // �㬬�஢����
      ddr=day(ddcr)

      cFldr='d'+ padl(ltrim(str(ddr, 2)), 2, '0')//iif(ddr<10,'0'+str(ddr,1),str(ddr,2))
      pFldr:=FieldPos(cFldr)
      FieldPut(pFldr, FieldGet(pFldr)+smr)//repl &cfldr with &cfldr+smr
      _field->d00 += smr

      DBGoTop()
      FieldPut(pFldr, FieldGet(pFldr)+smr)//repl &cfldr with &cfldr+smr
      _field->d00 += smr

      aSmMkpRs1[ 1, 2 ] -= smr// ����஫�
    endif

  next

  //outlog(__FILE__,__LINE__,aSmMkp)
  return (nil)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  10-19-18 * 04:53:49pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
static function ttnUc_kta_ktas_kgp_kpv()
  if (gnEnt=20)
    if (gnEntRm=0)
      netrepl('kta,ktas,kgp,kpv', {51, 51, 22012, 22012})
    else
      netrepl('kta,ktas,kgp,kpv', {51, 51, 22044, 22044})
    endif

  else

    if (gnEntRm=0)
      netrepl('kta,ktas,kgp,kpv', {365, 365, 20056, 20056})
    else
      netrepl('kta,ktas,kgp,kpv', {365, 365, 20056, 20056})
    endif

  endif

  return (nil)


/*******************************************************************
  */

#ifdef TTN169

  /************** */
  function -ttn169e()
    /************** */
    clea
    netuse('rs1')
    netuse('rs2')
    netuse('kln')
    netuse('mkeep')
    netuse('s_tag')
    netuse('cskl')
    netuse('ctov')
    netuse('mkeep')
    if (select('sl')=0)
      sele 0
      use _slct alias sl excl
      zap
    else
      sele sl
      zap
    endif

    store 0 to mkeep_r, pr169_r
    kol169r=0
    fldnomr=1
    sele rs1
    go top
    rcrs1r=recn()
    ForTtn_r='kop=169.and.mk169#0.and.sdv#0'
    ForTtnr=ForTtn_r
    osdvr=0
    while (.t.)
      set cent off
      sele rs1
      go rcrs1r
      foot('SPACE,F2,F3,F8,F9,F10,ENTER', '� ���,���,������,����.���,����� ��,��� ��,���')
      rcrs1r=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:prz h:'�' c:n(1) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:pr169 h:'O' c:n(1) e:mk169 h:'MK' c:n(3) e:ttn169 h:'����' c:n(6) e:dfp h:'��� ��' c:d(8)",,, 1,, ForTtnr,,, 1, 2)
      sele rs1
      go rcrs1r
      ttnr=ttn
      sdvr=sdv
      ttn169r=ttn169
      pr169r=pr169
      mk169r=mk169
      do case
      case (lastkey()=K_ESC)
        exit
      case (lastkey()=K_LEFT)// Left
        fldnomr=fldnomr-1
        if (fldnomr=0)
          fldnomr=1
        endif

      case (lastkey()=K_RIGHT)// Right
        fldnomr=fldnomr+1
      case (lastkey()=K_F3)   // ������
        clttncr=setcolor('gr+/b,n/bg')
        wttncr=wopen(10, 20, 16, 60)
        wbox(1)
        @ 0, 1 say '��મ��ঠ⥫�' get mkeep_r pict '999'
        @ 1, 1 say '�ਧ���       ' get pr169_r pict '9'
        read
        if (lastkey()=K_ESC)
          mkeep_r=0
          ForTtnr=ForTtn_r
        endif

        if (lastkey()=K_ENTER)
          if (mkeep_r#0)
            ForTtnr=ForTtn_r+'.and.mk169=mkeep_r'
          else
            ForTtnr=ForTtn_r
          endif

          if (pr169_r#0)
            ForTtnr=ForTtnr+'.and.pr169=pr169_r'
          endif

        endif

        wclose(wttncr)
        setcolor(clttncr)
        sele rs1
        go top
        osdvr=0
        while (!eof())
          if (mk169=mkeep_r.and.pr169=1.and.ttn169=0)
            osdvr=osdvr+sdv
          endif

          sele rs1
          skip
        enddo

        go top
        rcrs1r=recn()
        @ 23, 65 say str(osdvr, 12, 2)
      case (lastkey()=K_SPACE)// �⡮�
        if (mkeep_r#0)
          sele rs1
          if (fieldpos('pr169')#0)
            if (ttn169=0.and.pr169#2)
              if (pr169=0)
                netrepl('pr169', {1})
                osdvr=osdvr+sdv
              else
                netrepl('pr169', {0})
                osdvr=osdvr-sdv
              endif

            endif

            @ 23, 65 say str(osdvr, 12, 2)
            sele rs1
            netrepl('dtmod,tmmod', {date(), time()})
          endif

        else
          wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
        endif

      case (lastkey()=K_F10)// ����� ��
        sele rs1
        if (fieldpos('pr169')=0)
          wmess('������� �������� Rs1', 3)
          loop
        endif

        if (mkeep_r#0)
          osdvr=0
          sele rs1
          go top
          while (!eof())
            if (kop=169.and.mk169=mkeep_r)
              if (ttn169=0.and.pr169#2)
                netrepl('pr169', {1})
                osdvr=osdvr+sdv
                sele rs1
                netrepl('dtmod,tmmod', {date(), time()})
              endif

            endif

            sele rs1
            skip
          enddo

          @ 23, 65 say str(osdvr, 12, 2)
          sele rs1
          go rcrs1r
        else
          wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
        endif

      case (lastkey()=K_F8)// ������� �����
        quit
        if (mkeep_r#0)
          sdv_r=0
          ttn169r=0
          ttn169()
          ttnr=ttn169r
          sele rs1
          if (ttnr#0)
            netseek('t1', 'ttnr')
            netrepl('sdv,mk169', {sdv_r, mkeep_r})
            rcrs1r=recn()
          endif

          go rcrs1r
          @ 23, 65 say str(0, 12, 2)
        else
          wmess('��� 䨫��� �� ��મ��ঠ⥫�', 3)
        endif

      case (lastkey()=K_F9)// ����� �ਧ���
        if (mk169#0.and.pr169=0)
          netrepl('mk169', {0})
        endif

      case (lastkey()=K_F2)// ����
        otnof169()
      case (lastkey()=K_ENTER.and.pr169=2)// ��ᬮ��
        prsm169()
      endcase

    enddo

    nuse()
    return (.t.)

  /********************************************* */
  function -ttn169()
    /* ������� �� �⬥祭��� (pr169) ����� ���
     *********************************************
     */
    local kolr, smr, rc_r
    wait

    sele rs1
    set filt to
    go top
    prttn169r=0
    while (!eof())
      if (pr169#1)
        skip
        loop
      endif

      if (kop#169)
        skip
        loop
      endif

      if (ttn169#0)
        skip
        loop
      endif

      ttn_r=ttn
      sele rs2
      if (!netseek('t1', 'ttn_r'))
        sele rs1
        skip
        loop
      else
        prttn169r=1
        exit
      endif

      sele rs1
      skip
    enddo

    if (prttn169r=0)
      wmess('��� ��� ��� ��ꥤ������,3')
      return (.t.)
    endif

    sele cskl
    locate for sk=gnSk
    if (found())
      reclock()
      ttn169r=ttn
      if (ttn169r=999999)
        ttn169r=1
      endif

      sele rs1
      set filt to
      while (.t.)
        if (!netseek('t1', 'ttn169r'))
          exit
        endif

        ttn169r=ttn169r+1
        if (ttn169r=999999)
          ttn169r=1
        endif

      enddo

      sele rs1
      locate for pr169=1.and.kop=169
      if (found())
        arec:={}
        getrec()
        netadd()
        putrec()
        docguidr=''
        netrepl("ttn,kop,kopi,kpl,nkkl,kgp,kpv,ttn169,pr169,prz,vo,docguid,kto,ddc,tdc,dfp,dop,dvp,sdv",                                          ;
                 {ttn169r, 169, 169, 20034, 20034, 20034, 20034, 0, 2, 0, 9, docguidr, gnKto, date(), time(), ctod(''), ctod(''), date(), 0};
              )
        ttnUc_kta_ktas_kgp_kpv()

        netrepl('dtmod,tmmod', {date(), time()})
        if (fieldpos('mntov177')#0)

          mntov177r:=mntov177r(gnEnt)
          prc177r=getfield('t1', 'mntov177r', 'ctov', 'cenpr')

          netrepl('mntov177,prc177', {mntov177r, prc177r})
        endif

        dir_r=gcPath_m169+subs(gcDir_t, 1, len(gcDir_t)-1)
        if (dirchange(dir_r)#0)
          dirmake(dir_r)
        endif
        dirchange(gcPath_l)

        dir_r=gcPath_m169+gcDir_t+'t'+alltrim(str(ttn169r))
        if (dirchange(dir_r)#0)
          dirmake(dir_r)
        endif
        dirchange(gcPath_l)

        PathTtn169r=gcPath_m169+gcDir_t+'t'+alltrim(str(ttn169r))+'\'
        pathr=PathTtn169r
        if (!netfile('rs1', 1))
          copy file (gcPath_a+'rs1.dbf') to (PathTtn169r+'trsho14.dbf')
          copy file (gcPath_a+'rs2.dbf') to (PathTtn169r+'trsho15.dbf')
          lindx('trsho14', 'rs1', 1)
          lindx('trsho15', 'rs2', 1)
        endif

        netuse('rs1', 'rs1169',, 1)
        netuse('rs2', 'rs2169',, 1)
        sdv_r=0
        sele rs1
        set filt to
        go top
        while (!eof())
          if (pr169#1)
            skip
            loop
          endif

          if (kop#169)
            skip
            loop
          endif

          if (ttn169#0)
            skip
            loop
          endif

          sdv_r=sdv_r+sdv
          ttn_r=ttn
          sele rs2
          if (netseek('t1', 'ttn_r'))
            sele rs1
            reclock()
            arec:={}
            getrec()
            sele rs1169
            netadd()
            putrec()
            sele rs2
            while (ttn=ttn_r)
              rc169r=recn()
              ktlr=ktl
              kvpr=kvp
              arec:={}
              getrec()
              sele rs2169
              netadd()
              putrec()
              sele rs2
              if (!netseek('t1', 'ttn169r,ktlr'))
                netadd()
                putrec()
                netrepl('ttn', {ttn169r})
              else
                netrepl('kvp', {kvp+kvpr})
              endif

              netrepl('zen', {0.01})
              sele rs2
              go rc169r
              netdel()
              skip
            enddo

          endif

          sele rs1
          netrepl('ttn169,sdv', {ttn169r, 0})
          skip
        enddo

        sele rs2
        rznst2r=0
        rc_r=0
        if (netseek('t1', 'ttn169r'))
          kolr:=9999999
          smr:=0
          rc_r:=0
          while (ttn=ttn169r)
            // ��ப� � ��� �-��
            if (kvp<kolr)
              kolr=kvp
              rc_r=recn()
            endif

            // �㬬� �-�
            smr:=smr+round(kvp*zen, 2)
            sele rs2
            skip
          enddo

          outlog(__FILE__, __LINE__, kolr, smr, rc_r, 'kolr, smr, rc_r')
          if (prc177r#0)
            if (gnEnt=21)
              kol_rrr=int(smr/round(prc177r, 2))
              if (mod(smr, round(prc177r, 2))#0)
                rznst2r=(kol_rrr+1)*round(prc177r, 2)-smr
              endif

            else
              kol_rrr=round(smr/round(prc177r, 2), 2)
              if (kol_rrr<0.10)
                kol_rrr=0.10
              endif

              rznst2r=kol_rrr*round(prc177r, 2)-smr
            endif

          endif

          outlog(__FILE__, __LINE__, mntov177r, prc177r, kol_rrr, rznst2r, 'mntov177r, prc177r, kol_rrr, rznst2r')

          if (str(gnEnt, 3)$' 20; 21')
            // ���४�� 業�, �⮡� ��� �� �㬬�
            if (rznst2r#0)
              sele rs2
              go rc_r
              svp_r=round(kolr*zen, 2)+rznst2r
              zenr=round(svp_r/kolr, 2)
              if (zenr<0.01)
                zenr=0.01
              endif

              netrepl('zen', {zenr})
            endif

          endif

        endif

        nuse('rs1169')
        nuse('rs2169')
      endif

    endif

    return (.t.)

  /*************** */
  function otnof169()
    /*************** */

    if (select('ot169')#0)
      sele ot169
      close
    endif

    sele rs1
    copy stru to sot169 exte
    sele 0
    use sot169 excl
    zap
    appe blank
    repl field_name with 'mkeep', ;
     field_type with 'n',         ;
     field_len with 3
    appe blank
    repl field_name with 'nmkeep', ;
     field_type with 'c',          ;
     field_len with 20
    for i:=1 to eom(gdTd) //31
      appe blank
      repl field_name with 'd'+iif(i<10, '0'+str(i, 1), str(i, 2)), ;
       field_type with 'n',                                               ;
       field_len with 12,                                                 ;
       field_dec with 2
    next

    close
    create ot169 from sot169
    erase sot169.dbf
    sele 0
    use ot169
    sele rs1
    go top
    while (!eof())
      if (pr169#2)
        skip
        loop
      endif

      ttn169r=ttn
      mkeepr=mk169
      nmkeepr=getfield('t1', 'mkeepr', 'mkeep', 'nmkeep')
      ddcr=ddc
      PathTtn169r=gcPath_m169+gcDir_t+'t'+alltrim(str(ttn169r))+'\'
      pathr=PathTtn169r
      if (netfile('rs1', 1))
        netuse('rs1', 'rs1169',, 1)

        sele rs1169
        smr:=0
        while (!eof())
          smr=smr+sdv
          sele rs1169
          skip
        enddo

        if (smr#0)
          sele ot169
          locate for mkeep=mkeepr
          if (!found())
            appe blank
            repl mkeep with mkeepr, ;
             nmkeep with nmkeepr
          endif

          ddr=day(ddcr)
          cfldr='d'+iif(ddr<10, '0'+str(ddr, 1), str(ddr, 2))
          repl &cfldr with &cfldr+smr
        endif

        nuse('rs2169')
      endif

      sele rs1
      skip
    enddo

    // ����㫨����
    sele ot169
    go top
    rcot169r=recn()
    fldnomr=1
    while (.t.)
      sele ot169
      go rcot169r
      rcot169r=slce('ot169',,,,, "e:mkeep h:'TM' c:n(3) e:nmkeep h:'������������' c:c(20) e:d01 h:'01' c:n(10,2) e:d02 h:'02' c:n(10,2) e:d03 h:'03' c:n(10,2) e:d04 h:'04' c:n(10,2) e:d05 h:'05' c:n(10,2) e:d06 h:'06' c:n(10,2) e:d07 h:'07' c:n(10,2) e:d08 h:'08' c:n(10,2) e:d09 h:'09' c:n(10,2) e:d10 h:'10' c:n(10,2) e:d11 h:'11' c:n(10,2) e:d12 h:'12' c:n(10,2) e:d13 h:'13' c:n(10,2) e:d14 h:'14' c:n(10,2) e:d15 h:'15' c:n(10,2) e:d16 h:'16' c:n(10,2) e:d17 h:'17' c:n(10,2) e:d18 h:'18' c:n(10,2) e:d19 h:'19' c:n(10,2) e:d20 h:'20' c:n(10,2) e:d21 h:'21' c:n(10,2) e:d22 h:'22' c:n(10,2) e:d23 h:'23' c:n(10,2) e:d24 h:'24' c:n(10,2) e:d25 h:'25' c:n(10,2) e:d26 h:'26' c:n(10,2) e:d27 h:'27' c:n(10,2) e:d28 h:'28' c:n(10,2) e:d29 h:'29' c:n(10,2) e:d30 h:'30' c:n(10,2) e:d31 h:'31' c:n(10,2)",,,,,,,, 1, 2)
      sele ot169
      go rcot169r
      do case
      case (lastkey()=K_ESC)
        exit
      case (lastkey()=K_LEFT)// Left
        fldnomr=fldnomr-1
        if (fldnomr=0)
          fldnomr=1
        endif

      case (lastkey()=K_RIGHT)// Right
        fldnomr=fldnomr+1
      endcase

    enddo

    sele ot169
    close
    copy file ot169.dbf to (gcPath_m169+gcDir_t+'ot169.dbf')
    return (.t.)

  /*************** */
  function prsm169()
    /*************** */
    PathTtn169r=gcPath_m169+gcDir_t+'t'+alltrim(str(ttnr, 6))+'\'
    pathr=PathTtn169r
    if (netfile('rs1', 1))
      netuse('rs1', 'rs1169',, 1)
      sele rs1169
      sum sdv to sdvor
      go top
      rcrs1169r=recn()
      while (.t.)
        sele rs1169
        go rcrs1169r
        foot('', '')
        rcrs1169r=slcf('rs1169', 1,, 18,, "e:ttn h:'���' c:n(6) e:prz h:'�' c:n(1) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1169->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1169->kta','s_tag','fio') h:'�����' c:c(8) ",,, 1,,,, str(ttnr, 6)+' '+str(mk169r, 3)+' '+getfield('t1', 'mk169r', 'mkeep', 'nmkeep')+' '+str(sdvor, 12, 2))
        if (lastkey()=K_ESC)
          exit
        endif

      enddo

      nuse('rs1169')
    endif

    return (.t.)
#endif
