#include "common.ch"
#include "inkey.ch"
****************************************
* ��������� ��������� �� ⮢���
****************************************
*Private Ttnr,Men1,Tlfr,Nnr,Nsvr,Kkl1r,Nklr,Adrr,Dotr,Sdvr,Nopr
*Private Kopr,Vor,Sklr,Stri,Err,Rnds,Tar_kl,N_nds,prnnr,cntnttr,ddokr
if gnPnds=1 // ��壠���
else        // 2 - �����
   skr=gnSk
endif
ddokr=ctod('')
prnnr=1  // �� ⮢���
save scre to scnnt
clnnt=setcolor('g/n,n/g')
clea
*����⨥ ��� ������
netuse('bs',,'s')
netuse('dokk',,'s')
netuse('dkkln',,'s')
netuse('dknap',,'s')
netuse('kln',,'s')
netuse('tara',,'s')
netuse('nds',,'s')
netuse('tovn')
netuse('klndog')
*netuse('opfh')
if select('sl')=0
   sele 0
   use _slct alia sl      //s_slct
   if !nota('����� ����� !  �������� ������� !')
      retu
   endi
else
   sele sl
endif
zap
if gnPnds#1
**************************
* ������� ���४��
**************************
* ���࠭��� ��६����
nop_rr=nopr
ttn_rr=ttnr
sr_rr=srr
kop_rr=kopr
vu_rr=vur
vo_rr=vor
skl_rr=sklr
rnds_rr=rndsr
nds_rr=ndsr
cntttn_rr=cntttnr
bs_rr=bsr
ddok_rr=ddokr
sdv_rr=sdvr
sk_rr=skr
*
sele nds
set orde to tag t2
if netseek('t2','kplr')
   store 0 to sndsdr,sndscr,korktlr,ndsdr
   store ctod('') to dnnr
   do while kkl=kplr
      if korktl#0
         korktlr=korktl
      endif
      if ndsd=0.and.ttn=0.and.sk=0 // �� ��� ���죨
         ndsdr=nomnds
         sndsdr=sndsdr+sum
         dnnr=dnn
      else
         sndscr=sndscr+sumc
      endif
      skip
   endd
   szcorr=sndsdr-sndscr
   if szcorr>0
      sumcr=szcorr
      nopr='���� ��� �� �।�����'
      ttnr=0
      srr=0
      kopr=0
      vur=0
      vor=0
      sklr=0
      rndsr=0
      ndsr=0
      cntttnr=1
      bsr=0
      if gnArm=3
         dtt=dopr
      else
         if month(gdTd)#month(date())
            dtt=eom(gdTd)
         else
            dtt=gdTd
         endif
      endif
      ddokr=dtt
      sele setup
      locate for ent=gnEnt
      reclock()
      nomndsr=nnds
      sele nds
      do while .t.
         if netseek('t1','nomndsr')
            nomndsr=nomndsr+1
            loop
         endif
         sele setup
         netrepl('nnds','nomndsr+1')
         exit
      endd
      sele nds
      netadd()
      netrepl('nomnds,sum,sumc,kkl,dnn,ttn,ndsd,d0k1,korktl,rmsk',;
              'nomndsr,sumcr,sumcr,kplr,dtt,0,ndsdr,d0k1r,korktlr,gnRmsk')
      korktlr=korktl
      kklr=kkl
      nklr=nkplr
      sele kln
      if netseek('t1','kplr')
         adrr=adr
         tlfr=tlf
         nsvr=nsv
         nnr=nn
         kkl1r=kkl1
      endif
      sumkr=sumcr
      aTtn:={}
      private aRab[1,5]
      aRab[1,1]=0 //ttnr
      aRab[1,2]=0
      aRab[1,3]=sumcr
      aRab[1,4]=sumcr
      aRab[1,5]=dtt
      PNN()
   endif
