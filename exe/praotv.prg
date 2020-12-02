/***********************************************************
 * �����    : praotv.prg
 * �����    : 0.0
 * ����     :
 * ���      : 02/18/20
 * �������   :
 * ��⮬���᪨� ��室 �� ����� �᭮����� ᪫��� �� ��.��.
 * �� ���⢥ত���� ��室�(����) � �᭮���� ᪫���
 * ��⠭���� otv=0 � ��室��-���筨���
 * ���室-��⮬�� � vo=9 � kop=151 (����)
 *
 Function praotv()
 Return (Nil)
 */


sele pr1
if (netseek('t3', '1,kpsr'))
  sktpr=sksp
  skltpr=sklsp
else
  wmess('�� �뫮 ��室�� � ᪫��� ��.��. '+str(kpsr, 7), 2)
  return
endif


netUse('rs2')

sele cskl
netseek('t1', 'sktpr')
pathr=gcPath_d+alltrim(path)
mskltpr=mskl
skltpr=skl

netUse('rs1', 'rs1t',, 1)
netUse('rs2', 'rs2t',, 1)
netUse('rs3', 'rs3t',, 1)
netUse('tov', 'tovt',, 1)
netUse('tovm', 'tovmt',, 1)
netuse('sgrp', 'sgrpt',, 1)
netuse('soper', 'sopert',, 1)


if (mskltpr=1)
  netuse('sGrpE', 'sGrpEt',, 1)
endif

/*** ����� �� pr1 , ������� � rs1t ******************* */

sele pr1
if (netseek('t2', 'mnr'))
  amnpr=amnp
endif

