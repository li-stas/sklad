#include "inkey.ch"
/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  24.06.16 * 16:06:14
 ����������.........
 ���������..........
  * fil       - 䠩�
  * rw        -
  * cl        -
  * h         -
  * w         -
  * fld       - �뢮���� ����
  * kod       - �����頥��� ���� (0 & NIL - recn() ; ᨬ���쭮�  - ���祭�� ����  )
  * otb       - �⡮�
  * sv        - 1 - ��⠢��� �� �࠭�
  * bwhile    - do while ��� ����
  * bfor      - for ��� ����
  * cle       - color
  * hd        - header
 �����. ��������....
 ����������.........
 */
FUNCTION slcf(fil,rw,cl,h,w,fld,kod,otb,sv,bwhile,bfor,cle,hd)
  LOCAL cWhiler, cForr
  private kodr,filr,otbr,svr,fldr,bwhiler,bforr,rwr,clr,hr,wr,cler
  store 0 to filr,rwr,clr,hr,wr,kodr,otbr,svr,colotbr
  store '' to fldr,bwhiler,bforr

  if cle=nil
     cler='n/w,n/bg'
  else
     cler=cle
  endif
  filr=fil
  rwr=rw
  clr=cl
  hr=h
  if hr=nil
     hr=10
  endif
  wr=w
  if wr=nil
     wr=0
  endif
  fldr=fld
  kodr=kod
  if kodr=nil
     kodr=0
  endif
  otbr=otb
  if otbr=nil
     otbr=0
  endif
  svr=sv
  if svr=nil
     svr=0
  endif
  bwhiler=bwhile
  if bwhiler=nil
     bwhiler='.t..and.!eof()'
  endi
  bforr=bfor
  if bforr=nil
     bforr='.t.'
  endif
  ******************************************************************************
  private afil:={},afil1:={},prarr,afld1:={},afld2:={},afld3:={}
  private p1r,p2r,p3r
  * prarr      - �ਧ���,��।����騩 ����⢨� �� ���⨦���� top(bottom) ���ᨢ�
  * afil       - ���ᨢ ��� �뢮�� �� �࠭
  * afil1      - ���ᨢ recn()
  * afld1      - ��ࠦ����
  * afld2      - ��������� ��ࠦ����
  * afld3      - �ࠪ���⨪� ��ࠦ����

  store 0  to prarr,p1r,p2r,p3r
  *store '' to
  ********************************************************************************
  oclr=setcolor('g/n')
  save scre to fscre

  * ���������� ���ᨢ�� ��ࠦ����

  bbb=fldr
  do while len(bbb)#0
     store '' to expr,zagr,harr
     n=at('e:',bbb)

     bbb=subs(bbb,n+2)
     n=at('h:',bbb)
     expr=alltrim(subs(bbb,1,n-1))
     bbb=subs(bbb,n+2)

     n=at('c:',bbb)
     zagr=alltrim(subs(bbb,1,n-1))
     bbb=subs(bbb,n+2)

     n=at('e:',bbb)
     if n#0
        harr=alltrim(subs(bbb,1,n-1))
        bbb=subs(bbb,n-1)
     else
        harr=alltrim(bbb)
        bbb=''
     endif

     aadd(afld1,expr)
     aadd(afld2,&zagr)
     aadd(afld3,harr)
  endd

  * ��ࠢ������� ����� � �����������ﬨ
  for i=1 to len(afld2)
      bbb=subs(afld3[i],3)
      n=at(',',bbb)
      if n#0
         ccc=subs(bbb,1,n-1)
      else
         n=at(')',bbb)
         ccc=subs(bbb,1,n-1)
      endif
      lcr=val(ccc)       && ����� ��ࠦ���� �� �ࠪ���⨪�
      lnr=len(afld2[i])  && ����� ������������
      do case
         case lcr>lnr
              afld2[i]=center(afld2[i],lcr,.t.)
         case lcr<lnr
              afld2[i]=subs(afld2[i],1,lnr)
      endc
  next

  nfldr='�'
  nfld1r='�'
  for i=1 to len(afld2)
      nfldr=nfldr+afld2[i]+'�'
      nfld1r=nfld1r+repl('�',len(afld2[i]))+'�'
  next

  if otbr=0
     if !empty(wr)
        nfldr=subs(nfldr,1,len(nfldr)-1)+space(wr-len(nfldr)-1)
        nfld1r=subs(nfld1r,1,len(nfld1r)-1)+repl('�',wr-len(nfld1r)+1)+'�'
     else
        nfldr=subs(nfldr,1,len(nfldr)-1)+'�'
        nfld1r=subs(nfld1r,1,len(nfld1r)-1)+'�'
     endif
  else
     if !empty(wr)
        nfldr=subs(nfldr,1,len(nfldr)-1)+space(wr-len(nfldr)-1)+'� �'
        nfld1r=subs(nfld1r,1,len(nfld1r)-1)+repl('�',wr-len(nfld1r)-1)+'�Ĵ'
     else
        nfldr=subs(nfldr,1,len(nfldr))+' �'
        nfld1r=subs(nfld1r,1,len(nfld1r))+'Ĵ'
     endif
  endif

  if rwr=nil
     rwr=(maxrow()-hr)/2
  endif
  if clr=nil
     clr=(maxcol()-len(nfldr))/2
     if clr<0
        clr=0
     endif
  endif

  sele (filr)
  exr=0    // ��室 �� SLCF
  coder=0 // �����頥��� ���祭��

  IF  VALTYPE(bwhiler)="C"
    cWhiler:=bWhiler
    bwhiler:=&("{||"+bwhiler+"}")
  ELSE
    //���� ����
  ENDIF
  IF  VALTYPE(bforr)="C"
    cForr:=bForr
    bforr:=&("{||"+bforr+"}")
  ELSE
    //���� ����
  ENDIF

  do while .t.
     afil={}
     afil1={}
     prarr=0
     rcnr=recn()       && N ����� � ���ன ��稭����� ᪠��஢����
     h_rr=0            && ������⢮ ��᪠��஢����� ����ᥩ
     h_r=0             && ������⢮ �⮡࠭��� ����ᥩ
     //save screen to scfil
     scfil:=savescreen(1,1,MAXROW(),MAXCOL())
     mess('����...')
     do while EVAL(bwhiler)   // &bwhiler
        if eof()
           exit
        endif
        sele (filr)
        h_rr++
        if !(EVAL(bforr)) //      &bforr
           skip
           if eof()
              exit
           endif
           loop
        endif
        if eof()
           exit
        endif
        if !empty(kodr)
           coder=&kodr
        else
           coder=recn()
        endif
        fldr=''
        * ���᫥��� ��ࠦ����
        for i=1 to len(afld1)
            bbb=afld1[i]
  *          ccc=&bbb
            do case
               case subs(afld3[i],1,1)='n'
                    aaa='str('+bbb+','+subs(afld3[i],3)
                    ccc=&aaa
                    if &bbb#0.and.val(ccc)=0
                       af3r=alltrim(afld3[i])
                       chhr=''
                       cmmr=''
                       rzdlr=0
                       for zz=3 to len(af3r)-1
                           if subs(af3r,zz,1)=','
                              rzdlr=1
                              loop
                           endif
                           if rzdlr=0
                              chhr=chhr+subs(af3r,zz,1)
                           else
                              cmmr=cmmr+subs(af3r,zz,1)
                           endif
                       next
                       nhhr=val(chhr)
                       nmmr=val(cmmr)
                       if nmmr>0
                          do while nmmr>-1
                             nmmr=nmmr-1
                             if nmmr>-1
                                aaa_r='str('+bbb+','+alltrim(str(nhhr,3))+','+alltrim(str(nmmr,3))+')'
                             else
                                aaa_r='str('+bbb+','+alltrim(str(nhhr,3))+')'
                             endif
                             ccc_r=&aaa_r
                             if val(ccc_r)#0
                                ccc=ccc_r
                             endif
                          endd
                       endif
                    endif
               case subs(afld3[i],1,1)='c'
                    aaa='subs('+bbb+',1,'+subs(afld3[i],3)
                    ccc=&aaa
               case subs(afld3[i],1,1)='d'
                    ccc=dtoc(&bbb)
               othe
                    ccc=&bbb
            endc
            if len(ccc)>=len(afld2[i])
               fldr=fldr+subs(ccc,1,len(afld2[i]))+'�'
            else
               fldr=fldr+space(len(afld2[i])-len(ccc))+ccc+'�'
            endif
        next
        if !empty(otbr)
           sele sl
           do case
              case valtype(coder)='N'
                   scoder=str(coder,fieldsize(fieldpos('kod')))
              case valtype(coder)='C'
                   scoder=coder
              case valtype(coder)='D'
                   scoder=dtoc(coder)
           endc
           sele sl
           locate for sl->kod=scoder
           if FOUND()
              birdr='�'
           else
              birdr=' '
           endif
           sele (filr)
           if empty(wr)
              colotbr=len(fldr)+1
              fldr=subs(fldr,1,len(fldr))+birdr+'�'
           else
              colotbr=len(fldr)+wr-len(fldr)-1
              fldr=subs(fldr,1,len(fldr)-1)+space(wr-len(fldr)-2)+'�'+birdr+'�'
           endif
        else
           if empty(wr)
              fldr=subs(fldr,1,len(fldr)-1)
           else
              fldr=subs(fldr,1,len(fldr)-1)
           endif
        endif
        aadd(afil,fldr)
        aadd(afil1,coder)
        h_r++
        if h_r>hr-1
           exit
        endif
        skip
     enddo
     //rest screen from scfil
     RESTSCREEN(1,1,MAXROW(),MAXCOL(),scfil)

  *   if len(afil)=0
  *      oclr=setcolor(oclr)
  *      rest scre from fscre
  *      retu 0
  *   endif
  *   ocl3r=setcolor('n/w')
     oclr3r=setcolor(cler)
     if len(afil)=0
        aadd(afil,space(len(nfldr)))
        aadd(afil1,0)
     endif
     if empty(wr)
        teni(rwr,clr,rwr+hr+3,clr+len(nfldr)-1)
        @ rwr,clr,rwr+hr+3,clr+len(nfldr)-1 box frame+space(1)
     else
        if wr<78.and.rwr+hr+3<19
           teni(rwr,clr,rwr+hr+3,wr)
        endif
     endif
     @ rwr,clr,rwr+hr+3,wr box frame+space(1)
     if hd#nil
        if len(nfldr)>=len(hd)
           aa=(len(nfldr)-len(hd))/2
           @ rwr,clr+aa say hd color 'r/w'
        else
           @ rwr,clr say subs(hd,1,len(nfldr))
        endif
     endif
     @ rwr+1,clr say nfldr
     @ rwr+2,clr say nfld1r
     ocl2r=setcolor(cler)
     if empty(wr)
        n_n=achoice(rwr+3,clr+1,rwr+hr+2,clr+len(nfldr)-2,afil,,'oafilf')
     else
        n_n=achoice(rwr+3,clr+1,rwr+hr+2,wr-1,afil,,'oafilf')
     endif
     sele (filr)
     do case
        case prarr=1 && �����
             go rcnr
             h_r=0
             do while EVAL(bwhiler) //&bwhiler &&
                skip -1
                if bof()
                   exit
                endif
                if !(EVAL(bwhiler)) //&bwhiler &&
                   skip
                   exit
                endif
                if !(EVAL(bforr)) //&bforr &&!
                   loop
                endif
                h_r++
                if h_r>hr-2
                   exit
                endif
             enddo
             loop
        case prarr=2 && ����
             if len(afil)=hr
                loop
             else
                go rcnr
                loop
             endif
     endc
     oclr=setcolor(oclr)
     if svr=0
        rest scre from fscre
     else
        if p2r#0.and.p3r#0
           @ rwr+p3r+3,clr+1 say afil[p2r] color 'n/bg'
        endif
     endi
     if lastkey()=K_ESC
        retu 0
     else
        retu coder
     endif
  enddo


  func oafilf(p1,p2,p3)
  p3r=p3
  p2r=p2
  p1r=p1

  if p1r=1.or.p1r=2
     if p1r=1 && ��室 �����
        prarr=1
     else     && ��室 ����
        prarr=2
     endif
     retu 0
  endif
  prarr=0

  coder=afil1[p2]
  if select('sl')#0
     sele sl
     do case
        case valtype(coder)='N'
             scoder=str(coder,fieldsize(fieldpos('kod')))
        case valtype(coder)='C'
             scoder=coder
        case valtype(coder)='D'
             scoder=dtoc(coder)
     endc
  endif
  do case
  case lastkey()=32.and.otbr=1 && Space
      if subs(afil[p2],colotbr,1)=' '
          afil[p2]=stuff(afil[p2],colotbr,1,'�')
          sele sl
          locate for sl->kod=scoder
          if !FOUND()
            appe blank
            repl sl->kod with scoder
          endif
          sele (filr)
      else
          afil[p2]=stuff(afil[p2],colotbr,1,' ')
          sele sl
          locate for sl->kod=scoder
          if FOUND()
            dele
          endif
          sele (filr)
      endif
      retu 1
  case lastkey()=-39.and.otbr=1 && ��
      for i=1 to h_r
          coder=afil1[i]
          if select('sl')#0
              sele sl
              do case
                case valtype(coder)='N'
                scoder=str(coder,fieldsize(fieldpos('kod')))
                case valtype(coder)='C'
                scoder=coder
                case valtype(coder)='D'
                scoder=dtoc(coder)
              endc
          endif
      if subs(afil[i],colotbr,1)=' '
          afil[i]=stuff(afil[i],colotbr,1,'�')
          sele sl
          locate for sl->kod=scoder
          if !FOUND()
            appe blank
            repl sl->kod with scoder
          endif
          sele (filr)
      else
          afil[i]=stuff(afil[i],colotbr,1,' ')
          sele sl
          locate for sl->kod=scoder
          if FOUND()
            dele
          endif
          sele (filr)
      endif
      next
      go rcnr
      retu 1
  case lastkey()=5 && Up
      retu 2
  case lastkey()=24 && Down
      retu 2
  case lastkey()=19 && Left
      retu 1
  case lastkey()=4 && Right
      retu 1
  case lastkey()=1 && Home
      retu 2
  case lastkey()=6 && End
      retu 2
  case lastkey()=18 && PgUp
      retu 2
  case lastkey()=3 &&  PgDn
      retu 2
  case lastkey()=7 &&  Del
      retu 1
  case lastkey()=9 &&  Tab
      retu 1
  case lastkey()=22 &&  Ins
      retu 1
  case lastkey()=13 &&  Enter
      retu 1
  case lastkey()=32.and.otbr=0 &&  Space
      retu 1
  case lastkey()=28 &&  F1
      retu 1
  case lastkey()=-1 &&  F2
      retu 1
  case lastkey()=-2 &&  F3
      retu 1
  case lastkey()=-3 &&  F4
      retu 1
  case lastkey()=-4 &&  F5
      retu 1
  case lastkey()=-5 &&  F6
      retu 1
  case lastkey()=-6 &&  F7
      retu 1
  case lastkey()=-7 &&  F8
      retu 1
  case lastkey()=-8 &&  F9
      retu 1
  case lastkey()=-9 &&  F10
      retu 1
  case lastkey()=-31 &&  Alt-F2
      retu 1
  case lastkey()=-32 &&  Alt-F3
      retu 1
  case lastkey()=-33 &&  Alt-F4
      retu 1
  case lastkey()=-34 &&  Alt-F5
      retu 1
  case lastkey()=-35 &&  Alt-F6
      retu 1
  case lastkey()=-36 &&  Alt-F7
      retu 1
  case lastkey()=-37 &&  Alt-F8
      retu 1
  case lastkey()=-38 &&  Alt-F9
      retu 1
  case lastkey()=-39 &&  Alt-F10
      retu 1
  case lastkey()=K_ESC &&  Esc
      retu 0
  case lastkey()>32.and.lastkey()<255
  //case lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
      retu 1
  other
     retu 2
  endcase

