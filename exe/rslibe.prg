/***********************************************************
 * �����    : rslibe.prg
 * �����    : 0.0
 * ����     :
 * ���      : 04/03/18
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

#include "common.ch"
#include "inkey.ch"
//

/*************** */
function prnnds()
  /*************** */
  knds=1
  p_nds=ndsr
  p_pnds=pndsr
  nklr=nkplr
  d0k1r=gnD0k1
  if (bom(gdTd)<ctod('01.03.2011'))
    if (!netuse('nds'))
      return
    endif

    sele nds
    if (netseek('t3', 'gnSk,ttnr,d0k1r'))
      nomndsr=nomnds
      ndsdr=ndsd
      sumdcr=sumc
      sumr=sum
      dtt=dnn
      private arab[ 1, 5 ], andsd[ 10, 2 ], attn[ 1 ]
      if (empty(gcPrn))
        upri=chr(27)+chr(77)+chr(15)
      endif

      store 0 to ndsr, sfr, sumkr
      sele kln
      if (netseek('t1', 'kplr'))
        //      nklr=alltrim(nkl)
        if (!empty(nklprn))
          nklr=alltrim(nklprn)
        else
          nklr=alltrim(nkl)
        endif

        adrr=adr
        tlfr=tlf
        nnr=nn
        cnnr=cnn
        nsvr=nsv
        kkl1r=kkl1
      else
        nklr='��� � �ࠢ�筨��'
        store '' to adrr, tlfr, nsvr
        nnr=0
        cnnr=''
      endif

      if (!netuse('tovn'))
        nuse()
        return
      endif

      ktlr=ktl
      natr=nat
      neir=nei
      zenr=zen
      nopr='���� ��� �� �।�����'
      srr=0
      rndsr=0
      ndsr=0
      cntttnr=1
      ddokr=dtt
      nkl=nkplr
      if (ndsdr#0)        // �� - ���४��
        arab[ 1, 1 ]=ttnr
        arab[ 1, 2 ]=gnSk
        arab[ 1, 3 ]=0
        arab[ 1, 4 ]=sumdcr
      else                  // �� - ���筠�
        arab[ 1, 1 ]=ttnr
        arab[ 1, 2 ]=gnSk
        arab[ 1, 3 ]=sdvr
        arab[ 1, 4 ]=sdvr
      endif

      sele nds
      set orde to tag t1
      save scre to scnnpr
      clnppr=setcolor('g/n,n/g')
      clea
      pnn()
      clnppr=setcolor(clnppr)
      rest scre from scnnpr
    else
      save scre to scnnpr
      sele kln
      if (netseek('t1', 'kplr'))
        nklr=alltrim(nkl)
        adrr=adr
        tlfr=tlf
        nnr=nn
        cnnr=cnn
        nsvr=nsv
        kkl1r=kkl1
      else
        nklr='��� � �ࠢ�筨��'
        store '' to adrr, tlfr, nsvr
        nnr=0
        cnnr=''
      endif

      nnt()
      rest scre from scnnpr
    endif

  else
    if (!netuse('nnds'))
      return
    endif

    sele nnds
    if (netseek('t2', '0,0,gnSk,ttnr,0'))
      nomndsr=nnds
      ndsdr=0
      sumdcr=0
      sumr=sm
      dtt=dnn
      private arab[ 1, 5 ], andsd[ 10, 2 ], attn[ 1 ]
      store 0 to ndsr, sfr, sumkr
      sele kln
      if (netseek('t1', 'kplr'))
        if (!empty(nklprn))
          nklr=alltrim(nklprn)
        else
          nklr=alltrim(nkl)
        endif

        adrr=adr
        tlfr=tlf
        nnr=nn
        cnnr=cnn
        nsvr=nsv
        kkl1r=kkl1
      else
        nklr='��� � �ࠢ�筨��'
        store '' to adrr, tlfr, nsvr
        nnr=0
        cnnr=''
      endif

      if (!netuse('tovn'))
        nuse()
        return
      endif

      ktlr=ktl
      natr=nat
      neir=nei
      zenr=zen
      nopr='���� ��� �� �।�����'
      srr=0
      rndsr=0
      ndsr=0
      cntttnr=1
      ddokr=dtt
      nkl=nkplr
      if (ndsdr#0)        // �� - ���४��
        arab[ 1, 1 ]=ttnr
        arab[ 1, 2 ]=gnSk
        arab[ 1, 3 ]=0
        arab[ 1, 4 ]=sumdcr
      else                  // �� - ���筠�
        arab[ 1, 1 ]=ttnr
        arab[ 1, 2 ]=gnSk
        arab[ 1, 3 ]=sdvr
        arab[ 1, 4 ]=sdvr
      endif

      sele nds
      set orde to tag t1
      save scre to scnnpr
      clnppr=setcolor('g/n,n/g')
      clea
      pnn()
      clnppr=setcolor(clnppr)
      rest scre from scnnpr
    endif

  endif

  return (.t.)

/************ */
function ttnw()
  /************ */
  skttnr=savesetkey()
  set key K_SPACE to ttn()
  return (.t.)

/************ */
function ttnv()
  /************ */
  set key K_SPACE to
  restsetkey(skttnr)
  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  05-18-18 * 10:04:38am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
function ttn()
  static nRecStartView
  local getList:={}
  //DEFAULT nRecStartView to (DBGoTop(), RECNO())
  DEFAULT nRecStartView to RECNO()

  set key K_SPACE to
  sele sl
  zap

  ForTtnr:=WhoShow169(ForTtnr)

  kol177r=0
  fldnomr=1
  sele rs1
  go nRecStartView          //top
  while (.t.)
    set cent off
    sele rs1
    foot('F3,F4,F5,F6,F7,F8,F9,F10', '������,����� ��,��,�⌮�,� �����,��,XML,�/���')
    //   foot('F3,F4,F5,F6,F7,F8,F9,F10','������,����� ��,��,�⌮�,� �����,��,����,�/���')
    do case
    case (gnVo=2.or.gnVo=9.or.gnVo=1.or.gnVo=3)
      do case
      case (TtnPrzr=0)    // ��
        if (TtnKpkr=0)
          if (gnKt=0)
            //    ttnr=slcf('rs1',1,,18,,"e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)",'ttn',,,,ForTtnr)
            if (fieldpos('ttn177')#0)
              if (str(gnEnt,3)$' 20; 21')
                //ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:timecrt h:'�६� ���' c:c(19) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:dop h:'��� O' c:d(8)", 'ttn',,,, ForTtnr,,, 1, 2)
                ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:prZZen h:'Z' c:n(1) e:pr177 h:'O' c:n(1) e:npv h:'������਩' c:c(36)", 'ttn',,,, ForTtnr)
                //TtnKpkr:=1
                //ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:prZZen h:'Z' c:n(1) e:pr177 h:'O' c:n(1) e:npv h:'������਩' c:c(36)", 'ttn',,,, ForTtnr,,, 1, 2)
              else
                if (str(gnEnt,3)$' 20; 21')
                  ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:prZZen h:'Z' c:n(1) e:pr177 h:'O' c:n(1)", 'ttn',,,, ForTtnr)
                else
                  ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:prZZen h:'Z' c:n(1) e:pr177 h:'O' c:n(1)", 'ttn',,,, ForTtnr)
                endif

              endif

            else
              if (gnEnt=20)
                ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:prZZen h:'Z' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
              else
                ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:prZZen h:'Z' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
              endif

            endif

          else
            ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dot h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'�����ᨮ���' c:c(23) e:ttnkt h:'�����' c:n(6) e:nndskt h:'����' c:n(6) e:dnnkt h:'�⊒' c:d(8)", 'ttn',,,, ForTtnr)
          endif

        else
          if (TtnKpkpr=0)
            if (gnEnt=20.and.gnSk=241.or.gnEnt=21.and.gnSk=244)
              ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:timecrt h:'�६� ���' c:c(19) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:dop h:'��� O' c:d(8)", 'ttn',,,, ForTtnr,,, 1, 2)
            else
              if (fieldpos('fc')=0)
                if (gnEnt=20)
                  ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz() h:'�' c:c(4) e:dfp h:'��� ��' c:d(8) e:dop h:'��� O' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:timecrt h:'�६� ���' c:c(19) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:tdc h:'���' c:c(8)", 'ttn',,,, ForTtnr,,, 1, 2)
                else
                  ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:dop h:'��� O' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:timecrt h:'�६� ���' c:c(19) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:tdc h:'���' c:c(8)", 'ttn',,,, ForTtnr,,, 1, 2)
                endif

              else
                if (gnEnt=20 .or. gnEnt=21)
                  //ttnr=slce('rs1',1,,18,,"e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:kopi h:'���' c:n(3) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:dop h:'��� O' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:timecrt h:'�६� ���' c:c(19) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:tdc h:'���' c:c(8) e:fc h:'����' c:n(1) e:getfield('t1','rs1->ttn,46','rs3','ssf') h:'����' c:n(10,2)",'ttn',,,,ForTtnr,,,1,2)
                  ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz() h:'�' c:c(4) e:dfp h:'��� ��' c:d(8) e:ktofp h:'��' c:n(4) e:dop h:'��� O' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kgp','ngrpol') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:timecrt h:'�६� ���' c:c(19) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:tdc h:'���' c:c(8) e:fc h:'����' c:n(1) e:getfield('t1','rs1->ttn,46','rs3','ssf') h:'����' c:n(10,2)", 'ttn',,,, ForTtnr,,, 1, 2)
                else
                  ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:ktofp h:'��' c:n(4) e:dop h:'��� O' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:timecrt h:'�६� ���' c:c(19) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:tdc h:'���' c:c(8) e:fc h:'����' c:n(1) e:getfield('t1','rs1->ttn,46','rs3','ssf') h:'����' c:n(10,2)", 'ttn',,,, ForTtnr,,, 1, 2)
                endif

              endif

            endif

          else
            ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:ktofp h:'��' c:n(4) e:dsp h:'��� ��' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1)", 'ttn', 1,,, ForTtnr)
          endif

        endif

      case (TtnPrzr=1)    // ��
        ttnr=slce('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:dop h:'��� O' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpv','kln','nkl') h:'�����⥫�' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:DocGuid h:'���㬥�� ���' c:c(36) e:timecrt h:'�६� ���' c:c(19) e:kta h:'KTA' c:n(4) e:ktas h:'KTAS' c:n(4) e:tdc h:'���' c:c(8)", 'ttn',,,, ForTtnr,,, 1, 2)
      //01-31-17 06:10pm ttnr=slcf('rs1',1,,18,,"e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:kopi h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dfp h:'��� ��' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(4) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)",'ttn',,,,ForTtnr)
      case (TtnPrzr=2)    // ��
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dfp h:'��� ��' c:d(8) e:dsp h:'��� ��' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
      case (TtnPrzr=3)    // ��
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dsp h:'��� ��' c:d(8) e:dop h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
      case (TtnPrzr=4)    // ����
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dop h:'��� �' c:d(8) e:dot h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
      case (TtnPrzr=5)    // ����
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dot h:'��� �' c:d(8) e:dvttn h:'��� ��' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
      case (TtnPrzr=6)    // ��
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvttn h:'��� ��' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
      case (TtnPrzr=7)    // ��⍥���
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:dot h:'��� �' c:d(8) e:sdv h:'�㬬�' c:n(10,2) e:getfield('t1','rs1->kpl','kln','nkl') h:'���⥫�騪' c:c(23) e:getfield('t1','rs1->kta','s_tag','fio') h:'�����' c:c(8) e:kolosp h:'O' c:n(1) e:pr49 h:'�' c:n(1)", 'ttn',,,, ForTtnr)
      endcase

    case (gnVo=5.or.gnVo=4)
      if (gnVo=5.and.prlkr=0).or.gnVo=4
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:skl h:'���.' c:n(7) e:sdv h:'�㬬�' c:n(10,2) e:str(kpl,7)+' '+getfield('t1','rs1->kpl','bs','nbs') h:'���' c:c(20) e:getfield('t1','rs1->kps','kln','nkl') h:space(15) c:c(15)", 'ttn',,,, ForTtnr)
      else
        ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dvp h:'��� �' c:d(8) e:skl h:'���.' c:n(7) e:sdv h:'�㬬�' c:n(10,2) e:str(kpl,7)+' '+getfield('t1','rs1->kpl','bs','nbs') h:'���' c:c(20) e:getfield('t1','rs1->kps','kln','nkl') h:'��⮬�����' c:c(15)", 'ttn',,,, ForTtnr)
      endif

    otherwise
      // +' '+getfield('t1','rs1->skt','cskl','nskl')
      ttnr=slcf('rs1', 1,, 18,, "e:ttn h:'���' c:n(6) e:kop h:'���' c:n(3) e:prz h:'�' c:n(1) e:dot h:'���' c:d(8) e:str(rs1->skl,7)+' '+getfield('t1','rs1->skl','kln','nkl') h:'���筨�' c:c(26) e:sdv h:'�㬬�' c:n(10,2) e:str(rs1->skt,7) h:'����� �㤠' c:c(10) e:amn h:'��室' c:n(6)", 'ttn',,,, ForTtnr)
    endcase

    set cent on
    store 0 to kolospr, kolpspr
    sele rs1
    netseek('t1', 'ttnr',,, 1)
    kolospr=kolosp
    kolpspr=kolpsp
    DocGuidr=DocGuid
    nkklr=nkkl
    kpvr=kpv
    kplr=kpl
    kgpr=kgp
    dopr=dop
    kopr=kop
    vor=vo
    bsor=bso
    napr=nap
    ttn177r=ttn177
    pr177r=pr177
    ttn169r=ttn169
    pr169r=pr169
    if (fieldpos('mntov177')#0)
      mntov177r=mntov177
      prc177r=prc177
    else
      mntov177r=0
      prc177r=0
    endif

    if (fieldpos('ztxt')#0)
      ztxtr=ztxt
    else
      ztxtr=space(200)
    endif

    do case
    case (lastkey()=K_LEFT.and.TtnKpkr=1)// Left
      fldnomr=fldnomr-1
      if (fldnomr=0)
        fldnomr=1
      endif

    case (lastkey()=K_RIGHT.and.TtnKpkr=1)// Right
      fldnomr=fldnomr+1
    case (lastkey()=K_ALT_F2)
      if (gnAdm=1.or.gnKto=160.or.gnKto=848)
        if (fieldpos('prZZen')#0)
          if (rs1->prZZen=0)
            netrepl('prZZen', '1')
          else
            netrepl('prZZen', '0')
          endif

        endif

      endif

    case (lastkey()=K_F3)
      clttnr=setcolor('gr+/b,n/bg')
      wttnr=wopen(5, 10, 20, 70)
      wbox(1)
      @ 0, 1 say '��ਮ�    ' get ttndt1r
      @ 0, col()+1 get ttndt2r
      @ 1, 1 say '�ਧ���   ' get TtnPrzr pict '9'
      @ 1, col()+1 say '0��;1��;2��;3��;4����;5����;6��;7��⍥���'
      @ 2, 1 say '���⥫�騪' get ttnkplr pict '9999999'
      @ 3, 1 say '����஢�� ' get ttnktor pict '999'
      @ 4, 1 say '�㬬� �� 0' get TtnSdvr pict '9'
      @ 5, 1 say '���       ' get TtnKpkr pict '9'
      @ 6, 1 say '�����     ' get ttnktar pict '9999'
      @ 7, 1 say '����.tmesto' get ttntmr pict '9'
      @ 8, 1 say '��� �� ��� ' get TtnKpkpr pict '9'
      @ 9, 1 say '��� ������ ' get ttndzr pict '9'
      @ 10, 1 say '���        ' get TtnBsor pict '9'
      @ 11, 1 say '����      ' get ttnakcr pict '9'
      @ 12, 1 say '��. ��樨  ' get ttnpr177r pict '9'
      @ 13, 1 say '���        ' get kopucr pict '999'
      read
      if (lastkey()=K_ESC)
        wclose(wttnr)
        setcolor(clttnr)
        ForTtnr=ForTtn_r
        loop
      endif

      if (!empty(ttndt1r))
        if (empty(ttndt2r))
          ForTtnr=ForTtn_r+'.and.dvp=ttndt1r'
        else
          ForTtnr=ForTtn_r+'.and.dvp>=ttndt1r.and.dvp<=ttndt2r'
        endif

      endif

      do case
      case (TtnPrzr=0)    // ��
        ForTtnr=ForTtnr+'.and..t.'
      case (TtnPrzr=1)    // ��
        ForTtnr=ForTtnr+'.and.empty(dfp)'
      case (TtnPrzr=2)    // ��
        ForTtnr=ForTtnr+'.and.!empty(dfp).and.empty(dsp)'
      case (TtnPrzr=3)    // ��
        ForTtnr=ForTtnr+'.and.!empty(dsp).and.empty(dop)'
      case (TtnPrzr=4)    // ���_�
        ForTtnr=ForTtnr+'.and.!empty(dop).and.prz=0'
      case (TtnPrzr=5)    // ���_�
        ForTtnr=ForTtnr+'.and.prz=1'
      case (TtnPrzr=6)    // ��
        ForTtnr=ForTtnr+'.and.!empty(dvttn).and.prz=0'
      case (TtnPrzr=7)    // ��⥢� �� ����祭��
        sele rs1
        ForTtnr=ForTtnr+'.and.!empty(dsp).and.empty(dop).and.kolosp#kolpsp.and.kolosp#0'
      endcase

      if (ttnkplr#0)
        ForTtnr=ForTtnr+'.and.kpl=ttnkplr'
      endif

      if (ttnktor#0)
        ForTtnr=ForTtnr+'.and.kto=ttnktor'
      endif

      if (TtnSdvr#0)
        ForTtnr=ForTtnr+'.and. (sdv#0 .or. (sdv=0 .and. kop=160 .and. .not. empty(ztxt)))'
      endif

      if (TtnKpkr#0)
        //              ForTtnr=ForTtnr+".and.(!empty(DocGuid).or.!empty(getfield('t1','rs1->ttnp','rs1','DocGuid')).or.!empty(getfield('t1','rs1->docid','rs1','DocGuid')))"
        //              if fieldpos('prkpk')#0
        //                 ForTtnr=ForTtnr+"and.rs1->prkpk=1"
      //              endif
      endif

      if (ttnktar#0)
        ForTtnr=ForTtnr+'.and.kta=ttnktar'
      endif

      if (ttntmr=1)
        ForTtnr=ForTtnr+".and.!netseek('t1','rs1->kta,rs1->tmesto','stagtm')"
      endif

      if (TtnKpkpr=1)
        ForTtnr=ForTtn_r+'.and.dvp>=ttndt1r.and.dvp<=ttndt2r.and.pvt=1.and.sdv#0'
        if (ttnktar#0)
          ForTtnr=ForTtnr+'.and.kta=ttnktar'
        endif

        if (TtnKpkr=1)
          ForTtnr=ForTtnr+".and.(!empty(DocGuid).or.!empty(getfield('t1','rs1->ttnp','rs1','DocGuid')))"
        endif

        ForTtnr=ForTtnr+'.and.!empty(dfp).and.empty(dop).and.prz=0'
      endif

      if (ttndzr=1)
        ForTtnr=ForTtnr+".and.getfield('t1','rs1->nkkl','edz','pdz4')>0"
      endif

      if (TtnBsor=1)
        ForTtnr=ForTtnr+".and.bso#0"
      endif

      if (ttnakcr=1)
        ForTtnr=ForTtnr+".and.kop=177"
        //              ForTtnr=ForTtnr+".and.kopi=177"
      //              ForTtnr=ForTtnr+".and.pr177=ttnpr177r"
      endif

      if (ttnakcr=0.and.ttnpr177r#0)
        ForTtnr=ForTtnr+".and.pr177=ttnpr177r"
      endif

      if (kopucr#0)
        ForTtnr=ForTtnr+".and.kop=kopucr"
      endif

      ForTtnr:=WhoShow169(ForTtnr)

      wclose(wttnr)
      setcolor(clttnr)
      sele rs1
      go top
      loop
    case (lastkey()=K_F4)
      vlpt=0
      sele sl
      go top
      while (!eof())
        ttnr=val(kod)
        sele rs1
        if (netseek('t1', 'ttnr',,, 1))
          pvtr=pvt
          kplr=kpl
          if (rs1->ktas#0)
            prExter=getfield('t1', 'rs1->ktas', 's_tag', 'prExte')
            if (prExter=2)
              if (kgpr#20034)
                if (!netseek('t1', 'kgpr', 'kgp'))
                  wmess('��� ��㧮�����⥫� � �ࠢ�筨��', 3)
                  loop
                endif

              endif

            endif

          endif

          if (!empty(DocGuid).or.!empty(getfield('t1', 'rs1->ttnp', 'rs1', 'DocGuid')))
            if (!dog(rs1->kpl))
              wmess('�஡���� � ������஬', 1)
              sele rs1
              skip
              loop
            endif

          endif

          vmrshr=getfield('t2', 'kplr', 'atvme', 'vmrsh')
          atrcr=getfield('t1', 'vmrshr', 'atvm', 'atrc')
          if (atrcr=0)
            sele sl
            skip
            loop
          endif

          ppsfr=ppsf
          gnVo=vo
          kopr=kop
          npvr=npv
          kpvr=kpv
          textr=text
          AtNomr=atnom
          pSTr=pst
          sklr=skl
          kplr=kpl
          kgpr=kgp
          kpvr=kpv
          bsor=bso
          dspr=dsp
          dotr=dot
          sktr=skt
          skltr=sklt
          ttnpr=ttnp
          ttncr=ttnc
          rtcenr=0
          ttn1cr=ttn1c
          nndsr=nnds
          sele soper
          netseek('t1', '0,1,gnVo,kopr-100')
          brprr=brpr
          if (brprr=1)
            sele setup
            locate for ent=gnEnt
            Nbankr=OB2
            Bankr=KB2
            Schtr=NS2
          endif

          sele soper
          zcr=zc
          nopr=nop
          tcenr=tcen
          coptr=alltrim(getfield('t1', 'tcenr', 'tcen', 'zen'))
          sele rs1
          dvpr=dvp
          dopr=dop
          ktar=kta
          ktor=kto
          pprr=ppr
          if (fieldpos('kolpos')#0)
            kolposr=kolpos
          else
            kolposr=0
          endif

          fktor=alltrim(getfield('t1', 'ktor', 'speng', 'fio'))
          symklr=''
          symkl=0
          skr=gnSk
          rsprn(2, 1)     // ��⥢�� �����,1 �
                            //                 rsprn(2,2) // ��⥢�� �����,2 �
        endif

        sele sl
        skip
      enddo

      set prin off
      set prin to
      set cons on
      loop

    case (lastkey()=K_F5.and.(gnRfp=1.or.gnAdm=1)) // ��
      prnppr=0
      dfpr=date()
      tfpr=time()
      if (bsor#0.and.!(kopr=169.or.kopr=151))

        dolr:=klnlic->(DtLic(kplr, kgpr, 2)) // 2 - ��業��� ��������
        Do Case
        Case Empty(dolr)
          wmess('��� ��業���', 2)
          loop
        Case (dolr<date())
          wmess('��業��� �����稫��� '+dtoc(dolr), 2)
          loop
        EndCase

      endif

      sele rs1
      if (gnEnt=20 .or. gnEnt=21)
        prfp_rr=1
        ktar=kta
        ktasr=ktas
        kopr=kop
        kplr=kpl
        kgpr=kgp
        sdvr=sdv
        if (kplr=0.or.kgpr=0)
          wmess('���� ��� ���� =0', 2)
          prfp_rr=0
        else
          if (ktar#0)
            sele s_tag
            if (!netseek('t1', 'ktar'))
              wmess('����� ��� � �ࠢ�筨��', 2)
              ktar=0
            else
              if (ktas=0)
                wmess('�㯥ࢠ���� =0', 2)
                ktar=0
              else
                ktasr=ktas
              endif

            endif

          endif

          if (ktar=0)
            prfp_rr=0
          else
            if (ktasr=0)
              ktasr=getfield('t1', 'ktar', 's_tag', 'ktas')
            endif

            exter=exte(ktar)
            if (vor=9.and.(kopr=160.or.kopr=161.or.kopr=169.or.kopr=177))
              kplr=ChkKpl()
              if (kplr=0)
                prfp_rr=0
              else
                kgpr=ChkKgp()
                if (kgpr=0)
                  prfp_rr=0
                endif

              endif

            endif

          endif

        endif

      endif

      sele rs1
      if !(gnEnt=20)

        prfp_rr=1
        if (rs1->ktas#0)
          prExter=getfield('t1', 'rs1->ktas', 's_tag', 'prExte')
          if (prExter=2.and.gnVo=9)
            if (kgpr#20034)
              if (!netseek('t1', 'kgpr', 'kgp'))
                wmess('��� ��㧮�����⥫� � �ࠢ�筨��', 3)
                loop
              endif

            endif

          endif

        endif

        if (!empty(rs1->DocGuid).or.!empty(getfield('t1', 'rs1->ttnp', 'rs1', 'DocGuid')))
          prfp_rr=0
          if (!dog(kplr))
            wmess('�஡���� � ������஬', 1)
          else
            if (!kgprm(kpvr))
              wmess('��㧮�����⥫� �� �⮣� ॣ����', 1)
            else
              if (prExter=0)
                if (tmesto=0)
                  tmestor=getfield('t2', 'nkklr,kpvr', 'tmesto', 'tmesto')
                  netrepl('tmesto', 'tmestor')
                endif

                if (tmesto#0)
                  if (!netseek('t1', 'rs1->kta,rs1->tmesto', 'stagtm'))
                    prfp_rr=0
                  else
                    prfp_rr=1
                  endif

                endif

              else
                prfp_rr=1
              endif

              if (prExter=1)
                if (prfp_rr=0)
                  ach:={ '���', '��' }
                  achr=0
                  achr=alert('��� �ਢ離� �࣮���� ����.�த������?', ach)
                  if (achr=2)
                    prfp_rr=1
                  endif

                endif

              else
                if (ktasr=556)
                  prfp_rr=0
                  wmess('��� �ਢ離� �࣮���� ���� '+str(ktasr, 4), 2)
                endif

              endif

            endif

          endif

        endif

        if (gnEnt=21)
          if (!ChkLic())
            prfp_rr=0
          endif

        endif

        if (prfp_rr=1)
          if (gnEnt=20.and.kplr#0.and.pr361r=1.and.!(kopr=169.or.kopr=168).and.gnVo=9)
            prfp_rr=0
            codelistr=getfield('t1', 'kplr', 'kpl', 'codelist')
            if (!empty(codelistr))
              ckopr=str(kopr, 3)
              if (at(ckopr, codelistr)=0)
                if (kopr#177)
                  wmess('�������⨬� ��� ����樨', 1)
                  prfp_rr=0
                else
                  prfp_rr=1
                endif

              else
                prfp_rr=1
              endif

            else
              wmess('��� �ਢ� ����� ����', 1)
              prfp_rr=0
            endif

          endif

        endif

      endif

      sele rs1
      if (gnEnt=20 .or. gnEnt=21)
        If kopr=169 .and. !(sdvr < 50000) //sdv50000
          wmess('��࠭�祭�� �� �㬬� �-� 50000',2)
          loop
        EndIf
      EndIf
      if (prfp_rr=1)
        if (empty(dfp).and.!docblk())
          sele rs1
          netrepl('dfp,tfp,ktofp', 'dfpr,tfpr,gnKto')
          rso(23)
        else
          edtr=ctod('')
          etmr=space(8)
          sele rs1
          netrepl('dfp,tfp,ktofp', 'edtr,etmr,gnKto')
          rso(22)
        endif

      endif

      loop
    case (lastkey()=K_F6) // ��� ����䨪�樨
      netrepl('dtmod,tmmod', 'date(),time()')

    case ( lastkey()=K_F7 ; // �ਧ��� � ����� 7
      .and. str(gnEnt,3)$' 20; 21';
      .and. ( ;
              (gnAdm=1 .or. str(gnKto,3)$' 28; 71;160;217;786') .or.;
              ;//��४��
              (gnAdm=1 .or. str(gnKto,3)$'; 129; 160; 117');
            );
      )

      Do Case
      Case kopr=169;
        ;// ����� ����㦥�
         .and. rs1->(Sdv#0 .and. !empty(dop) .and. prz=0);
        ;//��४��
         .and. (gnAdm=1 .or. str(gnKto,3)$'; 129; 160; 117')

        cKopr=str(kopr, 3)
        cTtnUcr='ttn'+ckopr
        cMkUcr='mk'+ckopr
        cPrUcr='pr'+ckopr

        pTtnUcr:=rs1->(FIELDPOS(cTtnUcr))
        pMkUcr :=rs1->(FIELDPOS(cMkUcr))
        pPrUcr :=rs1->(FIELDPOS(cPrUcr))

        if (FIELDGET(pMkUcr)=0.and.FIELDGET(pPrUcr)=0)
          sele rs1
          netrepl(cMkUcr, { 169 })
        endif

      Case kopr=177
        pr177()
      EndCase
        */
    case (lastkey()=K_ALT_F7 ; // ������� �����
      .and.str(gnEnt,3)$' 20; 21';
      .and.(gnAdm=1 .or. str(gnKto,3)$' 28; 71;160;217;786'))

      if (select('ttrs2')#0)
        sele ttrs2
        CLOSE
      endif

      aTypeUc:=nil
      aTypeUc:=TypeUc()
      if (empty(aTypeUc))
        wmess('�⪠�')
        loop
      endif

      ttn177(aTypeUc)

      ttnr=ttn177r
      ForTtnr='.t.'
      sele rs2
      if (netseek('t1', 'ttnr'))
        while (ttn=ttnr)
          svpr=roun(kvp*zen, 2)
          netrepl('svp', 'svpr')
          sele rs2
          skip
        enddo

      endif

      sele rs1
      netseek('t1', 'ttnr')
      kol177r=0
      @ 23, 70 say str(kol177r, 9)
    case (lastkey()=K_F8) // ��
      dztv(1)
    case (lastkey()=K_ESC)
      exit
    case (lastkey()=K_F9) // ����䨪���
      // XmlAmbar()                      //           ttnsert()
      If !Empty(rs1->(DtOt))
        SendEdiDesadv()
      EndIf
    case (lastkey()=K_F10)// ztxt
      ztxt()
    case (lastkey()=K_ENTER)
      nRecStartView:=RECNO()
      exit
    endcase

  enddo

  sele rs1
  set key K_SPACE to ttn()
  @24, 0 clea to 24, 79
  set key K_SPACE to ttn
  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  05-24-18 * 04:31:02pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION WhoShow169(ForTtnr)
  LOCAL lc_pr169:='.and..not.(rs1->(pr169=2.or.pr139=2.or.pr129=2.or.pr177=2))'
  // ��४�
  If ((gnAdm=1 .or. str(gnKto,3)$'; 129; 160; 117'))
    //
  else
    If .not. lc_pr169 $ ForTtnr
      ForTtnr=ForTtnr + lc_pr169
    EndIf
  EndIf
  // outlog(__FILE__,__LINE__,ForTtnr)
  RETURN (ForTtnr)

/************** */
function entp()
  /************** */
  if (entpr=gnEnt)
    entpr=0
  endif

  sele menent
  if (entpr#0)
    locate for ent=entpr.and.comm=0
  endif

  if (!foun())
    entpr=0
    nentpr=''
    direpr=''
    pathepr=''
  endif

  if (entpr=0)
    go top
    rcentpr=slcf('menent', 10, 10,,, "e:ent h:'���' c:n(2) e:uss h:'������������' c:c(30)",,,,, 'ent#gnEnt.and.comm=0',, '�।�����')
    sele menent
    go rcentpr
    entpr=ent
    nentpr=uss
    direpr=alltrim(nent)+'\'
    if (comm=0)
      pathemr=gcPath_ini
    else
      pathemr=gcPath_ini+direpr
    endif

    pathepr=pathemr+direpr
    pathecr=pathemr+gcDir_c
  endif

  @ 5, 1 say '�।���⨥: '+ ' '+str(entpr, 3)+' '+nentpr
  return (.t.)

/************** */
function sktp()
  /************** */
  sele 0
  pathr=pathecr
  /*use (pathecr+'cskl') alias ecskl */
  netuse('cskl', 'ecskl',, 1)
  go top
  rcsktpr=slcf('ecskl', 10, 10,,, "e:sk h:'���' c:n(3) e:nskl h:'������������' c:c(30)",,,,, 'ent=entpr.and.ctov=1',, '�����')
  sele ecskl
  go rcsktpr
  sktpr=sk
  nsktpr=nskl
  nuse('ecskl')
  @ 6, 1 say '�����:       '+' '+str(sktpr, 3)+' '+nsktpr
  return (.t.)

/*********** */
function otn()
  /*********** */
  sele cskle
  if (netseek('t1', 'gnSk'))
    while (sk=gnSk)
      rccskler=recn()
      arec:={}
      getrec()
      otr=ot
      if (!netseek('t1', 'sktr,otr'))
        netadd()
        putrec()
        netrepl('sk', 'sktr')
      endif

      go rccskler
      skip
    enddo

  endif

  if (!netseek('t1', 'sktr,otnr').or.otnr=0)
    while (.t.)
      rccskler=slcf('cskle',,, 10,, "e:sk h:'SK' c:n(3) e:ot h:'��' c:n(2) e:nai h:'������������' c:c(20)",,,,, 'sk=sktr',, '�⤥�-�����祭��')
      if (lastkey()=K_ESC)
        exit
      endif

      go rccskler
      otnr=ot
      notnr=nai
      do case
      case (lastkey()=K_ENTER)
        @ 6, 1 say '�⤥�     : '+' '+str(otnr, 2)+' '+notnr
        exit
      endcase

    enddo

  else
    notnr=nai
    @ 6, 1 say '�⤥�     : '+' '+str(otnr, 2)+' '+notnr
  endif

  return (.t.)

/*********** */
function kgn()
  /*********** */
  sele cgrp
  if (!netseek('t1', 'kgnr').or.kgnr=0)
    while (.t.)
      rccgrpr=slcf('cgrp',,, 10,, "e:kgr h:'���' c:n(3) e:ngr h:'������������' c:c(20)",,,,,,, '��㯯�-�����祭��')
      if (lastkey()=K_ESC)
        exit
      endif

      go rccgrpr
      kgnr=kgr
      if (kgnr=0)
        ngnr='�� ��'
      else
        ngnr=ngr
      endif

      do case
      case (lastkey()=K_ENTER)
        @ 7, 1 say '��㯯�    : '+' '+str(kgnr, 3)+' '+ngnr
        exit
      endcase

    enddo

  else
    ngnr=ngr
    @ 7, 1 say '��㯯�    : '+' '+str(kgnr, 3)+' '+ngnr
  endif

  return (.t.)

/************ */
function otnp()
  /************ */
  sele cskle
  if (netseek('t1', 'gnSk'))
    while (sk=gnSk)
      rccskler=recn()
      arec:={}
      getrec()
      otr=ot
      if (!netseek('t1', 'sktpr,otr'))
        netadd()
        putrec()
        netrepl('sk', 'sktpr')
      endif

      go rccskler
      skip
    enddo

  endif

  if (!netseek('t1', 'sktpr,otnr').or.otnr=0)
    while (.t.)
      rccskler=slcf('cskle',,, 10,, "e:sk h:'SK' c:n(3) e:ot h:'��' c:n(2) e:nai h:'������������' c:c(20)",,,,, 'sk=sktpr',, '�⤥�-�����祭��')
      if (lastkey()=K_ESC)
        exit
      endif

      go rccskler
      otnr=ot
      notnr=nai
      do case
      case (lastkey()=K_ENTER)
        @ 7, 1 say '�⤥�:'+' '+str(otnr, 2)+' '+subs(notnr, 1, 10)
        exit
      endcase

    enddo

  else
    notnr=nai
    @ 7, 1 say '�⤥�:'+' '+str(otnr, 2)+' '+subs(notnr, 1, 10)
  endif

  return (.t.)

/************* */
function kgnp()
  /************* */
  pathr=pathepr
  sele 0
  netuse('cgrp', 'cgrpp',, 1)
  if (!netseek('t1', 'kgnr').or.kgnr=0)
    rccgrpr=slcf('cgrpp',,, 10,, "e:kgr h:'���' c:n(3) e:ngr h:'������������' c:c(20)",,,,,,, '��㯯�-�����祭��')
    go rccgrpr
    kgnr=kgr
    if (kgnr=0)
      ngnr='�� ��'
    else
      ngnr=ngr
    endif

    @ 7, 22 say '��㯯�    : '+' '+str(kgnr, 3)+' '+ngnr
  else
    ngnr=ngr
    @ 7, 22 say '��㯯�    : '+' '+str(kgnr, 3)+' '+ngnr
  endif

  nuse('cgrpp')
  return (.t.)

/************** */
function kpladd()
  /************** */
  if (gnVo=9)
    if (nkklr#20034.and.nkklr#0)
      if (gnRmsk#0)
        sele kpl
        if (!netseek('t1', 'nkklr'))
          crmskr=stuff(space(9), gnRmsk, 1, '1')
          netadd()
          netrepl('kpl,crmsk', 'nkklr,crmskr')
          netrepl('dtkpl', 'date()')
        else
          crmskr=crmsk
          crmskr=stuff(crmskr, gnRmsk, 1, '1')
          netrepl('crmsk', 'crmskr')
        endif

      else
        vmrshr=getfield('t1', 'nkklr', 'kln', 'vmrsh')
        if (vmrshr#0)
          atrc_r=getfield('t1', 'vmrshr', 'atvm', 'atrc')
          if (atrc_r#0)
            if (atrc_r=1)
              rm_r=2
            endif

            if (atrc_r=2)
              rm_r=1
            endif

            sele kpl
            if (!netseek('t1', 'nkklr'))
              crmskr=stuff(space(9), rm_r, 1, '1')
              netadd()
              netrepl('kpl,crmsk', 'nkklr,crmskr')
              netrepl('dtkpl', 'date()')
            else
              crmskr=crmsk
              crmskr=stuff(crmskr, rm_r, 1, '1')
              netrepl('crmsk', 'crmskr')
            endif

          endif

        endif

      endif

    endif

  endif

  return (.t.)

/************** */
function kgpadd()
  /************** */
  if (gnVo=9)
    if (kpvr#20034.and.kpvr#0)
      sele kgp
      if (!netseek('t1', 'kpvr'))
        netadd()
        netrepl('kgp', 'kpvr')
        netrepl('dtkgp', 'date()')
      endif

    endif

  endif

  return (.t.)

/********************** */
function ttnprov(p1, p2, p3)
  /********************** */
  // p1 sk
  // p2 ttn
  // p3 0 - dokk; 1 - dokko
  sk_rr=p1
  ttn_rr=p2
  fordocr='sk=sk_rr.and.rn=ttn_rr.and.mnp=0'
  whldocr='sk=sk_rr.and.rn=ttn_rr.and.mnp=0'
  while (.t.)
    foot('ENTER', 'PROV')
    if (!nettag('dokk', 't13'))
      if (p3=0)
        sele dokk
        go top
        rcdokkr=slcf('dokk', 4,, 8,, "e:bs_d h:'��' c:n(6) e:bs_k h:'��' c:n(6) e:bs_s h:'�㬬�' c:n(10,2) e:ddk h:'���' c:d(10) e:ksz h:'��' c:n(2) e:nap h:'����' c:n(4)",,,,, fordocr,, 'DOKK')
      else
        sele dokko
        go top
        rcdokkor=slcf('dokko', 4,, 8,, "e:bs_d h:'��' c:n(6) e:bs_k h:'��' c:n(6) e:bs_s h:'�㬬�' c:n(10,2) e:ddk h:'���' c:d(10) e:ksz h:'��' c:n(2) e:nap h:'����' c:n(4)",,,,, fordocr,, 'DOKKO')
      endif

    else
      if (p3=0)
        sele dokk
        set orde to tag t13
        netseek('t13', 'sk_rr,ttn_rr,0')
        rcdokkr=slcf('dokk', 4,, 8,, "e:bs_d h:'��' c:n(6) e:bs_k h:'��' c:n(6) e:bs_s h:'�㬬�' c:n(10,2) e:ddk h:'���' c:d(10) e:ksz h:'��' c:n(2) e:nap h:'����' c:n(4) e:nnds h:'���' c:n(10) e:nndsvz h:'�����' c:n(10) e:dnnvz h:'������' c:d(10)",,,, whldocr,,, 'DOKK')
      else
        sele dokko
        set orde to tag t13
        netseek('t13', 'sk_rr,ttn_rr,0')
        rcdokkor=slcf('dokko', 4,, 8,, "e:bs_d h:'��' c:n(6) e:bs_k h:'��' c:n(6) e:bs_s h:'�㬬�' c:n(10,2) e:ddk h:'���' c:d(10) e:ksz h:'��' c:n(2) e:nap h:'����' c:n(4)",,,, whldocr,,, 'DOKKO')
      endif

      set orde to tag t1
    endif

    do case
    case (lastkey()=K_ESC)
      exit
    case (lastkey()=K_ENTER.and.!empty(dopr))
      if (przr=1)
        rsprv(2, 0)
        rsprv(1, 0)
      else
        rsprv(2, 1)
        rsprv(1, 1)
      endif

    endcase

  enddo

  keyboard ''
  return (.t.)

/*************** */
function ttnsert()
  /*************** */
  if (empty(dopr).and.gnEnt=20)
    qr=mod(kopr, 100)
    store 0 to onofr, opbzenr, opxzenr, ;
     otcenpr, otcenbr, otcenxr,         ;
     odecpr, odecbr, odecxr
    inikop(gnD0k1, gnVu, gnVo, qr)
    sele rs3
    if (!netseek('t1', 'ttnr,46'))
      netadd()
      netrepl('ttn,ksz', 'ttnr,46')
    endif

    if (ssf#0)
      netrepl('ssf,bssf,xssf', '0,0,0')
    else
      netrepl('ssf,bssf,xssf', '0.30,0.30,0.30')
    endif

    pere(3)
  endif

  return (.t.)

/********************** */
function prprov(p1, p2, p3)
  /********************** */
  // p1 sk
  // p2 nd
  // p3 mn
  sk_rr=p1
  nd_rr=p2
  mnp_rr=p3
  fordocr='sk=sk_rr.and.rn=nd_rr.and.mnp=mnp_rr'
  whldocr='sk=sk_rr.and.rn=nd_rr.and.mnp=mnp_rr'
  while (.t.)
    foot('ENTER', 'PROV')
    if (!nettag('dokk', 't13'))
      sele dokk
      go top
      rcdokkr=slcf('dokk', 4,, 8,, "e:bs_d h:'��' c:n(6) e:bs_k h:'��' c:n(6) e:bs_s h:'�㬬�' c:n(10,2) e:ddk h:'���' c:d(10) e:ksz h:'��' c:n(2)",,,,, fordocr,, 'DOKK')
    else
      sele dokk
      set orde to tag t13
      netseek('t13', 'sk_rr,nd_rr,mnp_rr')
      rcdokkr=slcf('dokk', 4,, 8,, "e:bs_d h:'��' c:n(6) e:bs_k h:'��' c:n(6) e:bs_s h:'�㬬�' c:n(10,2) e:ddk h:'���' c:d(10) e:ksz h:'��' c:n(2) e:nnds h:'��' c:n(10) e:nndsvz h:'����' c:n(10)",,,, whldocr,,, 'DOKK')
      set orde to tag t1
    endif

    do case
    case (lastkey()=K_ESC)
      exit
    case (lastkey()=K_ENTER.and.przr=1)//.and.gnAdm=1
      prprv(2)
      prprv(1)
    endcase

  enddo

  keyboard ''
  return (.t.)

/************* */
static function dztv(p1)
  /************* */
  local lAccDeb

  if (.t.)                //gnEnt=20
    if (file(gcPath_ew+"deb\accord_deb"+".dbf"))
      netuse('dkkln')
      use (gcPath_ew+"deb\accord_deb") ALIAS skdoc NEW SHARED READONLY
      SET ORDER to TAG t1
      lAccDeb:=.T.
    endif

    skdoc->(dbseek(str(rs1->nkkl, 7)))

    sele skdoc
    index on ngp+nkta+DTOS(DtOpl) to tmpskdoc while rs1->nkkl=kpl
    DBGoTop()

    skdoc->(slcf('skdoc', 4, 1, MAXROW()-8,,             ;
                   "e:ngp h:'�����⥫�' c:c(23)"          ;
                   +" e:nkta h:'�����' c:c(5)"             ;
                   +" e:nnap h:'����' c:c(4)"              ;
                   +" e:ttn h:'���' c:n(6)"                ;
                   +" e:sdp h:'�㬬�����' c:n(8,2)"        ;
                   +" e:DtOpl h:'��⠎�����' c:d(8)"       ;
                   +" e:(DtOpl-date()) h:'�ப���' c:n(4)" ;
                   ,,,, 'rs1->nkkl=kpl',,, npl             ;
                )                                         ;
          )

    if (lAccDeb)
      close skdoc
    endif

  else
    if (p1=1)
      pathr=gcPath_ew+'deb\s361001\'
    else
      pathr=gcPath_ew+'deb\s361002\'
    endif

    if (file(pathr+'pdeb.dbf'))
      adirect=directory(pathr+'pdeb.dbf')
      dtcr=adirect[ 1, 3 ]
      tmcr=adirect[ 1, 4 ]
      sele 0
      use (pathr+'pdeb') shared
#ifdef nkklr
        locate for kkl=nkklr
#else
        locate for kkl=kplr
#endif
      if (foun())
        dzr=dz
        pdzr=pdz
        pdz1r=pdz1
        pdz3r=pdz3
        pdz4r=pdz4
        CLOSE
        cldzr=setcolor('gr+/b,n/bg')
        wdzr=wopen(8, 20, 17, 60)
        wbox(1)
        if (p1=1)
          @ 0, 1 say '361001'
        else
          @ 0, 1 say '361002'
        endif

        @ 1, 1 say '���'+' '+dtoc(dtcr)+' �६� '+tmcr color 'r+/b'
        @ 2, 1 say '��� ������    '+' '+str(dzr, 10, 2)
        @ 3, 1 say '��� ������ >7 '+' '+str(pdzr, 10, 2)
        @ 4, 1 say '��� ������ >14'+' '+str(pdz1r, 10, 2)
        @ 5, 1 say '��� ������ >21'+' '+str(pdz3r, 10, 2)
        @ 6, 1 say '��� ������ >30'+' '+str(pdz4r, 10, 2)
        inkey(0)
        wclose(wdzr)
        setcolor(cldzr)
      else
        sele pdeb
        CLOSE
      endif

    endif

  endif

RETURN (NIL)

/*************** */
function PrnPrRs()
  vzz=1
  lnn=48
  lstr=1
  rswr=1
  PrVzShap()
  sele pr2
  set orde to tag t3
  netseek('t3', 'mnr')
  kolpos_r=0
  ssf10r=0
  ssf11r=0
  ssf90r=0
  svesr=0
  while (mn=mnr)
    ktlr=ktl
    ktlpr=ktlp
    pptr=ppt
    mntovr=mntov
    kfr=kf
    zenr=ozen
    optr=zen
    sfr=roun(zenr*kfr, 2)
    ssf10r=ssf10r+sfr
    sele ctov
    netseek('t1', 'mntovr')
    nat_r=alltrim(nat)
    neir=nei
    sele tov
    netseek('t1', 'sklr,ktlr')
    k1tr=k1t
    vespr=vesp
    upakr=upak
    vesr=ves
    lnat_r=len(nat_r)
    if (lnat_r<lnn)       //50
      nat_r=nat_r+space(lnn-lnat_r)
      svesr=svesr+ROUND(kfr*vesr, 3)
      ?str(ktlr, 9)+' '+nat_r+' '+subs(neir, 1, 4)+' '+str(kfr, 10, 3)+' '+str(zenr, 9, 3)+' '+iif(sfr<10000000, str(sfr, 9, 2), str(sfr, 12, 2))
      kolpos_r=kolpos_r+1
      RsVzE()
    else
      store '' to xxx, yyy
      for i=lnat_r to 1 step -1
        yyy=right(nat_r, lnat_r-i)
        xxx=subs(nat_r, 1, i)
        if (i<lnn.and.subs(nat_r, i, 1)=' ')
          exit
        endif

      next

      if (len(xxx)<lnn)
        xxx=xxx+space(lnn-len(xxx))
      endif

      ?str(ktlr, 9)+' '+xxx+' '+subs(neir, 1, 4)+' '+str(kfr, 10, 3)+' '+str(zenr, 9, 3)+' '+iif(sfr<10000000, str(sfr, 9, 2), str(sfr, 12, 2))
      kolpos_r=kolpos_r+1
      RsVzE()
      ?space(9)+' '+yyy
      RsVzE()
    endif

    sele pr2
    skip
  enddo

  if (ttnvzr#0)
    ssf90r=ssf10r*(100+gnNds)/100
    ssf11r=ssf90r-ssf10r
  else
    ssf90r=ssf10r
    ssf11r=0
  endif

  nszr=getfield('t1', '10', 'dclr', 'nz')
  ?space(51)+str(10, 2)+'-'+nszr+':'+' '+str(0, 5, 2)+space(3)+iif(ssf10r<10000000, str(ssf10r, 10, 2), str(ss10r, 12, 2))
  RsVzE()
  if (ttnvzr#0)
    nszr=getfield('t1', '11', 'dclr', 'nz')
    ?space(51)+str(11, 2)+'-'+nszr+':'+' '+str(0, 5, 2)+space(3)+iif(ssf11r<10000000, str(ssf11r, 10, 2), str(ss11r, 12, 2))
    RsVzE()
  endif

  /*nszr=getfield('t1','90','dclr','nz')
   *?space(51)+str(90,2)+'-'+nszr+':'+' '+str(0,5,2)+space(3)+iif(ssf90r<10000000,str(ssf90r,10,2),str(ss90r,12,2))
   *RsVzE()
   */

  ?'����権 '+'     '+str(kolpos_r, 3)+space(35)+'�⮣� �� ���㬥���  '+space(8)+str(ssf90r, 15, 2)//+' ��.'
  RsVzE()
  for i=1 to 43-rswr-6
    ?''
  endfor

  ?'���� ���⢥न�     ___________       '+'           �.'+ '          ������  ___________ '
  ?'��� � ��ॢ���� �ਭ�  ___________                           ��� ����稫 ____________'
  ?repl('-', 94)
  eject
  return (.t.)

/*************** */
function PrVzShap()
  /*************** */
  kbr=getfield('t1', 'kpsr', 'kln', 'kb1')
  rschr=getfield('t1', 'kpsr', 'kln', 'ns1')
  kkl1r=getfield('t1', 'kpsr', 'kln', 'kkl1')
  nklr=getfield('t1', 'kpsr', 'kln', 'nkl')
  adrr=alltrim(getfield('t1', 'kpsr', 'kln', 'adr'))

  kzg_kbr=getfield('t1', 'kzgr', 'kln', 'kb1')
  kzg_rschr=getfield('t1', 'kzgr', 'kln', 'ns1')
  kzg_kkl1r=getfield('t1', 'kzgr', 'kln', 'kkl1')
  kzg_nklr=getfield('t1', 'kzgr', 'kln', 'nkl')
  kzg_adrr=alltrim(getfield('t1', 'kzgr', 'kln', 'adr'))

  ?'�����-�࠭ᯮ�⭠� ��������� N '+str(mnr, 6); RsVzE()

  aaa=allt('���⠢騪: '+str(kpsr, 7)+' '+alltrim(nklr)+' '+str(kkl1r, 10)+' '+adrr)
  if (len(aaa)<80)
    ?aaa; RsVzE()
  else
    ?subs(aaa, 1, 79); RsVzE(); ?subs(aaa, 80); RsVzE()
  endif

  if (!empty(kbr))
    ?alltrim(getfield('t1', 'kbr', 'banks', 'otb'))+' ��� '+alltrim(kbr)+' �/� '+alltrim(rschr)
    RsVzE()
  endif

  aaa:=allt('���� ���㧪�: '+str(kzgr, 7)+' '+alltrim(kzg_nklr)+' '+str(kzg_kkl1r, 10)+' '+kzg_adrr)
  if (len(aaa)<80)
    ?aaa; RsVzE()
  else
    ?subs(aaa, 1, 79); RsVzE(); ?subs(aaa, 80); RsVzE()
  endif

  ?; RsVzE()

  RsVzE()
  aaa='���⥫�騪: '+alltrim(gcName_c)+' ���  '+str(gnKln_c, 8)+' ⥫ '+alltrim(getfield('t1', 'gnKkl_c', 'kln', 'tlf'))+' '+alltrim(getfield('t1', 'gnKkl_c', 'kln', 'adr'))
  if (len(aaa)<80)
    ?aaa
    RsVzE()
  else
    ?subs(aaa, 1, 79)
    RsVzE()
    ?subs(aaa, 80)
    RsVzE()
  endif

  ?alltrim(gcOb1_c)+' ���-'+Right(gnKb1_c, 6)+' �/�-'+gcNs1_c//+' �/� ��� -'+gcNs1nds_c
  RsVzE()
  ?'�����⥫�: �� ��'
  RsVzE()
  ?'��� ���p�樨 - '+str(kopr, 3)+' '+nopr
  RsVzE()
  ?'������� '+str(mrshr, 6)+'       '+'                                                                   ���� '+str(lstr, 1)
  RsVzE()
  ?repl('-', 94)
  RsVzE()
  ?'| ���  |                 ������������                     |����|    �����᪨ ���饭�      |'
  RsVzE()
  ?'|      |                                                  |����|-----------------------------|'
  RsVzE()
  ?'| �.�  |                                                  |��.�| � - ��  |  ����   |  �㬬�  |'
  RsVzE()
  ?repl('-', 94)
  RsVzE()
  return (.t.)

/************* */
function RsVzE(p1)
  /************* */
  rswr++
  rsw_r=42
  if (rswr>=rsw_r)
    rswr=1
    lstr++
    eject
    if (p1=nil)
      PrVzShap()
    endif

  endif

  return (.t.)

/*********************************************
// ������� �� �⬥祭��� (pr177) ����� ���
  */
function ttn177(aTypeUc)
  sele rs1
  set filt to
  go top
  prttn177r=0
  while (!eof())
    if (pr177#1)
      skip
      loop
    endif

    if (kop#177)
      skip
      loop
    endif

    if (ttn177#0)
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
      prttn177r=1
      exit
    endif

    sele rs1
    skip
  enddo

  if (prttn177r=0)
    wmess('��� ��� ��� ��ꥤ������,3')
    return (.t.)
  endif

  sele cskl
  netseek('t1', 'gnSk',,, 1)//  locate for sk=gnSk
  NextNumTtn('ttn177r')

  /*
  sele cskl
  locate for sk=gnSk
  if (foun())
    reclock()
    ttn177r=ttn
    if (ttn177r=999999)
      ttn177r=1
    endif

    sele rs1
    set filt to
    while (.t.)
      if (!netseek('t1', 'ttn177r'))
        exit
      endif

      ttn177r=ttn177r+1
      if (ttn177r=999999)
        ttn177r=1
      endif

    enddo
  else
    return
  endif
    */

  sele rs1
  locate for pr177=1.and.kop=177
  if (foun())
    arec:={}
    getrec()
    netadd()
    putrec()
    DocGuidr=''
    netrepl("ttn,kop,kopi,kpl,nkkl,kgp,kpv,ttn177,pr177,prz,vo,DocGuid,kto,ddc,tdc,dfp,dop,dvp",                    ;
              {ttn177r,169,169,20034,20034,20034,20034,0,2,0,9,DocGuidr,gnKto,date(),time(),ctod(''),ctod(''),date()} ;
           )

      netrepl('RndSdv',{;
      getfield('t1', '0,gnVu,9,169-100';
      , Iif(!Empty(select("soper")),'soper','soper_uc');
      , 'RndSdv');
      },1)
      If Empty(RndSdv)
        outlog(__FILE__,__LINE__,'0,gnVu,gnVo,169-100',0,gnVu,gnVo,169-100)
        outlog(__FILE__,__LINE__,'select("soper")',Iif(!Empty(select("soper")),'soper','soper_uc'))
      EndIf

    if (gnEnt=20)
      if (gnEntRm=0)
        netrepl('kta,ktas,kgp,kpv', {51,51,22012,22012})
      else
        netrepl('kta,ktas,kgp,kpv', {51,51,22044,22044})
      endif

    endif

    netrepl('dtmod,tmmod', {date(),time()})
    if (fieldpos('mntov177')#0)
      MnTov177r:=mntov177r(gnEnt,rs1->(mk169 +  mk129 + mk139))
      Prc177r:=getfield('t1', 'mntov177r', 'ctov', 'cenpr')
      netrepl('mntov177,prc177', {mntov177r,Prc177r})
    endif

    dir_r=gcPath_m177+subs(gcDir_t, 1, len(gcDir_t)-1)
    if (dirchange(dir_r)#0)
      dirmake(dir_r)
    endif
    dirchange(gcPath_l)

    dir_r=gcPath_m177+gcDir_t+'t'+alltrim(str(ttn177r))
    if (dirchange(dir_r)#0)
      dirmake(dir_r)
    endif
    dirchange(gcPath_l)

    pathttn177r=gcPath_m177+gcDir_t+'t'+alltrim(str(ttn177r))+'\'
    pathr=pathttn177r
    if (!netfile('rs1', 1))
      copy file (gcPath_a+'rs1.dbf') to (pathttn177r+'trsho14.dbf')
      lindx('trsho14', 'rs1', 1)
    endif

    if (!netfile('rs2', 1))
      copy file (gcPath_a+'rs2.dbf') to (pathttn177r+'trsho15.dbf')
      lindx('trsho15', 'rs2', 1)
    endif

    netuse('rs1', 'rs1177',, 1)
    netuse('rs2', 'rs2177',, 1)
    sele rs1
    set filt to
    go top
    while (!eof())
      if (pr177#1)
        skip
        loop
      endif

      if (kop#177)
        skip
        loop
      endif

      if (ttn177#0)
        skip
        loop
      endif

      ttn_r=ttn
      sklr=skl

      sele rs2
      if (netseek('t1', 'ttn_r'))
        sele rs1
        reclock()
        arec:={}
        getrec()
        sele rs1177
        netadd()
        putrec()
        sele rs2
        while (ttn=ttn_r)
          rc177r=recn()
          ktlr=ktl
          kvpr=kvp
          arec:={}
          getrec()
          sele rs2177
          netadd()
          putrec()
          sele rs2
          if (!netseek('t1', 'ttn177r,ktlr'))
            netadd()
            putrec()
            netrepl('ttn', {ttn177r})
          else
            netrepl('kvp', {kvp+kvpr})
          endif

          //netrepl('zen', {0.01})
          //!! - ���� 業�
          TtnUcCalcZen(aTypeUc, ktlr)


          sele rs2
          go rc177r
          netdel()
          skip
        enddo

      endif

      sele rs1
      netrepl('ttn177', {ttn177r})
      skip
    enddo

    sele rs2
    rznst2r=0
    rc_r=0
    if (netseek('t1', 'ttn177r'))
      mkeep_r=102 // � �� ��।����
      // ���४�� �-�� � 業�
      Zen4KolUc(ttn177r,aTypeUc)

    endif

    nuse('rs1177')
    nuse('rs2177')
  endif


  return (.t.)

/************** */
function prn11tn()
  /************** */
  svczr:=0

  if (!ChkPrn11tn())
    return (.F.)
  endif
  adrnvr=gcAdr_c
  if (gnRmsk#0)
    if (gnEnt=21)
      do case
      case (gnRmsk=4)
        knvr=9000000
      endcase

    endif

    if (gnEnt=20)
      do case
      case (gnRmsk=3)
        knvr=8000000
      case (gnRmsk=4)
        knvr=9000000
      case (gnRmsk=5)
        knvr=7000000
      endcase

    endif

    adrnvr=getfield('t1', 'knvr', 'kln', 'adr')
  endif

  nAtvoKklr=''
  AtvoKkl1r=0
  AtvoKklr=0
  svczr=0
  if (mrshr#0) // ���� �������
    sele cmrsh
    if (netseek('t2', 'mrshr'))
      dfior=alltrim(dfio)
      KATranr=KATran
      vsvbr=vsvb
      kecsr=kecs
      svczr=0
      if (fieldpos('svcz')#0)
        svczr=svcz
      endif

      if (gnEnt=20.and.(kopr=169.or.gnEntRm=1.and.svczr=0))
        dfior=''
        AtNomr=''
        vsvbr=0
        anomr=''
        AtvoKklr=0
        nAtvoKklr=''
        AtvoKkl1r=0
        mrshr=0
        necsr=''
      else
        if (KATranr#0)
          sele kln
          if (netseek('t1', 'KATranr'))
            natranr=alltrim(nkl)
            dfior=alltrim(adr)
            anomr=alltrim(nkls)
            AtNomr=natranr+' '+anomr
            AtvoKklr=kklp
            nAtvoKklr=''
            AtvoKkl1r=0
          else
            dfior=''
            AtNomr=''
            vsvbr=0
            anomr=''
            AtvoKklr=0
            nAtvoKklr=''
            AtvoKkl1r=0
          endif

        endif

      endif

    else
      dfior=''
      AtNomr=''
      vsvbr=0
      anomr=''
      AtvoKklr=0
      nAtvoKklr=''
      AtvoKkl1r=0
    endif

  else                      // ��� �������
    if (gnArnd#0)         //  �� ��� ᫠�� - �ࢠ��
      kecsr=rs1->kecs
      if (KATranr=0)
        dfior=''
        AtNomr=rs1->AtNom
        vsvbr=0
        anomr=''
        AtvoKklr=0
        nAtvoKklr=''
        AtvoKkl1r=0
      else // ��� ᪫��
        sele kln
        if (netseek('t1', 'KATranr'))
          natranr=alltrim(nkl)
          dfior=alltrim(adr)
          anomr=alltrim(nkls)
          AtNomr=natranr+' '+anomr
          AtvoKklr=kklp
          nAtvoKklr=''
          AtvoKkl1r=0
        else
          dfior=''
          AtNomr=''
          vsvbr=0
          anomr=''
          AtvoKklr=0
          nAtvoKklr=''
          AtvoKkl1r=0
        endif

      endif

    else                    //  gnArnd=0 - ��� ᪫���
      if (kopr=154 ;       // ������ ���⠢騪�
          .or. iif(gnEnt=21, (kopr=160 .and. pSTr=1), .f.); // �த��� �/�
          )

        kecsr=0
        dfior=vodr
        AtNomr=Iif(kopr=154                                                            ;
                    .or. iif(gnEnt=21, (kopr=160 .and. pSTr=1), .f.), Avtor, AtNomr ;
                 )
        vsvbr=0
        anomr=''
        AtvoKklr=0
        nAtvoKklr=prvzr
        AtvoKkl1r=0
      else
        kecsr=0
        dfior=''
        AtNomr=''
        vsvbr=0
        anomr=''
        AtvoKklr=0
        nAtvoKklr=''
        AtvoKkl1r=0
      // outlog(__FILE__,__LINE__,AtNomr)
      endif

    endif

  endif

  necsr=''
  if (kecsr#0)
    necsr=getfield('t1', 'kecsr', 's_tag', 'fio')
  endif

  if (!Empty(AtvoKklr)) // ��।���� �⮬����� �१ ���
    nAtvoKklr=alltrim(getfield('t1', 'AtvoKklr', 'kln', 'nkl'))
    AtvoKkl1r=getfield('t1', 'AtvoKklr', 'kln', 'kkl1')
  endif

  if (kopr#154)
    do case
    case (iif(gnEnt=21, (kopr=160 .and. pSTr=1), .f.))
    // �� ���塞 ��祣�
    case (!(gnEnt=20.and.(kopr=169.or.gnEntRm=1.and.svczr=0)))
    endcase

  endif

  kmestr=0
  sele rs2
  if (netseek('t1', 'ttnr'))
    while (ttn=ttnr)
      mntovr=mntov
      kvpr=kvp
      //      upakr=getfield('t1','mntovr','ctov','upak')
      //      kmestr=kmestr+int(kvpr/upakr)
      kmestr=kmestr+kvpr
      skip
    enddo

  endif

  // outlog(__FILE__,__LINE__,ttnr,AtNomr,dopr,'ttnr,AtNomr,dopr')
  if (Empty(AtNomr))
    outlog(__FILE__,__LINE__,'*Prn11tn')
    return (.t.)
  endif

  ??chr(27)+'E'+chr(27)+'&l1h25a1O'+chr(27)+'&l3C'+chr(27)+'(3R'+chr(27)+'(s0p19.00h0s1b4102T'+chr(27)
  ??space(78)+'����⮪ 7'
  ?''
  ?space(78)+'�� �ࠢ�� ��ॢ����� ���⠦i� ��⮬��i�쭨� �࠭ᯮ�⮬ � �����i'
  ?''
  ?space(78)+'��ଠ N 1-��'
  ?''
  ?''
  ?space(43)+'������ - ����������� �������� '
  ?''
  if (gnEnt=20)
    if (rs1->prz=0)
      ?space(42)+' N '+str(ttnr, 6)+' �i� '+dtous(dopr)
    else
      ?space(42)+' N '+str(ttnr, 6)+' �i� '+dtous(dotr)
    endif

  else
    ?space(42)+' N '+str(ttnr, 6)+' �i� '+dtous(dopr)
  endif

  ?''
  ?''
  ?'��⮬��i�� '+padc(AtNomr, 20)+' '+'���i�/��������i�'+space(55)+' '+'��� ��ॢ�����'+' '+'�� �i�����஢�� ��䮬'
  ?''
  if (empty(nAtvoKklr))
    ?'��⮬��i�쭨� ��ॢi���� '+padr(gcName_c, 37)+space(43)+'���i� '+alltrim(dfior)
  else
    ?'��⮬��i�쭨� ��ॢi���� '+padr(nAtvoKklr, 37)+space(43)+'���i� '+alltrim(dfior)
  endif

  ?''
  ?'�������� '+padr(gcName_c, 107)
  ?''
  ?'���⠦��i��ࠢ��� '+alltrim(getfield('t1', 'gnKkl_c', 'kln', 'nklprn'))+' '+alltrim(getfield('t1', 'gnKkl_c', 'kln', 'adr'))
  ?''
  ?'���⠦�����㢠� '+alltrim(getfield('t1', 'kplr', 'kln', 'nklprn'))+' '+alltrim(getfield('t1', 'kplr', 'kln', 'adr'))
  ?''
  knaspr=getfield('t1', 'kgpr', 'kln', 'knasp')
  nnaspr=getfield('t1', 'knaspr', 'knasp', 'nnasp')
  ?'�㭪� �����⠦���� '+padr(adrnvr, 60)+space(2)+'�㭪� ஧���⠦���� '+' '+alltrim(nnaspr)+' '+padr(getfield('t1', 'kgpr', 'kln', 'adr'), 60)
  ?''
  ?'��ॠ���㢠��� ���⠦�'
  ?''
  ?'�i���� �� ���i७i��� ���⠦�����㢠�: ��i�_________________N____________�i�_"______"___________________20____�.,�������_______________________'
  ?''
  ?'���⠦ ������� ��� ��ॢ������ � �⠭i,� ������i��� �ࠢ���� ��ॢ����� �i����i���� ���⠦i�, ����� ������(�� �����i)__________________________'
  ?''
  ?'�i��i��� �i��� '+numstr(kmestr, 1)+' ,���� ����,�� '+numstr(roun(vsvr, 0), 1)+',��ਬ�� ��ᯥ���� '+padr(necsr, 15)+'______________'
  ?''
  buhr=repl('_', 40-12)
  do case
  case (gnEnt=20.and.gnSk=228)
    komir=subs(getfield('t1', '60', 'speng', 'fio'), 1, 15)
  case (gnEnt=20.and.gnSk=400)
    komir=subs(getfield('t1', '415', 'speng', 'fio'), 1, 15)
  case (gnEnt=21.and.gnSk=232)
    komir=subs(getfield('t1', '204', 'speng', 'fio'), 1, 15)
  case (gnEnt=21.and.gnSk=700)
    komir=subs(getfield('t1', '946', 'speng', 'fio'), 1, 15)
  otherwise
    komir=space(15)
  endcase

  //?'��壠���(�� �ᮡ� ���⠦��i��ࠢ����) '+buhr+'�i���� �������� ���i୨� '+komir+'________________'
  ?'�������� �� ���i���i(�i����i���쭠 �ᮡ� ���⠦��i��ࠢ����) '+buhr+'�i���� �������� ���i୨� '+komir+'________________'
  ?''
  s11r=getfield('t1', 'ttnr,11', 'rs3', 'ssf')
  ?'��쮣� �i���饭� �� ������� ��� '+padr(numstr(sdvr), 55)+',� �.�.��� '+str(s11r, 10, 2)+' ��'
  ?''
  ?'��஢i��i ���㬥�� �� ���⠦ '+'��� N '+str(ttnr, 6)
  ?''
  ?'�࠭ᯮ��i ���㣨, �i ��������� ��⮬��i�쭨� ��ॢi������'+repl('_', 86)
  ?''
  ?space(53)+'�I������I ��� ������'
  ?''
  /*?'�������������������������������������������������������������������������������������������������������������������������������������������������' */
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ŀ'
  ?'� N �     ������㢠��� ���⠦�(�����       �������ﳊi��i��쳖i�� ��� ��� ��������쭠 �㬠 ��   ���    ����㬥�� � ���⠦���  ���  �'
  ?'��/��    ���⥩���),� ࠧi ��ॢ������    �       �         �               �               �          �                    �        �'
  ?'�   ��������筨� ���⠦i�: ���� �������筨� ���i��  �����  ��������,��    �    ���,��    ����㢠��� �                    ������,�'
  ?'�   ��箢��,�� 类�� �i���ᥭ� ���⠦     �       �         �               �               �          �                    �        �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'� 1 �                  2                   �   3   �    4    �        5      �        6      �    7     �          8         �    9   �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�   ��i����i��� �.11.7 �ࠢ�� ��ॢ������ ���⠦i� ��⮬��i�쭨� �࠭ᯮ�⮬, � ⮢�୨� ஧�i� �������� ����⪮��� ���������N'+str(ttnr, 6)+' �'
  ?'�   ���� 类�� ���� ⮢��-�࠭ᯮ�⭠ �������� ���������� ���i�᭮�         �               �          �                    �        �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�                  ��쮣�                  �       �         �               �               �          �                    �        �'
  ?'���������������������������������������������������������������������������������������������������������������������������������������'
  ?''
  ?'���� (�i����i���쭠 �ᮡ� ���⠦��i��ࠢ����)'+space(5)+'�਩�� ��ᯥ����'+space(5)+'���� ��ᯥ����     '+space(5)+'�਩�� (�i����i���쭠 �ᮡ� ���⠦�����㢠�)'
  ?''
  ?''
  ?'���i୨� '+komir+'_____________________'+space(2)+padr(necsr, 15)+'_________'+space(2)+padr(necsr, 15)+'_____________'+space(2)+repl('_', 45)
  ?''
  ?''
  ?space(51)+'���i� '+padr(dfior, 15)+'___________________________'
  ?''
  ?space(48)+'��������-���������������I ������I�'
  ?''
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ŀ'
  ?'�         �����i�            �      ��� ����, �       �                        ���(���.,�.)                 ��i���� �i����i���쭮��'
  ?'�                             �                          ������������������������������������������������������Ĵ       �ᮡ�         �'
  ?'�                             �                          �     �ਡ����     �     �������     �      �����    �                     �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�            10               �             11           �        12        �        13       �        14       �          15         �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'������⠦����                 �'+padr(str(roun(vsvr, 0)/1000, 15, 3), 26)+'�     8-00         �     8-20        �      0-20       �                     �'
  ?'�������������������������������������������������������������������������������������������������������������������������������������Ĵ'
  ?'�������⠦����                �'+padr(str(roun(vsvr, 0)/1000, 15, 3), 26)+'�                  �                 �                 �                     �'
  ?'���������������������������������������������������������������������������������������������������������������������������������������'
  eject

  return (.t.)

/************* */
function PrnPrc()
  /************* */
  ??setprnr

  ?'�ࠩ� '+subs(str(ttnr, 6), 4, 3)
  ?''
  ?''
  sele prs2
  go top
  while (!eof())
    ?nat+' '+str(zenp, 10, 3)
    sele prs2
    skip
  enddo

  eject
  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  09-12-16 * 11:21:23am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
function prz()
  cOut:=REPLICATE('_', 4)
  // �������
  cOut:=STUFF(cOut, 1, 1, iif(empty(rs1->ztxt), ' ', 'z'))
  // �������
  cOut:=STUFF(cOut, 2, 1, iif(dog(rs1->nkkl, rs1->Kop), ' ', 'd'))
  // GPS - �-��
  cOut:=STUFF(cOut, 3, 1, IIF(Ttn = DocId .and. EMPTY(VAL(GpsLat)), ' ', '~'))
  //�����
  cOut:=STUFF(cOut, 4, 1, IIF('���' $ lower(npv), '@', ' '))

  /*
  LOCAL nRet:=_FIELD->prz
  DO CASE
  CASE Ttn = DocId
    nRet:=IIF(EMPTY(VAL(GpsLat)),0,1)
  OTHERWISE
    nRet:=1
  ENDCASE
  */
  //TRANSFORM(
  //,'@Z 9')
  return (cOut)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  11-09-17 * 12:11:45pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
function ChkPrn11tn(lvzz)
  DEFAULT lvzz to .T.       // �஢�����
                             //outlog(__FILE__,__LINE__,procname(1),procline(1))
  if (gnKto=934)
    outlog(3,__FILE__,__LINE__,'gnKto=934')
    return (.f.)
  endif

  if (lvzz)
    if (!(vzz=1.or.vzz=4))
      outlog(3,__FILE__,__LINE__,'lvzz & !(vzz=1.or.vzz=4)')
      return (.F.)
    endif

  endif

  if (kplr=20034)
    outlog(3,__FILE__,__LINE__,'kplr=20034')
    return (.F.)
  endif

  if (!(str(kopr, 3)$'160;161;183;193;188;'.or.(kopr=154.and.vor=1)))
    outlog(3,__FILE__,__LINE__,!(str(kopr, 3)$'160;161;183;193;188;'.or.(kopr=154.and.vor=1)))
    return (.f.)
  endif

  // outlog(__FILE__,__LINE__,ttnr,AtNomr,dopr,iif(TYPE('lPrn11tn')='U','U->.F.',lPrn11tn),'ttnr,AtNomr,dopr,lPrn11tn')

  if (lvzz)               // �஢�����
    if (!empty(dopr))   // ���㦥�
      if (TYPE('lPrn11tn')='U')
        outlog(3,__FILE__,__LINE__,"!empty(dopr) lPrn11tn')='U'")
        return (.f.)
      elseif (lPrn11tn)
      // �த����� �����
      else
        outlog(3,__FILE__,__LINE__,'!lPrn11tn')
        return (.f.)
      endif

    endif

  endif

  if (mrshr#0.and.gnEnt=20.and.gnEntRm=1)
    sele cmrsh
    svczr=0
    if (fieldpos('svcz')#0)
      svczr=getfield('t2', 'mrshr', 'cmrsh', 'svcz')
    endif

    if (svczr=0)
      outlog(3,__FILE__,__LINE__,'svczr=0')
      return (.F.)
    endif

  endif

  // ����� ��設�
  if (TYPE('AtNomr')='U')
    AtNomr=space(10)
  endif

  // ���஡㥬 ���⠭�����
  if (Empty(AtNomr))
    if (mrshr#0)
      sele cmrsh
      if (netseek('t2', 'mrshr'))
        KATranr=KATran
        svczr=0
        if (fieldpos('svcz')#0)
          svczr=svcz
        endif

        if (gnEnt=20.and.(kopr=169.or.gnEntRm=1.and.svczr=0))
          AtNomr=space(10)
        else
          if (KATranr#0)
            sele kln
            if (netseek('t1', 'KATranr'))
              natranr=allt(nkl)
              anomr=allt(nkls)
              AtNomr=natranr+' '+anomr
            else
              AtNomr=space(10)
            endif

          endif

        endif

      else
        AtNomr=space(10)
      endif

    else                    // ��� ����
      if (gnArnd#0)
        kecsr=rs1->kecs
        if (KATranr=0)
          AtNomr=rs1->AtNom
        else
          sele kln
          if (netseek('t1', 'KATranr'))
            AtNomr=natranr+' '+anomr
          else
            AtNomr=space(10)
          endif

        endif

      else               // ��� ᪫���
        if (kopr=154)  // ������ ���⠢騪�
                         // .or. (kopr=160 .and. pSTr=1)) �த��� �/�
          AtNomr=Iif(kopr=154, Avtor, AtNomr)
        else
          AtNomr=space(10)
        endif

      endif

    endif

  endif

  if (Empty(AtNomr))
    outlog(3,__FILE__,__LINE__,'Empty(AtNomr)')
    return (.F.)
  endif

  outlog(3, __FILE__, __LINE__, "����� ����� 1��")
  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  03-03-20 * 10:58:38am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION pr177()
  if (select('ttrs2')=0)
    crtt('ttrs2', 'f:ktl c:n(9) f:kvp c:n(12,3)')
    sele 0
    use ttrs2
  endif

  sele rs1
  if (fieldpos('pr177')#0)
    if (pr177=0)
      netrepl('pr177', '1')
      sele rs2
      if (netseek('t1', 'ttnr'))
        while (ttn=ttnr)
          ktlr=ktl
          kvpr=kvp
          sele ttrs2
          locate for ktl=ktlr
          if (!foun())
            netadd()
            netrepl('ktl', 'ktlr')
          endif

          netrepl('kvp', 'kvp+kvpr')
          sele rs2
          skip
        enddo

        //                    coun to a while ttn=ttnr
      //                    kol177r=kol177r+a
      endif

    else
      netrepl('pr177', '0')
      sele rs2
      if (netseek('t1', 'ttnr'))
        while (ttn=ttnr)
          ktlr=ktl
          kvpr=kvp
          sele ttrs2
          locate for ktl=ktlr
          if (!foun())
            netadd()
            netrepl('ktl', 'ktlr')
          endif

          netrepl('kvp', 'kvp-kvpr')
          sele rs2
          skip
        enddo

        //                    coun to a while ttn=ttnr
      //                    kol177r=kol177r-a
      endif

    endif

    sele ttrs2
    go top
    coun to kol177r for kvp#0
    @ 23, 70 say str(kol177r, 9)
    sele rs1
    netrepl('dtmod,tmmod', 'date(),time()')
  endif
  RETURN ( NIL )

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  08-13-18 * 01:10:11pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
function TypeUc()
  local scdt_r, wdt_r
  local nPercent:=1.5

  local aTypeUc:=nil
  local aqstr:=1
  local aqst:={ '�⬥��', "�������", "��業�" }

  aqstr:=alert(" ", aqst)
  do case
  case (aqstr = 2)
    aTypeUc:={ 2, 0.01, nil, nil }
  case (aqstr = 3)

    scdt_r=setcolor('gr+/b,n/w')
    wdt_r=wopen(8, 20, 13, 60)
    wbox(1)
    @ 0, 1 say '��業�  ' get nPercent picture '@K 99.99' ;
     valid nPercent >= 0.5 .and. nPercent < 99.9
    read
    wclose(wdt_r)
    setcolor(scdt_r)
    if (lastkey()=K_ESC)
    //retu
    else
      aTypeUc:={ 3, nil, nPercent, nPercent }
    //aTypeUc:={2,0.01, NIL}
    endif

  endcase

  outlog(__FILE__, __LINE__, aTypeUc)
  return (aTypeUc)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  04-29-20 * 04:38:47pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION TtnUcCalcZen(aTypeUc)
  //!! - ���� 業� nZenNew
  // ����� ������� optr
  do case
  case (aTypeUc[1] = 2)
    nZenNew:=0.01
    netrepl('zen', {nZenNew})
  case (aTypeUc[1] = 3)
    // (100 + %)/100

    nPrcntAktsiz:=aTypeUc[ 3 ]
    nPrcnt:=aTypeUc[ 4 ]

    optr=getfield('t1', 'sklr,ktlr', 'tov', 'opt')

    IndLOptr=0
    IndLRozr=0
    IndLOpt_Roz(@IndLOptr, @IndLRozr)
    if (IndLOptr # 0)

      if (IndLOptr <= optr)
        nZenNew:= optr
      else
        nZenNew:= IndLOptr
      endif

    else
      // ��樧
      kg_r:=int(ktlr/1000000)
      if !empty(getfield('t1','kg_r','cgrp','nal'))
        nPrcnt := nPrcntAktsiz
      endif
      // ��� + %
      nZenNew:=Round(optr * Round((100 + nPrcnt)/100, 3), 2)

    endif
    if (nZenNew <= Zen)
      If nZenNew = 0
        outlog(__FILE__,__LINE__,'<= sklr,ktlr,mntovr,nZenNew, Zen,optr,nPrcnt')
        outlog(__FILE__,__LINE__,sklr,ktlr,mntovr,nZenNew, Zen,optr,nPrcnt)
      else
      EndIf
      netrepl('zen,MZen', { nZenNew, optr })
      netrepl('sf', { (nZenNew/optr-1)*100 })
    else
       outlog(__FILE__,__LINE__,'  > sklr,ktlr,mntovr,nZenNew, Zen,optr,nPrcnt')
       outlog(__FILE__,__LINE__,sklr,ktlr,mntovr,nZenNew, Zen,optr,nPrcnt)
    endif

  endcase
  RETURN ( NIL )
