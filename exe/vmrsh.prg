/***********************************************************
 * �����    : vmrsh.prg
 * �����    : 0.0
 * ����     :
 * ���      : 07/09/18
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

#include "common.ch"
#include "inkey.ch"
//�������� ����࠭ᯮ��
netuse('atvm')
netuse('atvme')
netuse('kgp')
set colo to g/n, n/g,,,
clea
if (select('sl')=0)
  sele 0
  use _slct alias sl excl
endif

sele sl
zap
netuse('kln')

sele atvm
go top
rcvmrshr=recn()
while (.t.)
  sele atvm
  foot('INS,DEL,F4,F5,ENTER,F6', '��������,�������,���४��,��������,���⠢,����')
  if (fieldpos('vmrshp')=0)
    rcvmrshr=slcf('atvm', 1, 1, 18,, "e:vmrsh h:' N' c:n(3) e:nvmrsh h:'�������' c:�(20) e:atrc h:'��' c:n(1) e:rmsk h:'��' c:n(1) e:rg h:'�/�' c:n(1)",,, 1,,,, '��������')
  else
    rcvmrshr=slcf('atvm', 1, 1, 18,, "e:vmrsh h:' N' c:n(3) e:nvmrsh h:'�������' c:�(20) e:atrc h:'��' c:n(1) e:rmsk h:'��' c:n(1) e:rg h:'�/�' c:n(1) e:vmrshp h:'NP' c:n(3)",,, 1,,,, '��������')
  endif

  sele atvm
  go rcvmrshr
  vmrshr=vmrsh
  nvmrshr=nvmrsh
  atrcr=atrc
  rmskr=rmsk
  rgr=rg
  if (fieldpos('vmrshp')#0)
    vmrshpr=vmrshp
  else
    vmrshpr=0
  endif

  do case
  case (lastkey()=K_ESC)  // ��室
    exit
  case (lastkey()=K_ENTER)// ���⠢
    save scre to scatvm
    atvme()
    rest scre from scatvm
  case (lastkey()=K_INS)  // ��������
    atvmins()
  case (lastkey()=K_F4)   // ���४��
    atvmins(1)
  case (lastkey()=K_F5.and.gnEnt=20)// ��������
    vmrshob()
  case (lastkey()=K_F6)             // ����
    clmr=setcolor('gr+/b,n/w')
    wmr=wopen(7, 25, 13, 55)
    wbox(1)
    store 0 to kkl_r, vmrsh_r
    @ 0, 1 say '������  ' get kkl_r pict '9999999'
    read
    wclose(wmr)
    setcolor(clmr)
    if (lastkey()=K_ENTER)
      if (kkl_r#0)
        vmrsh_r=getfield('t2', 'kkl_r', 'atvme', 'vmrsh')
        sele atvm
        locate for vmrsh=vmrsh_r
        rcvmrshr=recn()
        loop
      endif

    endif

  case (lastkey()= K_DEL) // �������
    sele atvme
    if (netseek('t1', 'vmrshr'))
      while (vmrsh=vmrshr)
        netdel()
        skip
      enddo

    endif

    sele atvm
    netdel()
    skip -1
    if (bof())
      go top
    endif

    rcvmrshr=recn()
  endcase

enddo

nuse()

/***********************************************************
 * atvmins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function atvmins(p1)
  local corr
  clmins=setcolor('gr+/b,n/w')
  wmins=wopen(7, 25, 15, 55)
  wbox(1)

  if (p1=nil)
    store 0 to vmrshr, corr, vmrshpr
    store space(20) to nvmrshr
  else
    corr=1
  endif

  if (gnAdm=1)
    @ 0, 1 say '�������       ' get vmrshr pict '999999'
  else
    @ 0, 1 say '�������       '+' '+str(vmrshr, 6)
  endif

  @ 1, 1 say '������������  ' get nvmrshr
  @ 2, 1 say '�����-1,���-2 ' get atrcr pict '9'
  @ 3, 1 say '������ �த�� ' get rmskr pict '9'
  @ 4, 1 say '�����/��த   ' get rgr pict '9'
  @ 5, 1 say '�������-த��.' get vmrshpr pict '999'
  read
  if (lastkey()=K_ESC)
    wclose(wmins)
    setcolor(clmins)
    return
  endif

  wselect(wmins)
  mminsr=0
  @ 6, 14 prom '��୮'
  @ 6, col()+1 prom '�� ��୮'
  menu to mminsr

  sele atvm
  if (mminsr=1)
    if (corr=0)
      go bott
      vmrshr=vmrsh+1
      netadd()
      netrepl('vmrsh,nvmrsh,atrc,rmsk,rg', 'vmrshr,nvmrshr,atrcr,rmskr,rgr')
      if (fieldpos('vmrshp')#0)
        netrepl('vmrshp', 'vmrshpr')
      endif

      rcvmrshr=recn()
    else
      //     go mrc_r
      netrepl('nvmrsh,atrc,rmsk,rg', 'nvmrshr,atrcr,rmskr,rgr')
      if (fieldpos('vmrshp')#0)
        netrepl('vmrshp', 'vmrshpr')
      endif

      if (gnAdm=1)
        netrepl('vmrsh', 'vmrshr')
      endif

    endif

  endif

  wclose(wmins)
  setcolor(clmins)
  return (.t.)

/***********************************************************
 * atvme() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function atvme()
  sele atvme
  forme_r='.t..and.vmrsh=vmrshr.and.kkl>3000'
  former=forme_r
  kkl_r=0
  go top
  rcatvmer=recn()
  while (.t.)
    sele atvme
    go rcatvmer
    foot('INS,DEL,F3,F6', '��������,�������,������,��६�����')
    if (gnEnt=20)
      rcatvmer=slcf('atvme', 1, 30, 18,, "e:kkl h:'���' c:n(7) e:getfield('t1','atvme->kkl','kgp','ngrpol') h:'������������' c:c(30) e:getfield('t1','atvme->kkl','kln','knasp') h:'KNASP' c:n(4) e:getfield('t1','atvme->kkl','kgp','rm') h:'��' c:n(1)",,, 1,, former,, iif(atrcr=0, '', iif(atrcr=1, '�����', '��த')))
    else
      rcatvmer=slcf('atvme', 1, 30, 18,, "e:kkl h:'���' c:n(7) e:getfield('t1','atvme->kkl','kln','nkl') h:'������������' c:c(30) e:getfield('t1','atvme->kkl','kln','knasp') h:'KNASP' c:n(4) e:getfield('t1','atvme->kkl','kgp','rm') h:'��' c:n(1)",,, 1,, former,, iif(atrcr=0, '', iif(atrcr=1, '�����', '��த')))
    endif

    sele atvme
    go rcatvmer
    kklr=kkl
    do case
    case (lastkey()=K_ESC)   // ��室
      exit
    case (lastkey()=K_INS)// ��������
      atvmeins()
    case (lastkey()=-5)   // ��६�����
      atvmem()
    case (lastkey()=-2)   // ������
      atvmeflt()
    case (lastkey()= 7)   // �������
      netdel()
      skip -1
      if (bof())
        go top
      endif

    endcase

  enddo

RETURN (NIL)

/***********************************************************
 * atvmeins() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function atvmeins()
  clmins=setcolor('gr+/b,n/w')
  wmins=wopen(7, 25, 11, 55)
  wbox(1)
  store 0 to kklr
  store space(20) to nklr

  @ 0, 1 say '��㧮�����⥫�' get kklr pict '9999999' valid grpol()
  read
  nklr=getfield('t1', 'kklr', 'kln', 'nkl')
  @ 1, 1 say '������������   '+' '+nklr
  if (lastkey()=K_ESC)
    wclose(wmins)
    setcolor(clmins)
    return
  endif

  wselect(wmins)
  mminsr=0
  @ 2, 14 prom '��୮'
  @ 2, col()+1 prom '�� ��୮'
  menu to mminsr

  sele atvme
  if (!netseek('t1', 'vmrshr,kklr'))
    netadd()
    netrepl('vmrsh,kkl', 'vmrshr,kklr')
    rcatvmer=recn()
  else
    go rcatvmer
  endif

  wclose(wmins)
  setcolor(clmins)
  return (.t.)

/***********************************************************
 * grpol() -->
 *   ��ࠬ���� :
 *   �����頥�:
 */
