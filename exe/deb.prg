#include "common.ch"
#include "inkey.ch"
#define DEB_CNT_DAY 90
#define DEB_KOP_TARA (str(_FIELD->kop,3) $ '170;105')
#define DEB_KOP_KASSA (str(_FIELD->kop,3) $ '169;161') // �� � �-�� �� ���
#define DEB_KPL 2531604

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  12-22-17 * 02:33:38pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
 //  FUNCTION deb(nA361, dtDeb)
  //RETURN (NIL)

PARAMETER nA361, dtDeb
local dtEnd, dtBeg

default nA361 to 361001, dtDeb to date()

dtBeg := dtDeb

// �����ઠ
if (gnArm#0)
  clea
endif

If BOM(gdTd) # BOM(dtBeg)
  outlog(__FILE__,__LINE__,"����� ���� ��ਮ�� BOM(gdTd)=BOM(dtBegr) ",BOM(gdTd),BOM(dtBeg))
  return
EndIf

PathDebr=gcPath_ew+'deb\'
dirdebr=gcPath_ew+'deb'

if (dirchange(dirdebr)#0)
  dirmake(dirdebr)
endif
dirchange(gcPath_l)

ddeb01r=PathDebr+'s'+str(nA361,6)
pdeb01r=ddeb01r+'\'
if (dirchange(ddeb01r)#0)
  dirmake(ddeb01r)
endif
dirchange(gcPath_l)


ddeb02r=PathDebr+'s'+str(nA361+1,6) // ddeb02r=PathDebr+'s361002'
pdeb02r=ddeb01r+'\'                 // pdeb02r=PathDebr+'s361002\'
if (dirchange(ddeb02r)#0)
  dirmake(ddeb02r)
endif
dirchange(gcPath_l)

dirchange(gcPath_l)
if (dirchange('idx')#0)
  dirmake('idx')
endif
dirchange(gcPath_l)


if (file(PathDebr+'deb.dbf'))
  dflr=filedate(PathDebr+'deb.dbf')
  tflr=filetime(PathDebr+'deb.dbf')
  prflr=1
else
  prflr=0
endif

if (prflr=1.and.gnArm#0)
  avyb:={ "�த������", "��������" }
  avybr:=alert(dtoc(dflr)+' '+tflr, avyb)
  if (lastkey()=27)
    return (.t.)
  endif

  if (avybr=1)
    set excl off
    set excl on
    nuse('tdop')
    nuse('kops')
    nuse('dz')
    nuse('kz')
    nuse('deb')
    nuse('bdoc')
    nuse('SkDoc')
    nuse()
    erase tdop.dbf
    erase kops.dbf
    erase dz.dbf
    erase dz.cdx
    erase kz.dbf
    erase kz.cdd
    return (.t.)
  endif

endif

If file('*.cdx')

EndIf

crtt('temp', 'f:kkl c:n(7) f:nkl c:c(30) f:pdz c:n(10,2) f:pdz1 c:n(10,2) f:pdz2 c:n(10,2) f:pdz3 c:n(10,2) f:dz c:n(10,2) f:kz c:n(10,2) f:ddk c:d(10) f:ddb c:d(10) f:bs_s c:n(10,2) f:bs_d c:n(3) f:sprz0 c:n(10,2) f:msk c:c(9)')
sele 0
use temp
copy stru to temp1 exte
CLOSE
erase temp.dbf

use temp1 new Exclusive
Fld_SdvDop(DEB_CNT_DAY+1) // ��� ����஫� ࠧ���� ����� DZ � ⮣�, �� ࠧ��ᥭ�

for i=1 to DEB_CNT_DAY
  Fld_SdvDop(i)
next i
close
create deb from temp1 new
close
erase temp1.dbf

sele 0
use deb excl
inde on str(kkl, 7) tag t1

//dtEnd := bom(addmonth(gdTd, -(ceiling(DEB_CNT_DAY / 30)))) // ctod(stuff(dtoc(addmonth(gdTd, -1)), 1, 2, '01'))
dtEnd := bom(dtBeg - DEB_CNT_DAY) //
// outlog(__FILE__,__LINE__,dt1r, dt2r,'dt1r, dt2r')
outlog(__FILE__,__LINE__,nA361,dtBeg, dtEnd,'nA361,dtBeg, dtEnd')

netuse('kln')
netuse('etm')
netuse('opfh')

netuse('cskl')
netuse('DkKln')
netuse('dknap')
netuse('dokk')
netuse('doks')
netuse('bs')
netuse('s_tag')

netuse('kpl')
netuse('kgp')
netuse('knasp')
netuse('krn')
netuse('kgpnet')
netuse('klndog')

netuse('stagtm')
netuse('edz')

iif(gnArm#0,qout('SkDoc'),'')

If nA361 < 631000
  RsDoc(@dtBeg,@dtEnd,nA361)
Else
  PrDoc(@dtBeg,@dtEnd,nA361)
  //quit
EndIf

iif(gnArm#0,qout('DZ'),'')

dz(dtBeg,dtEnd,nA361)

nuse('klndog')
nuse('tdop')
nuse('kops')
nuse('dz')
nuse('kz')
nuse('deb')
nuse('bdoc')
nuse('SkDoc')
/*
  erase tdop.dbf
  erase kops.dbf
  erase dz.dbf
  erase dz.cdx
  erase kz.dbf
  erase kz.cdd
*/
nuse()
If nA361 < 631000 .and. dtBeg = date()
  debn03(NIL,NIL)
  // debs()
endif
dirchange(gcPath_l)
return

/***********************************************************
 * rsdoc() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
static function RsDoc(dtBeg,dtEnd,nA361)
  local dtr
  local dt1r:= dtEnd
  local yy1r:=year(dt1r)
  local mm1r:=month(dt1r)

  local dt2r:=gdTd
  local yy2r:=year(dt2r)
  local mm2r:=month(dt2r)
  LOCAL aAliasDokk:={}, lSeekDokk, i, nSumOpl, nSumVz

  Crtt_SkDoc()
  Crtt_SkDoc('SkDoc126')
  Crtt_SkDoc('SkDocOpl')
  Crtt_SkDoc('SkDocVz')
  Crtt_SkDoc('SkDocVz0')

  use SkDoc126 new excl
  use SkDoc new excl
  // inde on str(kpl, 7)+dtos(dop) tag t1
  // �� ���쭥� �-�� � ������� �-�
  for y=yy1r to yy2r
    do case
    case (yy1r=yy2r)
      m1r=mm1r
      m2r=mm2r
    case (y=yy1r)
      m1r=mm1r
      m2r=12
    case (y=yy2r)
      m1r=1
      m2r=mm2r
    otherwise
      m1r=1
      m2r=12
    endcase

    for m=m1r to m2r
      pathdr=gcPath_e+'g'+str(y, 4)+'\m'+iif(m<10, '0'+str(m, 1), str(m, 2))+'\'
      // ����
      pathr=pathdr+'bank\'
      if !netfile('dokk',1)
          loop
      endif

      aadd(aAliasDokk,'dokk'+padl(ltrim(str(y,4)),4,'0')+padl(ltrim(str(m,2)),2,'0'))
      netuse('dokk',atail(aAliasDokk),,1)

      // ᪫���
      sele cskl
      go top
      while (!eof())
        if (!(rasc=1.and.ent=gnEnt))
          skip
          loop
        endif

        skr=sk
        pathr=pathdr+alltrim(path)
        if (!netfile('soper', 1))
          skip
          loop
        endif

        if (gnArm#0)
          ?pathr
        else
          outlog(3,__FILE__,__LINE__,pathr)
        endif

        netuse('soper',,, 1)
        DKops(nA361)
        netuse('pr1',,, 1)
        netuse('rs1',,, 1)

        If Empty(Select('prVz'))
          // �����㥬 ⠡����
          If file('prVz.dbf')
            filedelete('prVz.*')
          EndIf

          sele pr1
          copy stru to prVz
          use prVz new Exclusive

        EndIf

        sele rs1
        go top
        while (!eof())

          // ��� ��ࢮ�� ����� ��६ � ���㦥��� � �����থ���
          // ��� ᫥����� ⮫쪮 ���⢥ত����
          // .f. - ⮫쪮 ���⢥ত����

          if ((y=yy2r.and.m=m2r) .and. kop=126) // ����� �-��� � ���-126
            // ��६ � ࠡ���
          else // ��� �� ��ࢮ�� �����
            if (prz=0) // ⮫쪮 ���⢥ত���
              skip;       loop
            else // prz=1 ���⢥ত���
              If DEB_KOP_KASSA  // STR(kop,3) $ '161 169'
                skip;       loop
              EndIf
            endif
          endif

          if (empty(dop)) // �믨ᠭ�� �ய�᪠��
            skip;  loop
          endif

          if DEB_KOP_TARA // �� �ய�᪠��
            skip;  loop
          endif

          // ���㦥��� ⥪. ��ਮ��
          kopr=kop
          kplr=kpl
          kgpr=kpv
          dopr=dop
          Sdvr=Sdv
          przr=prz

          ktar=kta
          ktasr=ktas
          DtOplr=DtOpl
          nktar=getfield('t1', 'ktar', 's_tag', 'fio')

          ttnr=ttn
          nkklr=nkkl

          If kop=126 // ���㦥�
            sele SkDoc126
          Else
            sele kops
            locate for d0k1=0.and.kop=kopr
            if (!found())
              sele rs1
              skip; loop
            endif
            sele SkDoc

          EndIf

          sele SkDoc
          netadd()
          netrepl('ttn,kpl,kgp,dop,Sdv,prz,kta,ktas,sk,kop,nkkl,nkta,DtOpl,NPl',                           ;
                    { ttnr, kplr, kgpr, dopr, Sdvr, przr, ktar, ktasr, skr, kopr, nkklr, nktar, DtOplr, allt(str(Sdvr,9,2)) } ;
                 )

          sele rs1
          skip
        enddo

        sele pr1
        copy to ('tmpPV') ;//+padl(ltrim(str(m,2)),2,'0')) ;
          for kop=108 .and. prz=1 .and. skvz#0 .and. TtnVz#0 ;
            .and. SdvM # 0 // ����� ⮢��
        sele prVz
        append from ('tmpPV') //+padl(ltrim(str(m,2)),2,'0'))

        nuse('rs1')
        nuse('pr1')
        nuse('soper')
        sele cskl
        skip
      enddo

    next

  next



  sele SkDoc
  copy to (str(DEB_KPL)+'d') for kpl=DEB_KPL .and. !DEB_KOP_TARA

  sele prVz
  index on str(SkVz)+str(TtnVz) tag t1
  sele SkDoc
  DBGoTop()
  Do While !eof()
    If kpl=DEB_KPL
      outlog(3,__FILE__,__LINE__,;
        SkDoc->Sk, SkDoc->Ttn;
        , str(SkDoc->sdv,9,2);
        , 'SkDoc->Sk, SkDoc->Ttn, sdv')

    endif
    // �஢�ઠ �� ������ ���
    lSeekDokk:=.F.
    nSumOpl:=0
    For i:=1 To len(aAliasDokk)
      (aAliasDokk[i])->(OrdSetFocus('t9'))
      If ((aAliasDokk[i])->(netseek('t9','SkDoc->sk,SkDoc->ttn')))
        // �㬬� ����� �����

        sele (aAliasDokk[i])
        Do While (SkDoc->Sk=Sk .and. SkDoc->Ttn=DokkTtn)

          nSumOpl += bs_s

          If kkl=DEB_KPL
            outlog(3,__FILE__,__LINE__,;
              aAliasDokk[i], str(bs_s,9,2), ddk, nplp;
              ,'bs_s, ddk, nplp')

          endif

          sele (aAliasDokk[i])
          DBSkip()
        EndDo
        lSeekDokk:=.T.
        // exit
      EndIf
    Next

    sele SkDoc
    If kpl=DEB_KPL
            outlog(3,__FILE__,__LINE__,  nSumOpl, 'nSumOpl')
    endif


    // ����� � �������
    nSumVz:=0
    sele prVz
    DBSeek(str(SkDoc->Sk)+str(SkDoc->Ttn))
    Do While SkDoc->Sk=SkVz .and. SkDoc->Ttn=TtnVz
      nSumVz += SdvM
      DBSkip()
    EndDo
    If !Empty(nSumVz)
      lSeekDokk:=.t.
    EndIf

    sele SkDoc
    If kpl=DEB_KPL
            outlog(3,__FILE__,__LINE__,  nSumVz, 'nSumVz')
    endif

    // �஢�ઠ �� ������
    If lSeekDokk
      sele SkDoc
      If nSumOpl > SkDoc->sdv    // ᤥ���� ������ ����୮
        //nSumOpl := nSumOpl // �।�����
        nSumOpl := SkDoc->sdv // �।������ �� �ନ�㥬
      EndIf
      nSdp:=round(SkDoc->sdv - (nSumOpl + nSumVz),2)
      If nSdp < 0
          If kpl=DEB_KPL
            outlog(3,__FILE__,__LINE__,;
             SkDoc->Sk, SkDoc->Ttn;
             , str(SkDoc->sdv,9,2), str(nSumOpl,9,2),str(nSumVz,9,2);
             , str(SkDoc->sdv-nSumOpl-nSumVz,9,2);
             , 'SkDoc->Sk, SkDoc->Ttn, sdv, nSumOpl, nSumVz')
          endif
        // ������ �।�� �� ��㧮�����⥫�
        //nSumOpl := SkDoc->Sdv // nSdp
        nSumOpl += nSumVz // ���� ����⥫��
      else //
        nSumOpl += nSumVz
      EndIf
      //DBDelete()
      repl Sdv with Sdv - nSumOpl
    EndIf

    sele SkDoc
    DBSkip()
  EndDo

  // �����⨥  ⠡��� �஢����
  aeval(aAliasDokk,{|cAlias| nuse(cAlias) })
  close PrVz

  sele SkDoc
  copy to (str(DEB_KPL)+'c') for kpl=DEB_KPL .and. !DEB_KOP_TARA

  sele SkDoc
  copy to ('SkDocVz')  for Sdv < 0 // �।���
  copy to ('SkDocOpl') for Sdv = 0 // �ய��祭��
  copy to ('SkDoc4') for  Sdv > 0 .and. Sdv # val(NPl)  // ���筮 �ய��祭��

  sele SkDoc
  dele for Sdv < 0 ; // �।���
   .or. Sdv = 0 // �ய��祭��

  pack

  // �।��� ������� ��㧮�����⥫�
  sele SkDoc
  inde on str(kpl)+str(kgp)+dtos(dop) tag t3

  // ࠧ���� ������ (�����)
  use SkDocVz new Exclusive
  copy to SkDocVz0
  use SkDocVz0 new Exclusive

  sele SkDocVz
  inde on str(kpl, 7)+dtos(dop) tag t1
  set rela to recno() into SkDocVz0
  DBGoTop()
  // DBGoBottom();  skip
  Do While !eof()

    nSumVz:=abs(Sdv) // ��९��� �� ���㬥���

    If kpl=DEB_KPL
      outlog(3,__FILE__,__LINE__,str(SkDocVz->kpl)+'-'+str(SkDocVz->kgp))
      outlog(3,__FILE__,__LINE__,;
        SkDocVz->Sk, SkDocVz->Ttn, str(nSumVz,9,2);
        , 'SkDocVz->Sk, SkDocVz->Ttn, nSumVz')
    EndIf

    sele SkDoc
    if DBSeek(str(SkDocVz->kpl)+str(SkDocVz->kgp))
      Do While SkDoc->kpl = SkDocVz->kpl .and. SkDoc->kgp =  SkDocVz->kgp

        If round(Sdv,2)=0
          sele SkDoc;  DBSkip()
          loop
        EndIf
        If kpl=DEB_KPL
          outlog(3,__FILE__,__LINE__,'->', SkDoc->Sk, SkDoc->Ttn;
           , str(Sdv,9,2),str(nSumVz,9,2), str(sdv-nSumVz,9,2);
           , 'SkDoc->Sk, SkDoc->Ttn, Sdv, nSumVz')
        EndIf

        If Sdv >= nSumVz
          repl Sdv with Sdv - nSumVz
          nSumVz := 0
        Else // �㬬� ������ ����� �।��
          nSumVz -= Sdv
          repl Sdv with 0
        EndIf
        If kpl=DEB_KPL
          outlog(3,__FILE__,__LINE__,'--', SkDoc->Sk, SkDoc->Ttn;
           , str(Sdv,9,2),str(nSumVz,9,2), str(sdv-nSumVz,9,2);
           , 'SkDoc->Sk, SkDoc->Ttn, Sdv, nSumVz')
        EndIf
        If nSumVz = 0
          exit
        EndIf

        sele SkDoc; DBSkip()
      EndDo
    endif
    // �������� ���⮪ �����
    sele SkDocVz0
    repl Sdv with nSumVz * (-1)

    sele SkDocVz; DBSkip()
    If kpl=DEB_KPL
      outlog(3,__FILE__,__LINE__,;
        SkDocVz->Sk, SkDocVz->Ttn, str(nSumVz,9,2);
        , 'SkDocVz->Sk, SkDocVz->Ttn, nSumVz')
    EndIf
  EndDo

  sele SkDoc
  inde on str(kpl, 7)+dtos(dop) tag t1
  copy to (str(DEB_KPL)+'b') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  dele for Sdv = 0
  pack

  //quit
  sele SkDocVz0
  //copy to (str(DEB_KPL)+'`') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  repl all sdp with sdv, sdv with val(npl)
  copy to (str(DEB_KPL)+'^') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  sele SkDocVz
  repl all sdp with sdv, sdv with val(npl)

  sele SkDoc126
  inde on str(kpl, 7)+dtos(dop) tag t1
  repl all sdp with sdv, nn with iif(date()-dop < 100,(date()-dop),99)
  sele SkDoc
  inde on str(kpl, 7)+dtos(dop) tag t1

  // ����� ���� ��ࠡ��뢠��
  crtt('tdop', 'f:nn c:n(2) f:dop c:d(10)')
  use tdop new
  dtr:=dtBeg + 1 //date()+1 // ��砫쭠� ���
  for i:=1 to DEB_CNT_DAY
    appe blank
    repl nn with i, dop with dtr-i
  next

  return (.t.)

/***********************************************************
 * dkops() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function DKops(nA361)
  if (select('kops')#0)
    sele kops
    CLOSE
  endif

  erase kops.dbf
  crtt('kops', 'f:d0k1 c:n(1) f:kop c:n(3)')
  sele 0
  use kops
  sele soper
  go top
  while (!eof())
    d0k1r=d0k1
    kopr=kop+100
    for i=1 to 20
      cdbr='ddb'+alltrim(str(i, 2)); pDB:=FieldPos(cDBr)
      ckrr='dkr'+alltrim(str(i, 2)); pKR:=FieldPos(cKRr)
      if (FieldGet(pDB) = nA361 .or. FieldGet(pKR) = nA361)
        sele kops
        netadd()
        netrepl('d0k1,kop', { d0k1r, kopr })
        exit
      endif

    endfor

    sele soper
    skip
  enddo

  return (.t.)

/***********************************************************
 * dz() -->
 *   ��ࠬ���� : dtBeg - ������� ��� (ᥣ����), dtEnd - ������ ��� -��㡨�� ���᪠
 *   �����頥�:
 */
function dz(dtBeg,dtEnd,nA361)
  Local cNmIndFl, dBeg, dEnd

  if (select('dz')#0)
    sele dz
    CLOSE
  endif
  erase dz.dbf;  erase dz.cdx
  crtt('dz', 'f:kkl c:n(7) f:dz c:n(12,2) f:ddb c:d(10)')

  use dz new Exclusive
  inde on str(kkl, 7) tag t1

  if (select('kz')#0)
    sele kz
    CLOSE
  endif

  erase kz.dbf; ;  erase kz.cdx
  crtt('kz', 'f:kkl c:n(7) f:kz c:n(12,2) f:ddb c:d(10)')
  use kz new Exclusive
  inde on str(kkl, 7) tag t1

  // ���� ⥪�饣� �� � �� � ����� ����
  sele DkKln
  go top
  while (!eof())
    kklr=kkl
    ddbr=ddb
    if (bs = nA361) // 361001)
      dzr=dn-kn+db-kr
      If nA361 < 631000
        //
      ELSE
        dzr:=ABS(dzr)
      EndIf
      sele dz
      netadd()
      netrepl('kkl,dz,ddb', { kklr, dzr, ddbr })
    else
      if (bs=631001)
        kzr=dn-kn+db-kr
        if (kzr<0)
          sele kz
          netadd()
          netrepl('kkl,kz,ddb', { kklr, kzr, ddbr })

        endif

      endif

    endif

    sele DkKln
    skip
  enddo


  // 㬥����� ������������
  If dtBeg # date()
    SubsSaldo('dz',nA361,dtBeg,'dz')
  EndIf

  if (select('tdop')=0)
    use tdop new
  endif

  if (select('SkDoc')=0)
    use SkDoc new excl
    inde on str(kpl, 7)+dtos(dop) tag t1
  endif

  // 㢥��稢��� ������������ �� ���㦥���� �-⠬
  sele SkDoc
  go top
  while (!eof())

    if (prz=1) // ��� ⢥ত���� �ய�᪠��
      skip;     loop
    endif

    if dtBeg # date() // ��६ ��
      If dop > dtBeg  // ��� ���㧪� ����� - �모���
        skip;     loop
      EndIf
    endif

    kklr=kpl
    dzr=Sdv
    ddbr=dop

    // ��騩 ���� �� �-��, �㬬� � ��� ��ࢮ�� �����
    // ����������� �㬬�
    sele dz
    seek str(kklr, 7)
    if (found())
      netrepl('dz', { dz+dzr })
    else
      netadd()
      netrepl('kkl,dz,ddb', { kklr, dzr, ddbr })
    endif

    sele SkDoc
    skip
  enddo

  // �� ����� ��襬
  sele dz
  go top
  while (!eof())
    if (dz < 0)
      skip; loop
    endif
    kklr=kkl // ��� �-��
    dzr=dz // �㬬�
    ddbr=ddb

    // ��騩 ���� �� �-��, �㬬� � ��� ��ࢮ�� �����
    sele deb
    seek str(kklr, 7)
    if (!found())
      netadd()
      netrepl('kkl,dz,ddb', { kklr, dzr, ddbr })
    endif

    sele SkDoc
    seek str(kklr, 7)
    if (found())
      while (kpl=kklr)
        If DEB_KOP_TARA
          skip; loop
        EndIf
        Sdvr=Sdv
        dopr=dop

        // �������� � �����뢥�� �������� ���
        sele tdop
        locate for dop=dopr
        if (found())
          nnr=nn
          // ��襬 �㬬� � ���� ����
          sele deb
          cSdvr='Sdv'+padl(alltrim(str(nnr, 3)),3,'0'); pSdv:=FieldPos(cSdvr)
          cDopr='dop'+padl(alltrim(str(nnr, 3)),3,'0'); pDop:=FieldPos(cDopr)
          FieldPut(pSdv, FieldGet(pSdv)+Sdvr)
          FieldPut(pDop, dopr)

          sele SkDoc
          repl nn with nnr, Sdp with Sdv
        endif

        sele SkDoc
        skip
      enddo

    endif

    sele dz
    skip
  enddo

  // ���� �� �����
  crtt('bdoc', 'f:kkl c:n(7) f:ddk c:d(10) f:bs_d c:n(6) f:bs_s c:n(10,2) f:nplp c:n(6) f:osn c:c(30) f:rn c:n(6) f:BOsn c:c(60) f:rnd c:n(6)')
  use bdoc new excl

  sele dokk
  set orde to tag t5        // kkl,mn,rnd,rn

  // �-�� ������
  sele dz
  go top
  while (!eof())
    kklr=kkl
    sele dokk
    if (netseek('t11', 'kklr,'+str(nA361,6))) //'361001'))
      while (kkl=kklr .and. iif(nA361 < 631000, bs_k,bs_d) = nA361) // 361001)
        if (mn=0)
          skip;          loop
        endif

        if (prc)
          skip;          loop
        endif

        If dtBeg # date()
          If ddk > dtBeg // �ய�� �஢����
            skip;          loop
          EndIf
        EndIf

        sele dokk
        ddkr=ddk
        bs_dr=bs_d
        bs_sr=bs_s
        nplpr=nplp
        rndr=rnd
        mnr=mn
        rnr=rn
        osnr=getfield('t1', 'mnr,rndr,kklr', 'doks', 'osn')
        bosnr=getfield('t1', 'mnr,rndr,kklr', 'doks', 'bosn')

        sele bdoc
        netadd()
        netrepl('kkl,ddk,bs_d,bs_s,nplp,osn,bosn,rn,rnd',;
                 {kklr,ddkr,bs_dr,bs_sr,nplpr,osnr,bosnr,rnr,rndr})
        sele dokk
        skip
      enddo

    endif

    sele dz
    skip
  enddo
  sele bdoc
  inde on str(kkl, 7) tag t1

  sele deb
  go top
  while (!eof())
    kklr=kkl
    nkler=getfield('t1', 'kklr', 'kln', 'nkle')
    opfhr=getfield('t1', 'kklr', 'kln', 'opfh')
    nsopfhr=getfield('t1', 'opfhr', 'opfh', 'nsopfh')
    nklr=alltrim(nsopfhr)+' '+alltrim(nkler)
    mskr=getfield('t1', 'kklr', 'kpl', 'crmsk')
    netrepl('nkl,msk', 'nklr,mskr')

    pdzr=dz   // 8
    pdz1r=dz  // 15
    pdz2r=dz
    pdz3r=dz  // 22

    for i=1 to DEB_CNT_DAY
      cSdvr:='Sdv'+padl(alltrim(str(i, 3)),3,'0'); pSdv:=FieldPos(cSdvr)
      Sdvr:=FieldGet(pSdv)

      // ����� 8 ����
      if (i<8)
        if (pdzr>Sdvr)
          pdzr=pdzr-Sdvr
        else
          Sdvr=pdzr
          FieldPut(pSdv, Sdvr)
          pdzr=0
        endif

      endif

      // ����� 15 ����
      if (i<15)
        if (pdz1r>Sdvr)
          pdz1r=pdz1r-Sdvr
        else
          Sdvr=pdz1r
          FieldPut(pSdv, Sdvr)
          pdz1r=0
        endif

      endif

      // ����� 22 ����
      if (i<22)
        if (pdz3r>Sdvr)
          pdz3r=pdz3r-Sdvr
        else
          Sdvr=pdz3r
          FieldPut(pSdv, Sdvr)
          pdz3r=0
        endif

      endif

      if (pdz2r>Sdvr)
        pdz2r=pdz2r-Sdvr
      else
        Sdvr=pdz2r
        FieldPut(pSdv, Sdvr)
        pdz2r=0
      endif

    next

    repl pdz with pdzr, pdz1 with pdz1r, pdz3 with pdz3r

    // ����訬 ��
    kzr=0
    sele kz
    locate for kkl=kklr
    if (found())
      kzr=abs(kz)
      sele deb
      repl kz with kzr
    endif

    sele bdoc
    seek str(kklr, 7)
    if (found())
      GoBottomFilt(str(kklr, 7)) // �� ��᫥���� ���⥦
      ddkr=ddk // ���
      bs_sr=bs_s // �㬬�
      bs_dr=int(bs_d/1000) // � ���� ��� ����
      sele deb
      repl bs_s with bs_sr, ddk with ddkr, bs_d with bs_dr
    endif

    sele deb
    skip
  enddo

  sele SkDoc
  ordsetfocus('t1');  copy to (str(DEB_KPL)+'a') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  sele SkDoc
  Updt_Sdp('deb','SkDoc',{|| DEB_KOP_TARA  })
  // ���⠭���� �㬬� �믨ᠭ���
  sele SkDoc
  repl all sdv with val(Npl)
  ordsetfocus('t1');  copy to (str(DEB_KPL)+'_') for kpl=DEB_KPL .and. !DEB_KOP_TARA

  //sele deb
  //deb->(Updt_Sdp('SkDoc'))

  // �㬬� �� ࠧ��ᥭ��� ���������
  mkeepr:=27
  cMKeepr:=padl(ltrim(str(mkeepr,3)),3,'0')
  PathDDr := PathOstDD(cMKeepr,dtBeg)

  nSumTotMaxDay := SumMaxDay('deb')
  nSumMaxDay := 0

  // ������ ���⪠ �� ࠧ��ᥭ����
  If file('tSkDoc91.dbf')
    erase ('tSkDoc91.dbf')
  EndIf

  If iif(gnEnt = 21,.F., dtBeg = date())
    If file('SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))+'.dbf')

      use ('SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))) alias SkDoc91  new Exclusive

      ChkSkDok91()
      sele SkDoc91
      sum Sdp to nSumMaxDay

      close SkDoc91
    EndIf
  Else // ���� ���
    If gnEnt = 21 // � ���⪨
      If file(PathDDr+'SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))+'.dbf')
        use (PathDDr+'SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))) alias SkDoc91  new Exclusive

        ChkSkDok91()
        sele SkDoc91
        sum Sdp to nSumMaxDay

        close SkDoc91
      EndIf
    EndIf
  EndIf


  outlog(__FILE__,__LINE__,'SkDoc91',nSumMaxDay, nSumTotMaxDay)
  if round(nSumMaxDay - nSumTotMaxDay, 2 ) = 0
    sele SkDoc
    If gnEnt = 21
      If file(PathDDr+'SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))+'.dbf')
        append from  (PathDDr+'SkDoc'+ltrim(str(DEB_CNT_DAY+1,2)))
      EndIf
    Else
      append from ('SkDoc'+ltrim(str(DEB_CNT_DAY+1,2)))
    EndIf
  else
    // ᮧ���� ��������� � ����஬ -99941 SkDoc
    // ���� ��᫥��� ���㦥���� ���
    sele deb
    cSdvr:='Sdv'+padl(alltrim(str(DEB_CNT_DAY+1, 3)),3,'0'); pSdv:=FieldPos(cSdvr)
    sele deb
    dbgotop()
    // dbGoBottom(); dbskip()
    while (!eof())
      nSum:=FieldGet(pSdv)
      If nSum > 0 .and. EMPTY(FieldGet(pSdv+1))


        ttnr:=0
        // ���� ��������� �� ���⥫�騪� �� ���.���� �� ����� �����
        dBeg:=ADDMONTH(BOM(dtEnd),-1)    //dBeg:=BOM(dtBeg)
        dEnd:=BOM(STOD('20060801'))
        outlog(__FILE__,__LINE__,"�㦥� ���",deb->kkl,nSum,  dBeg,  dEnd,dtBeg,dtEnd)

        // ��砫� 横�� ⮫쪮 ��� 361
        dBeg:=ADDMONTH(dBeg,+1)
        While nA361 < 631000 .and. (dBeg:=ADDMONTH(dBeg,-1),dBeg) >= dEnd

          sele cskl; DBGoTop()
          while !eof()
            if !(rasc=1.and.ent=gnEnt) // �㦭� � �।-⨥ � �த��� ����
                skip;   loop
            endif
            //   �ய�᪠�� ᪫��� 169 - 263;705'
            if str(Sk,3)$'263;705' // ᪫��� 169 �ࠪ�
                skip;   loop
            endif
            pathr:=gcPath_e + pathYYYYMM(dBeg) + '\' + alltrim(path)
            skr=sk
            If netfile('rs1',1)

              netuse('rs1','rs1vz',,1)
              cNmIndFl := 'rs1vz_'+strtran(pathYYYYMM(dBeg) + '\' + alltrim(cskl->path),'\','_')
              set index to
              // outlog(__FILE__,__LINE__,file(cNmIndFl+'.*'))
              If !file('idx\'+cNmIndFl+'.*')
                // index on str(nkkl, 7) to ('idx\'+cNmIndFl)
                index on str(kpl, 7) to ('idx\'+cNmIndFl)
              EndIf
              set index to ('idx\'+cNmIndFl)
              // ordsetfocus('t1')

              if DBSeek(str(deb->kkl, 7))

                // locate for vo=9 .and. prz=1 while nkkl=deb->kkl
                // ������ ��� �� ����i� �������
                locate for vo=9 .and. prz=1 .and. !(DEB_KOP_TARA .OR. DEB_KOP_KASSA) ;
                while kpl=deb->kkl
                If found()

                  kopr=kop
                  kplr=kpl
                  kgpr=kpv
                  dopr=dop
                  Sdvr=nSum // Sdv
                  przr=prz
                  ktar=kta
                  ktasr=ktas
                  DtOplr=DtOpl
                  nktar=getfield('t1', 'ktar', 's_tag', 'fio')
                  ttnr=ttn
                  nkklr=nkkl

                  sele SkDoc
                  netadd()
                  netrepl('ttn,kpl,kgp,dop,Sdv,prz,kta,ktas,sk,kop,nkkl,nkta,DtOpl',                           ;
                           { ttnr, kplr, kgpr, dopr, Sdvr, przr, ktar, ktasr, skr, kopr, nkklr, nktar, DtOplr } ;
                        )
                  repl nn with DEB_CNT_DAY+1, mn with -1, Sdp with Sdv
                   outlog(__FILE__,__LINE__,ttnr,cNmIndFl)
                  // ��室 �� 横�� �������
                  sele cskl
                  DBGoBottom()
                  skip
                  // ��室 �� 横�� ����楢
                  dBeg:=dEnd
                EndIf
              endif
              nuse('rs1vz')
            endif
            sele cskl
            skip
          enddo

        EndDo
        If ttnr = 0 // �� ��諨
            outlog(__FILE__,__LINE__, '��� ����')
        EndIf
      ELSE // �㬬� ⠦�

      EndIf
      sele deb
      skip
    enddo
    // ������� �� �������
    If file('tSkDoc91.dbf')
      sele SkDoc
      append from tSkDoc91
    EndIf
    sele SkDoc
    copy to ('SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))) for mn = -1
  endif

  SkDoc126->(UpDateSkDoc('SkDoc126'))
  SkDocVz->(UpDateSkDoc('SkDocVz'))
  SkDocVz0->(UpDateSkDoc('SkDocVz0'))
  sele SkDoc
  copy to SkDocful
  dele for nn = 0 .or. sdp = 0
  pack

  UpDateSkDoc()

  // �஢�ઠ ����� ᢥ��⮣� � ࠧ����⮣�
  sum sdp to nSum

  sele deb
  sum dz to Sdvr
    outlog(__FILE__,__LINE__,'SkDoc deb',nSum, Sdvr)
  If round(nSum - Sdvr,2) # 0
    outlog(__FILE__,__LINE__,nSum - Sdvr,'!!!�஢�ઠ ����� ᢥ��⮣� � ࠧ����⮣�')

    ChkDebDzSkDocSdp('deb','SkDoc')

  EndIf

  If gnEnt = 21 // � ���⪨

    sele SkDoc
    copy to (PathDDr+'SkDoc.dbf')

    // �⮣���� ⠡���
    inde on str(kpl)+str(kgp) tag t3
    total on str(kpl)+str(kgp) to SkDockpl field sdp ;
    for !(str(kpl,7) $ '  20034; 539105; 383053;2298568;5513371; 382533')
      // ����祭���
    total on str(kpl)+str(kgp) to SkDocExp field sdp ;
    for !(str(kpl,7) $ '  20034; 539105; 383053;2298568;5513371; 382533');
      .and. Dpd < 0

    use SkDockpl new
    copy fields kgp, kpl, ngp, agp, sdp ;
    to (PathDDr+'SkDockpl.dbf')  all
    close

    use SkDocExp new
    copy fields kgp, kpl, ngp, agp, sdp ;
    to (PathDDr+'SkDocExp.dbf')  all
    close

    sele SkDoc
    copy ; // file ('SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))+'.dbf') ;
    to (PathDDr+'SkDoc'+ltrim(str(DEB_CNT_DAY+1,2))+'.dbf') ;
    for mn = -1

  EndIf


  close SkDoc126
  sele SkDoc
  append from SkDoc126
  if dtBeg = date() // ��६ ��
    // ���������� "����窨" � ᪮�쪮 ���� ��᫥ "���㧪�"
    repl all dpd with DtOpl - Date(), nn with iif(date()-dop < 100,(date()-dop),99)
  endif

  nuse('deb')
  nuse('SkDocVz')
  nuse('SkDocVz0')
  nuse('SkDoc126')
  nuse('SkDoc')
  nuse('bdoc')


  // �����⮢�� � ����஢����
  filedelete('SkDocVz.cdx')
  filedelete('SkDocVz0.cdx')
  filedelete('SkDoc126.cdx')
  filedelete('SkDoc.cdx')

  use ('SkDocVz') new Exclusive
  index on str(kpl,7)+str(ktan) tag t1
  index on str(kgp,7)+str(ktan) tag t2
  index on str(kpl,7)+str(kgp,7) tag t3
  close SkDocVz

  use ('SkDocVz0') new Exclusive
  index on str(kpl,7)+str(ktan) tag t1
  index on str(kgp,7)+str(ktan) tag t2
  index on str(kpl,7)+str(kgp,7) tag t3
  close SkDocVz0

  use ('SkDoc126') new Exclusive
  index on str(kpl,7)+str(ktan) tag t1
  index on str(kgp,7)+str(ktan) tag t2
  index on str(kpl,7)+str(kgp,7) tag t3
  close SkDoc126
  use ('SkDoc') new Exclusive
  index on str(kpl,7)+str(ktan) tag t1
  index on str(kgp,7)+str(ktan) tag t2
  index on str(kpl,7)+str(kgp,7) tag t3
  close SkDoc

  if dtBeg = date() // ��६ ��
    DO CASE
    CASE nA361 = 631001
      DebCopy(pdeb01r)
    CASE nA361 = 361001
      DebCopy(pdeb01r)
      DebCopy(PathDebr)
    CASE nA361 = 361002
      DebCopy(pdeb02r)
    ENDCASE
  else // ������ ����

  EndIf


  return (.t.)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-04-17 * 01:02:01pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
STATIC FUNCTION DebCopy(PathDebr)
  if (!file(PathDebr+'deb.dbf'))
    copy file deb.dbf to (PathDebr+'deb.dbf')
    copy file deb.cdx to (PathDebr+'deb.cdx')

    copy file SkDocVz.dbf to (PathDebr+'SkDocVz.dbf')
    copy file SkDocVz.cdx to (PathDebr+'SkDocVz.cdx')

    copy file SkDoc126.dbf to (PathDebr+'SkDoc126.dbf')
    copy file SkDoc126.cdx to (PathDebr+'SkDoc126.cdx')

    copy file SkDoc.dbf to (PathDebr+'SkDoc.dbf')
    copy file SkDoc.cdx to (PathDebr+'SkDoc.cdx')

    copy file bdoc.dbf to (PathDebr+'bdoc.dbf')
    copy file bdoc.cdx to (PathDebr+'bdoc.cdx')
  else
    sele 0
    use (PathDebr+'deb') excl
    if (neterr())
      sele 0
      use (PathDebr+'deb') share
      while (!eof())
        netdel()
        skip
      enddo

      appe from deb
      CLOSE
      sele 0
      use (PathDebr+'SkDoc') share
      while (!eof())
        netdel()
        skip
      enddo

      appe from SkDoc.dbf
      CLOSE
      sele 0
      use (PathDebr+'bdoc') share
      while (!eof())
        netdel()
        skip
      enddo

      appe from bdoc
      CLOSE
    else
      CLOSE
      copy file deb.dbf to (PathDebr+'deb.dbf')
      copy file deb.cdx to (PathDebr+'deb.cdx')

      copy file SkDocVz.dbf to (PathDebr+'SkDocVz.dbf')
      copy file SkDocVz.cdx to (PathDebr+'SkDocVz.cdx')

      copy file SkDoc126.dbf to (PathDebr+'SkDoc126.dbf')
      copy file SkDoc126.cdx to (PathDebr+'SkDoc126.cdx')

      copy file SkDoc.dbf to (PathDebr+'SkDoc.dbf')
      copy file SkDoc.cdx to (PathDebr+'SkDoc.cdx')

      copy file bdoc.dbf to (PathDebr+'bdoc.dbf')
      copy file bdoc.cdx to (PathDebr+'bdoc.cdx')
    endif

  endif
  RETURN (NIL)


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-06-17 * 04:12:53pm
 ����������......... ���㫥��� �㬬� ����� � ���室��� �-��
 bNotRun -   �᫮���, �ਪ��஬ �-� ��⠥��� ����祭��
 ���������.......... ������� � ��, ������ �㦭� ��ࠡ����
 �����. ��������....
 ����������.........
 */
FUNCTION Updt_Sdp(cAls_Deb,cAls_SkDoc,bNotRun, lLogSum)
  LOCAL nStartDt:=1, nSum:=0
  DEFAULT lLogSum TO .T.
  outlog(__FILE__,__LINE__,'��� � SkDoc')
  sele (cAls_deb)
  go top
  while (!eof())
    nStartDt:=1; nSum:=0
    FOR i:=nStartDt to 190 // DEB_CNT_DAY
      if  (cAls_deb)->(FieldPos('Sdv'+padl(ltrim(str(i,3)),3,'0'))) = 0
        loop
      endif

      nSum := (cAls_deb)->(FieldGet(FieldPos('Sdv'+padl(ltrim(str(i,3)),3,'0'))))
      dDop := (cAls_deb)->(FieldGet(FieldPos('Dop'+padl(ltrim(str(i,3)),3,'0'))))
      kplr := (cAls_deb)->kkl

      sele (cAls_SkDoc)
      if dbseek(str(kplr, 7)+dtos(dDop))
        Do While  str(kplr, 7)+dtos(dDop) = str(kpl, 7)+dtos(Dop)
          If eval(bNotRun)   // ��
            repl Sdp with 0
          Else

            If nSum >= Sdp
            else // �㬬� �� ��� < �����
              repl Sdp with nSum
            EndIf
            nSum := round(nSum - Sdp, 2)

          EndIf

          DBSkip()
        EndDo
        If round(nSum,2) # 0 .AND. lLogSum
          outlog(__FILE__,__LINE__,str(kplr, 7),dtos(dDop),nSum,'str(kplr, 7),dtos(dDop),nSum')
        EndIf

      endif

    NEXT i

    sele (cAls_deb)
    skip
  enddo
  RETURN (NIL)


/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-10-17 * 01:47:38pm
 ����������......... ������ �㬬�, ����� �� ������ � "���" ⠡����
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION SumMaxDay(deb, nDay)
  LOCAL nSumMaxDay:=0
  LOCAL nSumTotMaxDay:=0
  LOCAL cSdvr_nDay, pSdvr_nDay, cSdvr, pSdvr
  LOCAL nStartDt, nSum
  DEFAULT nDay to DEB_CNT_DAY+1
  sele (deb)
  cSdvr_nDay='Sdv'+padl(alltrim(str(nDay, 3)),3,'0'); pSdv_nDay:=FieldPos(cSdvr_nDay)
  sele (deb)
  go top
  while (!eof())
    nStartDt:=1; nSum:=0
    FOR i:=nStartDt to 190
      pSdvr := (deb)->(FieldPos('Sdv'+padl(ltrim(str(i,3)),3,'0')))
      if pSdvr  = 0
        loop
      endif
      nSum += (deb)->(FieldGet(pSdvr))
    NEXT i

    nSumMaxDay:=round(dz - nSum,2) // ࠧ���
    nSumTotMaxDay += nSumMaxDay // ����������
    FieldPut(pSdv_nDay, nSumMaxDay )

    sele (deb)
    skip
  enddo
  RETURN (nSumTotMaxDay)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-14-17 * 05:28:23pm
 ����������......... 㬭���襭�� �-�� ��� �������� ����
 ���������.......... �����, ��� ������, ����� ���, ��� �-��, ���� ������
 �����. ��������....
 ����������.........
 */
FUNCTION SubsSaldo(cAl_Dz,nA361,dtBeg, cFldNm)
  local pFldNm
  sele dokk
  ordsetfocus('t5')

  sele (cAl_Dz)
  copy to dz1  // ⥪ ���ﭨ�

  sele (cAl_Dz)
  pFldNm := FieldPos(cFldNm)
  go top
  while (!eof())
    kklr=kkl
    sele dokk
    if (netseek('t5', 'kklr'))
      while (kkl = kklr)
        if (prc)
          skip;          loop
        endif
        // �뢮��� ���⮪ �� ����� ���
        // ��⠢�塞 �஢����, ����� ����� � ==
        If ddk <= dtBeg
          skip;          loop
        EndIf
        Do Case
        Case bs_k = nA361
          (cAl_Dz)->(FieldPut(pFldNm ,FieldGet(pFldNm) + dokk->bs_s))
          // (cAl_Dz)->dz += bs_s
        Case bs_d = nA361
          (cAl_Dz)->(FieldPut(pFldNm ,FieldGet(pFldNm) - dokk->bs_s))
          // (cAl_Dz)->dz -= bs_s
        EndCase
        skip
      enddo
    endif
    sele (cAl_Dz)
    DBSkip()
  enddo

  sele (cAl_Dz)
  copy to dz2  // ���ﭨ� ��᫥ ����

  RETURN (NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-15-17 * 12:44:49pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION ChkSkDok91()
  LOCAL cSdvr, pSdv, nSum
  sele deb
  ordsetfocus('t1')
  cSdvr:='Sdv'+padl(alltrim(str(DEB_CNT_DAY+1, 3)),3,'0'); pSdv:=FieldPos(cSdvr)

  // ��� ���������� �� ����������
  sele SkDoc91
  copy stru to tSkDoc91

  use tSkDoc91 new Exclusive
  sele SkDoc91
  DBGoTop()
  Do While !eof()
    kplr:=SkDoc91->kpl
    // �� ������ ���⢮����
    If DEB_KOP_TARA
      repl SkDoc91->Sdp with 0
    EndIf

    sele deb
    if DBSeek(str(kplr,7))
      nSum:=FieldGet(pSdv)

      If round(SkDoc91->Sdp - nSum,2) = 0
        FieldPut(pSdv+1,date())  // ᫥�. ���� ��᫥ �㬬�

        // ��࠭�� �� �������
        sele SkDoc91
        copy to tmp91 next 1
        sele tSkDoc91
        append from tmp91

        // outlog(__FILE__,__LINE__,SkDoc91->Sdp - nSum)
      else
        FieldPut(pSdv+1,blank(date()))  // ᫥�. ���� ��᫥ �㬬�
        // outlog(__FILE__,__LINE__,kkl,SkDoc91->Sdp, nSum)
      EndIf
    endif
    // ��������
    sele SkDoc91
    Do While  kplr = SkDoc91->kpl
      skip
    EndDo
  EndDo
    sele tSkDoc91
    close
  RETURN (NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-19-17 * 11:27:27am
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION ChkDebDzSkDocSdp(cAls_Deb,cAls_SkDoc, lSdv999)
  LOCAL nDz, nSdp, kplr
  DEFAULT lSdv999 TO .F.
    sele (cAls_Deb)
    DBGoTop()
    Do While !eof()
      kplr:=(cAls_Deb)->kkl

      sele (cAls_SkDoc)
      if dbseek(str(kplr, 7))
        sum sdp to nSdp  While  str(kplr, 7) = str(kpl, 7)
        nDz:=(cAls_Deb)->dz - iif(lSdv999,(cAls_Deb)->Sdv999,0)
        If round(nSdp - nDz  ,2) # 0

          outlog(__FILE__,__LINE__,kplr,nSdp,nDz,;
          ' nSdp,nDz !!!�஢ �-�� ᢥ� � ࠧ��୮')

          dbseek(str(kplr, 7))
          copy to ('d'+padl(allt(str(kplr,7)),7,'0')) While  str(kplr, 7) = str(kpl, 7)

        EndIf
      endif
      sele (cAls_Deb)
      DBSkip()
    EndDo
  RETURN (NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-19-17 * 12:56:59pm
 ����������......... ���⭠� �஢��� �-��� � �-⪮�
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION ChkSkDocSdpDebDz(cAls_Deb,cAls_SkDoc, lSdv999)
  LOCAL nDz, nSdp, nRecSkDoc
  DEFAULT lSdv999 TO .F.
    sele (cAls_SkDoc)
    DBGoTop()
    Do While !eof()
      nRecSkDoc:=RECNO()
      kplr:=kpl
      // �㬬� �� ���
      sum sdp to nSdp  While  str(kplr, 7) = str(kpl, 7)

      nDz:=0
      sele (cAls_Deb)
      If DBSeek(str(kplr, 7))
        nDz:=(cAls_Deb)->dz - iif(lSdv999,(cAls_Deb)->Sdv999,0)
      EndIf

      sele (cAls_SkDoc)
      If round(nSdp - nDz  ,2) # 0

        outlog(__FILE__,__LINE__,kplr,nSdp,nDz,;
        ' nSdp,nDz !!!�஢ �-�� ᢥ� � ࠧ��୮')

        dbseek(str(kplr, 7))
        copy to ('d'+padl(allt(str(kplr,7)),7,'0')) While  str(kplr, 7) = str(kpl, 7)

      EndIf

      sele (cAls_SkDoc)
    EndDo

  RETURN (NIL)

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  07-26-17 * 01:18:48pm
 ����������.........
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION Crtt_SkDoc(cFileName, cDopField)
  DEFAULT cFileName TO 'SkDoc', cDopField TO ''
  If file(cFileName+'.cdx')
    erase (cFileName+'.cdx')
  EndIf
  crtt(cFileName,                                                             ;
        'f:mn  c:n(6) f:rnd c:n(6) f:sk  c:n(3) f:rn  c:n(6) f:mnp c:n(6) '+ ;
        'f:prz c:n(1) '+                                                     ;
                           ;//
        'f:dep  c:n(3) '+                                                    ;
        'f:ndep c:c(15) '+                                                   ;
        'f:nkkl c:n(7) '+                                                    ;
        'f:ttn c:n(6) f:dop c:d(10) '+                                       ;
        'f:Sdv c:n(11,2) '+                                                  ;
                           ;//
        'f:kpl c:n(7) '+                                                     ;
        'f:npl c:c(40) '+                                                    ;
                           ;//
        'f:kgp c:n(7) '+                                                     ;
        'f:ngp c:c(40) '+                                                    ;
        'f:agp c:c(50) '+ ;
        'f:nnet c:c(40) '+                                                   ;
                           ;//
        'f:ktan c:n(4) '+                                                    ;
        'f:nktan c:c(15) '+                                                  ;
                           ;//
        'f:kta c:n(4) '+                                                     ;
        'f:nkta c:c(15) '+                                                   ;
        'f:ktas c:n(4) '+                                                    ;
        'f:nktas c:c(15) '+                                                  ;
                           ;//
        'f:nap c:n(4) '+                                                     ;
        'f:nnap c:c(20) '+                                                   ;
                           ;//
        'f:kop c:n(3) '+                                                     ;
        'f:sdp c:n(11,2) f:DtOpl c:d(10) '+                                  ;
        'f:dpd c:n(5) '+;
        'f:nn c:n(2) '+;
         cDopField                                                        ;
     )
  RETURN (NIL)

/***********************************************************
 * PrDoc() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
static function PrDoc(dtBeg,dtEnd,nA361)
  local dtr
  local dt1r:= dtEnd
  local yy1r:=year(dt1r)
  local mm1r:=month(dt1r)

  local dt2r:=gdTd
  local yy2r:=year(dt2r)
  local mm2r:=month(dt2r)
  LOCAL aAliasDokk:={}, lSeekDokk, i, nSumOpl, nSumVz

  Crtt_SkDoc()
  Crtt_SkDoc('SkDoc126')
  Crtt_SkDoc('SkDocOpl')
  Crtt_SkDoc('SkDocVz')
  Crtt_SkDoc('SkDocVz0')

  use SkDoc126 new excl
  use SkDoc new excl
  // inde on str(kpl, 7)+dtos(dop) tag t1
  // �� ���쭥� �-�� � ������� �-�
  for y=yy1r to yy2r
    do case
    case (yy1r=yy2r)
      m1r=mm1r
      m2r=mm2r
    case (y=yy1r)
      m1r=mm1r
      m2r=12
    case (y=yy2r)
      m1r=1
      m2r=mm2r
    otherwise
      m1r=1
      m2r=12
    endcase

    for m=m1r to m2r
      pathdr=gcPath_e+'g'+str(y, 4)+'\m'+iif(m<10, '0'+str(m, 1), str(m, 2))+'\'
      // ����
      pathr=pathdr+'bank\'
      if !netfile('dokk',1)
          loop
      endif

      aadd(aAliasDokk,'dokk'+padl(ltrim(str(y,4)),4,'0')+padl(ltrim(str(m,2)),2,'0'))
      netuse('dokk',atail(aAliasDokk),,1)

      // ᪫���
      sele cskl
      go top
      while (!eof())
        if (!(rasc=1.and.ent=gnEnt))
          skip
          loop
        endif

        skr=sk
        pathr=pathdr+alltrim(path)
        if (!netfile('soper', 1))
          skip
          loop
        endif

        if (gnArm#0)
          ?pathr
        else
          outlog(3,__FILE__,__LINE__,pathr)
        endif

        netuse('soper',,, 1)
        DKops(nA361)
        netuse('pr1',,, 1)
        //netuse('rs1',,, 1)

        If Empty(Select('prVz'))
          // �����㥬 ⠡����
          If file('prVz.dbf')
            filedelete('prVz.*')
          EndIf

          sele pr1
          copy stru to prVz
          use prVz new Exclusive

        EndIf

        sele pr1
        go top
        while (!eof())

          // ��� ��ࢮ�� ����� ��६ � ���㦥��� � �����থ���
          // ��� ᫥����� ⮫쪮 ���⢥ত����
          // .f. - ⮫쪮 ���⢥ত����

          if ((y=yy2r.and.m=m2r) .and. kop=126) // ����� �-��� � ���-126
            // ��६ � ࠡ���
          else // ��� �� ��ࢮ�� �����
            if (prz=0) // ⮫쪮 ���⢥ত���
              skip;       loop
            else // prz=1 ���⢥ত���
              If DEB_KOP_KASSA  // STR(kop,3) $ '161 169'
                skip;       loop
              EndIf
            endif
          endif

          if DEB_KOP_TARA ;// �� �ய�᪠��
            .or. kop=108
            skip;  loop
          endif


          // ���㦥��� ⥪. ��ਮ��
          kopr=kop
          kplr=kps
          kgpr=kzg
          dopr=dpr
          Sdvr=Sdv
          przr=prz

          ktar=kta
          ktasr=ktas
          nktar=' ' //getfield('t1', 'ktar', 's_tag', 'fio')

          ttnr=nd
          mnr=mn
          nkklr=kplr


          sele kops
          locate for d0k1=1.and.kop=kopr // =1 ��室
          if (!found())
            sele pr1
            skip; loop
          endif

          If empty(pr1->dop) // ��� ������
            kdOplr:=getfield('t1','nkklr','klnDog','kdOpl')
            If Empty(kdOplr)
              // ���᪠�� � ��㣮� ����
              outlog(3,__FILE__,__LINE__,ttnr,nkklr,kdOplr,'klnDog->nkklr,kdOplr')
            EndIf
            DtOplr:=pr1->dpr + kdOplr // ��� �����ত����
          else
            DtOplr:=pr1->dop
          EndIf


          // ����� � ���
          if dow(DtOplr)=7 .or. dow(DtOplr)=1
            Do While dow(DtOplr)=7 .or. dow(DtOplr)=1
              DtOplr++
            EndDo
          endif

          sele SkDoc
          netadd()
          netrepl('ttn,kpl,kgp,dop,Sdv,prz,kta,ktas,sk,kop,nkkl,nkta,DtOpl,NPl',                           ;
                    { ttnr, kplr, kgpr, dopr, Sdvr, przr, ktar, ktasr, skr, kopr, nkklr, nktar, DtOplr, allt(str(Sdvr,9,2)) } ;
                 )
          // ���㬥��� ���⠢騪�
          netrepl('ngp',{DTOC(pr1->DTtnPst,'dd.mm.yy')+' '+XTOC(pr1->TtnPst)})
          netrepl('mn',{mnr})

          sele pr1
          skip
        enddo

        sele pr1
        copy to ('tmpPV') ;//+padl(ltrim(str(m,2)),2,'0')) ;
          for kop=108 .and. prz=1 .and. skvz#0 ;//.and. TtnVz#0 ;
            .and. SdvM # 0 // ����� ⮢��
        sele prVz
        append from ('tmpPV') //+padl(ltrim(str(m,2)),2,'0'))

        //nuse('rs1')
        nuse('pr1')
        nuse('soper')
        sele cskl
        skip
      enddo

    next

  next

  sele SkDoc
  copy to (str(DEB_KPL)+'d') for kpl=DEB_KPL .and. !DEB_KOP_TARA

  sele prVz
  index on str(SkVz)+str(TtnVz) tag t1
  sele SkDoc
  DBGoTop()
  Do While !eof()
    If kpl=DEB_KPL
      outlog(3,__FILE__,__LINE__,;
        SkDoc->Sk, SkDoc->Ttn;
        , str(SkDoc->sdv,9,2);
        , 'SkDoc->Sk, SkDoc->Ttn, sdv')

    endif
    // �஢�ઠ �� ������ ���
    lSeekDokk:=.F.
    nSumOpl:=0
    For i:=1 To len(aAliasDokk)
      (aAliasDokk[i])->(OrdSetFocus('t9'))
      If ((aAliasDokk[i])->(netseek('t9','SkDoc->sk,SkDoc->ttn')))
        // �㬬� ����� �����

        sele (aAliasDokk[i])
        Do While (SkDoc->Sk=Sk .and. SkDoc->Ttn=DokkTtn)

          nSumOpl += bs_s

          If kkl=DEB_KPL
            outlog(3,__FILE__,__LINE__,;
              aAliasDokk[i], str(bs_s,9,2), ddk, nplp;
              ,'bs_s, ddk, nplp')

          endif

          sele (aAliasDokk[i])
          DBSkip()
        EndDo
        lSeekDokk:=.T.
        // exit
      EndIf
    Next

    sele SkDoc
    If kpl=DEB_KPL
            outlog(3,__FILE__,__LINE__,  nSumOpl, 'nSumOpl')
    endif


    // ����� � �������
    nSumVz:=0
    sele prVz
    DBSeek(str(SkDoc->Sk)+str(SkDoc->Ttn))
    Do While SkDoc->Sk=SkVz .and. SkDoc->Ttn=TtnVz
      nSumVz += SdvM
      DBSkip()
    EndDo
    If !Empty(nSumVz)
      lSeekDokk:=.t.
    EndIf

    sele SkDoc
    If kpl=DEB_KPL
            outlog(3,__FILE__,__LINE__,  nSumVz, 'nSumVz')
    endif

    // �஢�ઠ �� ������
    If lSeekDokk
      sele SkDoc
      If nSumOpl > SkDoc->sdv    // ᤥ���� ������ ����୮
        //nSumOpl := nSumOpl // �।�����
        nSumOpl := SkDoc->sdv // �।������ �� �ନ�㥬
      EndIf
      nSdp:=round(SkDoc->sdv - (nSumOpl + nSumVz),2)
      If nSdp < 0
          If kpl=DEB_KPL
            outlog(3,__FILE__,__LINE__,;
             SkDoc->Sk, SkDoc->Ttn;
             , str(SkDoc->sdv,9,2), str(nSumOpl,9,2),str(nSumVz,9,2);
             , str(SkDoc->sdv-nSumOpl-nSumVz,9,2);
             , 'SkDoc->Sk, SkDoc->Ttn, sdv, nSumOpl, nSumVz')
          endif
        // ������ �।�� �� ��㧮�����⥫�
        //nSumOpl := SkDoc->Sdv // nSdp
        nSumOpl += nSumVz // ���� ����⥫��
      else //
        nSumOpl += nSumVz
      EndIf
      //DBDelete()
      repl Sdv with Sdv - nSumOpl
    EndIf

    sele SkDoc
    DBSkip()
  EndDo

  // �����⨥  ⠡��� �஢����
  aeval(aAliasDokk,{|cAlias| nuse(cAlias) })
  close PrVz

  sele SkDoc
  copy to (str(DEB_KPL)+'c') for kpl=DEB_KPL .and. !DEB_KOP_TARA

  sele SkDoc
  copy to ('SkDocVz')  for Sdv < 0 // �।���
  copy to ('SkDocOpl') for Sdv = 0 // �ய��祭��
  copy to ('SkDoc4') for  Sdv > 0 .and. Sdv # val(NPl)  // ���筮 �ய��祭��

  sele SkDoc
  dele for Sdv < 0 ; // �।���
   .or. Sdv = 0 // �ய��祭��

  pack

  // �।��� ������� ��㧮�����⥫�
  sele SkDoc
  inde on str(kpl)+str(kgp)+dtos(dop) tag t3

  // ࠧ���� ������ (�����)
  use SkDocVz new Exclusive
  copy to SkDocVz0
  use SkDocVz0 new Exclusive

  sele SkDocVz
  inde on str(kpl, 7)+dtos(dop) tag t1
  set rela to recno() into SkDocVz0
  DBGoTop()
  // DBGoBottom();  skip
  Do While !eof()

    nSumVz:=abs(Sdv) // ��९��� �� ���㬥���

    If kpl=DEB_KPL
      outlog(3,__FILE__,__LINE__,str(SkDocVz->kpl)+'-'+str(SkDocVz->kgp))
      outlog(3,__FILE__,__LINE__,;
        SkDocVz->Sk, SkDocVz->Ttn, str(nSumVz,9,2);
        , 'SkDocVz->Sk, SkDocVz->Ttn, nSumVz')
    EndIf

    sele SkDoc
    if DBSeek(str(SkDocVz->kpl)+str(SkDocVz->kgp))
      Do While SkDoc->kpl = SkDocVz->kpl .and. SkDoc->kgp =  SkDocVz->kgp

        If round(Sdv,2)=0
          sele SkDoc;  DBSkip()
          loop
        EndIf
        If kpl=DEB_KPL
          outlog(3,__FILE__,__LINE__,'->', SkDoc->Sk, SkDoc->Ttn;
           , str(Sdv,9,2),str(nSumVz,9,2), str(sdv-nSumVz,9,2);
           , 'SkDoc->Sk, SkDoc->Ttn, Sdv, nSumVz')
        EndIf

        If Sdv >= nSumVz
          repl Sdv with Sdv - nSumVz
          nSumVz := 0
        Else // �㬬� ������ ����� �।��
          nSumVz -= Sdv
          repl Sdv with 0
        EndIf
        If kpl=DEB_KPL
          outlog(3,__FILE__,__LINE__,'--', SkDoc->Sk, SkDoc->Ttn;
           , str(Sdv,9,2),str(nSumVz,9,2), str(sdv-nSumVz,9,2);
           , 'SkDoc->Sk, SkDoc->Ttn, Sdv, nSumVz')
        EndIf
        If nSumVz = 0
          exit
        EndIf

        sele SkDoc; DBSkip()
      EndDo
    endif
    // �������� ���⮪ �����
    sele SkDocVz0
    repl Sdv with nSumVz * (-1)

    sele SkDocVz; DBSkip()
    If kpl=DEB_KPL
      outlog(3,__FILE__,__LINE__,;
        SkDocVz->Sk, SkDocVz->Ttn, str(nSumVz,9,2);
        , 'SkDocVz->Sk, SkDocVz->Ttn, nSumVz')
    EndIf
  EndDo

  sele SkDoc
  inde on str(kpl, 7)+dtos(dop) tag t1
  copy to (str(DEB_KPL)+'b') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  dele for Sdv = 0
  pack

  //quit
  sele SkDocVz0
  //copy to (str(DEB_KPL)+'`') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  repl all sdp with sdv, sdv with val(npl)
  copy to (str(DEB_KPL)+'^') for kpl=DEB_KPL .and. !DEB_KOP_TARA
  sele SkDocVz
  repl all sdp with sdv, sdv with val(npl)

  sele SkDoc126
  inde on str(kpl, 7)+dtos(dop) tag t1
  repl all sdp with sdv, nn with iif(date()-dop < 100,(date()-dop),99)
  sele SkDoc
  inde on str(kpl, 7)+dtos(dop) tag t1

  // ����� ���� ��ࠡ��뢠��
  crtt('tdop', 'f:nn c:n(2) f:dop c:d(10)')
  use tdop new
  dtr:=dtBeg + 1 //date()+1 // ��砫쭠� ���
  for i:=1 to DEB_CNT_DAY
    appe blank
    repl nn with i, dop with dtr-i
  next

  return (.t.)


/*
        // �஢�ઠ �� ����稥 ⠪�� �㬬�
        sele SkDoc
        sum sdp to nSdp for deb->kkl = kpl
        If round(nSdp - nSum) = 0
          sele deb
          Skip; loop
        Elseif nSdp > nSum
          dele for deb->kkl = kpl
        EndIf
*/