/*****************************************************************
 
 FUNCTION:
 �����..����..........�. ��⮢��  24.06.16 * 16:04:41
 ����������.........
 ���������..........
  * fil       - 䠩�
  * rw        -
  * cl        -
  * h         -
  * w         -
  * fld       - �뢮���� ����
  * kod       - �����頥��� ���� (0 & NIL - recn() ; ᨬ���쭮�  - ���祭�� ����  )
  * otb       - �⡮�
  * sv        - 1 - ��⠢��� �� �࠭�
  * bwhile    - do while ��� ����
  * bfor      - for ��� ����
  * cle       - color
  * hd        - header
  * fldnom    - N ��ࢮ�� ���� ��� �뢮��
  * fldfix    - �-�� 䨪� ����� ��稭�� � 1-��
 �����. ��������....
 ����������.........
 */
FUNCTION  slce(fil,rw,cl,h,w,fld,kod,otb,sv,bwhile,bfor,cle,hd,fldnom,fldfix)
  LOCAL cWhiler, cForr
  PRIVATE kodr,filr,otbr,svr,fldr,bwhiler,bforr,rwr,clr,hr,wr,cler,fldfixr
  STORE 0 to filr,rwr,clr,hr,wr,kodr,otbr,svr,colotbr,fldfixr
  STORE '' to fldr,bwhiler,bforr
  STORE 1 to iii
  if cle=nil
     cler='n/w,n/bg'
  else
     cler=cle
  endif
  filr=fil
  rwr=rw
  clr=cl
  hr=h
  if hr=nil
     hr=10
  endif
  wr=w
  if wr=nil
     wr=0
  endif
  fldr=fld
  kodr=kod
  if kodr=nil
     kodr=0
  endif

  //if TYPE('FldNomr')='U';  FldNomr=1;  endif

  if FldNomr=0;     FldNomr=fldnom;  endif

  if FldNomr=nil.or.FldNomr=0
     FldNomr=1
     oafr=0
  endif
  fldfixr=fldfix
  if fldfixr=nil
     fldfixr=0
  endif
  otbr=otb
  if otbr=nil
     otbr=0
  endif
  svr=sv
  if svr=nil
     svr=0
  endif
  bwhiler=bwhile
  if bwhiler=nil
     bwhiler='!eof()'
  endi
  bforr=bfor
  if bforr=nil
     bforr='.t.'
  endif
  ******************************************************************************
  private afil:={},afil1:={},prarr,afld1:={},afld2:={},afld3:={}
  private p1r,p2r,p3r
  * prarr      - �ਧ���,��।����騩 ����⢨� �� ���⨦���� top(bottom) ���ᨢ�
  * afil       - ���ᨢ ��� �뢮�� �� �࠭
  * afil1      - ���ᨢ recn()
  * afld1      - ��ࠦ����
  * afld2      - ��������� ��ࠦ����
  * afld3      - �ࠪ���⨪� ��ࠦ����

  store 0  to prarr,p1r,p2r,p3r
  *store '' to
  ********************************************************************************
  oclr=setcolor('g/n')
  save scre to fscre

  * ���������� ���ᨢ�� ��ࠦ����

  bbb=fldr
  do while len(bbb)#0
     store '' to expr,zagr,harr
     n=at('e:',bbb)

     bbb=subs(bbb,n+2)
     n=at('h:',bbb)
     expr=alltrim(subs(bbb,1,n-1))
     bbb=subs(bbb,n+2)

     n=at('c:',bbb)
     zagr=alltrim(subs(bbb,1,n-1))
     bbb=subs(bbb,n+2)

     n=at('e:',bbb)
     if n#0
        harr=alltrim(subs(bbb,1,n-1))
        bbb=subs(bbb,n-1)
     else
        harr=alltrim(bbb)
        bbb=''
     endif

     aadd(afld1,expr)
     aadd(afld2,&zagr)
     aadd(afld3,harr)
  endd

  * ��ࠢ������� ����� � �����������ﬨ
  if FldNomr>len(afld2)
     FldNomr=1 &&len(afld2)
  endif
  for i=iif(fldfixr=0,FldNomr,1) to len(afld2)
      if fldfixr#0.and.i>fldfixr
         if i<fldfixr+FldNomr
            loop
         endif
      endif
      bbb=subs(afld3[i],3)
      n=at(',',bbb)
      if n#0
         ccc=subs(bbb,1,n-1)
      else
         n=at(')',bbb)
         ccc=subs(bbb,1,n-1)
      endif
      lcr=val(ccc)       && ����� ��ࠦ���� �� �ࠪ���⨪�
      lnr=len(afld2[i])  && ����� ������������
      do case
         case lcr>lnr
              afld2[i]=center(afld2[i],lcr,.t.)
         case lcr<lnr
              afld2[i]=subs(afld2[i],1,lnr)
      endc
  next

  nfldr='�'
  nfld1r='�'
  for i=iif(fldfixr=0,FldNomr,1) to len(afld2)
      if fldfixr#0.and.i>fldfixr
         if i<fldfixr+FldNomr
            loop
         endif
      endif
      nfldr=nfldr+afld2[i]+'�'
      nfld1r=nfld1r+repl('�',len(afld2[i]))+'�'
  next

  if otbr=0
     if !empty(wr)
        if len(nfldr)<wr
           nfldr=subs(nfldr,1,len(nfldr)-1)+'�'+space(wr-len(nfldr)-1)+'�'
           nfld1r=subs(nfld1r,1,len(nfld1r)-1)+'�'+repl('�',wr-len(nfld1r)-1)+'�'
        else
           nfldr=subs(nfldr,1,wr-1)+'�'
           nfld1r=subs(nfld1r,1,wr-1)+'�'
        endif
     else
        if len(nfldr)<78
           nfldr=subs(nfldr,1,len(nfldr)-1)+'�'+space(78-len(nfldr))+'�'
           nfld1r=subs(nfld1r,1,len(nfld1r)-1)+'�'+repl('�',78-len(nfld1r))+'�'
        else
           nfldr=subs(nfldr,1,78)+'�'
           nfld1r=subs(nfld1r,1,78)+'�'
        endif
     endif
  else
     if !empty(wr)
        if len(nfldr)<wr
           nfldr=subs(nfldr,1,len(nfldr)-1)+'�'+space(wr-len(nfldr)-4)+'� �'
           nfld1r=subs(nfld1r,1,len(nfld1r)-1)+'�'+repl('�',wr-len(nfld1r)-4)+'�Ĵ'
        else
           nfldr=subs(nfldr,1,wr-4)+'� �'
           nfld1r=subs(nfld1r,1,wr-4)+'�Ĵ'
        endif
     else
        if len(nfldr)<78
           nfldr=subs(nfldr,1,len(nfldr)-1)+'�'+space(75-len(nfldr))+'� �'
           nfld1r=subs(nfld1r,1,len(nfld1r)-1)+'�'+repl('�',75-len(nfld1r))+'�Ĵ'
        else
           nfldr=subs(nfldr,1,75)+'� �'
           nfld1r=subs(nfld1r,1,75)+'�Ĵ'
        endif
     endif
  *   if len(nfldr)>77
  *      nfldr=subs(nfldr,1,77)
  *   else
  *      nfldr=subs(nfldr,1,len(nfldr)-1)+' '
  *   endif
  *   if len(nfld1r)>77
  *      nfld1r=subs(nfld1r,1,77)
  *   else
  *      nfld1r=subs(nfld1r,1,len(nfld1r)-1)+'�'
  *   endif
  *   if !empty(wr)
  *      nfldr=subs(nfldr,1,len(nfldr)-1)+space(wr-len(nfldr))+'� �'
  *      nfld1r=subs(nfld1r,1,len(nfld1r)-1)+repl('�',wr-len(nfld1r))+'�Ĵ'
  *   else
  *      nfldr=subs(nfldr,1,len(nfldr))+'� �'
  *      nfld1r=subs(nfld1r,1,len(nfld1r))+'�Ĵ'
  *   endif
  endif

  if rwr=nil
     rwr=(maxrow()-hr)/2
  endif
  if clr=nil
     clr=(maxcol()-len(nfldr))/2
     if clr<0
        clr=0
     endif
  endif

  sele (filr)
  exr=0    // ��室 �� SLCF
  coder=0 // �����頥��� ���祭��

  IF  VALTYPE(bwhiler)="C"
    cWhiler:=bWhiler
    bWhiler:=&("{||"+bwhiler+"}")
  ELSE
    //���� ����
  ENDIF
  IF  VALTYPE(bforr)="C"
    cForr:=bForr
    bforr:=&("{||"+bforr+"}")
  ELSE
    //���� ����
  ENDIF

  do while .t.
     afil={}
     afil1={}
     prarr=0
     rcnr=recn()       && N ����� � ���ன ��稭����� ᪠��஢����
     h_rr=0            && ������⢮ ��᪠��஢����� ����ᥩ
     h_r=0             && ������⢮ �⮡࠭��� ����ᥩ
     //save screen to scfil
     scfil:=savescreen(1,1,MAXROW(),MAXCOL())
     mess('����...')
     do while EVAL(bwhiler) //   do while &bwhiler
        sele (filr)
        h_rr++
        if !(EVAL(bforr)) //      if !&bforr
           skip
           if eof()
              exit
           endif
           loop
        endif
        if eof()
           exit
        endif
        if !empty(kodr)
           coder=&kodr
        else
           coder=recn()
        endif
        fldr=''
        * ���᫥��� ��ࠦ����
        for i=iif(fldfixr=0,FldNomr,1) to len(afld1)
            if fldfixr#0.and.i>fldfixr
               if i<fldfixr+FldNomr
                  loop
               endif
            endif
            bbb=afld1[i]
            do case
               case subs(afld3[i],1,1)='n'
                    aaa='str('+bbb+','+subs(afld3[i],3)
                    ccc=&aaa
                    if &bbb#0.and.val(ccc)=0
                       af3r=alltrim(afld3[i])
                       chhr=''
                       cmmr=''
                       rzdlr=0
                       for zz=3 to len(af3r)-1
                           if subs(af3r,zz,1)=','
                              rzdlr=1
                              loop
                           endif
                           if rzdlr=0
                              chhr=chhr+subs(af3r,zz,1)
                           else
                              cmmr=cmmr+subs(af3r,zz,1)
                           endif
                       next
                       nhhr=val(chhr)
                       nmmr=val(cmmr)
                       if nmmr>0
                          do while nmmr>-1
                             nmmr=nmmr-1
                             if nmmr>-1
                                aaa_r='str('+bbb+','+alltrim(str(nhhr,3))+','+alltrim(str(nmmr,3))+')'
                             else
                                aaa_r='str('+bbb+','+alltrim(str(nhhr,3))+')'
                             endif
                             ccc_r=&aaa_r
                             if val(ccc_r)#0
                                ccc=ccc_r
                             endif
                          endd
                       endif
                    endif
                    if val(ccc)=0
                       ccc=space(len(ccc))
                    endif
               case subs(afld3[i],1,1)='c'
                    aaa='subs('+bbb+',1,'+subs(afld3[i],3)
                    ccc=&aaa
               case subs(afld3[i],1,1)='d'
                    ccc=dtoc(&bbb)
               othe
                    ccc=&bbb
            endc
            if len(ccc)>=len(afld2[i])
               fldr=fldr+subs(ccc,1,len(afld2[i]))+'�'
            else
               fldr=fldr+space(len(afld2[i])-len(ccc))+ccc+'�'
            endif
        next
        if !empty(otbr)
           sele sl
           do case
              case valtype(coder)='N'
                   scoder=str(coder,fieldsize(fieldpos('kod')))
              case valtype(coder)='C'
                   scoder=coder
              case valtype(coder)='D'
                   scoder=dtoc(coder)
           endc
           sele sl
           locate for sl->kod=scoder
           if FOUND()
              birdr='�'
           else
              birdr=' '
           endif
           sele (filr)
        endif
  ***********
        if otbr=0
           if !empty(wr)
              if len(fldr)<wr
                 fldr=subs(fldr,1,len(fldr)-1)+'�'+space(wr-len(fldr)-1)+'�'
              else
                 fldr=subs(fldr,1,wr-1)+'�'
              endif
           else
              if len(fldr)<78
                 fldr=subs(fldr,1,len(fldr)-1)+'�'+space(78-len(fldr))+'�'
              else
                 fldr=subs(fldr,1,78)+'�'
              endif
           endif
        else
           if !empty(wr)
              if len(fldr)<wr
                 fldr=subs(fldr,1,len(fldr)-1)+'�'+space(wr-len(fldr)-5)+'�'+birdr+'�'
              else
                 fldr=subs(fldr,1,wr-5)+'�'+birdr+'�'
              endif
           else
              if len(fldr)<78
                 fldr=subs(fldr,1,len(fldr)-1)+'�'+space(74-len(fldr))+'�'+birdr+'�'
              else
                 fldr=subs(fldr,1,74)+'�'+birdr+'�'
              endif
           endif
           colotbr=len(fldr)-1
        endif
  *      colotbr=at(birdr,fldr)
  ***********
  *         if len(fldr)>76
  *            fldr=subs(fldr,1,76)
  *         else
  *            fldr=subs(fldr,1,len(fldr))+' '
  *         endif
  *         if empty(wr)
  *            colotbr=len(fldr)+2
  *            fldr=subs(fldr,1,len(fldr))+'�'+birdr+'�'
  *         else
  *            colotbr=len(fldr)+wr-len(fldr)-1
  *            fldr=subs(fldr,1,len(fldr)-1)+space(wr-len(fldr)-2)+'�'+birdr+'�'
  *         endif
  *      else
  *         if empty(wr)
  *            fldr=subs(fldr,1,len(fldr)-1)+'�'
  *         else
  *            fldr=subs(fldr,1,len(fldr)-1)+'�'
  *         endif
  *      endif
        aadd(afil,fldr)
        aadd(afil1,coder)
        h_r++
        if h_r>hr-1
           exit
        endif
        skip
     enddo
     //rest screen from scfil
     RESTSCREEN(1,1,MAXROW(),MAXCOL(),scfil)
     oclr3r=setcolor(cler)
     if len(afil)=0
        aadd(afil,space(len(nfldr)))
        aadd(afil1,0)
     endif
     if empty(wr)
        teni(rwr,clr,rwr+hr+3,clr+len(nfldr)-1)
        @ rwr,clr,rwr+hr+3,clr+len(nfldr)-1 box frame+space(1)
     else
        if wr<78.and.rwr+hr+3<19
           teni(rwr,clr,rwr+hr+3,wr)
        endif
     endif
     @ rwr,clr,rwr+hr+3,wr box frame+space(1)
     if hd#nil
        if len(nfldr)>=len(hd)
           aa=(len(nfldr)-len(hd))/2
           @ rwr,clr+aa say hd color 'r/w'
        else
           @ rwr,clr say subs(hd,1,len(nfldr))
        endif
     endif
     @ rwr+1,clr say nfldr
     @ rwr+2,clr say nfld1r
     ocl2r=setcolor(cler)
     if empty(wr)
        n_n=achoice(rwr+3,clr+1,rwr+hr+2,clr+len(nfldr)-2,afil,,'oafilf')
     else
        n_n=achoice(rwr+3,clr+1,rwr+hr+2,wr-1,afil,,'oafilf')
     endif
     sele (filr)
     do case
        case prarr=1 && �����
             go rcnr
             h_r=0
             do while EVAL(bwhiler) //&bwhiler &&
                skip -1
                if bof()
                   exit
                endif
                if !EVAL(bwhiler) //!&bwhiler &&
                   skip
                   exit
                endif
                if !(EVAL(bforr)) //!&bforr &&
                   loop
                endif
                h_r++
                if h_r>hr-2
                   exit
                endif
             enddo
             loop
        case prarr=2 && ����
             if len(afil)=hr
                loop
             else
                go rcnr
                loop
             endif
     endc
     oclr=setcolor(oclr)
     if svr=0
        rest scre from fscre
     else
        if p2r#0.and.p3r#0
           @ rwr+p3r+3,clr+1 say afil[p2r] color 'n/bg'
        endif
     endi
     if lastkey()=K_ESC
        retu 0
     else
        retu coder
     endif
  enddo
