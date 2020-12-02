/***********************************************************
 * �����    : rsnaczen.prg
 * �����    : 0.0
 * ����     :
 * ���      : 05/12/04
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

//*#define DEBUG
#define NEW_RSDOGZEN
#include "Common.ch"
#include "inkey.ch"
MEMVAR tarar, KpvR, KplR
MEMVAR GetList

*/*****************************************************************
* 
* FUNCTION: RsNacZen()
* �����..����..........�. ��⮢��  12.05.04 * 11:02:56
* ����������......... ���� 業 �� 䨪�஢���� �᫮���
* ���������..........
* �����. ��������....
* ����������.........
* */

/*****************************************************************
 
 FUNCTION: UslovCheck()
 �����..����..........�. ��⮢��  14.05.04 * 12:37:30
 ����������......... //�஢�ਬ ����⢨�  �᫮���
 ���������..........
 �����. ��������.... �� ��� - ����⢨� �᫮���
 ����������.........
 */
STATIC FUNCTION UslovCheck()
   LOCAL lRet
   lRet:=TRUE
   //�஢�ਬ ����⢨�  �᫮���
   DO CASE
   CASE (EMPTY(Kpl->dtnace))
      //��� �᫮��� ��� ��������� 業
      wmess('��� �᫮��� ��� ��������� 業', 3)
      lRet:=FALSE
   CASE (.T. .AND. Kpl->dtnace < MEMVAR->gdTd)
      //�ப �᫮��� �����稫��
      wmess('�ப �᫮��� � '+ DTOC(Kpl->dtnacb) +" �� "+ DTOC(Kpl->dtnace)+' �����稫��', 3)
      lRet:=FALSE
   ENDCASE
   CLEAR TYPEAHEAD

   RETURN (lRet)

/*****************************************************************
 
 FUNCTION: Usl4Pst()
 �����..����..........�. ��⮢��  14.05.04 * 11:38:10
 ����������......... ����祭�� ��� �᫮��� �� �⥪�����
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION Usl4Pst(bReplOldPst)
   LOCAL nRecNo_Kln
   DEFAULT bReplOldPst TO { || _FIELD->pst:=IIF(tarar=0, 1, 0) }
   //�᫮��� ��� �⥪�����
   //nKkl := IIF(KpvR = 0, KplR, KpvR)
   //������ �� ���� �����
   nRecNo_Kln:=Kln->(RECNO())
*   Kln->(NetSeek('T1',iif(kpvr=0,'KplR','kpvr')))
*   Kln->(NetSeek('T1','nkklr'))
   Kpl->(NetSeek('T1','kplr'))
   IF (Kpl->(UslovCheck()))
      repl pst with Kpl->pst
      MEMVAR->pstr:= _FIELD->pst
   ELSE                        //�᫮��� ��� ��� ��� �����稫���
      EVAL(bReplOldPst)
   /*
   if tarar=0
       repl pst with 1
   else
       repl pst with 0
   endif
   */
   ENDIF

   Kln->(DBGOTO(nRecNo_Kln))
   RETURN (NIL)