endif
**************************
* ����� ������� ���४樨
**************************
* ����⠭����� ��६����
nopr=nop_rr
ttnr=ttn_rr
srr=sr_rr
kopr=kop_rr
vur=vu_rr
vor=vo_rr
sklr=skl_rr
rndsr=rnds_rr
ndsr=nds_rr
cntttnr=cntttn_rr
bsr=bs_rr
ddokr=ddok_rr
sdvr=sdv_rr
skr=sk_rr
*
endif
sele sl
zap
Do While .T.
  clea
  sele sl
  zap
  save scree to scnnt
  aKln={} // ���ᨢ �����⮢ � ���죠��
  if gnPnds=1
     store 0 to ttnr,kplr
  endif
  store 0 to Tar_kl,Kkl1r,Nnr,err,sumdr,sumkr,sumtr,prcor,;
             sumcr,ndsdr,nomndsr,sumr,sumdtr,sumdcr,bsr
  store '' to Adrr,Nsvr,Tlfr
  knds=1
  sumcr=0.00
  Men1  = 1
  sele dkkln
  go top
  save scre to scmess
  mess('����,���� �����⮢��...')
  if gnPnds=1
     do while !eof()
        bsr=bs
        if !(kn-dn+kr-db>0.and.kr>db).or.getfield('t1','bsr','bs','uchr')#2
           skip
           loop
        endif
        kklr=kkl
        if kn-dn>0
           sumdr=kr-db-dn
        else
           sumdr=kn-dn+kr-db
        endif
        sele kln
        seek str(kklr,7)
        if FOUND()
           nklr:=nkl //subs(nkl,1,30)
        else
           nklr='��� � �ࠢ�筨��             '
        endif
        aadd(aKln,nklr+'�'+str(kklr,7)+'�'+str(sumdr,12,2))
        sele dkkln
        skip
     endd
  else
     netseek('t1','kplr')
     do while kkl=kplr
        bsr=bs
        if !(kn-dn+kr-db>0.and.kr>db).or.getfield('t1','bsr','bs','uchr')#2  // bs#6200
           skip
           if eof()
              exit
           endif
           loop
        endif
        kklr=kkl
        if kn-dn>0
           sumdr=kr-db-dn
        else
           sumdr=kn-dn+kr-db
        endif
        sele kln
        seek str(kklr,7)
        if FOUND()
           nklr:=nkl
        else
           nklr='��� � �ࠢ�筨��             '
        endif
        aadd(aKln,nklr+'�'+str(kklr,7)+'�'+str(sumdr,12,2))
        sele dkkln
        skip
     endd
  endif
  rest scre from scmess
  @ 0,0,6,78 box frame
  Set Cursor On
  if gnArm=5
     Dtt = gdTd
  else
     Dtt = getfield('t1','ttnr','rs1','dop')
     if dtt=ctod(' ')
        dtt=gdTd
     endif
  endif
  wdtt=wopen(10,30,13,50)
  wbox(1)
  @ 0,1 say '���' get dtt
  read
  wclose(wdtt)
  if gnPnds=1
     @ 1,1 Say '������' Get kplr Picture '9999999'
     Read
  endif
  If LastKey() = 27
    Exit
  EndIf
  if kplr=0.and.gnPnds=1
     save scre to scmess
     mess('����,���� �⡮� �����⮢...')
     sele kln
     copy stru to (gcPath_l+'\kln.dbf')
     use
     sele 0
     use (gcPath_l+'\kln.dbf') excl
     netuse('kln','kln1','s')
     store 0 to mnds1r,mnds2r,mnds3r
     sele dokk
     seek str(0,6)+str(0,6)
     if FOUND()
        kklr=0
        rnr=0
        do while mn=0.and.rnd=0
           if prnn=0
              skip
              loop
           endif
           if kkl=kklr
              skip
              loop
           endif
           do case
              case nds=0.or.nds=1.or.nds=5  // 03.04.2000
                   mnds1r=1
              case nds=2
                   mnds2r=1
              case nds=3.or.nds=4
                   mnds3r=1
           endc
           kklr=kkl
           rnr=rn
           sele kln1
           seek str(kklr,7)
           if FOUND()
              kkl1r=kkl1
              nklr=nkl
           else
              kkl1r=0
              nklr='��� � �ࠢ�筨��'
           endif
           sele kln
           netadd()
           netrepl('kkl,kkl1,nkl','kklr,kkl1r,nklr')
           sele dokk
           skip
        enddo
     endif
     sele kln1
     use
     sele kln
     inde on nkl tag t1
     set orde to tag t1
     go top
     rest scre from scmess
