/***********************************************************
 * �����    : pfakt.prg
 * �����    : 0.0
 * ����     :
 * ���      : 10/12/19
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

#include "common.ch"
#include "inkey.ch"
/*
    PFakt()  - ���⢥ত���� ��室�
*/
if (pr1->prZ = 1)
  mess("���⢥p���!!! "+str(mnr, 6)+' '+str(gnSk)+' '+DTOS(pr1->DtMod)+' '+pr1->TmMod, 1)
endif

if (Who = 2.or. Who=4)
  mess("���⢥p������ ���p�饭� !!!", 1)
  return
endif

if (getfield('t1', 'mnr,90', 'pr3', 'ssf')=0                                   ;
     .and.!((vor=6.and.kopr=111) .OR. vor=1.and.(str(kopr, 3)$'108;107')) ;
  )
  wmess('��� �㬬� �� ���㬥���', 3)
  return
endif

skr=gnSk
rmskr=gnRmsk
//gnSkT=skar
SkTr=SkAr
if (autor#0)
  if (SkTr#0)             // gnVo=6
    sele cskl
    if (netseek('t1', 'SkTr'))
      gcPath_tt=gcPath_d+alltrim(path)
      gnMsklt=mskl
      gnSklt=skl
    //gnTPsTPok:=TPsTPok
    endif

    if (autor#0.and.!file(gcPath_tt+'tprds01.dbf'))
      wmess ('��� ����� '+str(SkTr, 3), 3)
      return
    endif

  endif

endif

pr1ndsr=getfield('t1', 'kpsr', 'kpl', 'pr1nds')
if (kopr#110)
  pr1ndsr=0
endif

prXmlr=0
sele pr2
set orde to tag t1
if (netseek('t1', 'mnr'))
  while (mn=mnr)
    ktlr=ktl
    mntovr=mntov
    if (NdOtvr=3.or.NdOtvr=4).and. (ktl=ktlm .or. ktlm=0)
      wmess('����४���஢���� ⮢�� ktl=(ktlm || 0)'+str(ktlr, 9), 2)
      return
    endif

    uktr=getfield('t1', 'mntovr', 'ctov', 'ukt')
    optr=getfield('t1', 'sklr,ktlr', 'tov', 'opt')
    if (optr=0.and.!(int(ktlr/1000000)=0.or.int(ktlr/1000000)=1))
      wmess('��� �室��� 業�', 2)
      return
    endif

    if (gnSkOtv#0.and.gnVOtv=2)
      kfr=kf
      upakpr=getfield('t1', 'sklr,ktlr', 'tov', 'upakp')
      if (upakpr=0)
        wmess('��� 㯠����� ���� '+str(ktlr, 9), 2)
        return
      endif

      if (mod(kfr, upakpr)#0)
        wmess('�� 楫�� 㯠����� ���� '+str(ktlr, 9), 2)
        return
      endif

    endif

    if (!empty(uktr))
      if (pr1->kop=108.or.pr1->kop=110)
        prXmlr=1
      endif

    endif

    sele pr2
    skip
  enddo

else
  wmess('��� ⮢��', 2)
  return
endif

if (!netUse ('dokk'))
  return
endif

if (!netUse ('bs'))
  nuse('dokk')
  return
endif

if (!netUse ('dkkln'))
  nuse('dokk')
  nuse('bs')
  return
endif

if (!ChkVzt(.t.))       // �஢��� ������
  return
endif

// outlog(__FILE__,__LINE__,dprr, bom(gdTd), dprr,eom(gdTd))

if (Empty(dprr))
  dprr:=date()
endif

if (dprr < bom(gdTd) .or. dprr > eom(gdTd))
  dprr=eom(gdTd)
endif

if (gnScOut=0)
  if (empty(Get_dprr(@dprr)))
    return
  endif

endif

sele pr1
tprr=time()
netrepl('DPR,tpr', 'dprr,tprr', 1)
mode=1
tsz60r=0
pr60r=getfield('t1', 'mnr,60', 'pr3', 'pr')
if (pr60r=0)
  sm60r=getfield('t1', 'mnr,60', 'pr3', 'ssf')
  if (sm60r#0)
    sm10r=getfield('t1', 'mnr,10', 'pr3', 'ssf')
    sm11r=getfield('t1', 'mnr,11', 'pr3', 'ssf')
    if (sm10r+sm11r#0)
      tsz60r=sm60r/(sm10r+sm11r)
    endif

  endif

else
  tsz60r=pr60r/100
endif

mnor=0                      // Otv hr
if (NdOtvr=3.or.NdOtvr=4)
  netuse('pr1', 'pr1t')
  locate for otv=1.and.kps=kpsr
  if (FOUND())
    mnor=mn
  endif

  netuse('pr2', 'pr2t')
endif

sele pr2
set orde to tag t1
if (netseek('t1', 'mnr'))
  while (MN = mnr)
    ktlr = KTL
    ktlmr=ktlm
    kfr = KF
    sfr = SF
    seur = seu
    SELE Tov
    if (netseek('t1', 'sklr,ktlr'))
      mntov_r=mntov
      osfr=osf+kfr
      osvr=osv+kfr
      osfmr=osfm-osv-kfr+osvr
      osfor=osfo+kfr
      if (fieldpos('osfop')#0.and.kopr=188)
        osfopr=osfop-kfr
      else
        osfopr=0
      endif

      if (gnVo#2 .and. gnVo#1)
        netrepl('OSF,OSV,osfm,DPP', 'OSFr,OSVr,osfmr,DPrr')
      else
        netrepl('OSF,OSV,osfm', 'OSFr,OSVr,osfmr')
      endif

      if (fieldpos('tsz60')#0)
        netrepl('tsz60', 'tsz60r')
      endif

      if (fieldpos('prmn')#0)
        if (gnVo=9.or.gnVo=6.and.((kopr=168.or.kopr=185).and.(gnEnt=14.or.gnEnt=15.or.gnEnt=17).or.kopr=120.and.gnEnt=16))
          netrepl('prmn', 'mnr')
        endif

      endif

      netrepl('osfo', 'osfor')
      if (fieldpos('osfop')#0.and.kopr=188)
        netrepl('osfop', 'osfopr')
      endif

      if (gnCtov=1.and.mntov_r#0)
        sele tovm
        if (netseek('t1', 'sklr,mntov_r'))
          osfr=osf+kfr
          osvr=osv+kfr
          osfmr=osfm-osv-kfr+osvr
          osfor=osfo+kfr
          if (fieldpos('osfop')#0.and.kopr=188)
            osfopr=osfop-kfr
          else
            osfopr=0
          endif

          netrepl('osf,osfo,osv,osfm,dpp', 'osfr,osfor,osvr,osfmr,dprr')
          if (fieldpos('tsz60')#0)
            netrepl('tsz60', 'tsz60r')
          endif

          if (fieldpos('osfop')#0.and.kopr=188)
            netrepl('osfop', 'osfopr')
          endif

        endif

      endif

      sele tov
      keurr=keur
      keur1r=keur1
      keur2r=keur2
      keur3r=keur3
      keur4r=keur4
      keuhr=keuh
      do case
      case (month(dprr)>2.and.month(dprr)<6)
        keu_r=keur1r
      case (month(dprr)>5.and.month(dprr)<9)
        keu_r=keur2r
      case (month(dprr)>8.and.month(dprr)<12)
        keu_r=keur3r
      otherwise
        keu_r=keur4r
      endcase

      if (keu_r=0)
        keu_r=keurr
      endif

      sele pR2
      if (gnRoz=1)
        seur=ROUND(sf*keu_r/100, 2)
        netrepl('seu', 'seur')
      endif

    endif

    if (mnor#0.and.(NdOtvr=3.or.NdOtvr=4))
      sele pr2t
      if (netseek('t1', 'mnor,ktlmr'))
        netrepl('kfo', 'kfo-kfr')
      endif

    endif

    SELE PR2
    skip
  enddo

  sele pr2
  if (gnRoz=1)
    s92r=0
    if (netseek('t1', 'mnr'))
      while (mn=mnr)
        s92r=s92r+seu
        skip
      enddo

    endif

    sele pr3
    if (netseek('t1', 'mnr,92'))
      netrepl('ssf', 's92r')
    else
      netadd()
      netrepl('mn,ksz,ssf', 'mnr,92,s92r')
    endif

  endif

endif

if (NdOtvr=3.or.NdOtvr=4)
  nuse('pr1t')
  nuse('pr2t')
endif

if (gnScOut=0)
  @ 23, 0 clear
endif

PrPrv(1)                  // �஢����
                            // ��⮬�� �� ��
if (autor#0)              //and.NdOtvr=0
                            //outlog(__FILE__,__LINE__)
  PPrh()
//outlog(__FILE__,__LINE__)
endif

// ��室-��⮬�� � ᪫��� cskl.skotv
if (gnSkOtv#0)            // gnOtv=1
  PaOtv()
endif

// ���室 - ��⮬�� � ᪫��� ��.��.
if (NdOtvr=3.or.NdOtvr=4)
  mode=1
  PrAOtv()
endif

sele pr1
go rcpr1r
pro(8)
netrepl('PRZ', '1', 1)
if (fieldpos('rmsk')#0)
  netrepl('rmsk', 'rmskr', 1)
endif

if (fieldpos('dtmod')#0)
  netrepl('dtmod,tmmod', 'date(),time()', 1)
endif

prModr=1
przr=prz

return (.T.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-29-17 * 10:05:03am
 ����������......... �஢�ઠ ����� �� �� 19-(��� �����
 ���������..........
 �����. ��������....
 ����������.........
 */
function ChkVzt(lPrz)
  local lc_pathr:= pathr
  local dBeg:=BOM(gDtd), dEnd:=BOM(DtVzr)
  local nKf, lRet:=.T.
  DEFAULT lPrz to NO

  //   �ய�᪠�� ᪫��� 169 - 263;705'
  if ((str(kopr,3)$"107;108") .and. !(str(gnSk, 3)$'263;705'))
    if (select('dkkln')=0)
      netuse('dkkln')
      netuse('dknap')
      prDkKlnr=0
    else
      prDkKlnr=1
    endif

    // �㬬� ���
    sumtr=getfield('t1', 'mnr,19', 'pr3', 'ssf')
    if (sumtr#0.and.getfield('t1', 'mnr,18', 'pr3', 'ssf')=0)
      sele dkkln
      if (netseek('t1', 'kpsr,361002'))
        dbzr=dn-kn+db-kr
        if (dbzr<sumtr)
          wmess('������ �� �� '+str(dbzr, 10, 2)+' � ��� '+str(sumtr, 10, 2))
          if (prDkKlnr=0)
            nuse('dkkln')
            nuse('dknap')
            return (.f.)
          endif

        endif

      else
        wmess('������ �� ������ ���', 2)
        if (prDkKlnr=0)
          nuse('dkkln')
          nuse('dknap')
        endif

        return (.f.)
      endif

    endif

    if (prDkKlnr=0)
      nuse('dkkln')
      nuse('dknap')
    endif

    if (lPrz)
      // �஢�ઠ �� ������� ��ப ⮢��
      // ���� ��� ������
      if (!empty(SkVzr))
        cPthSkVz:=alltrim(getfield('t1', 'skvzr', 'cskl', 'path'))
      else
        cPthSkVz:=gcDir_t
      endif

      if (!empty(DtVzr))// ���� ��� ���
        pathr=gcPath_e + pathYYYYMM(dtvzr) + '\' + cPthSkVz
        if (netfile('rs1', 1))
          // ᪮��஢��� 蠯�� � ��ப� � �଒��
          netuse('rs1', 'rs1vz',, 1)
          netuse('rs2', 'rs2vz',, 1)
          // ᪮��஢��� 蠯��
          sele rs1vz
          if (netseek('t1', 'TtnVzr'))
            copy to tmptvzR1 next 1
            // ᪮��஢��� ��ப�
            sele rs2vz
            if (netseek('t1', 'TtnVzr'))
              copy to tmptvzR2 while TtnVzr = ttn

            else
              outlog(__FILE__, __LINE__, 3, '��� ��ப ������', skvzr, TtnVzr, pathr)
            endif

          else
            outlog(3, __FILE__, __LINE__, '��� ������', skvzr, TtnVzr, pathr)
          endif

          nuse('rs2vz')
          nuse('rs1vz')

          sele pr1; copy to tmpTVzP1 next 1// stru
          sele pr2; copy to tmpTVzP2 for pr1->mn = mn// stru

          use tmpTVzP1 alias pr1_vz new Exclusive
          use tmpTVzP2 alias pr2_vz new Exclusive
          use tmpTVzR1 alias rs1_vz new Exclusive
          use tmpTVzR2 alias rs2_vz new Exclusive

          // ᪠��஢��� � ���� ������� �� �������
          dBeg:=BOM(gDtd); dEnd:=BOM(DtVzr)
          dBeg:=ADDMONTH(dBeg, +1)
          while (dBeg:=ADDMONTH(dBeg, -1), dBeg) >= dEnd
            outlog(3, __FILE__, __LINE__, dBeg)
            sele cskl; DBGoTop()
            while (!eof())
              if (ent#gnEnt)// �� � �।-��
                skip; loop
              endif

              //  �ய�᪠�� ᪫��� 169 - 263;705'
              if (str(Sk, 3)$'263;705')// ᪫��� 169 �ࠪ�
                skip; loop
              endif

              pathr:=gcPath_e + pathYYYYMM(dBeg) + '\' + alltrim(path)
              //  �饬 ᪫�� � pr1 ���_᪫�� � ���_��
              if (netfile('pr1', 1))
                netuse('pr1', 'pr1vz',, 1)
                netuse('pr2', 'pr2vz',, 1)

                //  �᫨ ��諨, � �⠥� ��ப� ⮢�� �� �଒��
                sele pr1vz
                locate for TtnVzr = TtnVz .and. prz = 1
                if (found())
                  copy to tmpPr1 next 1
                  sele pr2vz
                  copy to tmpPr2 for pr1vz->mn = mn

                  sele pr1_vz; append from tmpPr1
                  sele pr2_vz; append from tmpPr2

                endif

                nuse('pr2vz')
                nuse('pr1vz')
              else
                outlog(3, __FILE__, __LINE__, '��� �R1', pathr)
              endif

              sele cskl
              skip
            enddo

          enddo

          // �஢���� �� �ॢ�襭�� �����⮢ � ��室�
          sele rs2_vz
          repl all KvpO with 0
          DBGoTop()
          while (!eof())
            sele pr2_vz
            sum kf to nKf for rs2_vz->ktl = ktl// �㬬�
            sele rs2_vz
            repl KvpO with KvpO + nKf// ��������
            sele rs2_vz
            skip
          enddo

          sele rs2_vz
          locate for KvpO > Kvp
          if (found())
            // �஡���� � ����� ���
            outlog(__FILE__, __LINE__, '�஡���� � ����� ���, KvpO, Kvp', ktl, KvpO, Kvp)
            wmess('�஡���� � ��� '+str(ktl, 9)+' �-�� ���:'+ltrim(str(KvpO, 4))+' � TTH:'+ltrim(str(Kvp, 4)), 3)
            lRet:=NO
          endif

          // ?�஢���� �� ������ ⮣� 祣� �� �뫮.
          close pr1_vz
          close pr2_vz
          close rs1_vz
          close rs2_vz

        else
          outlog(__FILE__, __LINE__, '��� RS1 ������ � ������', pathr)
        endif

      else
        outlog(__FILE__, __LINE__, '��� 㪠��� ���� ������')
      endif

    endif

  endif

  pathr:=lc_pathr
  return (lRet)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-20-18 * 01:24:58pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
static function Get_dprr(dprr)
  local clpdp:=setcolor('gr+/b,n/w')
  local wpdp:=wopen(10, 20, 13, 50)
  wbox(1)
  @ 0, 1 say '��� ��室�:' get dprr range bom(gdTd), eom(gdTd)
  read
  if (lastkey()=K_ESC)
    wclose(wpdp)
    setcolor(clpdp)
    return (.F.)
  endif

  wclose(wpdp)
  setcolor(clpdp)
  return (.T.)
