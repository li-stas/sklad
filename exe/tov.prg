/***********************************************************
 * �����    : tov.prg
 * �����    : 0.0
 * ����     :
 * ���      : 04/15/19
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

#include "common.ch"
#include "inkey.ch"
//��ࠢ�筨� TOV
save scre to sccskl
netuse('tov')
if (gnCtov=1)
  netuse('tovm')
  netuse('ctov')
  netuse('cgrp')
endif

netuse('sgrp')
netuse('cskle')
netuse('cskl')
netuse('kln')
netuse('soper')
netuse('lic')
netuse('klnlic')
oclr=setcolor('w+/b')
cntr=0
clea
if (gnMskl=0)
//  tovizg()
else
  tovtar()
  skl_rr=0
endif

iz_rr=0
skl_rr=0
sele tov
if (gnMskl=0)
  set orde to tag t2
else
  sklr=0
  set orde to tag t1
endif

go top
rcn_rr=recn()
prf7r=0
while (.t.)
  if (gnMskl=0)
    if (prf7r=0)
      foot('F4,F5,F7,F8,ESC', '��ᬮ�� ����窨,�⤥�,� ��.,��㯯�,�⬥��')
    else
      foot('F4,F5,F7,F8,ESC', '��ᬮ�� ����窨,�⤥�,� ��.��.,��㯯�,�⬥��')
    endif

  else
    foot('F3,F4,F5,ESC', '������,��ᬮ�� ����窨,������⭨�,�⬥��')
  endif

  sele tov
  if (gnMskl=0)
    set orde to tag t2
  else
    set orde to tag t1
  endif

  rcn_rr=recn()
  forr='.t.'
  whilr='.t.'
  if (gnMskl=0)
  else
    if (sklr=0)
      whilr='.t.'
    else
      whilr='skl=sklr'
    endif

  endif

  if (gnCtov=1)
    forr='.t.'
  endif

  if (iz_rr#0)
    forr=forr+'.and.izg=iz_rr'
    go rcn_rr
  endif

  if (gnMskl=0)
    if (prf7r=0)
      if (gnOtv=1)
        ktlr=slcf('tov', 1, 0, 18,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(23) e:nei h:'���' c:c(3) e:osn h:'���.���.' c:n(9,2) e:osf h:'���.䠪�' c:n(9,2) e:osv h:'���.��.' c:n(9,2) e:osvo h:'���.���.' c:n(9,2)", ;
                   'ktl',, 1,, forr,, '��ࠢ�筨� ᪫��� '+alltrim(gcNskl)+' �� �����'                                                                                                                                        ;
                )
      else
        ktlr=slcf('tov', 1, 0, 18,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(33) e:nei h:'���' c:c(3) e:osn h:'���.���.' c:n(9,2) e:osf h:'���.䠪�' c:n(9,2) e:osv h:'���.��.' c:n(9,2)", ;
                   'ktl',, 1,, forr,, '��ࠢ�筨� ᪫��� '+alltrim(gcNskl)+' �� �����'                                                                                                           ;
                )
      endif

    else
      if (gnOtv=1)
        ktlr=slcf('tov', 1, 0, 18,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(23) e:'��.' h:'���' c:c(3) e:osn/upakp h:'���.���.' c:n(9,2) e:osf/upakp h:'���.䠪�' c:n(9,2) e:osv/upakp h:'���.��.' c:n(9,2) e:osvo/upakp h:'���.���.' c:n(9,2)", ;
                   'ktl',, 1,, forr,, 'C�ࠢ�筨� ᪫��� '+alltrim(gcNskl)+' �� �����'                                                                                                                                                                  ;
                )
      else
        ktlr=slcf('tov', 1, 0, 18,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(33) e:'��.' h:'���' c:c(3) e:osn/upakp h:'���.���.' c:n(9,2) e:osf/upakp h:'���.䠪�' c:n(9,2) e:osv/upakp h:'���.��.' c:n(9,2)", ;
                   'ktl',, 1,, forr,, '��ࠢ�筨� ᪫��� '+alltrim(gcNskl)+' �� �����'                                                                                                                               ;
                )
      endif

    endif

  else
    if (!netseek('t1', 'sklr'))
      sklr=0
      whilr=nil
      go top
    endif

    rcktlr=slcf('tov', 1, 0, 18,, "e:skl h:'���.' c:n(7) e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(25) e:nei h:'���' c:c(3) e:osn h:'���.���.' c:n(9,2) e:osf h:'���.䠪�' c:n(9,2) e:osv h:'���.��.' c:n(9,2)",,, 1, whilr, forr,, '��ࠢ�筨� ᪫��� '+alltrim(gcNskl)+' �� �����')
  endif

  exxr=0
  sele tov
  if (gnMskl=0)
    netseek('t1', 'gnSkl,ktlr')
    rcktlr=recn()
  else
    go rcktlr
  endif

  ktlr=ktl
  sklr=skl
  mntovr=mntov
  rcn_rr=recn()
  kg_r=int(ktlr/1000000)
  sele sgrp
  do case
  case (lastkey()=K_ESC)
    exit
  case (lastkey()=K_F4)
    if (gnAdm=0.and.gnArnd=0)
      if (gnCtov=1)
        tovins(2, 'tov')
      else
        tovins(1, 'tov')
      endif

    else
      tovins(1, 'tov')
    endif

    sele tov
    go rcn_rr
  case (lastkey()=K_F5)
    if (gnMskl=0)
      sele cskle
      if (netseek('t1', 'gnSk'))
        gnOt=slcf('cskle',,,,, "e:ot h:'��' c:n(2) e:nai h:'������������' c:c(20)", 'ot', 0,, 'sk=gnSk')
      endif

      sele tov
      go top
      loop
    else
      sele kln
      //             if netseek('t1','sklr')
      set orde to tag t2
      go top
      while (.t.)
        rc_kln=recn()
        sklr=slcf('kln',,,,, "e:kkl h:'������⭨�' c:n(11) e:nkl h:'������������' c:c(30)", 'kkl',,,, 'kkl>8000.and.kkl<10000')
        if (lastkey()=K_ENTER)
          exit
        endif

        //if lastkey() >=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
        if (lastkey()>32.and.lastkey()<255)
          lstkr=upper(chr(lastkey()))
          if (!netseek('t2', 'lstkr'))
            go rc_kln
          endif

        endif

      enddo

      //             endif
      sele tov
      if (gnMskl=0)
        set orde to tag t2
      else
        set orde to tag t1
      endif

      go top
      loop
    endif

  case (lastkey()=K_F6.and.gnMskl=0)// ����⮢�⥫�
    loop
    sele lizg
    go top
    while (.t.)
      rc_izg=recn()
      iz_rr=slcf('lizg',,,,, "e:nizg h:'����⮢�⥫�' c:c(40) e:izg h:'���' c:n(8)", 'izg')
      if (lastkey()=K_ESC.or.lastkey()=K_ENTER)
        exit
      endif

      if (lastkey()>32.and.lastkey()<255)
        //if lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
        lstkr=upper(chr(lastkey()))
        seek lstkr
        if (!FOUND())
          go rc_izg
        endif

      endif

    enddo

  case (lastkey()=K_F7)
    if (prf7r=0)
      prf7r=1
    else
      prf7r=0
    endif

  //          tovpsk()
  case (lastkey()=K_F3.and.gnMskl#0)
    cltt=setcolor('gr+/b,n/bg')
    wtt=wopen(10, 20, 14, 40)
    wbox(1)
    @ 0, 1 say '��� ᪫.' get sklr pict '9999999'
    read
    wclose(wtt)
    setcolor(cltt)
    if (lastkey()=K_ESC)
      loop
    endif

    if (sklr=0)
      sele ltar
      go top
      while (.t.)
        rc_tar=recn()
        sklr=slcf('ltar',,,,, "e:nskl h:'������������' c:c(40) e:skl h:'���' c:n(7)", 'skl')
        if (lastkey()=K_ESC.or.lastkey()=K_ENTER)
          exit
        endif

        if (lastkey()>32.and.lastkey()<255)
          //if lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
          lstkr=upper(chr(lastkey()))
          seek lstkr
          if (!FOUND())
            go rc_tar
          endif

        endif

      enddo

    endif

    if (!empty(sklr))
      forr=forr+'.and.skl=sklr'
    endif

    wclose(wtt)
    setcolor(cltt)
    loop
  case (lastkey()=K_F8.and.gnMskl=0)
    sele sgrp
    set order to tag t2
    go top
    if (gnOt=0)
      forgr=nil
    else
      forgr='ot=gnOt'
    endif

    rcn_gr=recn()
    while (.t.)
      sele sgrp
      set order to tag t2
      rcn_gr=recno()
      kg_r=slcf('sgrp',,,,, "e:kgr h:'���' c:n(3) e:ot h:'��' c:n(2) e:ngr h:'������������' c:c(20)", 'kgr',,,, forgr)
      do case
      case (lastkey()=K_ENTER)
        sele tov
        if (!netseek('t2', 'gnSkl,kg_r'))
          go rcn_rr
        endif

        exit
      case (lastkey()=K_ESC)
        exit
      case (lastkey()>32.and.lastkey()<255)
        //case lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
        sele sgrp
        lstkr=upper(chr(lastkey()))
        if (!netseek('t2', 'lstkr'))
          go rcn_gr
        endif

        loop
      otherwise
        loop
      endcase

    enddo

  case (lastkey()>32.and.lastkey()<255)
    //case lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
    sele tov
    lstkr=upper(chr(lastkey()))
    if (!netseek('t2', 'sklr,int(ktlr/1000000),lstkr'))
      go rcn_rr
    endif

  case (lastkey()=K_INS)  // ins
                            //          rsins(0)

  case (lastkey()=K_DEL)  // del
                            //         rsdel()
                            //  othe
                            //     return
  endcase

enddo

setcolor(oclr)
nuse()
nuse('lizg')
nuse('ltar')
nuse('totv')
erase lizg.dbf
erase lizg.cdx
erase ltar.dbf
erase ltar.cdx
erase totv.dbf
erase totv.cdx
rest scre from sccskl

/***********************************************************
 * tovizg
 *   ��ࠬ����:
 */
