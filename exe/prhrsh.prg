setcolor('g/n,n/g')
fclr=setcolor()
clear
store 0 to mrshr,mrshNppr,prvzznr

przn=0    // �ਧ��� ������ ���㬥��
corsh=0   // �ਧ��� ���४樨 蠯��
pptr=0    // �ਧ��� �ਢ易���� ���
tarar=1   // �ਧ��� �����⭮� ���
prinstr=0 // �ਧ��� "������ ��������� � TOV,TOVD,CTOV"
mrshNppr=0
mrshr=0
pr49r=0
store 0 to onofr,opbzenr,opxzenr,;
           otcenpr,otcenbr,otcenxr,;
           odecpr,odecbr,odecxr,prdecr,prc177r,mntov177r

*fnlr=0   // �ਧ��� ������� �����
*if file(gcpath_t+"final.dbf")
  //  fnlr=1
*endif
Nppr=0   // �������樮��� ����� ��⮪���
prNppr=0 // ��� ����⢨� ॣ�����㥬��� � ��⮪���
store date() to dNpp
store space(8) to tNpp

  //��ଠ� �5 ������ ���� ᦠ��
  //���� 43
  //�ਭ� 95

str_lst=43

  //���樠������ SOPER
store 0 to d0k1r,kopr,koppr,qr,ndsr,pndsr,grtcenr,tcenr,ptcenr,xndsr,xtcenr,pxzenr,;
           skar,sklar,msklar,zcr,prnnr,ttor,vpr,autor,okklr,okplr,pbzenr,rtcenr,nofr
store '' to cuchr,cotpr,cdopr,cxotpr
vur=gnVu
vor=gnVo
store 0 to gnSkt,gnSklt,gnMsklt // �-�� ����.�� SOPER

store space(40) to NOPr
store '' to nvur,nvor,nopr,nndsr,npndsr,ntcenr,nptcenr,nsklar,;
            nokklr,nrtcenr,nttor,nxtcenr
store '' to coptr,cboptr,croptr,cxoptr
store 0 to optr,boptr,roptr,xoptr
for i=1 to 20
    if i<10
       ir=str(i,1)
    else
       ir=str(i,2)
    endif
    cdszr='dsz'+ir+'r'
    cddbr='ddb'+ir+'r'
    cdkrr='dkr'+ir+'r'
    cprzr='prz'+ir+'r'
    &cdszr=0
    &cddbr=0
    &cdkrr=0
    &cprzr=space(6)
next

if !netuse('kspovo')
   nuse()
   wmess('�� 㤠���� ������ KSPOVO',3)
   retu
endif
if !netuse('soper')
   nuse()
   wmess('�� 㤠���� ������ SOPER',3)
   retu
endif
if !netseek('t1','gnD0k1,gnVu,gnVo').and.gnVo#0
   wmess('��� ����権 ��� �⮣� ०���',3)
   nuse()
   retu
endif
  //���樠������ S_TAG
  store 0 to ktar,kecsr
if !netuse('s_tag')
   nuse()
   wmess('�� 㤠���� ������ S_TAG',3)
   retu
endif
if !netuse('stagm')
   nuse()
   wmess('�� 㤠���� ������ STAGM',3)
   retu
endif
  //���樠������ CZG
if !netuse('czg')
   nuse()
   wmess('�� 㤠���� ������ CZG',3)
   retu
endif
  //���樠������ CMRSH
if !netuse('cmrsh')
   nuse()
   wmess('�� 㤠���� ������ CMRSH',3)
   retu
endif
  //���樠������ SGRP
  store 0 to kgrr,otr,kgrsr,markr,licr,grpr
  store space(20) to ngrr,ngrsr,nalr
if !netuse('sgrp')
   nuse()
   wmess('�� 㤠���� ������ SGRP',3)
   retu