*     kplr=slc('kln',,,,,'nkl c(30),kkl n(7,0)','������������,���','kkl',0,1)
     kplr=slcf('kln',,,,,"e:nkl h:'������������' c:c(30) e:kkl h:'���' c:n(7)",'kkl')
     sele kln
     use
     erase (gcPath_l+'\kln.dbf')
     erase (gcPath_l+'\kln.cdx')
     netuse('kln',,'s')
  endif
  if kplr=0
     exit
  endif
  sele kln
  seek str(kplr,7)
  if FOUND()
     nklr=alltrim(nkl)
     adrr=adr
     tlfr=tlf
     nnr=nn
     nsvr=nsv
     kkl1r=kkl1
  else
     nklr='��� � �ࠢ�筨��'
     store '' to adrr,tlfr,nsvr
     nnr=0
  endif
  @ 1,1 Say '������ '+str(kkl1r,8)+'('+str(kplr,7)+') '+nklr
  @ 2,1 Say '����   '+adrr
  @ 3,1 Say '����䮭 '+tlfr
  @ 4,1 Say '�����.N '+str(nnr,14)
  @ 5,1 Say '�����. '+nsvr
  kszrr=12
  netuse('rs3')
  sele rs3
  if netseek('t1','ttnr,kszrr')
     tarar=0
  else
     tarar=1
  endif
  *sele tara
  *seek kplr
  *if FOUND()
  *   tarar=1
  *else
  *   tarar=0
  *endif
  a=0
  for i=1 to len(aKln)
      sumkr=val(subs(aKln[i],40,12))
     if val(subs(aKln[i],32,7))=kplr
        a=1
        exit
     endif
  next
  if a#0
     @ 2,45 say '����஫쭠� �㬬�   '+str(sumkr,12,2)
  else
     @ 2,45 say '������ ���                     '
  endif
  sele nds
  set orde to tag t2
  seek str(kplr,7)+str(0,10)+str(0,3)
  aNnd ={} // ���ᨢ �� ��� ���죨
  aNndt={} // ���ᨢ ��+���+��� ��� ���죨 (���४��)
  aNnt ={} // ���ᨢ ��+��� ��� ⮢��
  prnndr=0
  sumdr=0
  if FOUND() // ������� �� �� ���죠�
     prnndr=1
     do while kkl=kplr.and.ndsd=0.and.sk=0
        aadd(aNnd,str(nomnds,6)+'�'+str(sum,12,2))
        sumdr=sumdr+sum
        skip
     endd
     for i=1 to len(aNnd)
         ndsdr=val(subs(aNnd[i],1,6))
         seek str(kplr,7)+str(ndsdr,10)
         if FOUND()
            do while kkl=kplr.and.ndsd=ndsdr
*               if dnn>=bom(gdTd).and.dnn<=eom(gdTd)
                  aadd(aNndt,str(nomnds,6)+'�'+str(sk,3)+'�'+str(ttn,6)+'�'+str(ndsdr,6)) // ���������� ���ᨢ� �믨ᠭ��� �� �� NDS ��� ���죨
                  sumdtr=sumdtr+sum
                  sumdcr=sumdcr+sumc
*               endif
               skip
            endd
         else
         endif
     next