if (mode = 1)             // ��ନ஢����
  sele rs1t
  if (amnpr#0)
    ttnr=amnpr
    if (netseek('t1', 'ttnr'))
      netdel()
      sele rs2t
      if (netseek('t1', 'ttnr'))
        while (ttn=ttnr)
          netdel()
          skip
        enddo

      endif

      sele rs3t
      if (netseek('t1', 'ttnr'))
        while (ttn=ttnr)
          netdel()
          skip
        enddo

      endif

    endif

  else

    sele cskl
    netseek('t1', 'sktpr')
    Reclock()
    if (ttn=0)
      repl ttn with 1
    endif

    ttnr=ttn
    if (ttn<999999)
      Replace ttn with ttn+1
    else
      Replace ttn with 1
    endif

    netunlock()

  endif

  sele pr1
  if (netseek('t2', 'mnr'))
    reclock()
    mnr=mn
    dvpr=date()
    ddcr=date()
    tdcr=time()
    dprr=dpr
    netrepl('amnp,sktp,skltp', 'ttnr,sktpr,skltpr')


    vo_tr=9 // ��� ��� ����
    kop_tr=151 // ��� ���
    g_tr=mod(kop_tr,100)

    sele rs1t
    NetAdd()
    netrepl('ttn,skl,sksp,sklsp,amnp,kpl,dvp,ddc,tdc,kto,vo,kop,prz,dot',        ;
             {ttnr,skltpr,gnSk,sklr,mnr,gnKklm,dvpr,ddcr,tdcr,gnKto,vo_tr,kop_tr,1,dprr} ;
          )
    // �ਧ��� 2-� 業�
    pBZenr=getfield('t1', '0,1,vo_tr,g_tr','sopert','pBZen')
    // ⨯ 業�
    pTCenr=getfield('t1', '0,1,vo_tr,g_tr','sopert','pTCen')
    // �⭮襭�� ���
    pNdsr =getfield('t1', '0,1,vo_tr,g_tr','sopert','pNds')
    cBOptr=""
    If pBZenr#0
      //�������� ���� � CTOV
      cBOptr=allt(getfield('t1', 'ptcenr', 'tcen', 'zen'))
    EndIf
    outlog(3,__FILE__,__LINE__,"pBZenr cBOptr",pBZenr,cBOptr)


  endif

else                        //�������� mode <> 1
  if (amnpr#0)
    ttnr=amnpr
    sele rs1t
    if (netseek('t1', 'ttnr'))
      netdel()
    endif

  endif

endif

/*** ����� � pr3 , ������� � rs3t ******************** */
if (mode=1)
else
  if (ttnr#0)
    sele rs3t
    if (netseek('t1', 'ttnr'))
      while (ttn=ttnr)
        netdel()
        skip
      enddo

    endif

  endif

endif

/*** ����� � pr2 , ������� � rs2t ******************** */
if (mode=1)

  sele pr2
  netseek('t1', 'mnr')
  while (mn=mnr)
    ktlr=ktl
    mntovr=mntov
    ktlpr=ktlm
    ktlmr=ktlm
    ktlmpr=ktlmp
    pptr=ppt
    kgnr=int(ktlr/1000000)
    kvpr=kf
    zenr=zen
    svpr=ROUND(kvpr*zenr, 2)

    sele sgrpt
    if (!netseek('t1', 'kgnr'))
      sele sgrp
      if (netseek('t1', 'kg_r'))
        arec:={}
        getrec()
        sele sgrpt
        netadd()
        putrec()
        netrepl('ktl', 'kgnr*1000000+1')
      endif

    endif

    if (mskltpr=1)
      sele sGrpEt
      if (!netseek('t1', 'skltr,kgnr'))
        ktlnr=kgnr*1000000+1
        netadd()
        netrepl('skl,kg,ktl', 'skltr,kgnr,ktlnr')
      endif

    endif

    /*** ��p���� ���⪮� ************************************** */
    SELE tov
    izgr=0
    if (netseek('t1', 'sklr,ktlr'))
      izgr=izg
      arec:={}
      getrec()              // gather(fox)
    endif

    SELE tovt
    netseek('t1', 'skltpr,ktlmr')
    if (FOUND())
      netrepl('osv,osfm,osf', 'osv-kvpr,osfm-kvpr,osf-kvpr')
    else
      NetAdd()
      Reclock()
      putrec()              // scatter(fox)
      netrepl('skl,ktl,osn,osfm,osv,osf,ktlm', ;
               'skltpr,ktlmpr,0,0,0,0,ktlr'     ;
            )
    endif

    sele tovmt
    if (!netseek('t1', 'skltpr,mntovr'))
      sele tovm
      netseek('t1', 'sklr,mntovr')
      arec:={}
      getrec()
      sele tovmt
      netadd()
      putrec()
      netrepl('skl,osn,osv,osf,osfm', 'skltpr,0,0,0,0')
    else
      netrepl('osv,osfm,osf', 'osv-kvpr,osfm-kvpr,osf-kvpr')
    endif

    sele rs2t
    netadd()
    netrepl('ttn,mntov,mntovp,ktl,kvp,svp,zen,ktlp,ppt,ktlm,ktlmp,izg',           ;
             {ttnr,mntovr,mntovr,ktlmr,kvpr,svpr,zenr,ktlmpr,pptr,ktlr,ktlpr,izgr} ;
          )
    If !Empty(cBOptr) // ������ 2-�� 業�
      BZenr=getfield('t1','mntovr','ctov',cBOptr)
      netrepl('BZen,BSvp',{BZenr,ROUND(kvpr*BZenr, 2)})
    EndIf

    sele pr2
    skip
    if (eof())
      exit
    endif

  enddo

  /*  ���㫥��� otv � ��室��-���筨��� */
  sele rs2
  set orde to tag t5
  if (netseek('t5', 'mnr'))
    while (amnp=mnr)
      netrepl('otv', '0')
      skip
    enddo

  endif

  set orde to tag t1
else                        // ��������
  if (ttnr#0)
    sele rs2t
    if (netseek('t1', 'ttnr'))
      while (ttn=ttnr)
        ktlr=ktl
        mntovr=mntov
        kvpr=kvp
        netdel()
        sele tovt
        if (netseek('t1', 'skltpr,ktlr'))
          netrepl('osv,osfm,osf', 'osv+kvpr,osfm+kvpr,osf+kvpr')
        endif

        sele tovmt
        if (netseek('t1', 'skltpr,mntovr'))
          netrepl('osv,osfm,osf', 'osv+kvpr,osfm+kvpr,osf+kvpr')
        endif

        sele rs2t
        skip
      enddo

    endif

  endif

endif

/*unlock all */
nuse('rs1t')
nuse('rs2t')
nuse('rs3t')
nuse('tovt')
nuse('sgrpt')
nuse('sGrpEt')
nuse('sopert')
nuse('rs2')
return
