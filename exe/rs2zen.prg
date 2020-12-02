//���� ���� 業 RS2.DBF
#define DEF_ROUND 2
// *******************************************************
function rs2pZen(p1, p2)
  // r s2prc()
  // p1=1 ⥪�騥 �ࠩᮢ� 業� ,�������� ᪨���
  // p1=2 �ࠩᮢ� 業� �� ���㬥���,᪨��� �� ���㬥���
  // prDecr=0 - 3 ��
  // prDecr=1 - �� TCen
  // prDecr=2 - �� 2 �� �᫨ TCen.Dec=0
  // ********************************************************
  local nZenNew

  if (gnKt=1) // ᪫�� �������
    return (.t.)
  endif

  okopr=mod(kopr, 100)

  store 0 to onofr, opBZenr, opXZenr// soper nof,�ਧ���� �ନ஢���� 2,3 業�

  store 0 to oTCenPr, oTCenBr, oTCenXr// soper �ࠩ��
  store 0 to oDecPr, oDecBr, oDecXr   // rs2 soper �ࠩ�� ���㣫����

  store 0 to rTCenPr, rTCenBr, rTCenXr// rs2 �ࠩ��
  store 0 to rDecPr, rDecBr, rDecXr   // rs2 ���㣫����

  store 0 to Optr, DecOr    // �室��� 業�
  TCenOr=1

  store 0 to MinZenr, DecMZr// �������쭠� 業�
  TCenMZr=30

  al_rs1 := If( Empty(select("rs1")),tbl1r,"rs1")
  al_rs2 := If( Empty(select("rs2")),tbl2r,"rs2")
  al_rs2m := If( Empty(select("rs2m")),tbl2mr,"rs2m")

  sele soper
  if (netseek('t1', '0,1,vor,okopr'))
    onofr=nof
    opBZenr=pBZen
    opXZenr=pXZen

    oTCenPr=TCen
    oTCenBr=pTCen
    if (oTCenBr=0)
      oTCenBr=oTCenPr
    endif

    oTCenXr=xTCen
    if (oTCenXr=0)
      oTCenXr=1             // �室��� 業�
    endif

    oDecPr=getfield('t1', 'oTCenPr', 'TCen', 'Dec')
    if (oDecPr=0)
      oDecPr=DEF_ROUND//3
    endif

    oDecBr=getfield('t1', 'oTCenBr', 'TCen', 'Dec')
    if (oDecBr=0)
      oDecBr=DEF_ROUND//3
    endif

    oDecXr=getfield('t1', 'oTCenXr', 'TCen', 'Dec')
    if (oDecXr=0)
      oDecXr=DEF_ROUND//3
    endif

  else
    wmess('�� ������ ��� � soper', 3)
    quit
  endif


  sele (al_rs2)
  set orde to tag t1
  if (netseek('t1', 'ttnr'))
    while (ttn=ttnr)
      ktlr=ktl
      ktlpr=ktlp
      pptr=ppt
      MnTovr=MnTov
      MnTovpr=MnTovp
      kvpr=kvp
      outlog(3,__FILE__,__LINE__,'MnTovr',MnTovr)

      if (kvpr=0)
        netdel()
        skip;        loop
      endif

      KolAkcr=getfield('t1', 'MnTovr', 'ctov', 'KolAkc')

      if (KolAkcr#0) // ��樨 �� ⮢���
        if (kvpr>=KolAkcr) // �-�� ��. �����= ��樨, � �� �஢��塞
          sele (al_rs2)
          skip;          loop
        endif

      endif
      outlog(3,__FILE__,__LINE__,' ���� =0 ��� kvp<  MnTovr',MnTovr)

      // ��������� �㬬� ��� ���४樨 rs2m
      svp_r=svp
      bsvp_r=bsvp
      xsvp_r=xsvp
      sr_r=sr
      //

      Zenr=Zen
      prZenr=pZen
      ZenPr=ZenP
      prZenPr=prZenP
      BZenr=BZen
      prBZenPr=prBZenP
      prBZenr=pBZen
      BZenPr=BZenP
      XZenr=XZen
      prXZenr=pXZen
      XZenPr=XZenP
      prXZenPr=prXZenP

      MZenr=MZen

      if (fieldpos('TCenP')#0)
        rTCenPr=TCenP
      else
        rTCenPr=0
      endif

      if (fieldpos('TCenB')#0)
        rDecPr=DecP
        rTCenBr=TCenB
        rDecBr=DecB
        rTCenXr=TCenX
        rDecXr=DecX
      else
        rDecPr=0
        rTCenBr=0
        rDecBr=0
        rTCenXr=0
        rDecXr=0
      endif

      do case
      case (prDecr=0)
        rDecPr=DEF_ROUND//3
        rDecBr=DEF_ROUND//3
        rDecXr=DEF_ROUND//3
      case (prDecr=2)
        rTCenPr=oTCenPr
        rDecPr=getfield('t1', 'rTCenPr', 'TCen', 'Dec')
        if (rDecPr=0)
          rDecPr=2
        endif

        rTCenBr=oTCenBr
        rDecBr=getfield('t1', 'rTCenBr', 'TCen', 'Dec')
        if (rDecBr=0)
          rDecBr=2
        endif

        rTCenXr=oTCenXr
        rDecXr=getfield('t1', 'rTCenXr', 'TCen', 'Dec')
      otherwise
        rTCenPr=oTCenPr
        rDecPr=getfield('t1', 'rTCenPr', 'TCen', 'Dec')
        rTCenBr=oTCenBr
        rDecBr=getfield('t1', 'rTCenBr', 'TCen', 'Dec')
        rTCenXr=oTCenXr
        rDecXr=getfield('t1', 'rTCenXr', 'TCen', 'Dec')
      endcase

      if (rDecPr=0)
        rDecPr=DEF_ROUND//3
      endif

      if (rDecBr=0)
        rDecBr=DEF_ROUND//3
      endif

      if (rDecXr=0)
        rDecXr=DEF_ROUND//3
      endif

      // �室��� 業�
      Optr=getfield('t1', 'sklr,ktlr', 'tov', 'Opt')
      DecOr=getfield('t1', '1', 'TCen', 'Dec')
      if (DecOr=0)
        DecOr=3
      endif

      sele (al_rs2)
      if (p1=1)
        outlog(3,__FILE__,__LINE__,"ZenRs2()")
        ZenRs2()            // �� �ࠩ��
      else
        outlog(3,__FILE__,__LINE__,"ZenRs2(1)")
        ZenRs2(1)         // �� ���㬥���
      endif

      sele (al_rs2)
      srr=roun(Optr*kvp, 2)
      svpr=roun(Zenr*kvp, 2)
      bsvpr=roun(BZenr*kvp, 2)
      xsvpr=roun(XZenr*kvp, 2)

      netrepl('svp,sr,Zen,pZen,BZen,pBZen,ZenP,prZenP,BZenP,prBZenP,XZen,pXZen,XZenP,prXZenP',                                   ;
               { svpr, srr, Zenr, prZenr, BZenr, prBZenr, ZenPr, prZenPr, BZenPr, prBZenPr, XZenr, prXZenr, XZenPr, prXZenPr }, 1 ;
           )
      netrepl('bsvp,xsvp', { bsvpr, xsvpr }, 1)

      if (fieldpos('TCenP')#0)
        netrepl('TCenP', { rTCenPr }, 1)
      endif

      if (fieldpos('TCenB')#0)
        netrepl('DecP,TCenB,DecB,TCenX,DecX', { rDecPr, rTCenBr, rDecBr, rTCenXr, rDecXr }, 1)
      endif

      netrepl('MZen', 'MZenr')

      sele (al_rs2m)
      if (netseek('t3', 'ttnr,MnTovpr,pptr,MnTovr'))
        netrepl('svp,sr,ZenP,prZenP,BZenP,prBZenP,XZenP,prXZenP',                                      ;
                 { svp-svp_r+svpr, sr-sr_r+srr, ZenPr, prZenPr, BZenPr, prBZenPr, XZenPr, prXZenPr }, 1 ;
             )
        netrepl('bsvp,xsvp', { bsvp-bsvp_r+bsvpr, xsvp-xsvp_r+xsvpr }, 1)

        if (fieldpos('TCenP')#0)
          netrepl('TCenP', { rTCenPr }, 1)
        endif

        if (fieldpos('TCenB')#0)
          netrepl('DecP,TCenB,DecB,TCenX,DecX',                   ;
                   { rDecPr, rTCenBr, rDecBr, rTCenXr, rDecXr }, 1 ;
               )
        endif

        netrepl('MZen', { MZenr }, 1)

        Zenmr=Zenr
        prZenmr=prZenr
        BZenmr=BZenr
        prBZenmr=prBZenr
        XZenmr=XZenr
        prXZenmr=prXZenr

        if (ndsr=2.or.ndsr=3.or.ndsr=5)
          Zenmr=ROUND(svp/kvp, rDecPr)
          BZenmr=ROUND(bsvp/kvp, rDecBr)
          XZenmr=ROUND(xsvp/kvp, rDecXr)
        else
          Zenmr=ROUND(svp/kvp, 2)
          BZenmr=ROUND(bsvp/kvp, 2)
          XZenmr=ROUND(xsvp/kvp, 2)
        endif

        prZenmr=roun((Zenmr/ZenPr-1)*100, 2)
        if (abs(prZenmr)>999)
          prZenmr=0
        endif

        prBZenmr=roun((BZenmr/BZenPr-1)*100, 2)
        if (abs(prBZenmr)>999)
          prBZenmr=0
        endif

        prXZenmr=roun((XZenmr/XZenPr-1)*100, 2)
        if (abs(prXZenmr)>999)
          prXZenmr=0
        endif

        netrepl('Zen,pZen,BZen,pBZen,XZen,pXZen',                      ;
                 { Zenmr, prZenmr, BZenmr, prBZenmr, XZenmr, prXZenmr } ;
             )
      endif

      sele (al_rs2)
      skip
    enddo

  endif

  if (p1=1)
    sele (al_rs1)
    if (KopI#177)
      netrepl('KopI', { kopr }, 1)
    endif

  endif

  sele (al_rs1)
  if (fieldpos('prDec')#0)
    netrepl('prDec', { prDecr }, 1)
    prDec_fr=prDec
  else
    prDec_fr=0
  endif

  if (p1=1)
    if (gnScOut=0)
      @ 2, 14 say str(rs1->kop, 3)+'('+str(rs1->KopI, 3)+')'+' '+nopr
    endif

    if (KopIr#177)
      KopIr=kopr
    endif

    nds_fr=ndsr
    pnds_fr=pndsr
    xnds_fr=xndsr
    kop_fr=kopr
    nKkl_fr=nKkl
    if (fieldpos('prDec')#0)
      prDec_fr=prDec
    else
      prDec_fr=0
    endif

    nof_fr=nofr
  endif

  return (.t.)

/*****************************************************************
  // ZenRs2()
  // p1=0 ⥪�騥 �ࠩᮢ� 業� ,�������� ᪨���
  // p1=1 �ࠩᮢ� 業� �� ���㬥���,᪨��� �� ���㬥���
  // p2 - ktl
  // p3 - MnTov
  */
function ZenRs2(p1, p2, p3)
  local nZenNew
  local al_rs2 := If( Empty(select("rs2")),tbl2r,"rs2")

  if (!empty(p2))
    ktlr=p2
  endif

  if (!empty(p3))
    MnTovr=p3
  endif

  store 0 to rcMnTovr, rcMnTovtr

  sele ctov
  if (!netseek('t1', 'MnTovr'))
    wmess(str(MnTovr, 7)+' �� ������ � CTOV', 3)
    quit
  else
    MnTovtr=MnTovt
    rcMnTovr=recn()
    if (MnTovtr=0)
      MnTovtr=MnTovr
      rcMnTovtr=rcMnTovr
    else
      if (!netseek('t1', 'MnTovtr'))
        MnTovtr=MnTovr
        rcMnTovtr=rcMnTovr
      else
        rcMnTovtr=recn()
      endif

    endif

    go rcMnTovr
  endif

  izgr=izg
  mkeepr=mkeep
  brandr=brand
  kgr_r=int(MnTovr/10000)

  if (fieldpos('blksk')#0)
    blkskr=blksk
  else
    blkskr=0
  endif

  // ��।������ �ࠩ� �� �᫮���
  // ������ ⮫쪮 �� klnnac.dbf
  store 0 to vipTCenr, kgpnacr, kgpnac1r
  if (empty(p1).or.nKklr#nKkl_fr.and.CorSh=1.or.prDec_fr=prDecr)//  �� �᫮���
    if (gnVo=9.and.KopIr#177)
      sele klnnac
      if (netseek('t1', 'nkklr,izgr,kgr_r'))
        if (TCen#0)
          vipTCenr=TCen
          outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
        endif

      else
        sele klnnac
        if (netseek('t1', 'nkklr,izgr,999'))
          if (TCen#0)
            vipTCenr=TCen
            outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
          endif

        endif

      endif

      if (vipTCenr=0)
        sele kgptm
        if (netseek('t1', 'kpvr,mkeepr'))
          vipTCenr=TCen
          outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
          kgpnacr=nac
          kgpnac1r=nac1
        endif

        if (vipTCenr=0)
          knaspr=getfield('t1', 'kpvr', 'kln', 'knasp')
          kgpcatr=getfield('t1', 'kpvr', 'kgp', 'kgpcat')
          if (knaspr#0)
            sele nasptm
            if (kgpcatr#0)
              if (netseek('t2', 'knaspr,kgpcatr,mkeepr'))
                vipTCenr=TCen
                outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
                kgpnacr=nac
                kgpnac1r=nac1
              endif

            endif

            if (vipTCenr=0)
              if (netseek('t2', 'knaspr,0,mkeepr'))
                vipTCenr=TCen
                outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
                kgpnacr=nac
                kgpnac1r=nac1
              endif

            endif

          endif

        endif

        if (vipTCenr=0)
          krnr=getfield('t1', 'kpvr', 'kln', 'krn')
          kgpcatr=getfield('t1', 'kpvr', 'kgp', 'kgpcat')
          if (krnr#0)
            sele rntm
            if (kgpcatr#0)
              if (netseek('t2', 'krnr,kgpcatr,mkeepr'))
                vipTCenr=TCen
                outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
                kgpnacr=nac
                kgpnac1r=nac1
              endif

            endif

            if (vipTCenr=0)
              sele krntm
              if (netseek('t1', 'krnr,mkeepr'))
                vipTCenr=TCen
                outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
                kgpnacr=nac
                kgpnac1r=nac1
              endif

            endif

          endif

        endif

      endif

    else
      vipTCenr=0
    endif

    // �ࠩ��
    outlog(3, __FILE__, __LINE__, ' vipTCenr', vipTCenr)
    if (vipTCenr=0)
      // �� soper
      rTCenPr=oTCenPr
      rDecPr=oDecPr
      rTCenBr=oTCenBr
      rDecBr=oDecBr
      rTCenXr=oTCenXr
      rDecXr=oDecXr
    else
      rTCenPr=vipTCenr
      if (prDecr=1)
        rDecPr=getfield('t1', 'rTCenPr', 'TCen', 'Dec')
      else
        rDecPr=DEF_ROUND//3
      endif

      rTCenBr=oTCenBr
      rDecBr=oDecBr

      rTCenXr=oTCenXr
      rDecXr=oDecXr
    endif

    if (rDecPr=0)
      rDecPr=DEF_ROUND//3
    endif

    if (rDecBr=0)
      rDecBr=DEF_ROUND//3
    endif

    if (rDecXr=0)
      rDecXr=DEF_ROUND//3
    endif


    cZenPr=alltrim(getfield('t1', 'rTCenPr', 'TCen', 'Zen'))
    if (rTCenPr=1)
      ZenPr=getfield('t1', 'sklr,ktlr', 'tov', cZenPr)
    else
      ZenPr=getfield('t1', 'MnTovtr', 'ctov', cZenPr)
    endif
    Zenr=ZenPr
    outlog(3, __FILE__, __LINE__, ' rTCenPr,cZenPr,ZenPr', rTCenPr,cZenPr,ZenPr)


    cBZenPr=alltrim(getfield('t1', 'rTCenBr', 'TCen', 'Zen'))
    if (rTCenBr=1)
      BZenPr=getfield('t1', 'sklr,ktlr', 'tov', cBZenPr)
    else
      BZenPr=getfield('t1', 'MnTovtr', 'ctov', cBZenPr)
    endif
    BZenr=BZenPr


    cXZenPr=alltrim(getfield('t1', 'rTCenXr', 'TCen', 'Zen'))
    if (rTCenXr=1)
      XZenPr=getfield('t1', 'sklr,ktlr', 'tov', cXZenPr)
    else
      XZenPr=getfield('t1', 'MnTovtr', 'ctov', cXZenPr)
    endif
    XZenr=XZenPr

  else
  endif

  // �������� ᪨���
  store 0 to nacZenPr, nacBZenPr, MinZen1r
  kgrr=int(ktlr/1000000)
  if (DogUslr=1.and.KopIr#177.and.(blkskr=0.or.blkskr=1.and.vipTCenr#0))
    if (brandr#0)
      if (kgrr>1)
        sele mnnac
        if (netseek('t1', 'nkklr,brandr,MnTovr'))
          nacZenPr=nac
          nacBZenPr=nac1
          MinZen1r=MinZen1
        endif

        if (nacZenPr=0)
          store 0 to nacZenPr, nacBZenPr, MinZen1r
          sele brnac
          if (netseek('t1', 'nkklr,mkeepr,brandr'))
            nacZenPr=nac
            nacBZenPr=nac1
            MinZen1r=MinZen1
          endif

        endif

      endif

    endif

    if (nacZenPr=0)
      store 0 to nacZenPr, nacBZenPr, MinZen1r
      if (kgrr>1)
        sele klnnac
        if (!netseek('t1', 'nKklr'))
          sele mkeepe
          if (netseek('t2', 'izgr') .AND. !DELETED())//��!!!!!!!!!!!!
            nacZenPr=0
            nacBZenPr=0
            MinZen1r=0
          else              //��� - ��  //��騩 ��業�
            sele kpl
            if (netseek('t1', 'nKKLr'))
              nacZenPr=nac
              nacBZenPr=nac1
              MinZen1r=0
            endif

          endif

        else
          sele mkeepe
          if (NetSeek('t2', 'izgr').AND. !DELETED())//��!!!!!!!!!!!!
            sele klnnac
            if (!NetSeek('t1', 'nKklr,izgr'))//��� ⠪��� ����⮢�⥫�
              nacZenPr=0
              nacBZenPr=0
              MinZen1r=0
            else            //����⮢�⥫� ⠪�� ����!!!
              sele klnnac
              if (!NetSeek("T1", "nKklr, Izgr, 999"))
                nacZenPr=0
                nacBZenPr=0
                MinZen1r=0
              else
                nacZenPr=nac
                nacBZenPr=nac1
                MinZen1r=MinZen1
              endif

              if (nacZenPr=0)
                if (netseek("T1", "nKklr, Izgr, kgrr"))
                  nacZenPr=nac
                endif

              endif

              if (nacBZenPr=0)
                if (netseek("T1", "nKklr, Izgr, kgrr"))
                  nacBZenPr=nac1
                  MinZen1r=MinZen1
                endif

              endif

            endif

          else              // �� ��મ��ঠ⥫� � klnnac
            sele kpl
            if (netseek('t1', 'nKKLr'))
              nacZenPr=nac
              nacBZenPr=nac1
              MinZen1r=0
            endif

          endif

        endif

      endif                 // kgrr>1

    endif                   // nacZenPr=0(brand)

  endif

  // �᫨ ���� ��業�� �� ��㧮�����⥫�
  if (gnVo=9.and.KopIr#177.and.kgrr>1.and.blkskr=0)
    if (vipTCenr=0)
      if (nacZenPr=0)
        nacZenPr=kgpnacr
      endif

      if (nacBZenPr=0)
        nacBZenPr=kgpnac1r
      endif

    endif

  endif

  /****************************************************** */
  // �᫮��� ��⮬���᪮�� ������ 業
  /****************************************************** */
  if (empty(p1).or.nKklr#nKkl_fr.and.CorSh=1.and.KopIr#177.and.blkskr=0.or.prDecr#prDec_fr)
    if (gnVo=9.or.gnVo=2)
      prZenr=nacZenPr
      prZenPr=nacZenPr
    else
      if (kopr=186)       // �������
        prZenr=1
        prZenPr=1
      else
        prZenr=0
        prZenPr=0
      endif

    endif

    if (gnVo=9.or.gnVo=2)
      prBZenr=nacBZenPr
      prBZenPr=nacBZenPr
    else
      prBZenr=0             //nacBZenPr
      prBZenPr=0            //nacBZenPr
    endif

    prXZenr=0
    prXZenPr=0
  endif

  /******************************************************** */

  // ����� ����� 業
  if (nofr=1)
      if (ndsr=2.or.ndsr=3.or.ndsr=5)
        Zenr=ROUND(ZenPr*(prZenr+100)/100, rDecPr)
        BZenr=ROUND(BZenPr*(prBZenr+100)/100, rDecBr)
        XZenr=ROUND(XZenPr, rDecXr)
      else
        Zenr=ROUND(ZenPr*(1+gnNds/100)*(prZenr+100)/100, 2)
        BZenr=ROUND(BZenPr*(1+gnNds/100)*(prBZenr+100)/100, 2)
        XZenr=ROUND(XZenPr*(1+gnNds/100)*(prXZenr+100)/100, 2)
        if (Zenr=0.and.int(ktlr/1000000)>1)
          Zenr=0.01
        endif

        if (BZenr=0.and.int(ktlr/1000000)>1)
          BZenr=0.01
        endif

        if (XZenr=0.and.int(ktlr/1000000)>1)
          XZenr=0.01
        endif

      endif

  else
    if (ndsr=2.or.ndsr=3.or.ndsr=5)
      Zenr=ROUND(ZenPr*(prZenr+100)/100, rDecPr)
    else
      Zenr=ROUND(ZenPr*(prZenr+100)/100, 2)
      if (Zenr=0.and.int(ktlr/1000000)>1)
        Zenr=0.01
      endif

    endif

    if (pndsr=2.or.pndsr=3.or.pndsr=5)
      BZenr=ROUND(BZenPr*(prBZenr+100)/100, rDecBr)
    else
      BZenr=ROUND(BZenPr*(prBZenr+100)/100, 2)
      if (BZenr=0.and.int(ktlr/1000000)>1)
        BZenr=0.01
      endif

    endif

    if (xndsr=2.or.xndsr=3.or.xndsr=5)
      XZenr=ROUND(XZenPr*(prXZenr+100)/100, rDecXr)
    else
      XZenr=ROUND(XZenPr*(prXZenr+100)/100, 2)
      if (XZenr=0.and.int(ktlr/1000000)>1)
        XZenr=0.01
      endif

    endif

  endif
  outlog(3,__FILE__,__LINE__,"Zenr,ZenPr,prZenr,rDecPr",Zenr,ZenPr,prZenr,rDecPr)

  // �஢�ઠ 1-� 業� �� ���������� � �室���
  if (gnCtov=1)
    sele ctov
  else
    sele tov
  endif

  // ��� 業� �24
  if (empty(p1) .or. (nKklr#nKkl_fr.and.CorSh=1) .or. prDecr#prDec_fr)
    MZenr=c24
  else
    if (MZenr=0)
      MZenr=c24
    endif

  endif
  outlog(3, __FILE__, __LINE__, ' ALIAS(), MZenr', ALIAS(),MZenr)

  // �����஢�� �� �室��� 業�� 1-���� �몫.
  if (fieldpos('NoOpt')#0)
    NoOptr=NoOpt
  else
    NoOptr=0
  endif
  outlog(3, __FILE__, __LINE__, ' NoOpt', NoOpt)

  Optr=getfield('t1', 'sklr,ktlr', 'tov', 'Opt')
  MZen_rr=MZenr
  Opt_rr=Optr

  //��ଠ�����㥬 業� ����������
  if (!(ndsr=5.or.ndsr=3.or.ndsr=2))
    MZenr=round(MZenr*(1+gnNds/100), 2)
  endif

  //��ଠ�����㥬 業� ���㯮���
  if (!(ndsr=5.or.ndsr=3.or.ndsr=2))
    Optr:=round(Optr*(1+gnNds/100), 2)
  endif

  // ���⥫�騪 �஢������ �� ���.業� =1
  prMZenr=getfield('t1', 'nkklr', 'kpl', 'prMZen')
  outlog(3, __FILE__, __LINE__, ' ���⥫�騪 prMZenr', prMZenr)

  if (gnEnt=20)
    if (empty(p1).or.nKklr#nKkl_fr.and.CorSh=1);
      .and.int(ktlr/1000000)>1.or.prDecr#prDec_fr
      if (gnVo=9.or.gnVo=2)
        if (IIF(prMZenr=0, EMPTY(MZenr), .T.))
          if (Zenr<Optr.and.NoOptr=0)//����� ����稫���
            Zenr:=roun(Optr, rDecPr)
          endif

        else
          if (Zenr<MZenr.and.NoOptr=0)//����� ����稫���
            Zenr:=roun(MZenr, rDecPr)
          endif

        endif

        if (MZenr#0.and.MinZen1r=0.and.nofr=1)
          if (BZenr<MZenr.and.NoOptr=0)
            BZenr=roun(MZenr, rDecBr)
          endif

        endif

        if (MinZen1r=1.and.nofr=1)
          if (BZenr<Optr.and.NoOptr=0)
            BZenr=roun(Optr, rDecBr)
          endif

        endif

      else
        if (Zenr<Optr.and.NoOptr=0)
          Zenr:=roun(Optr, rDecPr)
        endif

        if (BZenr<Optr.and.nofr=1)
          BZenr:=roun(Optr, rDecBr)
        endif

      endif

    endif

  else                      // gnEnt = 21

    if (empty(p1).or.((nKklr#nKkl_fr.or.Kpvr#Kpv_fr)).and.CorSh=1);
      .and.int(ktlr/1000000)>1

      outlog(3,__FILE__, __LINE__,'AktsSWZen p1=',p1)
      cAddNat:=""
      nZenNew:=AktsSWZen(MnTovr,Kpvr,nKklr, rs1->DtRo, cAddNat)
      If !empty(nZenNew)
          outlog(__FILE__,__LINE__,'  MnTovr,Zenr,nZenNew';
          , MnTovr,allt(str(Zenr)) ,nZenNew,cAddNat)
        If Zenr # nZenNew
          outlog(__FILE__,__LINE__,'  Zenr#nZenNew';
          , allt(str(Zenr)),allt(str(nZenNew)) )
        EndIf

        // ���� 173 - ����
        If "-169" $ rs1->npv .or. rs1->kop=173
          Zenr:=nZenNew // ������ ࠡ��
        EndIf

      else
        outlog(3,__FILE__, __LINE__,'  MnTovr',MnTovr,Kpvr,nKklr, rs1->DtRo)
      EndIf

    endif

    outlog(3, __FILE__, __LINE__, 'MinZen 4 21 p1', p1)

    if (empty(p1).or.nKklr#nKkl_fr.and.CorSh=1).and.int(ktlr/1000000)>1;
      .or.prDecr#prDec_fr

      outlog(3, __FILE__, __LINE__, 'prMZenr MZenr', prMZenr, MZenr)
      if (gnVo=9.or.gnVo=2)
        if (IIF(prMZenr=1, EMPTY(MZenr), .T.))
          if (Zenr<Optr.and.NoOptr=0)//����� ����稫���
            Zenr:=roun(Optr, rDecPr)
          endif

        else
          if (Zenr<MZenr.and.NoOptr=0)//����� ����稫���
            Zenr:=roun(MZenr, rDecPr)
          endif

        endif

        if (MZenr#0.and.MinZen1r=0.and.nofr=1)
          if (BZenr<MZenr.and.NoOptr=0)
            BZenr=roun(MZenr, rDecBr)
          endif

        endif

        if (MinZen1r=1.and.nofr=1)
          if (BZenr<Optr)
            BZenr=roun(Optr, rDecBr)
          endif

        endif

      else
        if (Zenr<Optr.and.NoOptr=0)
          Zenr:=roun(Optr, rDecPr)
        endif

        if (BZenr<Optr.and.nofr=1)
          BZenr:=roun(Optr, rDecBr)
        endif

      endif

    endif
    outlog(3, __FILE__, __LINE__, 'End Zenr', Zenr)

  endif

    // �ࠩᮢ� 業�

  outlog(3, __FILE__, __LINE__, '�஢�ઠ �� ������⨢ gnVo', gnVo)
  // �஢�ઠ �� ������⨢
  // ������⨢(��� ���)
  if (gnVo=9.or.gnVo=2)
    IndLOptr=0
    IndLRozr=0
    IndLOpt_Roz(@IndLOptr,@IndLRozr)

    if (kopr=191)         // ������
      if (IndLRozr#0)
        if (Zenr<roun(IndLRozr*(1+gnNds/100), 2))
          Zenr=roun(IndLRozr*(1+gnNds/100), 2)
        endif

        if (nofr=1)
          if (BZenr<roun(IndLRozr*(1+gnNds/100), 2))
            BZenr=roun(IndLRozr*(1+gnNds/100), 2)
          endif

        endif

      endif

    else                    // ���
      outlog(3, __FILE__, __LINE__, 'kopr', kopr)
      If kopr=169
        if (IndLOptr#0)
          if (Zenr<IndLOptr.and.NoOptr=0)
            Zenr=IndLOptr
          endif

          if (nofr=1)
            if (BZenr<IndLOptr.and.NoOptr=0)
              BZenr=IndLOptr
            endif

          endif

        endif

      Else

      EndIf

    endif
    outlog(3, __FILE__, __LINE__, 'End IndL Zenr', Zenr)

    // �஢�ઠ 2-� 業� �� 1-�

#ifndef __CLIP__
#else
      if (BZenr>Zenr.and.nofr=1)
        BZenr=Zenr
        prBZenr=prZenr
      endif

#endif

    // �஢�ઠ 2-� 業� �� 3-�
    if (BZenr<XZenr.and.nofr=1)
      //      BZenr=XZenr
    //      prBZenr=prXZenr
    endif

  endif

  if (int(ktlr/1000000)<2)
    if (Zenr=0)
      BZenr=0
      XZenr=0
    endif

  endif

  sele (al_rs2)
  outlog(3, __FILE__, __LINE__, 'Zenr,Zen', Zenr,Zen)
  RpZen(0)
  outlog(3, __FILE__, __LINE__, 'Zenr,Zen', Zenr,Zen)
  sele (al_rs2)

  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  10-03-18 * 09:13:46pm
 ����������......... ���᫥��� ������⨢� ⮢�� � ��⮬ ���
 ���������.......... MnTovr,sklr,ktlr)
                sgrp - ������ ��㯯� ������
 �����. ��������....
 ����������.........
 */
FUNCTION IndLOpt_Roz(IndLOptr,IndLRozr)
  LOCAL VesPr, KeiPr
  LOCAL nSelect:=SELECT()
  if (gnCtov=1) // c ����� �ࠢ ࠡ����
    // MnTovr - ࠭�� ��।�����
    sele ctov
    netseek('t1', 'MnTovr')
  else
    // sklr,ktlr - ࠭�� ��।�����
    sele tov
    netseek('t1', 'sklr,ktlr')
  endif
  outlog(3, __FILE__, __LINE__, 'alias(),MnTovr,ktl,ktlr', alias(),MnTovr,ktl,ktlr)

  VesPr=VesP
  KeiPr=KeiP
  outlog(3, __FILE__, __LINE__, 'gnCtov, VesPr, KeiPr', gnCtov, VesPr, KeiPr   )

  if (gnCtov=1)
    sele sgrp // ��㯯� ������
    GrKeir=0
    if (netseek('t1', 'int(ktlr/1000000)').and.VesPr#0.and.KeiPr#0)
      GrKeir=GrKei
    endif
    outlog(3, __FILE__, __LINE__, 'GrKeir, KeiPr', GrKeir, KeiPr)

    if (GrKeir=KeiPr.and.GrKeir#0)
      IndLOptr=IndLOpt
      IndLRozr=IndLRoz
      outlog(3, __FILE__, __LINE__, 'IndLOptr,IndLRozr', IndLOptr,IndLRozr)
      IndLOptr=ROUND(IndLOptr*VesPr, 2)
      IndLRozr=ROUND(IndLRozr*VesPr, 2)
    else
      IndLOptr=0
      IndLRozr=0
    endif

  else
    IndLOptr=0
    IndLRozr=0
  endif
  outlog(3, __FILE__, __LINE__, 'IndLOptr,IndLRozr 4 VesPr', IndLOptr,IndLRozr)
  SELECT (nSelect)
  RETURN (NIL)


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  10-21-19 * 09:43:05am
 ����������......... ���� ��樮����  業� �� �६ 䠩���
 ��� �����
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION AktsSWZen(nl_MnTov,nl_Kgp,nl_Kpl, dDate, cAddNat, nMnTovNotActs,cPath_Order)
  LOCAL nZen,cOl_code
  DEFAULT cPath_Order TO gcPath_ew+"obolon\swe2cus",;
  cAddNat TO "", nMnTovNotActs TO 0

  cOl_code:=ltrim(STR(nl_kgp,7)+"-"+STR(nl_kpl,7)) // 㤠���� ���騥 �஡���

  outlog(3,__FILE__,__LINE__,'nl_MnTov,nl_Kgp,nl_Kpl',nl_MnTov,cOl_code)

  if .not. OpenDbSW4Zen(cPath_Order)
    RETURN (nZen)
  endif
  if .not. int(nl_MnTov/1000)>1 // �� ⮢��
    RETURN (nZen)
  endif

  sele a_prod
  ordsetfocus('t1')
  If DBSEEK(str(nl_MnTov,7)) // ⮢�� ���� � ᯨ᪥ ��権
    // ���� �� � ᯨ᪥ ��権
    sele a_tt
    If DBSeek(cOl_code)
      DO WHILE ol_code = cOl_code
        // ���� ��� ��樨
        nA_Id:=a_tt->A_Id

        sele a_idAct // ⠡��� ��権, � ������ ������ ��
        If DBSeek(str(nA_id,5))
          // �஢�ઠ ���
          If dDate >= ABeg .AND. dDate <= AEnd
            sele a_prod
            ordsetfocus('t1')
            If DBSEEK(str(nl_MnTov,7)+str(nA_id,5)) // ⮢�� ���� � ᯨ᪥ ��権
              nZen:=a_prod->Price
              nZen:=round((nZen / (100+20))*100,5)

              // ���� ⮢�� ��� ᫮�� ���
              sele a_prod
              ordsetfocus("t2")
              DBSeek(str(nA_id,5))
              nMnTovNotActs:=MnTov
              //outlog(__FILE__,__LINE__,found(),MnTov,nA_id)
              Locate for !('���' $ UPPER(a_prod->Nat)) while str(nA_id,5) = str(A_id,5)
              If found()
                nMnTovNotActs:=MnTov
              EndIf

              sele a_idAct
              cAddNat:=allt("��� N" + allt(SubStr(AName,AT("�",AName)+1)) + ":")

              exit
            else
              outlog(3,__FILE__,__LINE__,'';
              +' AKC=>TT ��� 4 ��� � �-樨 a_id='+str(nA_Id,5);
            )
            endif
          else
            outlog(3,__FILE__,__LINE__,'';
            +' AKC=>�-�� �� � �ப�� a_id='+str(nA_Id,5);
            +' 4 '+DTOC(dDate);
            +' '+DTOC(ABeg)+'<->'+DTOC(AEnd))

          endif
        else
          //�訡�� � 楫�᭮�� ������
          outlog(3,__FILE__,__LINE__,' !!!�-樨 ��� a_id=',str(nA_Id,5),'nZen', nZen)

        endif

        sele a_tt
        DBSkip()
     EndDo
    Else
      outlog(3,__FILE__,__LINE__,' �-権 ��� ��� ��')

    EndIf
  Else
    outlog(3,__FILE__,__LINE__, '  ��� ⮢ � ᯨ᪥ ��権')
  EndIf
  If !empty(nZen)
    outlog(3,__FILE__,__LINE__, '  ��諨->nZen,nA_id,nMnTovNotActs, cAddNat', nZen, str(nA_id,5), nMnTovNotActs, cAddNat)
  Else
    outlog(3,__FILE__,__LINE__, '  nZen', nZen)
  EndIf
  RETURN (nZen)


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  09-16-19 * 12:38:12pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
Function OpenDbSW4Zen(cPath_Order)
  DEFAULT cPath_Order TO gcPath_ew+"obolon\swe2cus"
  If !file(cPath_Order+'\a_prod'+'.dbf')
    Return (.F.)
  EndIf
  If empty(select('a_prod'))
    use (cPath_Order+'\a_prod') alias a_prod new ReadOnly Shared
    //index on str(mntov,7)+str(a_id,5) to a_prod
    ordsetfocus('t1')
  EndIf
  If empty(select('a_idAct'))
    use (cPath_Order+'\a_idAct') alias a_idAct new ReadOnly Shared
    //index on str(a_id,5) to a_idAct
    ordsetfocus('t1')
  EndIf
  If empty(select('a_tt'))
    use (cPath_Order+'\a_tt') alias a_tt new ReadOnly Shared
    //index on ol_code+str(a_id,5) to a_tt
    ordsetfocus('t1')
  EndIf
  Return (.t.)

/*
    nZenNew := NIL
    if gnEnt=211 .and. kgr_r > 1 // ����� � ⮢��
      // ���� �� ������
      nZenNew := AktsSWZen(MnTovr,kpvr,nkklr, dvpr)

      If !empty(nZenNew)
          outlog(__FILE__,__LINE__,'Akts Zenr,nZenNew,kpvr,nkklr,Kgpr,Kplr', Zenr,nZenNew,,kpvr,nkklr,Kgpr,Kplr)
        If Zenr # nZenNew
          outlog(__FILE__,__LINE__,'  Zenr#nZenNew', Zenr,nZenNew)
        EndIf
        //Zenr:=nZenNew
      EndIf

      // ���� ��樮���� 業�
      // AktsSWZen(MnTovr, Kpvr, nKklr, dvpr)
      if (empty(p1).or.((nKklr#nKkl_fr.or.Kpvr#Kpv_fr)).and.CorSh=1);
        .and.int(ktlr/1000000)>1

        nZenNew:=AktsSWZen(MnTovr,Kgpr,Kplr, Date())
        If !empty(nZenNew)
            outlog(__FILE__,__LINE__,'Zenr,nZenNew', Zenr,nZenNew)
          If Zenr # nZenNew
            outlog(__FILE__,__LINE__,'  Zenr#nZenNew', Zenr,nZenNew)
          EndIf
          //Zenr:=nZenNew
        EndIf

      endif

    endif
*/