endif
netuse('atvm')
netuse('atvme')
if gnCtov=1
     //���樠������ CGRP
     store 0 to kgrr,otr,kgrsr,markr,licr,grpr,tgrpr
     store space(20) to ngrr,ngrsr,nalr
   if !netuse('cgrp')
      nuse()
      wmess('�� 㤠���� ������ CGRP',3)
      retu
   endif
   if !netuse('crosid')
      nuse()
      wmess('�� 㤠���� ������ CROSID',3)
      retu
   endif

endif
  //���樠������ grpizg
*if !netuse('grpizg')
  //  nuse()
  //  wmess('�� 㤠���� ������ GRPIZG',3)
  //  retu
*endif

  //���樠������ fop
if !netuse('fop')
   nuse()
   wmess('�� 㤠���� ������ FOP',3)
   retu
endif
fopr=0
nfopr=space(20)
if !netUse('dokk')
   nuse()
   retu
endif
if !netUse('bs')
   nuse()
   retu
endif
if !netUse('dkkln')
   nuse()
   retu
endif
if !netUse('knasp')
   nuse()
   retu
endif
if !netUse('dknap')
   nuse()
   retu
endif

if !netUse('dkklns')
   nuse()
   retu
endif

if !netUse('dkklna')
   nuse()
   retu
endif

if !netUse('dokko')
   nuse()
   retu
endif

if !netUse('moddoc')
   nuse()
   retu
endif
if !netUse('mdall')
   nuse()
   retu
endif

if !netUse('nap')
   nuse()
   retu
endif
if !netUse('naptm')
   nuse()
   retu
endif
if !netUse('kplnap')
   nuse()
   retu
endif
if !netUse('ktanap')
   nuse()
   retu
endif

*netuse('opfh')

  //���樠������ klnnac
if !netuse('klnnac')
   nuse()
   wmess('�� 㤠���� ������ KLNNAC',3)
   retu
endif

  //���樠������ brnac
if !netuse('brnac')
   nuse()
   wmess('�� 㤠���� ������ BRNAC',3)
   retu
endif
  //���樠������ mnnac
if !netuse('mnnac')
   nuse()
   wmess('�� 㤠���� ������ MNNAC',3)
   retu
endif

  //���樠������ klndog
if !netuse('klndog')
   nuse()
   wmess('�� 㤠���� ������ KLNDOG',3)
   retu
endif
*****************
netuse('kplkgp')
*****************
*****************
netuse('kpl')
*****************
*****************
netuse('kps')
*****************
*****************
netuse('kgp')
*****************
*****************
netuse('kgpcat')
*****************
*****************
netuse('etm')
*****************
*****************
netuse('stagtm')
*****************
*****************
netuse('edz')
*****************
*****************
netuse('tmesto')
*****************
*****************
netuse('atran')
*****************
*****************
netuse('nnds')
*****************
*****************
netuse('posid')
*****************
*****************
netuse('posbrn')
*****************
*****************
netuse('cntm')
if recc()=0
   netadd()
endif
*****************
  //���樠������ mkeep
if !netuse('MKeep')
   nuse()
   wmess('�� 㤠���� ������ MKeep',3)
   retu
endif

  //���樠������ mkeepe
if !netuse('MKeepE')
   nuse()
   wmess('�� 㤠���� ������ MKeepE',3)
   retu
endif
if !netuse('brand')
   nuse()
   wmess('�� 㤠���� ������ brand',3)
   retu
endif

if !netuse('kgptm')
   nuse()
   wmess('�� 㤠���� ������ KGPTM',3)
   retu
endif

if !netuse('krntm')
   nuse()
   wmess('�� 㤠���� ������ KRNTM',3)
   retu
endif

if !netuse('nasptm')
   nuse()
   wmess('�� 㤠���� ������ NASPTM',3)
   retu
endif

if !netuse('rntm')
   nuse()
   wmess('�� 㤠���� ������ RNTM',3)
   retu
endif

if !netuse('kplbon')
   nuse()
   wmess('�� 㤠���� ������ KPLBON',3)
   retu
endif

if !netuse('kplboe')
   nuse()
   wmess('�� 㤠���� ������ KPLBOE',3)
   retu