*     sumcr=sumdr-sumdtr
     sumcr=sumdr-sumdcr


     if str(sumcr,10,2)>str(0.00,10,2).and.substr(alltrim(str(sumcr,10,2)),1,1)#'-'  // ���४��
        prcor=1
     else
        prcor=0
     endif
  endif

  seek str(kplr,7)+str(0,10)
  if FOUND()
     do while kkl=kplr.and.ndsd=0
        if sk=0
           skip
           loop
        endif
        if dnn>=bom(gdTd).and.dnn<=eom(gdTd)
           aadd(aNnt,str(nomnds,6)+'�'+str(sk,3)+'�'+str(ttn,6)) // ���������� ���ᨢ� �믨ᠭ��� �� �� NDS ��� ⮢��
           sumtr=sumtr+sum
        endif
        skip
     endd
  endif
  aTtn={}
  if gnPnds=2
     do case
        case p_nds=0.or.p_nds=1.or.p_nds=5 // 03.04.2000
             mndsr=1
             @ 3,45 say '     �⠢�� 20%     '
        case p_nds=2
             mndsr=2
             @ 3,45 say '     �⠢��  0%     '
        case p_nds=3.or.p_nds=4
             mndsr=3
             @ 3,45 say '�⠢�� 20% � ��業��'
     endc
     aadd(aTtn,'��'+str(ttnr,6)+'�'+str(skr,3)) // ttn,�믨�뢠���� ᪫����
  else
     @ 3,45 prom '     �⠢�� 20%     '
     @ 3,45 prom '     �⠢��  0%     '
     @ 3,45 prom '�⠢�� 20% � ��業��'
     menu to mndsr
     if lastkey()=K_ESC
        loop
     endif
     sele dokk
     seek str(0,6)+str(0,6)+str(kplr,7)
     if FOUND()
        rnr=0
        do while mn=0.and.rnd=0.and.kkl=kplr
           do case
              case mndsr=1
                   if !(nds=0.or.nds=1.or.nds=5)  // 03.04.2000
                      skip
                      loop
                   endif
              case mndsr=2
                   if nds#2
                      skip
                      loop
                   endif
              case mndsr=3
                   if !(nds=3.or.nds=4)
                      skip
                      loop
                   endif
           endc
           if prnn=0
              skip
              loop
           endif
           if rnr=rn
              skip
              loop
           endif
           rnr=rn
           skr=sk
           p_nds=nds
           a=0
           for i=1 to len(aNndt)
               sk_r=val(subs(aNndt[i],8,3))
               ttn_r=val(subs(aNndt[i],12,6))
               if sk_r=skr.and.ttn_r=rnr
                  a=1
                  exit
               endif
           next
           if a=0
              for i=1 to len(aNnt)
                  sk_r=val(subs(aNnt[i],8,3))
                  ttn_r=val(subs(aNnt[i],12,6))
                  if sk_r=skr.and.ttn_r=rnr
                     a=1
                     exit
                  endif
              next
           endif
           if a=0
              aadd(aTtn,'��'+str(rnr,6)+'�'+str(skr,3)) // ���������� ���ᨢ� ttn,�������. � NDS
           endif
           skip
        endd
     endif
  endif
  @ 4,45 say '�㬬� ��� ���४樨 '+str(sumcr,12,2)
  if len(aTtn)=0  // ��� ttn ��� �믨᪨ ��
     save scre to scmess
     mess('��� TT� ��� �믨᪨ ��')
     inkey(3)
     rest scre from scmess
     nuse()
     retu
  endif
  if gnPnds=1
     netuse('cskl',,'s')
     sumsdvr=0
     for i=1 to len(aTtn)
         sele cskl
         ttnr=val(subs(aTtn[i],3,6))
         skr=val(subs(aTtn[i],10,3))
         seek str(skr,3)
         Pathr=gcPath_d+alltrim(path)
         netuse('soper',,'s',1)
         netuse('rs1',,'s',1)
         seek str(ttnr,6)
         if FOUND()
            sdvr=sdv
            kopr=kop
            vor=vo
         else
            sdvr=0
            kopr=0
            vor=0
         endif
         use
         sele soper
         seek str(int(kopr/100),1)+str(vor,1)+str(vor,1)+str(mod(kopr,100),2)
         if FOUND()
            p_nds=nds
            ndsr=nds
         else
            p_nds=0
            ndsr=0
         endif
         use
         aTtn[i]=aTtn[i]+'�'+str(sdvr,15,2)+'�'+str(ndsr,1) // ���������� �㬬� �� ����.
         sumsdvr=sumsdvr+sdvr
         sele sl
         appe blank
         repl kod with str(ttnr,6)
     next
     @ 5,45 say '�㬬� �⮡࠭��� ���'+str(sumsdvr,12,2)


     save scre to sc1
     @ 7,1 say '     ���४��              ��� ⮢��                  �� �믨ᠭ��' color 'w/n'
     oclr=setcolor('gr+/b,gr+/r,,,')
     cyclr=0
     do while cyclr=0