/*****************************************************************
 
 FUNCTION: Usl4Zat_61()
 �����..����..........�. ��⮢��  14.05.04 * 12:45:49
 ����������......... ���������� ��� �� �᫮���
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION Usl4Zat_61(lUpdate)
   LOCAL nRecNo_Kln
   LOCAL nSelect
   MEMVAR ttnr

   DEFAULT lUpdate TO FALSE
   nSelect:=SELECT()
   //������ �� ���� �����
   nRecNo_Kln:=Kln->(RECNO())

   ///////////   61 - ����� �����  /////////////
   rs3->(netseek('t1', 'ttnr'))
   SELECT rs3
   LOCATE FOR rs3->Ksz = 61 WHILE rs3->ttn = ttnr
   IF (!FOUND())
      netadd()
      netrepl('ttn,ksz,ssf,bssf,pr,bpr', 'ttnr,61,Kpl->smksz61,Kpl->smksz61,Kpl->prksz61,Kpl->prksz61')
   ELSE
      IF (lUpdate)
         netrepl('ttn,ksz,ssf,bssf,pr,bpr', 'ttnr,61,Kpl->smksz61,Kpl->smksz61,Kpl->prksz61,Kpl->prksz61')
      ENDIF

   ENDIF

   SELECT (nSelect)

   Kln->(DBGOTO(nRecNo_Kln))

   RETURN (NIL)


/*****************************************************************
 
 FUNCTION: Usl4Zat_46()
 �����..����..........�. ��⮢��  28.05.04 * 08:53:00
 ����������......... ���� �㬬� ��ଫ���� ���㬥�⮢ �� 業� 17��� �� ����⮢�⥫�
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION Usl4Zat_46(lUpdate)
   LOCAL nRecNo_Kln, aIzg
   LOCAL nSelect
   MEMVAR ttnr, Zat46_Sumr, Zat46_Pr
   PRIVATE  Zat46_Sumr, Zat46_Pr

   DEFAULT lUpdate TO FALSE
   nSelect:=SELECT()
   //������ �� ���� �����
   nRecNo_Kln:=Kln->(RECNO())
*   Kln->(NetSeek('T1',iif(kpvr=0,'KplR','kpvr')))
   Kpl->(NetSeek('T1','nkklr'))

   ///////////   46 - ����� �����  /////////////
   Zat46_Sumr:=0
   Zat46_Pr:=0
   IF .T.
    IF Kpl->ksz46=1 //��ଫ���� ���㬥�⮢ (���䨪���  �����?)
       //�����⠥� �-�� �ந�����⥫�� ��� ��મ��ঠ⥫��
       aIzg:={}
       rs2->(netseek('t1', 'ttnr'))
       rs2->(DBEVAL({ ||                                                          ;
                        IIF(EMPTY(aIzg) .OR. EMPTY(ASCAN(aIzg, rs2->Izg)),   ;
                              (AADD(aIzg, rs2->Izg)),                           ;
                              NIL                                                    ;
                           )                                                        ;
                      },;
                      {|| int(rs2->ktl/1000000) > 1 }, ;//⮫쪮 ��� ⮢��
                      { || rs2->ttn = ttnr }                                     ;
                   )                                                                ;
           )


       //�-�� 㬭���� �� 17��� � ����訬
       Zat46_Sumr:=VAL("0.15") * LEN(aIzg)
       Zat46_Pr:=0
    ENDIF
   ELSE
     Zat46_Sumr:=Kpl->smksz46
     Zat46_Pr:=Kpl->prksz46
   ENDIF

   SELECT rs3
   rs3->(netseek('t1', 'ttnr'))
   LOCATE FOR rs3->Ksz = 46 WHILE rs3->ttn = ttnr
    IF (!FOUND())
      netadd()
      netrepl('ttn,ksz,ssf,bssf,pr,bpr', 'ttnr,46,Zat46_Sumr,Zat46_Sumr,Zat46_Pr,Zat46_Pr')
    ELSE
      IF (lUpdate)
          netrepl('ttn,ksz,ssf,bssf,pr,bpr', 'ttnr,46,Zat46_Sumr,Zat46_Sumr,Zat46_Pr,Zat46_Pr')
      ENDIF
    ENDIF

   SELECT (nSelect)

   Kln->(DBGOTO(nRecNo_Kln))

  RETURN (NIL)

/*****************************************************************
 
 FUNCTION: CreateFiltNamTov()
 �����..����..........�. ��⮢��  10.06.04 * 08:57:24
 ����������......... ����祭�� 䨫��� �� ������������
 ���������..........
 �����. ��������....
 ����������.........
 */
FUNCTION CreateFiltNamTov(forNaT)
  LOCAL cChrSeek, cChrSeekNorm
  LOCAL aItem

  IF forNaT=".AND..T."
    forNaT:=SPACE(60)
  ELSE
    forNaT:=PADR(SUBSTR(forNaT,6),60)
  ENDIF

  cChrSeek:=forNaT

  aItem:=SaveRestImage()
  @ MAXROW()-1, 0 SAY "�᫮��� 䨫���:" GET  cChrSeek PICT "@K" COLOR "G/N,N/BG"
  SET CURSOR ON; READ; SET CURSOR OFF

  IF LASTKEY()=K_ENTER .AND. !EMPTY(cChrSeek)
    cChrSeek:=ALLTRIM(cChrSeek)
    DO CASE
    CASE LEN(cChrSeek) = 7 .AND. VAL(cChrSeek) # 0
      MakeBlockSeek(cChrSeek, @cChrSeekNorm, "str(mntov,7)")
    CASE .F.
      //
    OTHERWISE
      MakeBlockSeek(cChrSeek, @cChrSeekNorm, "UPPER(NaT)")
    ENDCASE
    @ MAXROW()-1, 0 SAY cChrSeekNorm
    forNaT:=".AND."+cChrSeekNorm
  ELSE
    forNaT:=".AND..T."
  ENDIF

  SaveRestImage(aItem)
  RETURN (NIL)