endif

  //���樠������ TOV
store 0 to k1tr,kger,mntovr,kgr,mnntovr,osfr,osvr,osnr,vupackr,keir,kachr,;
           keipr,vesr,postr,izgr,vespr,upakr,sertr,srealr,kodst1r,vesst1r,;
           kodst2r,vesst2r,osfmr,keurr,keur1r,keur2r,keur3r,keur4r,keuhr,;
           optr,optzr,cenprr,cenpsr,rozprr,rozpsr,rozmgr,roz05r,kgnr,ktlnr,;
           kgsr,ktlsr,barr,loc,ksertr,kukachr,kspovor
store '' to neir,neipr,tovdopr,namr,upur
store space(60) to natr,nair
store ctod('') to dppr,dpor,drlzr
for i=1 to 30
    if i<10
       ir='0'+str(i,1)
    else
       ir=str(i,2)
    endif
    ccr='c'+ir+'r'
    &ccr=0
next

if !netUse('tov')
   nuse()
   wmess('�� 㤠���� ������ TOV',3)
   retu
endif
set orde to tag t1
if fieldsize(fieldpos('ktl'))#9
   wmess('UPGRADE.������� � ������������!!!',1)
   nuse()
   retu
endif
*******************************************
*netuse('tovpt') //��� �஢��ન ࠡ��� � ᮢ���⭮� ����㯥
*******************************************
*******************************************
if gnCtov=1
   netUse('tovm','tovmsrt')
endif
netUse('tov','tovsrt')
netuse('kprod')
*******************************************
do case
   case gnCtov=0                       // ����� ०��
   case gnCtov=1
        if !netUse('ctov')             // ��騩 �ࠢ�筨�
           nuse()
           wmess('�� 㤠���� ������ CTOV',3)
           retu
        endif
        set orde to tag t1
        if !netfile('tovm')
           copy file (gcPath_a+'tov.dbf') to (gcPath_t+'tovm.dbf')
           netind('tovm')
        endif
        if !netuse('tovm')
           nuse()
           wmess('�� 㤠���� ������ TOVM',3)
           retu
        endif
        *******************************************
        netUse('tovm','tovmsrt')
        *******************************************
        if !netfile('rs2m')
           copy file (gcPath_a+'rs2.dbf') to (gcPath_t+'rs2m.dbf')
           netind('rs2m')
        endif
        if !netuse('rs2m')
           nuse()
           wmess('�� 㤠���� ������ RS2M',3)
           retu
        endif
        set orde to tag t3
        if lower(indexkey())='str(ttn,6)+str(mntovp,7)+str(ktlp,9)+str(ppt,1)+str(mntov,7)+str(ktl,9)'
           prrs2mr=1
        else
           prrs2mr=0
        endif
        set orde to tag t1
        store 0 to mntovr,mntovpr
   case gnCtov=2
        if !netUse('tovd')             // ����������
           nuse()
           wmess('�� 㤠���� ������ TOVD',3)
           retu
        endif
        set orde to tag t1
   case gnCtov=3
        if !netUse('ctovk')             // ��騩 ����७��� �ࠢ�筨� KTL
           nuse()
           wmess('�� 㤠���� ������ CTOVK',3)
           retu
        endif
        set orde to tag t1
        if !netUse('cgrpk')             // ��騩 ����७��� �ࠢ�筨� ��㯯
           nuse()
           wmess('�� 㤠���� ������ CGRPK',3)
           retu
        endif
        set orde to tag t1
endc
  //���樠������ GRU
if !netfile('gru')
   copy file (gcPath_a+'gru.dbf') to (gcPath_E+'gru.dbf')
   netind('gru')
endif
if !netuse('gru')
   nuse()
   wmess('�� 㤠���� ������ GRU',3)
   retu
