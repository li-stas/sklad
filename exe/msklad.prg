/***********************************************************
 * �����    : msklad.prg
 * �����    : 0.0
 * ����     :
 * ���      : 02/25/19
 * �������   :
 * �ਬ�砭��: ����� ��ࠡ�⠭ �⨫�⮩ CF ���ᨨ 2.02
 */

#include "common.ch"
#include "inkey.ch"

/************************************ */
//������� ����
//(c) 1998 Harry B. Dubrovin
/************************************ */
przvr=0                     // �ਧ��� ���
if (Lastkey()=K_ENTER)
  setcolor("g/n,n/g,,,")
  do case
  case (I = 3)            //��ࠢ�筨�� menu3[]
    do case
    case (pozicion=1)     //����� ᪫���
      VPATH()
    case (pozicion=2)     //OPER
      if (alltrim(uprlr)=gcSprl.or.gnEnt=21.and.gnKto=786)
        s_soper()
      else
        wmess('������ !!!')
      endif

    case (pozicion=3)     // ��ࠢ�筨� ��㯯 �� ����⮢�⥫�
      if (gnAdm=1.or.dkklnr=1)//alltrim(uprlr)=gcSprl
        s_sgrp()
      else
        wmess('��� ������� !!!')
      endif

    case (pozicion=4)     //����䨪���
      if (gnCtov=1)
        sert()
      endif

    case (pozicion=5)     //����� ���䨪�⮢
      if (gnCtov=1)
        PSert()
      endif

    case (pozicion=6)     //��।��
      if (gnAdm=1.or.gnRrm=1)
        rmmain(1)
      endif

    case (pozicion=7)     //�ਥ�
      if (gnAdm=1.or.gnRrm=1)
        rmmain(2)
      endif

    case (pozicion=8)     //�ਥ�
      rmprot()
    case (pozicion=9)     //�७��
      if (gnEnt=21)
        //                     #ifdef __CLIP__
        //                       lpos()
        //                     #else
        lposd()
      //                     #endif
      else
        netuse("ctov")
        netuse("tovm")
        netuse("tov")
        netuse("sgrp")
        netuse("mkeep")
        netuse("kspovo")
        ctov()
        nuse("mkeep")
        nuse("sgrp")
        nuse("tov")
      endif

    case (pozicion=10)    //������
      skspovo()             // vost.prg
    case (pozicion=11)    //���� �த�樨
      kprod()               // vost.prg
    endcase

  case (I = 4)            //.and.who#0   //��室 menu4[]
    gnRegrs=0
    gnD0k1=1
    gnVo=0
    crpro()                 // �������� pro1,pro2
    NdOtvr=0
    do case
    case (pozicion=1.and.who#0)//���⠢騪�
      gnVo=9
      fornd_r='vo=9'
      PrhRsh()
    case (pozicion=2.and.who#0)//��������
      gnVo=2
      fornd_r='vo=2'
      PrhRsh()
    case (pozicion=3.and.who#0)//������ �� ���㯠⥫��
      gnVo=1
      fornd_r='vo=1'
      PrhRsh()
    case (pozicion=4.and.who#0)//��ॡ�᪠
      gnVo=6
      fornd_r='vo=6'
      PrhRsh()
    case (pozicion=5.and.who#0)//�७��
      gnVo=10
      fornd_r='vo=10'
      PrhRsh()
    case (pozicion=6)          //��������� ��室� Ok
      PRVED()
    case (pozicion=7.and.who#0)//�������� ��室� Ok
      PUDL()
    case (pozicion=8)
      pprot()                    // ��⮪�� ��室�
    case (pozicion=9.and.who#0)
      gnVo=0
      fornd_r='sks#0'
      PrhRsh()                   // ��⮬���᪨� ��室�
    case (pozicion=10.and.who#0)// ������
      etic()
    case (pozicion=11.and.who#0)//�������
      gnVo=3
      fornd_r='vo=3'
      PrhRsh()
    case (pozicion=12.and.who#0)//��⮪�� �த�� �� ��.��.
      if (gnSkotv#0)
        wmess('��� ᪫�� �� ����� ⠪�� ��⮪����', 2)
        return
      endif

      gnVo=9
      fornd_r='vo=9'
      NdOtvr=2
      PrhRsh()
    case (pozicion=13.and.who#0)//��室�(�����) c ��.��.
      if (gnSkOtv#0)
        wmess('��� ᪫�� �� ����� ⠪�� ��室��', 2)
        return
      endif

      gnVo=9
      fornd_r='vo=9'
      NdOtvr=3
      PrhRsh()
    case (pozicion=14 .and.gnAdm=1)//.and.who#0    //��室�(�����) c ��.��.
      if (gnSkOtv#0)
        wmess('��� ᪫�� �� ����� ⠪�� ��室��', 2)
        return
      endif

      gnVo=9
      fornd_r='vo=9'
      NdOtvr=4
      PrhRsh()
    case (pozicion=15.and.gnAdm=1)//��� �� ���
      mkotchd()
    case (pozicion=16)            // ���⪨ �����ᨮ��஢
      ostkt()                       // ost/tov.ptg
    case (pozicion=17)            // ��� ��।�� �� ��
      prtotv()                      // pr/paotv.ptg
    case (pozicion=18 .and. gnEnt=21) // MENU4[18] := "����� ��� (�����)"
      MkSoh2()
    endcase

  case (I = 5)            // ���室 menu5[]
    prnnpr=0                // ������� ����⢨� � ���㬥�⮬ �� �뫮
    gnD0k1=0
    crrso()                 // �������� rso1,rso2
    do case
    case (pozicion=1)     //���㯠⥫�
      gnVo=9
      gnRegrs=0
      PrhRsh()
      //              case pozicion=2.and.(gnAdm=1.or.(gnRp=1.and.who#1))
      //                   gnVo=9       //���㯠⥫� �/� Ok
      //                  gnRegrs=1
    //                  PrhRsh()
    case (pozicion=2)     //��������
      gnVo=2
      gnRegrs=0
      PrhRsh()
      //              case pozicion=4.and.(gnAdm=1.or.(gnRp=1.and.who#1))
      //                   gnVo=2       //�������� �/� Ok
      //                  gnRegrs=1
    //                   PrhRsh()
    case (pozicion=3)     //��������� �������
      gnVo=7
      gnRegrs=0
      vor=7
      PrhRsh()
    case (pozicion=4)     //������ �� �������
      gnVo=8
      gnRegrs=0
      vor=7
      PrhRsh()
    case (pozicion=5)     //����७��� ��ॡ�᪠
      gnVo=6
      gnRegrs=0
      PrhRsh()
    case (pozicion=6)     //��� �� ᯨᠭ��
      prlkr=0
      gnRegrs=0
      gnVo=5
      store space(60) to kom1r, kom2r, kom3r, zak1r, zak2r, zak3r
      PrhRsh()
    case (pozicion=7)     //������ ���⠢騪�
      gnRegrs=0
      gnVo=1
      PrhRsh()
    case (pozicion=8)     //�७��
      gnRegrs=0
      gnVo=10
      PrhRsh()
    case (pozicion=9.and.who#2)//���⢥ত����    Ok
      if (.t.)
        if (!(month(gdTd)=month(date()).and.year(gdTd)=year(date())))
          ach:={ '���', '��' }
          achr=0
          achr=alert('�� �� ⥪�騩 �����.�த������?', ach)
          if (achr#2)
            return
          endif

        endif

        RFAKT()
      else
        wmess('������ !!!')
      endif

    case (pozicion=10)    //�������� ��室� Ok
      if (.t.)
        RUDL()
      else
        wmess('������ !!!')
      endif

    case (pozicion=11)    //��������� ��室�  Ok
      RSVED()
    case (pozicion=12)    //��������� ⥪�饣� ���
      RSVEDTD()
    case (pozicion=13)    //�����ᨮ���� �࣮���
      gnRegrs=0
      gnVo=3
      PrhRsh()
    case (pozicion=14)    //����� �����ᨮ��஢
      rvedvGR()
    case (pozicion=15)
      rprot()               // ��⮪�� ��室�
    case (pozicion=16)    //��⮬���᪨�
      gnVo=0
      fornd_r='sks#0'
      PrhRsh()
    case (pozicion=17)    // ��⮪�� �� �����⭮� ��
      prlkr=0
      gnRegrs=0
      gnVo=4
      PrhRsh()
    case (pozicion=18)    //���� �� docguid bso2.prg
      if (gnEnt=21)
        pskguid()
      endif

    /*
    *                   if gnCtov=3.and.gnMskl=0  // ����⭠� ����
    *                      prlkr=1
    *                      gnRegrs=0
    *                      gnVo=5
    *                      store space(60) to kom1r,kom2r,kom3r,zak1r,zak2r,zak3r
    *                      PrhRsh()
    *                   endif
    */
    case (pozicion=19)    //����㧪� �த��
      if (empty(gcPath_pm))
        wmess('PATH_PM � SHRIFT ���⮩', 1)
        return
      endif

      przvr=1               // �ਧ��� ���
      prnnpr=0              // ������� ����⢨� � ���㬥�⮬ �� �뫮
      gnD0k1=0
      gnVo=9
      gnRegrs=0
      PrhRsh()
      przvr=0
    case (pozicion=20.and.gnEnt=20.and.prdp().and.gnAdm=1)//���⢥ত���� ᯨ᪮�
      lstfakt()             // rfakt
    case (pozicion=21)    //����� �����ᨮ��஢
      otkms()               // rvedvgr.prg
                            //                    rvedvGR()
    case (pozicion=22                    ; // �業��
           .and.str(gnEnt, 3)$' 20; 21' ;
           .and.(gnAdm=1.or.str(gnKto, 4)$' 129; 160; 117') ;// ���� ��࠭�� �饭�� 169
        )
      TtnUc()               // crrso.prg
    endcase

  case (I = 6)            // ���⪨ menu6[]
    do case
    case (pozicion=1)     //��ᬮ�� ���⪮� Ok
      kpsr=0
      gnD0k1=0
      if (gnCtov=1)
        tovm()
      else
        tov()
      endif

    case (pozicion=2)     //�������� ���⪮� Ok
      vost()
    case (pozicion=3)     //�������� ���⪮� �� ⮢��� Ok
      vostm()
    case (pozicion=4)     //����⭠� ��������� Ok
      VOBR()
    case (pozicion=5)
      vcen()                //��������� 業
    case (pozicion=6)
      vinv()                //��������� ������ਧ�樨
    case (pozicion=7)
      odkp()                //���� ���㯠⥫��
    case (pozicion=8)
      debn()                // �����ઠ
    /* //                  sctov()       //��८業�� */
    case (pozicion=9)
      gd_Td:=gdTd

      gdTd:=ADDMONTH(gdTd, -1)
      inipath()
      kssk(, 1)           // ����� �㬬� �� ᪫��� debs.prg
      gdTd:=gd_Td
      inipath()
      kssk(-19)           // ����� �㬬� �� ᪫��� debs.prg
                            // //                 debs()        //�����ઠ �� �㯥�
                            // //                 zagrat()
    case (pozicion=10)    // ����஫� ���㧪�
      chkotgr()             // sctov.prg
    case (pozicion=11)    // ����஫� ��� ���
      chkzvkpk()
    case (pozicion=12)    // ������ ���
      vtara()
    case (pozicion=13)    //����� �ࠩᮢ
      prnprice()
    case (pozicion=14)    //��� �� ���� sctov.prg
      ostday()
    case (pozicion=15)    // ��� ���
      zvkpk()               //sctov.prg
    case (pozicion=16)    // ������ ��� ���
      SbZvKpk()             //sctov.prg
    case (pozicion=17.and.gnEnt=20)// �����
      vzkpk()                        //sctov.prg
                                     // ktaopl()      //sctov.prg
    case (pozicion=18)             // ��樨
      rsakc()                        // cen.prg
    case (pozicion=19.and.(gnAdm=1.or.gnRnap=1).and.gnEnt=20)// ����� �� ���ࠢ�����
      OplNap()              //sctov.prg
    case (pozicion=20)    // ��� ��ન �� ����㤮�����
      if (gnCtov = 1)
        AktChkKpl()
      endif

    case (pozicion=21)    // ��� ��ન �� ����㤮�����
      if (gnCtov = 1)
        AktChkTa()
      endif

    endcase

  case (I = 7)            //��ࢨ� menu7[]
    do case
    case (pozicion=1)     //��������
                            //                    BINDX()
      sindxns()
    case (pozicion=2)     //��ॢ��� Ok
      if (Who = 3)
        if (alltrim(uprlr)=gcSprl.or.gnEnt=5)
          vbr=0
          avb:={ '��', '���' }
          vbr=alert('�� ��ॢ��� �����.�� 㢥७�?', avb)
          if (vbr=1)
            pathtr=gcPath_t
            DOBNV()
          endif

        endif

      endif

    case (pozicion=3)     // ���४�� ���㬥�⮢ �� opt  MENU7[3]
                            //                      wmess('�⪫�祭�',2)
      if (gnAdm=1)
        vbr=1
        avb:={ '���', '��' }
        vbr=alert('�� ������� ���㬥�⮢.�� 㢥७�?', avb)
        if (vbr=2)
          CDocOpt()
        endif

      else
        wmess('�����!!!', 2)
      endif

    case (pozicion=4)     // ���⪨ ���
                            //                  if gnAdm=1
      if (gnTpstpok=2.and.bom(gdTd)=ctod('01.09.2006').and.gnEnt=21)
      else
        path_tr=gcPath_t
        dtpr=bom(gdTd)-1
        yyr=year(dtpr)
        mmr=month(dtpr)
        path_pr=gcPath_e+'g'+str(yyr, 4)+'\m'+iif(mmr<10, '0'+str(mmr, 1), str(mmr, 2))+'\'+gcDir_t
        ctov_r=gnCtov
        nost()
      endif

      //                  else
      //                      wmess('�����!!!',2)
    //                  endif
    case (pozicion=5)     // ����騥 ���⪨
                            //                   if gnAdm=1
      path_tr=gcPath_t
      ctov_r=gnCtov
      skr=gnSk
      sklr=gnSkl
      entr=gnEnt
      arndr=gnArnd
      //                      #ifdef __CLIP__
      tost()
      //                      #else
      //                        tost1()
      //                      #endif
      //                   else
      //                      wmess('�����!!!',2)
    //                   endif
    case (pozicion=6)     // ��室� �� �࠭
      if (gnAdm=1)
        //                     cropl() // psert.prg
      //                     crotvosv()
      endif

      //                  if gnOtv#0
      //                     if gnAdm=1
      //                        path_tr=gcPath_t
      //                        ctov_r=gnCtov
      //                        p rvotv() //  protv.prg
      //                     else
      //                        wmess('�����!!!',2)
      //                     endif
      //                 else
      //                     wmess('��� ᪫�� �� ����� �⢥��࠭����',2)
    //                endif
    case (pozicion=7)     // �� �� ����
                            // ���᪭� 業�
                            //                 if gnAdm=1
      path_tr=gcPath_t
      dtpr=bom(gdTd)-1
      yyr=year(dtpr)
      mmr=month(dtpr)
      path_pr=gcPath_e+'g'+str(yyr, 4)+'\m'+iif(mmr<10, '0'+str(mmr, 1), str(mmr, 2))+'\'+gcDir_t
      ctov_r=gnCtov
      OtvPrv()              // protv.prg
                            //                  scen()
                            //                 else
                            //                   wmess('�����!!!',2)
                            //                endif
    case (pozicion=8)     // ���४�� RS2M
      if (gnAdm=1)
        path_tr=gcPath_t
        ctov_r=gnCtov
        if (gnCtov=1)
          crs2m()
        endif

      else
        wmess('�����!!!', 2)
      endif

    case (pozicion=9)     // �������
      if (gnAdm=1)
        psort()
      else
        wmess('�����!!!', 2)
      endif

    case (pozicion=10)    // S92
      s92()
    case (pozicion=11)    // ���㬥��� �� �६���
      tdoc()
    case (pozicion=12)    // ��⮬���
                            // ���४�� ������⮢ ⥪���
      if (gnAdm=1)
        autodoc()
      endif

    //                   adoc()
    case (pozicion=13)    // OSN OSF ��� �ࠩ�� ��娢
                            //                   if gnAdm=1
                            //                      frarh()
                            //                  endif
      ostprd()
    case (pozicion=14)    // ���� ���㬥��
      docsrch()
    case (pozicion=15)    // ���� ���� ���
      CorVt()
    case (pozicion=16)    // ���� rs1.tmesto, ktas /serv/scen.prg
      cortm()
    case (pozicion=17)    // ����� ���  /serv/scen.prg
      mdglkn()
    case (pozicion=18)    // 361
      s361()
    case (pozicion=19)    // ����� ��� 361 /serv/scen.prg
      md361()
    case (pozicion=20)    // �� DOCGUID /serv/scen.prg
      dvid()
    endcase

  case (I = 8)            //���⠢�� menu8[]
    do case
    case (pozicion=1)
      cmrsh()               //�������� �����
    case (pozicion=2)
      kgpsk()               //���⠢��
    case (pozicion=3)
      vmrsh()               //��������
    case (pozicion=4)
      if (gnAdm=1)
        crmrshn()           //���� ���
      endif

    case (pozicion=5)
      if (gnAdm=1)
        crmrsht()           //���� ⥪
      endif

    case (pozicion=6)
      vzttn()
    case (pozicion=7)
      shvzttn()
    endcase

  endcase

  keyboard chr(5)
endif

return (.T.)