function grpol()
  knaspr=getfield('t1', 'kklr', 'kln', 'knasp')
  if (gnEntrm=0)
    if (atrcr#0)
      if (knaspr=1701.and.atrcr=1)
        wmess('��������!!! ��㧮�����⥫� ��த', 1)
      endif

      if (knaspr#0.and.knaspr#1701.and.atrcr=2)
        wmess('��������!!! ��㧮�����⥫� ࠩ��', 1)
      endif

    else
      if (knaspr#0)
        if (knaspr=1701)
          wmess('��������!!! ��㧮�����⥫� ��த', 1)
        endif

        if (knaspr#1701)
          wmess('��������!!! ��㧮�����⥫� ࠩ��', 1)
        endif

      endif

    endif

  endif

  return (.t.)

/************** */
function atvmem()
  /************** */
  clmr=setcolor('gr+/b,n/w')
  wmr=wopen(7, 25, 13, 55)
  wbox(1)
  while (.t.)
    store 0 to vmrsh_r
    @ 0, 1 say '������  '+' '+str(kklr, 7)
    @ 1, 1 say '���.����'+' '+str(vmrsh, 3)
    @ 2, 1 say '���.����' get vmrsh_r pict '999'
    read
    if (lastkey()=K_ESC)
      exit
    endif

    if (lastkey()=K_ENTER.and.vmrsh#vmrsh_r)
      netrepl('vmrsh', 'vmrsh_r')
      skip -1
      while (vmrsh#vmrshr)
        skip -1
        if (bof())
          exit
        endif

      enddo

      if (bof())
        go top
      endif

      rcatvmer=recn()
      exit
    endif

  enddo

  wclose(wmr)
  setcolor(clmr)
  return (.t.)

/************** */
function atvmeflt()
  /************** */
  clmr=setcolor('gr+/b,n/w')
  wmr=wopen(7, 25, 13, 55)
  wbox(1)
  while (.t.)
    store 0 to kkl_r
    @ 0, 1 say '������  ' get kkl_r pict '9999999'
    //  @ 1,1 say '���.����'+' '+str(vmrsh,3)
    //  @ 2,1 say '���.����' get vmrsh_r pict '999'
    read
    if (lastkey()=K_ESC)
      former=forme_r
      exit
    endif

    if (lastkey()=K_ENTER)
      former=forme_r+'.and.kkl=kkl_r'
      exit
    endif

  enddo

  wclose(wmr)
  setcolor(clmr)
  return (.t.)

/********************************** */
function vmrshob()
  //���������� ������⮢ �� kgp.dbf
  /********************************** */
  clea
  set prin to txt.txt
  set prin on
  sele atvme
  set orde to tag t2
  ?'��������'
  sele atvme
  go top
  kkl_r=9999999
  vmrsh_r=999
  while (!eof())
    if (kkl=kkl_r.and.vmrsh=vmrsh_r)
      ?str(kkl, 7)+' '+str(vmrsh, 3)+' ������� '
      netdel()
      skip
      loop
    endif

    kkl_r=kkl
    vmrsh_r=vmrsh
    skip
  enddo

  ?'��� � KGP'
  sele atvme
  go top
  while (!eof())
    kklr=kkl
    vmrshr=vmrsh
    if (!netseek('t1', 'kklr'))
      ?str(kklr, 7)+' '+str(vmrshr, 3)+' ���'
    endif

    sele atvme
    skip
  enddo

  ?'���४��'
  sele kgp
  go top
  while (!eof())
    kklr=kgp
    vmrshr=vmrsh
    sele atvme
    netseek('t2', 'kklr')
    if (!foun())
      if (vmrshr#0)
        ?str(vmrshr, 3)+' '+str(kklr, 7)+' ��������'
        //        netadd()
      //        netrepl('vmrsh,kkl','vmrshr,kklr')
      endif

    else
      prerr=0
      while (kkl=kklr)
        if (vmrsh#vmrshr.and.(vmrshr#0.or.vmrsh#0))
          prerr=1
          exit
        endif

        skip
      enddo

      if (prerr=1)
        netseek('t2', 'kklr')
        while (kkl=kklr)
          ?str(kklr, 7)+' ATVME '+str(vmrsh, 3)+' KGP '+str(vmrshr, 3)
          skip
        enddo

      endif

    endif

    sele kgp
    skip
  enddo

  set prin off
  set prin to
  wmess('���������� ����祭�', 0)
  return (.t.)