procedure tovizg
  if (gnMskl=0)
    if (select('lizg')#0)
      sele lizg
      CLOSE
    endif

    crtt('lizg', "f:izg c:n(8) f:nizg c:c(40)")
    sele 0
    use lizg
    index on str(izg, 8) tag t1
    sele tov
    while (!eof())
      iz_rr=izg
      nizgr=''
      if (iz_rr=0)
        skip
        loop
      endif

      sele lizg
      seek str(iz_rr, 8)
      if (!FOUND())
        nizgr=getfield('t1', 'iz_rr', 'kln', 'nkl')
        appe blank
        repl izg with iz_rr, nizg with nizgr
      endif

      sele tov
      skip
    enddo

    sele lizg
    inde on nizg tag t2
  endif

  return

/***********************************************************
 * tovtar
 *   ��ࠬ����:
 */
procedure tovtar
  if (gnMskl#0)
    crtt('ltar', "f:skl c:n(7) f:nskl c:c(40)")
    sele 0
    use ltar
    index on str(skl, 7) tag ltar1
    sele tov
    while (!eof())
      skl_rr=skl
      nsklrr=''
      if (skl_rr=0)
        skip
        loop
      endif

      sele ltar
      seek str(skl_rr, 7)
      if (!FOUND())
        nsklrr=getfield('t1', 'skl_rr', 'kln', 'nkl')
        appe blank
        repl skl with skl_rr, nskl with nsklrr
      endif

      sele tov
      skip
    enddo

    sele ltar
    inde on nskl tag ltar2
  endif

  return

/************* */
function ostkt()
  /************* */
  if (gnKt#1)
    return (.t.)
  endif

  netuse('tov')
  set orde to tag t2
  netuse('kln')
  sele tov
  go top
  rctovr=recn()
  for_r='.t.'
  forr=for_r
  while (.t.)
    sele tov
    go rctovr
    foot('', '')
    rctovr=slcf('tov', 1, 0, 18,, "e:skl h:'���' c:n(7) e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(23) e:osn h:'���.���.' c:n(9,2) e:osf h:'���.䠪�' c:n(9,2) e:osv h:'���.��.' c:n(9,2) e:ttnkt h:'���' c:n(6)",,,,, forr,, '��ࠢ�筨� ᪫��� '+alltrim(gcNskl)+' �� �����')
    if (lastkey()=K_ESC)
      exit
    endif

    sele tov
    go rctovr
  enddo

  nuse()
  clea
  return (.t.)

/***********************************************************
 * mntovt() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function mntovt()
  sele (tov_r)
  rctov_r=recn()
  if (mntovtr=0)
    sele ctov
    iordr=indexord()
    set orde to tag t2
    if (netseek('t2', 'kgr'))
      mntovtr=slcf('ctov',,,,, "e:mntov h:'���' c:n(7) e:nat h:'������������' c:c(40) ", 'mntov',,, 'kg=kgr', 'mntov=mntovt')
      if (lastkey()=K_ESC)
        setlastkey(24)
        mntovtr=0
      endif

    endif

    set orde to iordr
  endif

  sele (tov_r)
  go rctov_r
  if (mntovtr#0.and.mntovr#0.and.mntovtr#mntovr)
    if (tov_r=='tovm')
      sele ctov
    endif

    if (!netseek('t1', 'mntovtr'))
      wmess('��� ⠪��� ���� � CTOV', 1)
      sele (tov_r)
      go rctov_r
      return (.f.)
    else
      if (mntov#mntovt)
        wmess('�� �� த�⥫�', 1)
        sele (tov_r)
        go rctov_r
        return (.f.)
      else
        if (int(mntov/10000)#kg_r)
          wmess('��� ��� �� ⮩ ��㯯�', 1)
          sele (tov_r)
          go rctov_r
          return (.f.)
        endif

      endif

    endif

  endif

  return (.t.)

/***********************************************************
 * tm() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function tm()
  if (tov_r=='tov')
    if (postr#0)
      if (netseek('t1', 'postr', 'kps'))
        if (mkeepr#0)
          sele kpsmk
          if (!netseek('t1', 'postr,mkeepr'))
            mkeepr=0
          endif

        endif

        if (mkeepr=0)
          sele kpsmk
          go top
          rckpsmkr=recn()
          while (.t.)
            go rckpsmkr
            rckpsmkr=slcf('kpsmk',,,,, "e:mkeep h:'���' c:n(3) e:getfield('t1','kpsmk->mkeep','mkeep','nmkeep') h:'������������' c:c(40) ",,,,, 'kps=postr',, '��� ��ન')
            if (lastkey()=K_ESC)
              mkeepr=0
              exit
            endif

            go rckpsmkr
            if (lastkey()=K_ENTER)
              mkeepr=mkeep
              exit
            endif

          enddo

        endif

      endif

      @ 14, 20 say getfield('t1', 'mkeepr', 'mkeep', 'nmkeep')
    endif

  else                      // tov_r#'tov'
    if (mkeepr#0)
      sele mkeep
      if (!netseek('t1', 'mkeepr'))
        mkeepr=0
      endif

    endif

    if (mkeepr=0)
      sele mkeep
      go top
      rcmkr=recn()
      while (.t.)
        go rcmkr
        rcmkr=slcf('mkeep',,,,, "e:mkeep h:'���' c:n(3) e:nmkeep h:'������������' c:c(40) ",,,,,,, '��� ��ન')
        if (lastkey()=K_ESC)
          mkeepr=0
          exit
        endif

        go rcmkr
        if (lastkey()=K_ENTER)
          mkeepr=mkeep
          exit
        endif

      enddo

    endif

    @ 14, 20 say getfield('t1', 'mkeepr', 'mkeep', 'nmkeep')
  endif

  return (.t.)

/***********************************************************
 * keiins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function keiins(p1)
  local getlist:={}
  if (p1=nil)
    keir=1
    neir=space(5)
  endif

  oclkeir=setcolor('gr+/b,n/w')
  wkeir=wopen(10, 20, 14, 60)
  wbox(1)
  while (.t.)
    @ 0, 1 say '���          '+str(keir, 3)
    @ 1, 1 say '������������' get neir
    read
    if (lastkey()=K_ESC)
      exit
    endif

    @ 2, 20 prom '��୮'
    @ 2, col()+1 prom '�� ��୮'
    menu to vn
    if (lastkey()=K_ESC)
      exit
    endif

    if (vn=1)
      neir=uppe(neir)
      if (p1=nil)
        set orde to tag t1
        go top
        while (!eof())
          if (kei#keir)
            exit
          endif

          keir++
          skip
        enddo

        netadd()
        netrepl('kei,nei', 'keir,neir')
      else
        netseek('t1', 'keir')
        if (FOUND())
          netrepl('nei', 'neir')
        endif

      endif

      exit
    endif

  enddo

  wclose(wkeir)
  setcolor(oclkeir)
  wselect(0)
  return (.t.)

/************* */
function pbrn()
  /************* */
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  sele posbrn
  if (!netseek('t1', 'posbrnr').or.posbrnr=0)
    go top
    rcposbrnr=recn()
    while (.t.)
      sele posbrn
      go rcposbrnr
      foot('', '')
      rcposbrnr=slcf('posbrn',,,,, "e:posbrn h:'���' c:n(10) e:nposbrn h:'������������' c:c(40)")
      if (lastkey()=K_ESC)// �⬥��
        exit
      endif

      sele posbrn
      go rcposbrnr
      posbrnr=posbrn
      if (lastkey()=K_ENTER)// �����
        exit
      endif

    enddo

  endif

  restsetkey(asvkr)
  return (.t.)

/************* */
function pid()
  /************* */
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  sele posid
  if (!netseek('t1', 'posidr').or.posidr=0)
    go top
    rcposidr=recn()
    while (.t.)
      sele posid
      go rcposidr
      foot('', '')
      rcposidr=slcf('posid',,,,, "e:posid h:'���' c:n(10) e:nposid h:'������������' c:c(40)")
      if (lastkey()=K_ESC)// �⬥��
        exit
      endif

      sele posid
      go rcposidr
      posidr=posid
      if (lastkey()=K_ENTER)// �����
        exit
      endif

    enddo

  endif

  restsetkey(asvkr)
  return (.t.)

/************* */
function arvid()
  /************* */
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  arvid_r=arvidr
  sele arvid
  if (!netseek('t1', 'arvidr').or.arvidr=0)
    go top
    rcarvidr=recn()
    while (.t.)
      sele arvid
      go rcarvidr
      foot('INS,DEL,F4', '��������,�������,���४��')
      rcarvidr=slcf('arvid',,,,, "e:arvid h:'���' c:n(3) e:narvid h:'������������' c:c(20)")
      if (lastkey()=K_ESC)// �⬥��
        arvidr=arvid_r
        exit
      endif

      sele arvid
      go rcarvidr
      arvidr=arvid
      narvidr=narvid
      do case
      case (lastkey()=K_ENTER)// �����
        exit
      case (lastkey()=K_INS)  // ��������
        arvidins()
      case (lastkey()=K_F4)   // ���४��
        arvidins(1)
      case (lastkey()=K_DEL)  // �������
        netdel()
        skip -1
        if (bof())
          go top
        endif

        rcarvidr=recn()
      endcase

    enddo

  endif

  @ 19, 17 say narvidr
  restsetkey(asvkr)
  return (.t.)

/****************** */
function arvidins(p1)
  /****************** */
  local getlist:={}
  if (p1=nil)
    narvidr=space(20)
    arvid_r=0
  endif

  clgrpins=setcolor('gr+/b,n/w')
  wgrpins=wopen(10, 20, 15, 60)
  wbox(1)
  while (.t.)
    if (p1=nil)
      @ 0, 1 say '��� ����  ' get arvidr pict '999'
    else
      @ 0, 1 say '��� ����  '+str(arvidr, 3)
    endif

    @ 1, 1 say '������������' get narvidr
    read
    if (lastkey()=K_ESC)
      exit
    endif

    @ 3, 20 prom '��୮'
    @ 3, col()+1 prom '�� ��୮'
    menu to vn
    if (vn=1)
      if (p1=nil)
        sele arvid
        if (netseek('t1', 'arvidr'))
          wmess('��� �������', 1)
          loop
        endif

        netadd()
        netrepl('arvid,narvid', 'arvidr,narvidr')
      else
        netrepl('narvid', 'narvidr')
      endif

      exit
    endif

  enddo

  wclose(wgrpins)
  setcolor(clgrpins)
  return (.t.)

/************** */
function mntovc()
  /************** */
  if (mntovcr=0)
    return (.t.)
  endif

  rctov_r=recn()
  if (tov_r=='tovm')
    sele ctov
  endif

  if (!netseek('t1', 'mntovcr'))
    wmess('��� ⠪��� ���� � CTOV', 1)
    sele (tov_r)
    go rctov_r
    return (.f.)
  else
    if (mntov#mntovc)
      wmess('�� �� த�⥫�', 1)
      sele (tov_r)
      go rctov_r
      return (.f.)
    else
      if (int(mntov/10000)#kg_r)
        wmess('��� ��� �� ⮩ ��㯯�', 1)
        sele (tov_r)
        go rctov_r
        return (.f.)
      endif

      if (gnEnt=20)
        if (empty(bar))
          wmess('��� ��� �� த�⥫�(�=0)', 1)
          sele (tov_r)
          go rctov_r
          return (.f.)
        endif

      endif

    endif

  endif

  return (.t.)

/***********************************************************
 * ntovigins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function ntovigins(p1)
  local getlist:={}
  forr=nil
  while (.t.)
    foot('F3', '������')
    kklr=slcf('kln',,,,, "e:kkl h:'���' c:n(7) e:nkl h:'������������' c:c(30) ", 'kkl',,,, forr)
    sele kln
    netseek('t1', 'kklr')
    do case
    case (lastkey()=K_F3) // F3
      clkln=setcolor('gr+/b,n/w')
      wkln=wopen(10, 20, 15, 60)
      wbox(1)
      store 0 to kklr
      store space(20) to ktxr
      store space(15) to rschr
      @ 0, 1 say '��� 7��  ' get kklr pict '9999999'
      @ 1, 1 say '���⥪�� ' get ktxr
      @ 2, 1 say '����.���' get rschr
      read
      do case
      case (kklr#0)
        forr=nil
        if (!netseek('t1', 'kklr'))
          go top
        endif

      case (!empty(ktxr))
        ktxr=alltrim(upper(ktxr))
        sele kln
        go top
        forr='at(ktxr,kln->nkl)#0'
      case (!empty(rschr))
        rschr=alltrim(rschr)
        sele kln
        go top
        forr='at(rschr,kln->kb1)#0'
      case (kklr=0.and.empty(ktxr))
        forr=nil
        go top
      endcase

      wclose(wkln)
    case (lastkey()=K_ESC)// ESC
      exit
    case (lastkey()=K_ENTER)// ENTER
      exit
    endcase

  enddo

  izgr=kklr
  sele ntovig
  if (izgr#0)
    if (netseek('t1', 'MnNTovr,izgr'))
      wmess('����� ����⮢�⥫� 㦥 ����', 3)
    else
      netadd()
      netrepl('MnNTov,izg', 'MnNTovr,izgr')
    endif

  endif

  return (.t.)

/****************** */
function grpti()
  /****************** */
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  grp_r=grpr
  sele grp
  if (!netseek('t1', 'grpr').or.grpr=0)
    go top
    while (.t.)
      foot('ENTER,INS,F4', '�����,��������,���४��')
      grpr=slcf('grp',,,,, "e:kg h:'���' c:n(3) e:ng h:'������������' c:c(20)", 'kg')
      do case
      case (lastkey()=K_ENTER)// �����
        exit
      case (lastkey()=K_INS)  // ��������
        grptiins1()
      case (lastkey()=K_F4)   // ���४��
        grptiins1(1)
      case (lastkey()=K_ESC)  // �⬥��
        grpr=grp_r
        exit
      endcase

    enddo

  endif

  restsetkey(asvkr)
  ngrpr=getfield('t1', 'grpr', 'grp', 'ng')
  @ 3, 18 say ' '+ngrpr
  return (.t.)

/***********************************************************
 * grptiins1() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function grptiins1(p1)
  local getlist:={}
  ot_r=otr
  if (p1=nil)
    ngrpr=space(20)
    ot_r=0
    grpr=0
  endif

  clgrpins=setcolor('gr+/b,n/w')
  wgrpins=wopen(10, 20, 15, 60)
  wbox(1)
  while (.t.)
    if (p1=nil)
      @ 0, 1 say '��� ��㯯�  ' get grpr pict '999'
    else
      @ 0, 1 say '��� ��㯯�   '+str(grpr, 3)
    endif

    @ 1, 1 say '������������' get ngrpr
    @ 2, 1 say '�⤥�       ' get ot_r pict '99'
    read
    if (lastkey()=K_ESC)
      exit
    endif

    @ 3, 20 prom '��୮'
    @ 3, col()+1 prom '�� ��୮'
    menu to vn
    if (vn=1)
      if (p1=nil)
        sele grp
        if (netseek('t1', 'grpr'))
          wselect(0)
          save scre to scmess
          mess('����� ��㯯� 㦥 �������', 1)
          rest scre from scmess
          wselect(wgrpins)
          loop
        endif

        ngrpr=upper(ngrpr)
        netadd()
        netrepl('kg,ng,ot', 'grpr,ngrpr,ot_r')
      else
        netseek('t1', 'grpr')
        netrepl('ng,ot', 'ngrpr,ot_r')
      endif

      exit
    endif

  enddo

  wclose(wgrpins)
  setcolor(clgrpins)
  return (.t.)

/***********************************************************
 * KgEti() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function kgeti()
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  kge_r=kger
  sele GrpE
  if (!netseek('t1', 'kger').or.kger=0)
    netseek('t2', 'grpr')
    while (.t.)
      foot('ENTER,INS,F4', '�����,��������,���४��')
      set orde to tag t2
      kger=slcf('GrpE',,,,, "e:kge h:'���' c:n(6) e:nge h:'������������' c:c(20)", 'kge',,, 'kg=grpr')
      do case
      case (lastkey()=K_ENTER)// �����
        exit
      case (lastkey()=K_INS)  // ��������
        GrpEtiIns()
      case (lastkey()=K_F4)   // ���४��
        GrpEtiIns(1)
      case (lastkey()=K_ESC)  // �⬥��
        kger=kge_r
        exit
      endcase

    enddo

  endif

  restsetkey(asvkr)
  nger=getfield('t1', 'kger', 'GrpE', 'nge')
  @ 4, 21 say ' '+nger
  return (.t.)

/***********************************************************
 * GrpEtiins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function GrpEtiins(p1)
  local getlist:={}
  if (p1=nil)
    nger=space(15)
    kger=0
  else
    nger=subs(nger, 1, 15)
  endif

  clgrpins=setcolor('gr+/b,n/w')
  wgrpins=wopen(10, 20, 15, 60)
  wbox(1)
  while (.t.)
    @ 0, 1 say '��� �����㯯� '+str(kger, 6)
    @ 1, 1 say '������������' get nger
    read
    //  nger=upper(nger)
    if (lastkey()=K_ESC)
      exit
    endif

    @ 3, 20 prom '��୮'
    @ 3, col()+1 prom '�� ��୮'
    menu to vn
    if (vn=1)
      if (p1=nil)
        sele GrpE
        set orde to tag t1
        go top
        while (!eof())
          if (kge#kger)
            exit
          endif

          kger++
          skip
        enddo

        netadd()
        netrepl('kge,nge,kg', {kger, nger, grpr})
      else
        netseek('t1', 'kger')
        netrepl('nge', 'nger')
      endif

      exit
    endif

  enddo

  wclose(wgrpins)
  setcolor(clgrpins)
  return

/***********************************************************
 * MnNTov() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function MnNTov()
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  MnNTov_r=MnNTovr
  sele ntov
  if (!netseek('t1', 'MnNTovr').or.MnNTovr=0)
    set orde to tag t2
    netseek('t2', 'kger')
    rcntovr=recn()
    while (.t.)
      sele ntov
      go rcntovr
      foot('ENTER,INS,F4', '�����,��������,���४��')
      rcntovr=slcf('ntov',,,,, "e:MnNTov h:'���' c:n(6) e:ntov h:'������������' c:c(30)",,,, 'kge=kger')
      if (lastkey()=K_ESC)// �⬥��
        MnNTovr=MnNTov_r
        exit
      endif

      go rcntovr
      MnNTovr=MnNTov
      do case
      case (lastkey()=K_ENTER)// �����
        exit
      case (lastkey()>32.and.lastkey()<255)
        sele ntov
        lstkr=upper(chr(lastkey()))
        if (!netseek('t2', 'kger,lstkr'))
          go rcntovr
        endif

      case (lastkey()=K_INS)// ��������
        ntovins()
      case (lastkey()=K_F4) // ���४��
        ntovins(1)
      endcase

    enddo

  endif

  restsetkey(asvkr)
  ntovr=getfield('t1', 'MnNTovr', 'ntov', 'ntov')
  ntovr=subs(ntovr, 1, 23)
  @ 5, 21 say ' '+ntovr
  return (.t.)

/***********************************************************
 * ntovins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function ntovins(p1)
  local getlist:={}
  if (p1=nil)
    ntovr=space(30)
    MnNTovr=0
  endif

  clgrpins=setcolor('gr+/b,n/w')
  wgrpins=wopen(10, 20, 15, 60)
  wbox(1)
  while (.t.)
    @ 0, 1 say '��� ������������ '+str(MnNTovr, 6)
    @ 1, 1 say '������������     ' get ntovr
    read
    ntovr=upper(ntovr)
    if (lastkey()=K_ESC)
      exit
    endif

    @ 3, 20 prom '��୮'
    @ 3, col()+1 prom '�� ��୮'
    menu to vn
    if (vn=1)
      if (p1=nil)
        sele ntov
        set orde to tag t1
        go bott
        MnNTovr=MnNTov+1
        sele ntov
        netadd()
        netrepl('MnNTov,ntov,kge', 'MnNTovr,ntovr,kger')
        set orde to tag t2
      else
        sele ntov
        netseek('t1', 'MnNTovr')
        netrepl('ntov,kge', 'ntovr,kger')
        set orde to tag t2
      endif

      exit
    endif

  enddo

  wclose(wgrpins)
  setcolor(clgrpins)
  return (.t.)

/***********************************************************
 * keiti() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function keiti()
  ocleir=setcolor()
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  sele ntovim
  kei_r=keir
  keip_r=keipr
  if (!netseek('t1', 'MnNTovr,keir,keipr').or.keir=0.or.keipr=0)
    if (!netseek('t1', 'MnNTovr,0,0'))
      netadd()
    endif

    netseek('t1', 'MnNTovr')
    rcntovimr=recn()
    while (.t.)
      sele ntovim
      go rcntovimr
      foot('ENTER,INS,F4', '�����,��������,���४��')
      rcntovimr=slcf('ntovim',,,,, "e:getfield('t1','ntovim->izm','nei','nei') h:'���' c:c(5) e:getfield('t1','ntovim->fas','nei','nei') h:'���' c:c(5)",,,, 'MnNTov=MnNTovr')
      go rcntovimr
      if (lastkey()=K_ESC)// �⬥��
        keir=kei_r
        keipr=keip_r
        exit
      endif

      go rcntovimr
      keir=izm
      keipr=fas
      do case
      case (lastkey()=K_ENTER)// �����
        exit
      case (lastkey()=K_INS)  // ��������
        ntovimins()
      case (lastkey()=K_F4)   // ���४��
        ntovimins(1)
      endcase

    enddo

  endif

  restsetkey(asvkr)
  setcolor(ocleir)
  neir=getfield('t1', 'keir', 'nei', 'nei')
  neipr=getfield('t1', 'keipr', 'nei', 'nei')
  @ 8, 20 say neir
  @ 9, 16 say str(keipr, 3)+' '+neipr
  return (.t.)

/***********************************************************
 * ntovimins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function ntovimins(p1)
  local getlist:={}
  oclr=setcolor('gr+/b,n/w')
  wei=wopen(10, 20, 14, 60)
  wbox(1)
  if (p1=nil)
    izmr=0
    fasr=0
  endif

  while (.t.)
    @ 0, 1 say '��.���.' get izmr pict '999' valid ntovkei(1)
    @ 1, 1 say '��ᮢ��' get fasr pict '999' valid ntovkei(2)
    read
    if (lastkey()=K_ESC)
      exit
    endif

    @ 2, 20 prom '��୮'
    @ 2, col()+1 prom '�� ��୮'
    menu to vn
    if (vn=1)
      sele ntovim
      if (netseek('t1', 'MnNTovr,izmr,fasr'))
        wmess('����� ������� 㦥 ����', 3)
        loop
      endif

      netadd()
      netrepl('MnNTov,izm,fas', 'MnNTovr,izmr,fasr')
      rcntovimr=recn()
      exit
    endif

  enddo

  wclose(wei)
  setcolor(oclr)
  return (.t.)

/***********************************************************
 * ntovkei() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function ntovkei(p1)
  wselect(0)
  do case
  case (p1=1)
    if (izmr#0)
      sele nei
      if (!netseek('t1', 'izmr'))
        go top
      endif

    else
      go top
    endif

  case (p1=2)
    if (fasr#0)
      sele nei
      if (!netseek('t1', 'fasr'))
        go top
      endif

    else
      go top
    endif

  endcase

  asvk1r=savesetkey()
  set key 22 to
  set key -3 to
  sele nei
  rcneir=recn()
  while (.t.)
    sele nei
    go rcneir
    foot('INS', '��������')
    rcneir=slcf('nei',,,,, "e:kei h:'���' c:n(3) e:nei h:'���' c:c(5)")
    go rcneir
    keir=kei
    do case
    case (lastkey()=K_ESC.or.lastkey()=K_ENTER)
      exit
    case (lastkey()=K_INS)
      keiins()
    endcase

  enddo

  restsetkey(asvk1r)
  wselect(wei)
  if (p1=1)
    izmr=keir
    nizmr=getfield('t1', 'keir', 'nei', 'nei')
    @ 0, 13 say nizmr
  else
    fasr=keir
    nfasr=getfield('t1', 'keir', 'nei', 'nei')
    @ 1, 13 say nfasr
  endif

  return (.t.)

/***********************************************************
 * mntvti() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function mntvti()
  sele (tov_r)
  if (tov_r=='tov')
    if (k1tr#0)
      if (!netseek('t1', 'sklr,k1tr'))
        k1tr=0
        m1tr=0
      endif

    endif

    if (gnCtov=1)
      if (m1tr#0)
        sele tovm
        if (!netseek('t1', 'sklr,m1tr'))
          m1tr=0
        endif

      endif

    endif

    if (k1tr=0)
      if (gnCtov=1)
        if (m1tr#0)
          sele tov
          if (netseek('t5', 'sklr,m1tr'))
            k1tr=slcf('tov',,,,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(30) e:opt h:'���� ��.' c:n(10,3) e:getfield('t1','sklr,tov->k1t','tov','ktl') h:'�.��' c:n(9) e:getfield('t1','sklr,tov->k1t','tov','opt') h:'�.����' c:n(9,3)", 'ktl',,, 'mntov=m1tr')
            if (lastkey()=K_ESC)
              k1tr=0
              m1tr=0
            endif

          else
            k1tr=0
            m1tr=0
          endif

        endif

        if (k1tr=0)
          sele tovm
          go top
          m1tr=slcf('tovm',,,,, "e:mntov h:'���' c:n(7) e:nat h:'������������' c:c(40)", 'mntov',,, 'int(mntov/10000)<2')
          if (lastkey()=K_ENTER)
            sele tov
            if (netseek('t5', 'sklr,m1tr'))
              k1tr=slcf('tov',,,,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(30) e:opt h:'���� ��.' c:n(10,3) e:getfield('t1','sklr,tov->k1t','tov','ktl') h:'�.��' c:n(9) e:getfield('t1','sklr,tov->k1t','tov','opt') h:'�.����' c:n(9,3)", 'ktl',,, 'mntov=m1tr')
              if (lastkey()=K_ESC)
                k1tr=0
                m1tr=0
              endif

            endif

          endif

        endif

      endif

      if (k1tr=0)
        sele (tov_r)
        go top
        k1tr=slcf('tov',,,,, "e:ktl h:'���' c:n(9) e:nat h:'������������' c:c(30) e:opt h:'���� ��.' c:n(10,3) e:getfield('t1','sklr,tov->k1t','tov','ktl') h:'�.��' c:n(9) e:getfield('t1','sklr,tov->k1t','tov','opt') h:'�.����' c:n(9,3)", 'ktl',,, 'int(ktl/1000000)<2')
        if (lastkey()=K_ESC)
          k1tr=0
        endif

        if (gnCtov=1)
          if (k1tr#0)
            m1tr=getfield('t1', 'sklr,k1tr', tov_r, 'mntov')
          endif

        endif

      endif

    endif

  else
    if (tov_r=='tovm'.or.tov_r=='ctov')
      if (m1tr#0)
        if (tov_r=='tovm')
          if (!netseek('t1', 'sklr,m1tr'))
            m1tr=0
          endif

        else
          if (!netseek('t1', 'm1tr'))
            m1tr=0
          endif

        endif

      endif

      if (m1tr=0)
        if (tov_r=='tovm')
          sele tovm
          go top
          m1tr=slcf('tovm',,,,, "e:mntov h:'���' c:n(7) e:nat h:'������������' c:c(40)", 'mntov',,, 'int(mntov/10000)<2')
        else
          sele ctov
          go top
          m1tr=slcf('ctov',,,,, "e:mntov h:'���' c:n(7) e:nat h:'������������' c:c(40)", 'mntov',,, 'int(mntov/10000)<2')
        endif

        if (lastkey()=K_ESC)
          m1tr=0
        endif

      endif

    endif

  endif

  sele (tov_r)
  if (cor_r=1)
    go rcn_rr
    reclock()
  endif

  return (.t.)

/***********************************************************
 * izg1() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function izg1()
  if (mkeepr=0)
    if (izgr#0)
      sele kln
      if (netseek('t1', 'izgr'))
        nizgr=nkl
        nizgsr=nkls
        @ 15, 24 say alltrim(nizgr)+' '+nizgsr
      else
        izgr=0
      endif

    endif

    if (izgr=0)
      sele kln
      kklr=izgr
      izgr=slct_kl(10, 1, 12)
      nizgr=getfield('t1', 'izgr', 'kln', 'nkl')
      nizg_r=getfield('t1', 'izgr', 'kln', 'nkls')
      nizgsr=nizg_r
      if (empty(nizg_r))
        nizg_r=nizgr
      endif

      @ 15, 24 say alltrim(nizgr)+' '+nizgsr
    endif

  else
    if (izgr#0)
      sele mkeepe
      if (!netseek('t1', 'mkeepr,izgr'))
        izgr=0
      endif

    endif

    if (izgr=0)
      sele mkeepe
      if (netseek('t1', 'mkeepr'))
        rcmker=recn()
        while (.t.)
          rcmker=slcf('mkeepe',,,,, "e:izg h:'���' c:n(7) e:getfield('t1','mkeepe->izg','kln','nkl') h:'������������' c:c(40) ",,,, 'mkeepe->mkeep=mkeepr',,, '��� ��ન')
          if (lastkey()=K_ESC)
            exit
          endif

          go rcmker
          if (lastkey()=K_ENTER)
            izgr=izg
            exit
          endif

        enddo

      endif

    endif

  endif

  sele (tov_r)
  return (.t.)

/***********************************************************
 * ksert() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function ksert()
  if (ksertr#0)
    sele sert
    if (netseek('t1', 'ksertr'))
      nsertr=nsert
    else
      ksertr=0
    endif

  endif

  if (ksertr=0)
    sele sert
    set orde to tag t3
    if (netseek('t3', 'izgr'))
      rcksertr=slcf('sert',,,,, "e:ksert h:'���' c:n(6) e:nsert h:'������������' c:c(20)",,,, 'izg=izgr')
      sele sert
      go rcksertr
      ksertr=ksert
      nsertr=nsert
    else
      ksertr=0
      nsertr=''
    endif

  endif

  @ 4, 66 say nsertr
  return (.t.)

/***********************************************************
 * kukach() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function kukach()
  /*if ksertr#0 */
  sele ukach
  set orde to tag t3
  if (kukachr#0)
    if (netseek('t3', 'ksertr,izgr,kukachr'))
      dtukachr=dtukachr
    else
      kukachr=0
    endif

  endif

  if (kukachr=0)
    if (netseek('t3', 'ksertr,izgr'))
      rckukachr=slcf('ukach',,,,, "e:kukach h:'���' c:n(6) e:nukach h:'������������' c:c(20) e:dtukach h:'���' c:d(10)",,,, 'ksert=ksertr', 'izg=izgr')
      sele ukach
      go rckukachr
      kukachr=kukach
      dtukachr=dtukach
    else
      kukachr=0
      dtukachr=ctod('')
    endif

  endif

  /*endif */
  @ 5, 66 say dtukachr
  return (.t.)

/***********************************************************
 * fbar() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function fbar()
  local rcbarr
  if (barr#0)
    if (tov_r=='tovm'.or.tov_r=='ctov')
      sele (tov_r)
      rcbarr=recn()
      if (netseek('t4', 'barr').and.(cor_r=1.and.recn()#rcbarr.or.cor_r=0))
        go rcbarr
        reclock()
        wmess('����� ��� �������', 2)
        return (.f.)
      endif

    endif

  endif

  return (.t.)

/***********************************************************
 * flocr() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function flocr()
  sele (tov_r)
  if (locr#0)
    locate for loc=locr .and. mntov#mntovr
    if (found())
      wmess('����� ��� �������', 2)
      return (.f.)
    endif

  endif

  return (.t.)

/***********************************************************
 * izg() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function izg()
  asvkr=savesetkey()
  set key -1 to
  set key -2 to
  set key -3 to
  set key -4 to
  izg_r=izgr
  sele ntovig
  if (!netseek('t1', 'MnNTovr,izgr').or.izgr=0)
    if (!netseek('t1', 'MnNTovr,0'))
      netadd()
      netrepl('MnNTov,izg', 'MnNTovr,0')
    endif

    rcntovigr=recn()
    while (.t.)
      sele ntovig
      go rcntovigr
      foot('ENTER,INS,DEL', '�����,��������,�������')
      rcizgr=slcf('ntovig',,,,, "e:getfield('t1','ntovig->izg','kln','nkl') h:'����⮢�⥫�' c:c(30) e:getfield('t1','ntovig->izg','kln','nkls') h:'���⪮�' c:c(10)",,,, 'MnNTov=MnNTovr')
      sele ntovig
      go rcntovigr
      izgr=izg
      do case
      case (lastkey()=K_ENTER)// �����
        exit
      case (lastkey()=K_INS)  // ��������
        ntovigins()
      case (lastkey()=K_F4)   // ���४��
        ntovigins(1)
      case (lastkey()=K_DEL)  // �������
        netdel()
        skip -1
        if (MnNTov#MnNTovr)
          netseek('t1', 'MnNTovr')
        endif

      case (lastkey()=K_ESC)// �⬥��
        izgr=izg_r
        exit
      endcase

    enddo

  endif

  nizgr=getfield('t1', 'izgr', 'kln', 'nkl')
  nizg_r=getfield('t1', 'izgr', 'kln', 'nkls')
  nizgsr=nizg_r
  if (empty(nizg_r))
    nizg_r=nizgr
  endif

  @ 15, 24 say alltrim(nizgr)+' '+nizgsr
  restsetkey(asvkr)
  return (.t.)

/*************** */
function sntovka()
  /****************
   *wselect(0)
   */
  if (kachr#0)
    sele kach
    if (!netseek('t1', 'kachr'))
      set orde to tag t2
      go top
    endif

  else
    sele kach
    set orde to tag t2
    go top
  endif

  while (.t.)
    set orde to tag t2
    foot('INS,DEL,F4', '��������,�������,���४��')
    rckachr=slcf('kach',,,,, "e:kach h:'���' c:n(3) e:nkach h:'������������' c:c(15)")
    sele kach
    go rckachr
    kachr=kach
    do case
    case (lastkey()=K_ESC.or.lastkey()=K_ENTER)
      exit
    case (lastkey()>32.and.lastkey()<255)
      //case lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
      lstkr=chr(lastkey())
      sele kach
      rckachr=recn()
      if (!netseek('t2', 'lstkr'))
        go rckachr
      endif

    case (lastkey()=K_INS)// ��������
      kachins()
    case (lastkey()=K_F4) // ���४��
      kachins(1)
    case (lastkey()=K_DEL)// �������
      netdel()
      skip-1
      if (bof())
        go top
      endif

    endcase

  enddo

  /*wselect(wkach) */
  return (.t.)

/***********************************************************
 * kachins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function kachins(p1)
  local getlist:={}
  if (p1=nil)
    kachr=1
    nkachr=space(15)
  else
    nkachr=nkach
  endif

  clkir=setcolor('gr+/b,n/w')
  wkir=wopen(10, 20, 14, 60)
  wbox(1)
  while (.t.)
    @ 0, 1 say '���          '+str(kachr, 3)
    @ 1, 1 say '������������' get nkachr
    read
    if (lastkey()=K_ESC)
      exit
    endif

    @ 2, 20 prom '��୮'
    @ 2, col()+1 prom '�� ��୮'
    menu to vn
    if (lastkey()=K_ESC)
      exit
    endif

    if (vn=1)
      if (p1=nil)
        sele kach
        set orde to tag t1
        go top
        while (!eof())
          if (kach#kachr)
            exit
          endif

          kachr++
          skip
        enddo

        sele kach
        netadd()
        netrepl('kach,nkach', 'kachr,nkachr')
      else
        netseek('t1', 'kachr')
        if (FOUND())
          netrepl('nkach', 'nkachr')
        endif

      endif

      exit
    endif

  enddo

  wclose(wkir)
  setcolor(clkir)
  return (.t.)

/***********************************************************
 * post() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function post()
  set key K_SPACE to
  if (postr#0)
    npostr=getfield('t1', 'postr', 'kln', 'nkl')
    if (empty(npostr))
      postr=0
    endif

    @ 14, 24 say npostr
  endif

  if (postr=0)
    sele kln
    kklr=postr
    postr=slct_kl(10, 1, 12)
    npostr=getfield('t1', 'postr', 'kln', 'nkl')
    @ 14, 24 say npostr
  endif

  sele (tov_r)
  return (.t.)

/***********************************************************
 * otti() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function otti()
  if (otr#0)
    if (!netseek('t1', 'gnSk,otr', 'cskle'))
      otr=0
    endif

  endif

  if (otr=0)
    sele cskle
    if (netseek('t1', 'gnSk'))
      otr=slcf('cskle',,,,, "e:ot h:'��' c:n(2) e:nai h:'������������' c:c(20)", 'ot',,, 'sk=gnSk')
    endif

  endif

  sele cskle
  if (netseek('t1', 'gnSk,otr'))
    notr=nai
  else
    otr=0
    notr=''
  endif

  @ 8, 63 say notr
  return (.t.)

/***********************************************************
 * kodstti() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function kodstti()
  sele st1sb
  if (!netseek('t1', 'kodst1r').or.kodst1r=0)
    set order to tag t1
    go top
    kodst1r=slcf('st1sb',,,,, "e:natst h:'���.��-��' c:c(30) e:kodst h:'���' c:n(4) e:kves h:'' c:n(4)", 'kodst')
  endif

  @ 9, 61 say kodst1r
  return (.t.)

/***********************************************************
 * upakins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function upakins(p1)
  local getlist:={}
  if (p1=nil)
    upakr=1
    nupakr=space(5)
  endif

  oclupakr=setcolor('gr+/b,n/w')
  wupak1=wopen(10, 20, 14, 60)
  wbox(1)
  while (.t.)
    @ 0, 1 say '���          '+str(upakr, 3)
    @ 1, 1 say '������������' get nupakr
    read
    if (lastkey()=K_ESC)
      exit
    endif

    @ 2, 20 prom '��୮'
    @ 2, col()+1 prom '�� ��୮'
    menu to vn
    if (lastkey()=K_ESC)
      exit
    endif

    if (vn=1)
      if (p1=nil)
        set orde to tag t1
        go top
        while (!eof())
          if (upak=0)
            skip
            loop
          endif

          if (upak#upakr)
            exit
          endif

          upakr++
          skip
        enddo

        netadd()
        netrepl('upak,nupak', 'upakr,nupakr')
      else
        netseek('t1', 'upakr')
        if (FOUND())
          netrepl('nupak', 'nupakr')
        endif

      endif

      exit
    endif

  enddo

  wclose(wupak1)
  setcolor(oclupakr)
  wselect(0)
  return (.t.)

/*************** */
function sntovup()
  /*************** */
  para p1
  asvk1r=savesetkey()
  set key 22 to
  set key -3 to
  wselect(0)
  if (p1=1)
    if (upakr#0)
      sele upak
      if (!netseek('t1', 'upakr'))
        go top
      endif

    endif

  else
    if (upakpr#0)
      sele upak
      if (!netseek('t1', 'upakpr'))
        go top
      endif

    endif

  endif

  while (.t.)
    foot('INS', '��������')
    sele upak
    if (p1=1)
      upakr=slcf('upak',,,,, "e:upak h:'���' c:n(3) e:nupak h:'������������' c:c(5)", 'upak')
    else
      upakpr=slcf('upak',,,,, "e:upak h:'���' c:n(3) e:nupak h:'������������' c:c(5)", 'upak')
    endif

    do case
    case (lastkey()=K_ESC.or.lastkey()=K_ENTER)
      exit
    case (lastkey()=K_INS)
      upakins()
    endcase

  enddo

  restsetkey(asvk1r)
  wselect(wupak)
  return (.t.)