endif
  //���樠������ PR1,RS1
   store ctod('') to dvpr,ddcr,dnzr,dopr
   store space(8) to tdcr
   store 0 to kplr,ktor,sdvr,sksr,sklsr,sktr,skltr,sdv2r,pr49r
   stor space(10) to nnzr,atnomr
   store space(60) to textr
  //���樠������ PR2,RS2
  store 0 to ktlr,kplr,zenr,kfr,sfr,bzenr,xzenr,srr,seur
  //���樠������ PR3,RS3
  store 0 to kszr,ssfr,bssfr,xssfr,prr,bprr,xprr
  //���樠������ GrpE
if !netuse('GrpE')
   nuse()
   wmess('�� 㤠���� ������ GrpE',3)
   retu
endif
  //���樠������ SL
if select('sl')=0
   sele 0
   use _slct alia sl excl     //s_slct
else
   sele sl
endif
zap
  //���樠������ SPENG
if !netUse('speng')
   nuse()
   wmess('�� 㤠���� ������ SPENG',3)
   retu
endif
  //���樠������ SERT
if !netUse('sert')
   nuse()
   wmess('�� 㤠���� ������ SERT',3)
   retu
endif
  //���樠������ UKACH
if !netUse('ukach')
   nuse()
   wmess('�� 㤠���� ������ UKACH',3)
   retu
endif
  //���樠������ KLN
if !netUse('kln')
   nuse()
   wmess('�� 㤠���� ������ KLN',3)
   retu
endif
  //���樠������ BANKS
if !netUse('banks')
   nuse()
   wmess('�� 㤠���� ������ BANKS',3)
   retu
endif
  //���樠������ NEI
if !netUse('nei')
   nuse()
   wmess('�� 㤠���� ������ NEI',3)
   retu
endif
  //���樠������ TARA
if !netUse('tara')
   nuse()
   wmess('�� 㤠���� ������ TARA',3)
   retu
endif
  //���樠������ DCLR
if !netUse('dclr')
   nuse()
   wmess('�� 㤠���� ������ DCLR',3)
   retu
endif
  //���樠������ CSKLE
if !netuse('cskle')
   nuse()
   wmess('�� 㤠���� ������ CSKLE',3)
   retu
endif
  //���樠������ CSKL
if !netuse('cskl')
   nuse()
   wmess('�� 㤠���� ������ CSKL',3)
   retu
endif
  //���樠������ TCEN
if !netuse('tcen')
   nuse()
   wmess('�� 㤠���� ������ TCEN',3)
   retu
endif
  //���樠������ PODR
if !netuse('podr')
   nuse()
   wmess('�� 㤠���� ������ PODR',3)
   retu
endif
netuse('skl')
if gnKt=1
   netuse('otkt')
   netuse('otkte')
endif
******************************************************************
  //������祭�� ���⨣�㯯
*******************************************************************
if gnMskl=1.and.gnCtov#3
   if !netfile('sGrpE')
      mess('�������� SGrpE')
      copy file (gcPath_a+'sGrpE.dbf') to (gcPath_t+'sGrpE.dbf')
      netind('sGrpE')
      netuse('sGrpE')
      netuse('tov')
      do while !eof()
         sklr=skl
         ktlr=ktl
         kgr=int(ktlr/1000000)
         sele sGrpE
         if !netseek('t1','sklr,kgr')
            netadd()
            netrepl('skl,kg,ktl','sklr,kgr,ktlr')
         else
            if ktlr>ktl
               netrepl('ktl','ktlr')
            endif
         endif
         sele tov
         skip
      enddo
      nuse('tov')
   endif
   if !netuse('sGrpE')
      nuse()
      wmess('�� 㤠���� ������ SGrpE',3)
      retu
   endif
   clea
endif
********************************************************************
  //����� ������祭�� ���⨣�㯯
********************************************************************
netuse('pr1')
if netseek('t3','1')
   gnOtv=1 // ����� ࠡ�⠥� � �⢥��࠭�����
else
   gnOtv=0