*    �������� ���४��
        @ 24,0 say space(80) color 'n/w'
        @ 24,1 say '"ENTER" - �த������' color 'n/w'
        fnnd()
*    �������� ��� ⮢��
        @ 24,0 say space(80) color 'n/w'
        @ 24,1 say '"ENTER" - �த������' color 'n/w'
        fnnt()
*    ���믨ᠭ��
        @ 24,0 say space(80) color 'n/w'
        @ 24,1 say '"ENTER" - �믨��� ;  "->" ��� "<-"  -�த������ ; Space - �⡮�' color 'n/w'
        fttn()
     enddo
     if cyclr=1
        oclr=setcolor(oclr)
        rest scre from sc1
        loop
     endif
     oclr=setcolor(oclr)
  else
     aTtn[1]=aTtn[1]+'�'+str(sdvr,15,2)+'�'+str(p_nds,1) // ���������� �㬬� �� ����.
  endif
  nrab=0
  for i=1 to len(aTtn)
      if subs(aTtn[i],1,1)=' '
         loop
      endif
      nrab++
  next
  private aRab[nrab,5]
  n=1
  for i=1 to len(aTtn)
      if subs(aTtn[i],1,1)=' '
         loop
      endif
      ttn_r=val(subs(aTtn[i],3,6))
      sk_r=val(subs(aTtn[i],10,3))
      sdv_r=val(subs(aTtn[i],14,15))
      aRab[n,1]=ttn_r
      aRab[n,2]=sk_r
      aRab[n,3]=sdv_r
      aRab[n,4]=sdv_r
      aRab[n,5]=ctod('')   // ����୮� ��� ���
      n++
  next
  if prcor=0            // ���४樨 ���
     for i=1 to len(aRab)
         ttn_r=aRab[i,1]
         sk_r=aRab[i,2]
         sdv_r=aRab[i,3]
         sele nds
         if i=1
            sele setup
            locate for ent=gnEnt
            reclock()
            nomndsr=nnds
            sele nds
            do while .t.
               if netseek('t1','nomndsr')
                  nomndsr=nomndsr+1
                  loop
               endif
               sele setup
               netrepl('nnds','nomndsr+1')
               exit
            endd
            nndsr=nomndsr
         endif
         sele nds
         netadd()
         netrepl('nomnds,kkl,sk,ttn,sum,dnn,d0k1,rmsk',;
                 'nomndsr,kplr,sk_r,ttn_r,sdv_r,dtt,d0k1r,gnRmsk')
     next
  else                   // ���४��
     for j=1 to len(aNnd)
         ndsdr=val(subs(aNnd[j],1,6))
         sndsdr=val(subs(aNnd[j],8,12))
         sele nds
         set orde to tag t2
         seek str(kplr,7)+str(ndsdr,10)
         ktlrr=korktl
         sndsdtr=0
         if FOUND()
            do while kkl=kplr.and.ndsd=ndsdr
*               sndsdtr=sndsdtr+sum
               sumcr=sumc
               sndsdtr=sndsdtr+sumcr
               skip
            enddo
         endif
