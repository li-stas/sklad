*****************************************************************************
** RZAG ��ᢥ�. �����.�������                                               *
*****************************************************************************
@ 5,0 CLEA
@ 5,10 SAY '    ��������� ���㬥��    '+STR(ttnr,6)
@ 6, 0 SAY ' 1. ��� �믨᪨         : '+DTOC(DVPR)
@ 7, 0 SAY ' 2. ��� ���㬥��       : '+DTOC(DDCR)+' '+tdcr
@ 8, 0 SAY ' 3. ��� ���⥫�騪�      : '+STR(KPLR,7,0)+' '+nkplr 
@ 9, 0 SAY ' 4. ��� ��㧮�����⥫�  : '+STR(KGPR,7,0)+' '+nkgpr
@ 10,0 SAY ' 5. ��� ᪫���           : '+STR(SKLR,4,0)+' '+nsklr
@ 11,0 SAY ' 6. N �������           : '+NNZR
@ 12,0 SAY ' 7. ��� �������        : '+DTOC(DNZR)
@ 13,0 SAY ' 8. ��� ����樨         : '+STR(KOPR,3,0)+' '+nopr
@ 14,0 SAY ' 9. ��� ᯮᮡ� ���⠢�� : '+STR(SPDR,2,0)
@ 15,0 SAY '10. ��� ���� ������      : '+STR(VOR,2,0)+' '+nvor
@ 16,0 SAY '11. ����஢��            : '+fktor
@ 17,0 SAY '12. ��� ���㧪�        : '+DTOC(DOTR)+' '+totr
oclr=''
if przr=0
   oclr=setcolor('n/g')
   saw='�� ���⢥ত�� !'
else
   oclr=setcolor('w/r')
   saw='���⢥ত�� !'
endi
@ 17,50,19,67 box ''
@ 17,50,19,67 box frame
@ 18,51 say saw
oclr=setcolor(oclr)
@ 19,0 SAY '14. �㬬� �� ���㬥���  : '+STR(SDVR,15,2)
@ 20,0 SAY '15. ��騩 ���           : '+STR(VSVR,12,6)
VUR=INT(KOPR/100)
RETU