endif
nuse('pr1')
if gnD0k1=1
   tbl1r='pr1'
   tbl2r='pr2'
   tbl3r='pr3'
   mdocr='mnr'
   fdocr='mn'
   fkolr='kf'
   fsumr='sf'
   fprr='prp'
   mprr='prpr'
     //���樠������ pr1
   store 0 to ndr,mnr,kpsr,bsr,sopr,rnr
   bprzr=0
   store ctod('') to dprr
   store space(8) to tprr
   if !netUse('pr1')
      nuse()
      wmess('�� 㤠���� ������ PR1',3)
      retu
   endif
     //���樠������ pr1g
   if !netfile('pr1g')
      copy file (gcPath_a+'pr1g.dbf') to (gcPath_t+'pr1g.dbf')
      netind('pr1g')
   endif
   if !netuse('pr1g')
      nuse()
      wmess('�� 㤠���� ������ PR1G',3)
      retu
   endif
     //���樠������ pr2
   if !netUse('pr2')
      nuse()
      wmess('�� 㤠���� ������ PR2',3)
      retu
   endif
     //���樠������ pr3
   if !netUse('pr3')
      nuse()
      wmess('�� 㤠���� ������ PR3',3)
      retu
   endif
     //���樠������ VOP
   if !netUse('vop')
      nuse()
      wmess('�� 㤠���� ������ VOP',3)
      retu
   endif
   netuse('nds')
   prh()
else
   tbl1r='rs1'
   tbl2r='rs2'
   tbl3r='rs3'
   mdocr='ttnr'
   fdocr='ttn'
   fkolr='kvp'
   fsumr='svp'
   fprr='pr'
   mprr='prr'
     //���樠������ rs1
   store 0 to ttnr,kgpr,spdr,bprzr,sdfr,vsvr,pdrr,konr,pprr,serr,numbr,vzz
   store ctod('') to dotr,dopr
   store space(8) to totr
   store '' to notr
   if !netUse('rs1')
      nuse()
      wmess('�� 㤠���� ������ RS1',3)
      retu
   endif
     //���樠������ rs1g
   if !netfile('rs1g')
      copy file (gcPath_a+'rs1g.dbf') to (gcPath_t+'rs1g.dbf')
      netind('rs1g')
   endif
   if !netuse('rs1g')
      nuse()
      wmess('�� 㤠���� ������ RS1G',3)
      retu
   endif
     //���樠������ rs2
   store 0 to kvpr,svpr,tnr,svr,sertr
   if !netUse('rs2')
      nuse()
      wmess('�� 㤠���� ������ RS2',3)
      retu
   endif
     //���樠������ rs3
   store 0 to sszr,postr
   if !netUse('rs3')
      nuse()
      wmess('�� 㤠���� ������ RS3',3)
      retu
   endif
   lcrtt('lrs3','rs3')
   lindx('lrs3','rs3')
   luse('lrs3')
   if !netuse('lic')
      nuse()
      wmess('�� 㤠���� ������ LIC',3)
      retu
   endif
   if !netuse('lice')
      nuse()
      wmess('�� 㤠���� ������ LICE',3)
      retu
   endif
   if !netuse('klnlic')
      nuse()
      wmess('�� 㤠���� ������ KLNLIC',3)
      retu
   endif
   if gnVo=5 .or.gnVo=4
      if !netuse('bs')
         nuse()
         wmess('�� 㤠���� ������ BS',3)
         retu
      endif
   endif
     //���樠������ VO
   if !netUse('vo')
      nuse()
      wmess('�� 㤠���� ������ VO',3)
      retu
   endif
   netuse('nds')
   netUse('mkcros')
   if przvr=0
      rsh()
   else
      rszg()
   endif
   if select('lrs3')#0
      sele lrs3
      use
      erase lrs3.dbf
      erase lrs3.cdx
   endif
endif

store 0 to entpr,sktpr,skltpr,otpr,kgpr,amnpr
store '' to nentpr,nsktpr,nskltpr,notpr,ngpr
store '' to pathepr,direpr,pathtpr,pathbpr

