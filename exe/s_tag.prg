#include "common.ch"
#include "inkey.ch"
clea
netuse('s_tag')
do while .t.
   foot('INS,DEL,F4,ESC','��������,�������,���४��,��室')
   kodr=slcf('s_tag',1,,18,,"e:kod h:'���' c:n(3) e:fio h:'   �.  �.  �.  ' c:c(30)",'kod')
   sele s_tag
   netseek('t1','kodr')
   rcn_r=recn()
   fior=fio
   ktasr=0
   if fieldpos('ktas')#0
      ktasr=ktas
   endif
   do case
      case lastkey()=K_INS .and. (dkklnr=1.or.gnadm=1)
           tagins(0)
      case lastkey()=K_DEL .and. (dkklnr=1.or.gnadm=1)
           LOCATE FOR kod=kodr
           if FOUND()
              netdel()
              skip-1
           endif
      case lastkey()=-3 .and. (dkklnr=1.or.gnadm=1)
           tagins(1)
      case lastkey()=K_ESC
           exit
     case lastkey()>32.and.lastkey()<255
     //case lastkey()>=65.and.lastkey()<=90.or.lastkey()>=97.and.lastkey()<=122.or.lastkey()>=128.and.lastkey()<=175.or.lastkey()>=224.and.lastkey()<=239
          sele s_tag
          lstkr=upper(chr(lastkey()))
          if !netseek('t2','lstkr')
              go rcn_r
          else
              rcn_r=recn()
          endif
   endc
enddo
nuse()

func tagins(p1)
if p1=0
   store 0 to ktasr
   fior=space(30)
   sele s_tag
   set orde to 1
   go bott
   kodr=kod+1
   if netseek('t1','kodr')
      wmess('�訡�� ���������� ������ ����')
   endif
endif
clpodrins=setcolor('gr+/b,n/w')
wpodrins=wopen(10,15,15,60)
wbox(1)
do while .t.
*   if p1=0
*      @ 0,1 say '���         ' get kodr pict '999'
*   else
      @ 0,1 say '���          '+str(kodr,3)
*   endif
   @ 1,1 say    '�.�.�.      ' get fior
   if fieldpos('ktas')#0
      @ 2,1 say '��� �㯥�. ' get ktasr pict '999'
      @ 2,col()+1 say getfield('t1','ktasr','s_tag','fio')
   endif
   @ 3,1 prom '<��୮>'
   @ 3,col()+1 prom '<�� ��୮>'
   read
   if lastkey()=K_ESC
      exit
   endif
   fior=upper(fior)
   fior=alltrim(fior)
   menu to mpodrr
   if mpodrr=1
      if p1=0
         if !netseek('t1','kodr')
            netadd()
            if fieldpos('ktas')#0
               netrepl('kod,fio,ktas','kodr,fior,ktasr')
            else
               netrepl('kod,fio','kodr,fior')
            endif
            exit
         else
            wselect(0)
            save scre to scpodrins
            mess('����� ��� �������',1)
            rest scre from scpodrins
            wselect(wpodrins)
         endif
      else
         if netseek('t1','kodr')
            if fieldpos('ktas')#0
               netrepl('fio,ktas','fior,ktasr')
            else
               netrepl('fio','fior')
            endif
            exit
         endif
      endif
   endif
enddo
wclose()
setcolor(clpodrins)
retu