*         if sndsdr-sndsdtr>0 .and. sndsdr-sndsdtr#0.00    // ���४�� �� ��� ���죨
         if str((sndsdr-sndsdtr),1)#'0'    // ���४�� �� ��� ���죨
            for i=1 to len(aRab)
                if aRab[i,3]=0
                   loop
                endif
                ttn_r=aRab[i,1]
                sk_r=aRab[i,2]
                sdv_r=aRab[i,3]
                sele nds
                sele setup
                locate for ent=gnEnt
                reclock()
                nomndsr=nnds
                sele nds
                do while .t.
                   if netseek('t1','nomndsr')
                      nomndsr=nomndsr+1
                      loop
                   endif
                   sele setup
                   netrepl('nnds','nomndsr+1')
                   exit
                endd
                nndsr=nomndsr
                sele nds
                netadd()
                netrepl('nomnds,ndsd,ttn,dnn,sk,sum,kkl,d0k1,rmsk',;
                        'nomndsr,ndsdr,ttn_r,dtt,sk_r,sdv_r,kplr,d0k1r,gnRmsk')
                aaa=sndsdr-sndsdtr-sdvr
                if aaa>=0 // TTN ��������� ��諠 � �� �� ���죠�
                   netrepl('sumc','sdv_r')
                   aRab[i,3]=0
                else   // �㬬� ��� ����� ���⪠ �� ���죠�
                   netrepl('sumc','sndsdr-sndsdtr')
                   aRab[i,3]=0
                   aRab[i,4]=sndsdr-sndsdtr
                endif
            next
         else
         endif
     next
     for i=1 to len(aRab) // �믨᪠ ��⠢���� �� ��᫥ ���४樨
         if aRab[i,3]=0
            loop
         endif
         ttn_r=aRab[i,1]
         sk_r=aRab[i,2]
         sdv_r=aRab[i,3]
         sele setup
         locate for ent=gnEnt
         reclock()
         nomndsr=nnds
         sele nds
         do while .t.
            if netseek('t1','nomndsr')
               nomndsr=nomndsr+1
               loop
            endif
            sele setup
            netrepl('nnds','nomndsr+1')
            exit
         endd
         nndsr=nomndsr
         sele nds
         netadd()
         netrepl('nomnds,ttn,dnn,sk,sum,kkl,d0k1,rmsk',;
                 'nomndsr,ttn_r,dtt,sk_r,sdv_r,kplr,d0k1r,gnRmsk')
     next
  endif
  PNN()
  exit
enddo

if gnPnds=1
   nuse()
endif

rest scre from scnnt
clnnt=setcolor(clnnt)
clea
Return .T.


*******************************************************************
* FUNCTIONS
*******************************************************************

func oaTtn(p1,p2,p3)
loca ttnr,sdvr
ttnr=subs(aTtn[p2],3,6)
sdvr=val(subs(aTtn[p2],14,15))
if lastkey()=32
   if subs(aTtn[p2],1,1)='�'
      aTtn[p2]=stuff(aTtn[p2],1,1,' ')
      sele sl
      locate for kod=ttnr
      if FOUND()
         dele
         sumsdvr=sumsdvr-sdvr
         @ 5,45 say '�㬬� �⮡࠭��� ���'+str(sumsdvr,12,2) color 'g/n'
      endif
   else
      aTtn[p2]=stuff(aTtn[p2],1,1,'�')
      sele sl
      locate for kod=ttnr
      if !FOUND()
         appe blank
         repl kod with ttnr
         sumsdvr=sumsdvr+sdvr
         @ 5,45 say '�㬬� �⮡࠭��� ���'+str(sumsdvr,12,2) color 'g/n'
      endif
   endif
   retu 2
else
   do case
      case lastkey()=K_ESC
           cyclr=1
           retu 0
      case lastkey()=K_ENTER
           cyclr=2
           retu 1
      case lastkey()=19.or.lastkey()=4
           cyclr=0
           retu 0
   othe
      retu 2
   endc

endif
***********************************************************************
func fnnd()
* �������� ��� ���죨
  if len(aNndt)=0
     aadd(aNndt,'���')
  endif
  teni(8,1,22,18)
  @ 8,1,22,18 box frame+space(1)
  achoice(9,2,21,17,aNndt)
retu

func fnnt()
  // * ��������,�믨ᠭ�� ��� ⮢��
  if len(aNnt)=0
     aadd(aNnt,'���')
  endif
  teni(8,5,22,43+20)
  @ 8,5,22,43+20 box frame+space(1)
  achoice(9,6,21,42+20,aNnt)
retu

func fttn()
  //* ���믨ᠭ��
  teni(8,48,22,78)
  @ 8,48,22,78 box frame+space(1)
  kodr=achoice(9,49,21,77,aTtn,,'oaTtn')
retu