/*****************************************************************
 
 FUNCTION: MakeBlockSeek
 �����..����..........�. ��⮢��  18.08.01 * 11:39:04
 ����������......... ࠧ��ઠ ��������� ��ப� � ᮧ����� ����� ���᪠
 ���������.......... cChrSeek -��ப� ���᪠
                     cBlockSeek - ࠧࠡ�⠭��� ��ப� ���᪠
 �����. ��������....
 ����������.........
 */
FUNCTION MakeBlockSeek(cChrSeek, cChrSeekNorm, cInclude)
  LOCAL bBlockSeek, cBlockSeek, nWord, cWord, lWordLocic
  LOCAL cSaveToken

  DEFAULT cInclude TO "UPPER(_FIELD->Name)"

  cSaveToken:=SAVETOKEN()

  lWordLocic:=FALSE

  //ࠧ��ઠ ��������� ��ப�
  cBlockSeek:=""
  nWord:=0
  TOKENINIT(@cChrSeek, CHR(32)+[#/-�"'])
  // .# -�"'
  WHILE (!TOKENEND())
    cWord := TOKENNEXT(cChrSeek)
    nWord++
    DO CASE
    CASE (cWord="AND")
      //���묨 �� ����� ����
      IF (nWord#1 .AND. !lWordLocic .AND. !lWordLocic_AND_OR)
        cBlockSeek+=".AND."
        lWordLocic_AND_OR:=TRUE
      ENDIF

    CASE (cWord="OR")
      //���묨 �� ����� ����
      IF (nWord#1 .AND. !lWordLocic .AND. !lWordLocic_AND_OR)
        cBlockSeek+=".OR. "
        lWordLocic_AND_OR:=TRUE
      ENDIF

    CASE (cWord="NOT")
      cBlockSeek+=".NOT."
      lWordLocic:=TRUE
    OTHERWISE
      IF (nWord#1 .AND. !lWordLocic .AND. !lWordLocic_AND_OR)
        //�᫨ ���� ᫮�� � ��� ��� �離� � ᮤ��塞 �१ �
        cBlockSeek+=".AND."
      ENDIF

      cBlockSeek+='"'+UPPER(cWord)+'"'+"$"+cInclude
      lWordLocic:=FALSE
      lWordLocic_AND_OR:=FALSE
    ENDCASE

  ENDDO

  IF (lWordLocic .OR. lWordLocic_AND_OR)
    cBlockSeek:=LEFT(cBlockSeek, LEN(cBlockSeek)-5)
  ENDIF

  cChrSeekNorm:=cBlockSeek
  cBlockSeek:="{||"+cBlockSeek+"}"
  //᪮������㥬 � �ந������ ����
  bBlockSeek:=&cBlockSeek

  RESTTOKEN(cSaveToken)

  RETURN (bBlockSeek)

/*****************************************************************
 
 FUNCTION: SaveRestImage()
 �����..����........  �. ��⮢��  09/04/97 * 10:22:34
 ����������.........
 */
FUNCTION SaveRestImage(aItem)
   IF (ISNIL(aItem))       //������ ���㦥���
      aItem:={               ;
               SETCOLOR(),    ;//1
               SETCURSOR(),   ;//2
               SAVEGETS(),    ;//3
               SAVESETKEY(),  ;//4
               SELECT(),      ;//5
               ROW(),         ;//6
               COL()          ;//7
             }
   ELSE
      SETCOLOR(aItem[ 1 ])
      SETCURSOR(aItem[ 2 ])
      RESTGETS(aItem[ 3 ])
      RESTSETKEY(aItem[ 4 ])
      SELECT (aItem[ 5 ])
      DEVPOS(aItem[ 6 ], aItem[ 7 ])
   ENDIF

   RETURN (aItem)


