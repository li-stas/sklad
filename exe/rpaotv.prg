* ������ � ��⮪�� �த��                 otv=2
* ���४�� ��室� ��� ���⪮� ��.��. otv=1
a_ktl:={}
a_ktln:={}
netUse('tov')
netUse('tovm')
netuse('sgrp')
netUse('rs1')
netUse('rs3')
netUse('rs2')
if !netseek('t1','ttnr')
   retu
endif
netUse('pr1')
netUse('pr2')
netUse('pr3')


*** ����� �� rs1 , ������� � pr1 *******************
sele rs1
if netseek('t1','ttnr',,,1)
   sklr=skl
endi
*** ����� � rs2 , ������� � pr2 ********************
SELE rs2
netseek('t1','ttnr')
do while ttn=ttnr
   ktlr=ktl
   otv_r=otv
   if otv_r=3 // ����� � ������. ���� (��⮪�� �த�� �� ���४������)
      skip
      loop
   endif
   if otv_r=0
      optr=getfield('t1','sklr,ktlr','tov','opt')
      if optr=0
         netrepl('otv','1')
         otv_r=1  // ����� � ��.��. opt=0
      endif
   endif
   * otv_r=2 ����� � ��⮪��� �த�� (���४�� � ��⮪��� �த��)
   if otv_r=0  // ����� � ��ଥ (��⮪�� �த�� �� ���४������)
      sele rs2
      skip
      loop
   endif
   mntovr=mntov
   kpsr=getfield('t1','sklr,ktlr','tov','post')
   ktlpr=ktlp
   pptr=ppt
   kfr=kvp     // ����饥 ���祭��
   kvpor=kvpo  // �।��饥 (������⢮ ��ࠢ������ � ��⮪�� �த��)
   mnr=amnp    // MN ��⮪��� �த��
   sele pr1
   if mnr#0
      if !netseek('t2','mnr')
         mnr=0
      endif
   endif
   if mnr=0
      sele pr1
      if netseek('t3','2,kpsr')
         mnr=mn
      else

          sele cskl
          netseek('t1','gnSk')
          Reclock()
          mnr=mn
          if mn<999999
            Replace mn with mn+1
          else
            Replace mn with 1
          endif
          netunlock()

         sele pr1
         netadd()
         netrepl('nd,mn,skl,vo,kps,kop,ddc,tdc,otv',;
         'mnr,mnr,sklr,9,kpsr,101,date(),time(),2')
      endif
   endif
   sele pr2
   if !netseek('t1','mnr,ktlr,ktlpr')
      netadd()
      netrepl('mn,mntov,ktl,kf,kfo,ktlp,ppt',;
              'mnr,mntovr,ktlr,kfr,kfr,ktlpr,pptr')
   else
      netrepl('kf,kfo','kf+kfr-kvpor,kfo+kfr-kvpor')
   endif
   kf_r=kfr-kvpor // ������⢮ ��� ���४樨
   * ���४�� ������⢠ � ��室�� � ��.��. (���������� ��室�)
   sele pr1
   set orde to tag t3
   if netseek('t3','1,kpsr')
      do while otv=1.and.kps=kpsr
         mn_r=mn
         sele pr2
         if netseek('t1','mn_r,ktlr,ktlpr')
            if kf-kf_r>=0  // ������� � ⥪. ���祭��
               if kf-kf_r<=kfo // ������� � �-�� ��室�
                  netrepl('kf','kf-kf_r')
                  kf_r=0
                  exit
               else            // �� �������,���� � ⥪�騩,���⮪ � ᫥�.
                  kf_r=(kf-kf_r)-kfo
                  netrepl('kf','kfo')
               endif
            else          // �� �������,���� � ⥪�騩,���⮪ � ᫥�.
               kf_r=kf_r-kf
               netrepl('kf','0')
            endif
         endif
         sele pr1
         skip
      endd
      if kf_r#0  // �� �� ������
         wmess('�� ����뢠���� '+str(ktlr,9),2)
      endif
   endif
   sele rs2
   netrepl('amnp,kvpo,otv','mnr,kfr,2')
   skip
endd
nuse('pr1')
nuse('pr2')
nuse('pr3')
retu
