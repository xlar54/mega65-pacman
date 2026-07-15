10 print"{clr}";chr$(27);"x";
20 dim s$(21): rem sprite builder array
30 dim ac(5,10): rem actor data
40 dim sp$(33) : rem sprites, including items and their point popups
50 gosub 3340:gosub 1600:gosub 1860:gosub 6000:nw=1:cs=0:vol 5,10:ma=4:gosub 4630:d$="{up}{rght}{down}{left}"
60 dim pt(7):pt(0)=7:pt(1)=20:pt(2)=7:pt(3)=20:pt(4)=5:pt(5)=20:pt(6)=5:pt(7)=9999
70 dim st(4,1):st(1,0)=25:st(1,1)=-3:st(2,0)=2:st(2,1)=-3:st(3,0)=27:st(3,1)=25:st(4,0)=0:st(4,1)=25
80 dim ge(4),gr(4),cd(4),gb(4),rb(4)
85 dim hn$(10),hd$(10),hv(10):gosub 5000
86 dim pv(8),zc(8)
87 pv(1)=100:pv(2)=300:pv(3)=500:pv(4)=700:pv(5)=1000:pv(6)=2000:pv(7)=3000:pv(8)=5000
88 zc(1)=2:zc(2)=2:zc(3)=18:zc(4)=2:zc(5)=5:zc(6)=7:zc(7)=7:zc(8)=3
90 goto 4650
100 dc=dc-1:fd=fd+1:cursor 30,7:print "{lblu}"+right$("000000"+mid$(str$(cs),2),6):gosub 4850
105 if (fd=70 or fd=170) and fa<2 then gosub 5650
110 sound 4,8000,5,2,0,1500,1,0:return
120 cursor 30,7:print "{lblu}"+right$("000000"+mid$(str$(cs),2),6):gosub 4850:return
130 rem interrupt. sound, flash pp, anim pac
140 ct=ti
142 sf=16000
144 if dc<=td*0.75 then sf=19000
146 if dc<=td*0.5 then sf=22000
148 if dc<=td*0.25 then sf=25000
149 if dc<=td*0.1 then sf=28000
150 if ct-at>=1.95 and fr=0 then sound 1,sf,100,2,sf/2,700,2,2000:at=ct
160 if ct-ft >= 0.25 then begin
170   fp=fp+1:if fp=2 then fp=0
180   c@&(1,2)=fp:c@&(25,2)=fp:c@&(1,16)=fp:c@&(25,16)=fp
190   ft=ct
200 bend
210 rem if ca<>0 then 330
220 if an(0)=0 then sn=0:goto290
230 ct=ti
240 if ct-lt >= 0.05 then begin
250  if ac(0,1)=90  then sn=sn+1:if sn>1 then sn=0
260  if ac(0,1)=270 then sn=sn+2:if sn>2 then sn=0
270  if ac(0,1)=0   then sn=sn+3:if sn>3 then sn=0
280  if ac(0,1)=180 then sn=sn+4:if sn>4 then sn=0
290  sprsav sp$(sn),0
300  lt=ct
310 bend
320 return
330 rem sprite to sprite collision handler
340 cm%=bump(1):co%=co% or cm%:if xx=0 then xx=((co% and 1)=0)+1
350 return:rem 1540
360 rem init screen
370 border0: background0:color1:fort=0to6:movspr t,0#0:spritet,0:next:dc=0
380 gd=0:gc=0:ld=ti:fr=0:gs=100:fa=0:fu=0:fs=0:fd=0:mc=0:ce=1:gosub 5900
390 collision 1,330: rem sprite to sprite collision interrupt
400 print"{clr}{lblu}";
410 print"OCCCCCCCCCCCC{CBM-R}CCCCCCCCCCCCP
420 print"B............W............#
430 print"BQUCCI.UCCCI.W.UCCCI.UCCIQ#
440 print"B.JCCK.JCCCK.A.JCCCK.JCCK.#
450 print"B.........................#
460 print"B.ZCCX.UI.ZCC{CBM-R}CCX.UI.ZCCX.#
470 print"B......WW....W....WW......#
480 print"LCCCCI.WVCCX A ZCC{SHIFT-+}W.UCCCC{SHIFT-@}
490 print"     W.WW         WW.W
500 print"CCCCCK.JK UCC{CBM-@}CCI JK.JCCCCC
510 print"      .   W     W   .
520 print"CCCCCI.UI JCCCCCK UI.UCCCCC
530 print"     W.WW         WW.W
540 print"OCCCCK.JK ZCC{CBM-R}CCX JK.JCCCCP
550 print"B............W............#
560 print"B.ZCCI.ZCCCX.A.ZCCCX.UCCX.#
570 print"BQ...W...............W...Q#
580 print"{CBM-Q}CCX.A.UI.ZCC{CBM-R}CCX.UI.A.ZCC{CBM-W}
590 print"B......WW....W....WW......#
600 print"B.ZCCCC{CBM-E}{CBM-E}CCX.A.ZCC{CBM-E}{CBM-E}CCCCX.#
610 print"B.........................#
620 print"LCCCCCCCCCCCCCCCCCCCCCCCCC{SHIFT-@}
630 cursor 28,1:print"{rvon}{yel}pacman 65{lblu}{rvof}"
640 cursor 28,3:print"high score"
650 cursor 30,4:print right$("000000"+mid$(str$(hs),2),6)
660 cursor 28,6:print"score"
670 cursor 30,7:print"000000"
680 print"{home}";
690 rem color
700 fory=0to22:forx=0to26
705  if t@&(x,y)=46 or t@&(x,y)=81 then dc=dc+1
710  ift@&(x,y)=46 or t@&(x,y)=81 or t@&(x,y)=32 then c@&(x,y)=10:else c@&(x,y)=6
720 nextx:nexty
725 td=dc
730 rem c@&(13,9)=3:c@&(14,9)=3
740 rem sprite starting positions
750 for t=1 to 4:ge(t)=0:gr(t)=0:gb(t)=0:rb(t)=0:next t
760 sn=0:sprsav sp$(sn),0
770 sprsav sp$(6),1:sprsav sp$(7),2:sprsav sp$(8),3:sprsav sp$(9),4
780 sprite 0,1,ac(0,0):movspr 0,ac(0,1)#ac(0,2):movspr 0,ac(0,3),ac(0,4)
790 sprite 1,1,ac(1,0):movspr 1,ac(1,1)#ac(1,2):movspr 1,ac(1,3),ac(1,4)
800 sprite 2,1,ac(2,0):movspr 2,ac(2,1)#ac(2,2):movspr 2,ac(2,3),ac(2,4)
810 sprite 3,1,ac(3,0):movspr 3,ac(3,1)#ac(3,2):movspr 3,ac(3,3),ac(3,4)
820 sprite 4,1,ac(4,0):movspr 4,ac(4,1)#ac(4,2):movspr 4,ac(4,3),ac(4,4)
830 rem ready!
840 t=bump(1):co%=0:xx=0:cursor 11,12:print"{yel}ready!":gosub 4560
850 rem if new game, play music, else wait briefly
860 if nw=1 then gosub 3310:nw=0:sleep4.0:goto880
870 sleep 2
880 cursor 11,12:print"      "
890 rem movement loop
900 rem current speed and original speed
910 pc=0:gt=ti:gm=0:ut=ti
920 fort=0to4
930  ac(t,2)=vg
932  if t=0 then ac(t,2)=vp
934  ac(t,9)=ac(t,2)
940  ac(t,7)=rsppos(t,0):ac(t,8)=rsppos(t,1)
950 nextt
960 b$="{left}"
965 if ti-ut<0.02 then 965
966 ut=ti
970 for ca=0 to ma
980  if ca=0 then j=joy(3) and 15:if (j and 1)=1 then b$=mid$(d$,(j+1)/2,1)
990 if ca=0 and fr=0 and pc<7 and ti-gt>=pt(pc) then pc=pc+1:gt=ti:gm=pc and 1:gosub 3780
1000 if ca=0 and fr=1 and ti-fz>=du then fr=0:gt=gt+(ti-fz):gosub 4460
1010 if ca=0 and fr=1 and ti-fz>=wa then gosub 4520
1020  ac(ca,7)=rsppos(ca,0):ac(ca,8)=rsppos(ca,1)
1025  if ca=0 and (fu=1 or fs=1) then gosub 5700
1030  px=ac(ca,7)-22:py=ac(ca,8)-50
1040  rem check for tunnel
1050  if px>219 and py=79 then px=8 :movspr ca,px,py+50:goto1070
1060  if px=0   and py=79 then px=216:movspr ca,px,py+50
1070  tx=int(px/8):ty=int((py+8)/8)
1080  ai=mod(px,8)=0 and mod(py-7,8)=0
1090  rem ifca=0then cursor 0,23:print"                           "
1100  rem ifca=0then cursor 0,23:print"ai=";ai;" tx=";tx;" ty=";ty;" px=";px
1110  gosub 130
1120  if ai=-1 then begin
1130 rem collisions are resolved after every complete actor update pass
1140    c=t@&(tx,ty)
1150    ml=c@&(tx-1,ty):mr=c@&(tx+1,ty):mu=c@&(tx,ty-1):md=c@&(tx,ty+1)
1160    if ty=10 and (tx<=2 or tx>=25) then mu=6:md=6
1170    ac(ca,5)=tx:ac(ca,6)=ty
1180    if ca=0 then begin
1190 if c=46 then t@&(tx,ty)=32:cs=cs+10:gc=gc+1:ld=ti:gosub 100:goto1210
1200 if c=81 then t@&(tx,ty)=32:cs=cs+50:gosub 100:gosub 4380:goto1210
1210     if dc=0 then mc=1
1220    if b$="{left}" and ml<>6 then ac(0,1)=270
1230    if b$="{rght}" and mr<>6 then ac(0,1)=90
1240    if b$="{up}" and mu<>6 then ac(0,1)=0
1250    if b$="{down}" and md<>6 then ac(0,1)=180
1260   bend
1270   no=0
1280   if ac(ca,1)=270 and ml=6 then no=1
1290   if ac(ca,1)=90  and mr=6 then no=1
1300   if ac(ca,1)=0   and mu=6 then no=1
1310   if ac(ca,1)=180 and md=6 then no=1
1320   if ca=0 then begin
1330    ac(ca,2)=ac(ca,9):an(ca)=1:if no=1 then ac(ca,2)=0:an(ca)=0
1340   bend
1350 if ca>0 and ca<5 and ai=-1 then gosub 3480
1351 if ca>0 and ca<5 and ge(ca)=0 then begin
1352  ac(ca,2)=vg
1353  if ca=1 and ce=1 and dc<=e1 then ac(ca,2)=vg*r1
1354  if ca=1 and ce=1 and dc<=e2 then ac(ca,2)=vg*r2
1355  if gb(ca)=1 then ac(ca,2)=vf
1356  if ty=10 and (tx<=5 or tx>=21) then ac(ca,2)=ac(ca,2)*0.5
1357 bend
1360  dx=0:dy=0:qx=mod(px,8):qy=mod(py-7,8)
1370  if ac(ca,1)=90  then dx=8-qx
1380  if ac(ca,1)=270 then dx=qx-8:if qx>0 then dx=-qx
1390  if ac(ca,1)=0   then dy=qy-8:if qy>0 then dy=-qy
1400  if ac(ca,1)=180 then dy=8-qy
1410  if ac(ca,2)>0 then movspr ca,px+22,py+50 to px+22+dx,py+50+dy,ac(ca,2)
1420 bend
1430 next ca
1432 if mc=1 then 1450
1435 if xx=1 then xx=0:gosub 4230:co%=0:if dth=1 then dth=0:goto 1540
1440 goto 970
1450 rem cleared screen
1455 for t=0to4:movspr t,0#0:next t:sound clr:sleep 1
1460 for t=0to5:sprite t,0:next t:fu=0:fs=0
1470 forx=1to4
1480  edma 3,80*25,0,$1f800
1490  sleep 0.25
1500  edma 3,80*25,1,$1f800
1510  sleep 0.25
1520 nextx
1530 le=le+1:gosub 3340:goto 360
1540 rem player dies
1545 for t=0 to 4:movspr t,0#0:next t:sleep 0.5
1550 fu=0:fs=0:sprite 5,0:sound 1,1,1:sound 5,1,1:fort=1to4:spritet,0:next:sleep 0.2
1560 q=0
1562 for t=10 to 12
1564  sprsav sp$(t),0
1566  for z=1 to 4
1568   q=q+1:sound 4,24000-q*1800,5,2,0,1200,1,0:sleep 0.09
1570  next z
1572 next t
1574 sprite 0,0:sleep 0.3
1580 gd=1:gc=0:ld=ti:fr=0:ce=0:sound 5,1,1:lv=lv-1:gosub 4560:if lv<0 then 4600
1590 gosub 3340:goto 740
1600 rem character defs
1610 chardef 46,0,0,0,24,24,0,0,0                : rem dots
1620 chardef 66,144,144,144,144,144,144,144,144 : rem l vert bar
1630 chardef 67,0,0,255,0,0,255,0,0 : rem horiz double bar
1640 chardef 85,0,0,31,32,32,35,36,36: rem joy - shft-o
1650 chardef 75,36,36,196,4,4,248,0,0: rem curve - up to left
1660 chardef 74,36,36,35,32,32,31,0,0: rem curve - up to right
1670 chardef 73,36,36,39,32,32,31,0,0: rem rpen - shft-p
1680 chardef 115,9,9,241,1,1,241,9,9:rem v bar, left connection
1690 chardef 107,144,144,143,128,128,143,144,144:rem - - alt-q
1700 chardef 114,0,0,255,0,0,231,36,36
1710 chardef 113,36,36,231,0,0,255,0,0
1720 chardef 90,0,0,3,4,4,3,0,0: rem sound  shft-z
1730 chardef 88,0,0,192,32,32,192,0,0: rem tron - shft-x
1740 chardef 65,24,0 ,0 ,0 ,0 ,0 ,0,0: rem atn : shft-a
1750 chardef 91,36,36,196,4,4,196,36,36:rem resume - alt-dbl quote
1760 chardef 81,0,24,60,126,126,60,24,0:rem dec - shft-o
1770 chardef 35,9,9,9,9,9,9,9,9: rem righ border
1780 chardef 87,36,36,36,36,36,36,36,36: rem trap - shft-w
1790 chardef 76,144,144,143,128,128,127,0,0: rem rgraphic - shft l
1800 chardef 79,0,0,127,128,128,143,144,144: rem joy - shft-o
1810 chardef 122,9,9,241,1,1,254,0,0 : rem sqr - shft-@
1820 chardef 80,0,0,254,1,1,241,9,9: rem rpen - shft-p
1830 chardef 73,0,0,248,4,4,196,36,36: rem rpen - shft-p
1840 chardef 86,36,36,35,32,32,35,36,36:rem resume - shft-v
1850 return
1860 rem sprites
1870 rem pacman sprite
1880 s$(0)="     ##                 "
1890 s$(1)="  ########              "
1900 s$(2)=" ##########             "
1910 s$(3)="############            "
1920 s$(4)="############            "
1930 s$(5)="############            "
1940 s$(6)="############            "
1950 s$(7)=" ##########             "
1960 s$(8)="  ########              "
1970 s$(9)="     ##                 "
1980 sn=0:gosub 3180
1990 s$(0)="     ##                 "
2000 s$(1)="  ########              "
2010 s$(2)=" ###########            "
2020 s$(3)="##########              "
2030 s$(4)="#######                 "
2040 s$(5)="#######                 "
2050 s$(6)="##########              "
2060 s$(7)=" ###########            "
2070 s$(8)="  ########              "
2080 s$(9)="     ##                 "
2090 sn=1:gosub 3180
2100 s$(0)="     ##                 "
2110 s$(1)="  ########              "
2120 s$(2)="###########             "
2130 s$(3)="  ##########            "
2140 s$(4)="      ######            "
2150 s$(5)="      ######            "
2160 s$(6)="  ##########            "
2170 s$(7)="###########             "
2180 s$(8)="  ########              "
2190 s$(9)="     ##                 "
2200 sn=2:gosub 3180
2210 s$(0)="                        "
2220 s$(1)="                        "
2230 s$(2)=" #        #             "
2240 s$(3)="###      ###            "
2250 s$(4)="####    ####            "
2260 s$(5)="#####  #####            "
2270 s$(6)="############            "
2280 s$(7)=" ##########             "
2290 s$(8)="   #######              "
2300 s$(9)="     ##                 "
2310 sn=3:gosub 3180
2320 s$(0)="     ###                "
2330 s$(1)="   #######              "
2340 s$(2)=" ##########             "
2350 s$(3)="############            "
2360 s$(4)="#####  #####            "
2370 s$(5)="####    ####            "
2380 s$(6)="###      ###            "
2390 s$(7)=" #        #             "
2400 s$(8)="                        "
2410 s$(9)="                        "
2420 sn=4:gosub 3180
2430 s$(0)="      ##                "
2440 s$(1)="   ########             "
2450 s$(2)=" ############           "
2460 s$(3)="##############          "
2470 s$(4)="######  ######          "
2480 s$(5)="#####    #####          "
2490 s$(6)="####      ####          "
2500 s$(7)=" ##        ##           "
2510 s$(8)="                        "
2520 s$(9)="                        "
2530 sn=5:gosub 3180
2540 s$(0)="      ##                "
2550 s$(1)="   ########             "
2560 s$(2)=" ##   ##   ##           "
2570 s$(3)="### # ## # ###          "
2580 s$(4)="###   ##   ###          "
2590 s$(5)="##############          "
2600 s$(6)="##############          "
2610 s$(7)="##############          "
2620 s$(8)="##############          "
2630 s$(9)="##  ##  ##  ##          "
2640 sn=6:gosub 3180
2650 sn=7:gosub 3180
2660 sn=8:gosub 3180
2670 sn=9:gosub 3180
2680 s$(0)="                        "
2690 s$(1)="                        "
2700 s$(2)=" #        #             "
2710 s$(3)="###      ###            "
2720 s$(4)="####    ####            "
2730 s$(5)="#####  #####            "
2740 s$(6)="############            "
2750 s$(7)=" ##########             "
2760 s$(8)="   #######              "
2770 s$(9)="     ##                 "
2780 sn=10:gosub 3180
2790 s$(1)="                        "
2800 s$(2)="                        "
2810 s$(3)="                        "
2820 s$(4)="##        ##            "
2830 s$(5)="###      ###            "
2840 s$(6)="############            "
2850 s$(7)=" ##########             "
2860 s$(8)="   #######              "
2870 s$(9)="     ##                 "
2880 sn=11:gosub 3180
2890 s$(1)="                        "
2900 s$(2)="                        "
2910 s$(3)="                        "
2920 s$(4)="                        "
2930 s$(5)="                        "
2940 s$(6)="   ######               "
2950 s$(7)=" ####  ####             "
2960 s$(8)="                        "
2970 s$(9)="                        "
2980 sn=12:gosub 3180
2990 s$(0)="                        "
2994 s$(1)="                        "
2998 s$(2)=" ###    ###             "
3002 s$(3)="#####  #####            "
3006 s$(4)="## ##  ## ##            "
3010 s$(5)="#####  #####            "
3014 s$(6)=" ###    ###             "
3018 s$(7)="                        "
3022 s$(8)="                        "
3026 s$(9)="                        "
3040 sn=13:gosub 3180
3050 s$(0)=""
3052 s$(8)=""
3054 s$(9)=""
3056 s$(1)="     #### #### ####"
3058 s$(2)="        # #  # #  #"
3060 s$(3)="        # #  # #  #"
3062 s$(4)="     #### #  # #  #"
3064 s$(5)="     #    #  # #  #"
3066 s$(6)="     #    #  # #  #"
3068 s$(7)="     #### #### ####"
3070 sn=14:gosub 3180
3080 s$(0)=""
3082 s$(8)=""
3084 s$(9)=""
3086 s$(1)="     #  # #### ####"
3088 s$(2)="     #  # #  # #  #"
3090 s$(3)="     #  # #  # #  #"
3092 s$(4)="     #### #  # #  #"
3094 s$(5)="        # #  # #  #"
3096 s$(6)="        # #  # #  #"
3098 s$(7)="        # #### ####"
3100 sn=15:gosub 3180
3110 s$(0)=""
3112 s$(8)=""
3114 s$(9)=""
3116 s$(1)="     #### #### ####"
3118 s$(2)="     #  # #  # #  #"
3120 s$(3)="     #  # #  # #  #"
3122 s$(4)="     #### #  # #  #"
3124 s$(5)="     #  # #  # #  #"
3126 s$(6)="     #  # #  # #  #"
3128 s$(7)="     #### #### ####"
3130 sn=16:gosub 3180
3140 s$(0)=""
3142 s$(8)=""
3144 s$(9)=""
3146 s$(1)="    #  #### #### ####"
3148 s$(2)="   ##  #    #  # #  #"
3150 s$(3)="    #  #    #  # #  #"
3152 s$(4)="    #  #### #  # #  #"
3154 s$(5)="    #  #  # #  # #  #"
3156 s$(6)="    #  #  # #  # #  #"
3158 s$(7)="   ### #### #### ####"
3160 sn=17:gosub 3180
3170 return
3180 rem build sprite
3190 fort=10to20:s$(t)="                        ":nextt
3200 fort=0to20
3210  forb=1to24 step 8
3220   x$=mid$(s$(t),b,8):v=0
3230   forz=1to8
3240    if mid$(x$,z,1)="#" then v=v+2^(8-z)
3250   nextz
3260  sp$(sn)=sp$(sn)+chr$(v)
3270  nextb
3280 nextt
3290 sp$(sn)=sp$(sn)+chr$(0)
3300 return
3310 rem new game music
3320 play"o4 sc o5 c o4 g e o5 c o4 g e r o4 d$ o5 d$ o4 a$ f o5 d$ o4 a$ f r             o4 sc o5 c o4 g e o5 c o4 g e o4 se f# f g a b o5 c"
3330 return
3340 rem starting actor values
3350 rem ac(x,y) - x = actor number (0=pacman,1=blinky,2=pinky,3=inky,4=clyde)
3360 rem           y = data (0=color,1=direction,2=speed,3=x,4=y)
3370 ac(0,0)=7  :ac(1,0)=2  :ac(2,0)=4  :ac(3,0)=3  :ac(4,0)=18
3380 ac(0,1)=270:ac(1,1)=90 :ac(2,1)=90 :ac(3,1)=90 :ac(4,1)=270
3390 ac(0,2)=0  :ac(1,2)=0  :ac(2,2)=0  :ac(3,2)=0  :ac(4,2)=0
3400 ac(0,3)=126:ac(1,3)=126:ac(2,3)=110:ac(3,3)=126:ac(4,3)=142
3410 ac(0,4)=177:ac(1,4)=113:ac(2,4)=129:ac(3,4)=129:ac(4,4)=129
3420 return:rem 129
3430 mt=ti
3440 et=ti-mt
3450 if et>0.25 then poke53280,x::mt=ti:x=x+1
3460 print et
3470 goto 3440
3480 rem ghost ai: target tile per ghost + scatter/chase (steam guide)
3490 d=ac(ca,1):od=d+180:if od>=360 then od=od-360
3500 if ge(ca)=1 then 4060
3510 if ty=9 and tx=13 then ac(ca,1)=0:return
3520 if ty=10 and tx>=11 and tx<=15 then goto 3840
3530 if gb(ca)=1 then 4150
3540 d=ac(ca,1):od=d+180:if od>=360 then od=od-360
3545 if ca=1 and ce=1 and dc<=e1 then 3570
3550 if gm=0 then gx=st(ca,0):gy=st(ca,1):goto 3680
3560 rem chase targets
3570 if ca=1 then gx=ac(0,5):gy=ac(0,6):goto 3680
3580 ux=0:uy=0:pd=ac(0,1)
3590 if pd=0 then ux=-1:uy=-1
3600 if pd=90 then ux=1
3610 if pd=180 then uy=1
3620 if pd=270 then ux=-1
3630 if ca=2 then gx=ac(0,5)+4*ux:gy=ac(0,6)+4*uy:goto 3680
3640 if ca=3 then ex=ac(0,5)+2*ux:ey=ac(0,6)+2*uy:gx=2*ex-ac(1,5):gy=2*ey-ac(1,6):goto 3680
3650 dd=(tx-ac(0,5))*(tx-ac(0,5))+(ty-ac(0,6))*(ty-ac(0,6))
3660 if dd>64 then gx=ac(0,5):gy=ac(0,6):goto 3680
3670 gx=st(4,0):gy=st(4,1)
3680 rem pick the open non-reverse direction nearest the target
3690 bd=-1:bv=999999
3700 if mu<>6 and od<>0   then nx=tx:ny=ty-1:gosub 3770:if nv<bv then bv=nv:bd=0
3710 if ml<>6 and od<>270 then nx=tx-1:ny=ty:gosub 3770:if nv<bv then bv=nv:bd=270
3720 if md<>6 and od<>180 then nx=tx:ny=ty+1:gosub 3770:if nv<bv then bv=nv:bd=180
3730 if mr<>6 and od<>90  then nx=tx+1:ny=ty:gosub 3770:if nv<bv then bv=nv:bd=90
3740 if bd<0 then bd=od
3750 ac(ca,1)=bd
3760 return
3770 nv=(nx-gx)*(nx-gx)+(ny-gy)*(ny-gy):return
3780 rem mode switch: ghosts reverse (arcade rule)
3790 for t=1 to 4
3795 if gr(t)=0 or ge(t)=1 then 3820
3800 a=ac(t,1)+180:if a>=360 then a=a-360
3810 ac(t,1)=a
3820 next t
3830 return
3840 rem ghost house: staggered release, then out through the door
3850 rl=0
3855 if rb(ca)>0 then 3970
3860 if ti-ld>=rt then rl=1:ld=ti:goto 3960
3870 if gr(ca)=1 then rl=1:goto 3960
3880 if gd=1 then 3930
3890 if ca=1 or ca=2 then rl=1
3900 if ca=3 and fd>=p3 then rl=1
3910 if ca=4 and fd>=p4 then rl=1
3920 goto 3960
3930 if ca=2 and gc>=7 then rl=1
3940 if ca=3 and gc>=17 then rl=1
3950 if ca=4 and gc>=32 then rl=1
3960 if rl=1 then 4020
3970 rem waiting: pace between the pen walls
3975 rv=0:rr=0
3980 if ac(ca,1)=90 and mr=6 then ac(ca,1)=270:rv=1
3990 if ac(ca,1)=270 and ml=6 then ac(ca,1)=90:rv=1
4000 if rv=1 and rb(ca)>0 then rb(ca)=rb(ca)-1:rr=1
4002 if rr=1 and rb(ca)=0 then 4020
4005 if ac(ca,1)<>90 and ac(ca,1)<>270 then ac(ca,1)=90
4010 return
4020 rem released: line up on the door column, then go up through it
4030 if tx<13 then ac(ca,1)=90:return
4040 if tx>13 then ac(ca,1)=270:return
4050 ac(ca,1)=0:gr(ca)=1
4052 if ca=4 then ce=1
4055 return
4060 rem eyes: return to the pen
4070 if ty=9 and tx=13 then ac(ca,1)=180:return
4080 if ty=10 and tx>=11 and tx<=15 then 4110
4090 if ty=8 and tx=13 then ac(ca,1)=180:return
4100 gx=13:gy=8:goto 3680
4110 rem reform, then bounce one or two times before leaving
4120 ge(ca)=0:gr(ca)=0:ac(ca,1)=90:ac(ca,2)=vg:rb(ca)=2+2*int(rnd(1)*2)
4130 sprsav sp$(5+ca),ca:sprite ca,1,ac(ca,0)
4140 goto 3840
4150 rem frightened: random turn at each tile
4160 k=0
4170 if mu<>6 and od<>0 then k=k+1:cd(k)=0
4180 if ml<>6 and od<>270 then k=k+1:cd(k)=270
4190 if md<>6 and od<>180 then k=k+1:cd(k)=180
4200 if mr<>6 and od<>90 then k=k+1:cd(k)=90
4210 if k=0 then ac(ca,1)=od:return
4220 ac(ca,1)=cd(int(rnd(1)*k)+1):return
4230 rem collision resolve: lethal contacts take priority
4240 dth=0
4250 for t=1 to 4
4260 if (co% and (2^t))=0 then 4300
4270 if abs(rsppos(t,0)-rsppos(0,0))>12 or abs(rsppos(t,1)-rsppos(0,1))>12 then 4300
4280 if ge(t)=1 then 4300
4290 if gb(t)=0 then dth=1
4300 next t
4310 if dth=1 then return
4320 for t=1 to 4
4321 if (co% and (2^t))=0 then 4332
4322 if abs(rsppos(t,0)-rsppos(0,0))>12 or abs(rsppos(t,1)-rsppos(0,1))>12 then 4332
4323 if ge(t)=1 or gb(t)=0 then 4332
4324 gs=gs*2:cs=cs+gs:gosub 120:ge(t)=1:gb(t)=0:sprsav sp$(13),t:sprite t,1,1:ac(t,2)=1.5
4325 nc=nc+1:sound 6,20000,14,0,0,2200,2,2048:if nc>4 then nc=4
4326 sprsav sp$(13+nc),6:movspr 6,ac(0,7),ac(0,8)-20:sprite 6,1,3
4327 pd=0.75:gosub 5750:sprite 6,0
4332 next t
4334 return
4380 rem power pellet: frighten the ghosts
4385 if fr=1 then gt=gt+(ti-fz)
4390 gc=gc+1:ld=ti:fr=1:fz=ti:gs=100:nc=0:sound 1,1,1
4392 if du>0 then sound 5,8000,360,2,2000,1200,2,2048
4395 if du=0 then fr=0
4400 for t=1 to 4
4410 if ge(t)=1 then 4440
4415 if gr(t)=0 then 4430
4420 a=ac(t,1)+180:if a>=360 then a=a-360
4425 ac(t,1)=a
4430 if du=0 then 4440
4435 ac(t,2)=vf:sprite t,1,6:gb(t)=1
4440 next t
4450 return
4460 rem frightened over: colours and speeds back
4470 for t=1 to 4
4480 if gb(t)=1 then ac(t,2)=vg:sprite t,1,ac(t,0):gb(t)=0
4490 next t
4500 sound 5,1,1:at=0
4510 return
4520 fc=6:if (int((ti-fz)*4) and 1)=1 then fc=1
4530 for t=1 to 4:if gb(t)=1 then sprite t,1,fc
4540 next t:return
4550 rem lives row: mini pacmen on the bottom screen line
4560 for t=1 to 5:t@&(t,24)=32:next t:for t=20 to 26:t@&(t,24)=32:next t
4570 if lv>0 then for t=1 to lv:t@&(t,24)=60:c@&(t,24)=7:next t
4572 sl=le-6:if sl<1 then sl=1
4574 x=26
4576 for ll=le to sl step -1:gosub 5800:t@&(x,24)=91+fi:c@&(x,24)=zc(fi):x=x-1:next ll
4580 return
4590 rem game over: record a qualifying score, then start fresh
4600 sound clr:print chr$(147):cursor 15,12:print"{yel}game over"
4605 sleep 3
4610 if cs>0 and (hc<10 or cs>hv(hc)) then gosub 5500
4615 print chr$(147):cs=0:lv=2:le=1:nw=1:xl=0:goto 4650
4620 rem one-time init: mini pacman glyph on char 60
4630 chardef 60,60,126,248,240,240,248,126,60:lv=2:le=1
4640 return
4650 rem attract mode: swap the center panel every 3 seconds
4660 border 0:background 0:print chr$(147):q$=chr$(34)
4661 for t=0 to 7:movspr t,0#0:sprite t,0:next t
4662 cursor 9,1:print"{wht}1up   high score   2up"
4663 cursor 10,2:print"00":cursor 15,2:print right$("0000000000"+mid$(str$(hs),2),10):cursor 29,2:print"00"
4664 aw=0:gosub 4700:bc=0:gosub 4990
4670 if (joy(3) and 128)>0 then 4670
4675 get kk$:if kk$<>"" then 4675
4680 wt=ti:bt=ti
4690 goto 4800
4700 gosub 4982
4720 cursor 10,4:print"character / nickname"
4730 sprsav sp$(6),1:sprsav sp$(7),2:sprsav sp$(8),3:sprsav sp$(9),4
4740 for t=1 to 4:movspr t,0#0:movspr t,86,81+t*24:sprite t,1,ac(t,0):next t
4750 cursor 11,7:print"{red}-shadow    ";q$;"blinky";q$
4760 cursor 11,10:print"{pur}-speedy    ";q$;"pinky";q$
4770 cursor 11,13:print"{cyn}-bashful   ";q$;"inky";q$
4780 cursor 11,16:print"{orng}-pokey     ";q$;"clyde";q$
4782 t@&(10,20)=46:c@&(10,20)=10:cursor 12,20:print"{wht}10 pts"
4784 t@&(10,21)=81:c@&(10,21)=10:cursor 12,21:print"50 pts"
4790 return
4800 get kk$:if kk$<>"" then 4880
4802 if (joy(3) and 128)>0 then 4880
4805 if ti-bt>=0.5 then bc=1-bc:bt=ti:gosub 4990
4810 if ti-wt<3 then 4800
4820 aw=1-aw:wt=ti
4830 if aw=0 then gosub 4700:goto 4800
4840 gosub 4900:goto 4800
4850 if cs>hs then hs=cs:cursor 30,4:print "{lblu}"+right$("000000"+mid$(str$(hs),2),6)
4860 if xl=0 and cs>=10000 then xl=1:lv=lv+1:gosub 4560:sound 6,30000,20,1,15000,1000,2,2048
4870 return
4880 for t=0 to 7:sprite t,0:next t
4890 print chr$(147):gosub 3340:b$="":goto 360
4900 rem high-score attract screen
4910 gosub 4982:for t=0 to 7:movspr t,0#0:sprite t,0:next t
4920 cursor 14,4:print"{yel}high scores"
4930 i=1:ry=6:gosub 4972
4932 i=2:ry=7:gosub 4972
4934 i=3:ry=8:gosub 4972
4936 i=4:ry=9:gosub 4972
4938 i=5:ry=10:gosub 4972
4940 i=6:ry=11:gosub 4972
4942 i=7:ry=12:gosub 4972
4944 i=8:ry=13:gosub 4972
4946 i=9:ry=14:gosub 4972
4948 i=10:ry=15:gosub 4972
4950 if hc=0 then cursor 13,10:print"{wht}no scores yet"
4960 return
4972 if i>hc then return
4974 cursor 2,ry:print"{wht}";right$(" "+mid$(str$(i),2),2);". ";left$(hn$(i),20):cursor 31,ry:print right$("         "+mid$(str$(hv(i)),2),9)
4976 return
4982 rem clear only the center panel, preserving header and fire prompt
4984 for i=4 to 22:cursor 0,i:print"                                        ";:next i
4986 return
4990 cursor 11,23
4992 if bc=0 then print"{red}press fire to play";:return
4994 print"{yel}press fire to play";:return
5000 rem load and sort the scores seq file
5010 hc=0:hs=0:dopen#2,"scores"
5020 if left$(ds$,2)<>"00" then dclose#2:return
5030 r$=""
5040 get#2,z$
5050 if z$="" then 5060
5055 if asc(z$)<>13 and asc(z$)<>10 then r$=r$+z$:goto 5070
5060 if r$<>"" then gosub 5200:r$=""
5070 if st=0 then 5040
5080 dclose#2:if hc>0 then hs=hv(1)
5090 return
5200 rem parse one name,date,score record
5210 p=instr(r$,","):if p=0 then return
5220 n$=left$(r$,p-1):x$=mid$(r$,p+1):p=instr(x$,","):if p=0 then return
5230 sd$=left$(x$,p-1):if left$(sd$,1)=" " then sd$=mid$(sd$,2)
5240 sc=val(mid$(x$,p+1)):if n$="" or sc<0 then return
5245 gosub 5450
5250 rem insert score in descending order, retaining only ten
5260 if hc=10 and sc<=hv(10) then return
5270 if hc<10 then hc=hc+1
5280 i=hc
5290 if i>1 and sc>hv(i-1) then hn$(i)=hn$(i-1):hd$(i)=hd$(i-1):hv(i)=hv(i-1):i=i-1:goto 5290
5300 hn$(i)=n$:hd$(i)=sd$:hv(i)=sc:if hv(1)>hs then hs=hv(1)
5310 return
5350 rem rewrite the sorted top ten as a scores seq file
5360 scratch "scores"
5370 dopen#2,"scores",w
5380 for i=1 to hc
5390 print#2,hn$(i)+", "+hd$(i)+", "+mid$(str$(hv(i)),2)
5400 next i
5410 dclose#2:return
5450 rem uppercase a score name for the uppercase/graphics screen
5460 un$=""
5470 for j=1 to len(n$)
5480 a=asc(mid$(n$,j,1)):if a>=97 and a<=122 then a=a-32
5490 un$=un$+chr$(a):next j
5495 n$=un$:return
5500 rem prompt for and save a qualifying score
5510 print chr$(147):cursor 11,8:print"{yel}new high score!"
5520 cursor 5,11:print"{wht}enter your name? ";
5525 line input n$
5530 nn$="":for i=1 to len(n$):z$=mid$(n$,i,1):if z$="," then z$=" "
5540 nn$=nn$+z$:next i:n$=left$(nn$,20):if n$="" then n$="anonymous"
5545 gosub 5450
5610 sd$=dt$+" "+ti$
5620 sc=cs:gosub 5250:gosub 5350
5630 return
5650 rem show the level item after 70 and 170 pellets
5660 fa=fa+1:ll=le:gosub 5800
5670 sprsav sp$(17+fi),5:movspr 5,0#0:movspr 5,126,177:sprite 5,1,zc(fi)
5680 fu=1:fs=0:fe=ti+9+rnd(1):fv=pv(fi):return
5700 rem expire or collect the visible item
5710 if ti>=fe then fu=0:fs=0:sprite 5,0:return
5715 if fs=1 then return
5720 if abs(ac(0,7)-126)>12 or abs(ac(0,8)-177)>12 then return
5730 fu=0:fs=1:fe=ti+1:sprsav sp$(25+fi),5:sprite 5,1,zc(fi):cs=cs+fv:gosub 120
5740 sound 6,24000,16,1,12000,900,2,2048:return
5750 rem pause gameplay without advancing active clocks
5760 sleep pd
5770 gt=gt+pd:ld=ld+pd:ft=ft+pd:lt=lt+pd
5780 if fr=1 then fz=fz+pd
5790 if fu=1 then fe=fe+pd
5795 return
5800 rem map a level in ll to item number fi
5810 fi=8
5820 if ll<=12 then fi=7
5830 if ll<=10 then fi=6
5840 if ll<=8 then fi=5
5850 if ll<=6 then fi=4
5860 if ll<=4 then fi=3
5870 if ll=2 then fi=2
5880 if ll=1 then fi=1
5890 return
5900 rem level difficulty table
5910 vp=0.9:vg=0.84:vf=0.42:du=6:bw=2.5:p3=30:p4=60:rt=4
5912 if le>=2 then vp=0.95:vg=0.89:vf=0.445:du=5:bw=2.25:p3=0:p4=50
5914 if le>=3 then vp=1:vg=0.94:vf=0.47:du=4:bw=2:p3=0:p4=0
5916 if le>=5 then vp=1:vg=0.95:vf=0.475:du=3:bw=1.5:rt=3
5918 if le>=9 then vp=1.05:vg=0.99:vf=0.495:du=2:bw=1
5920 if le>=13 then vp=1.05:vg=1:vf=0.5:du=1:bw=0.5
5921 if le=17 or le>=19 then du=0:bw=0
5922 r1=1.06:r2=1.12:e1=20:e2=10
5923 if le>=2 then e1=30:e2=15
5924 if le>=3 then e1=40:e2=20
5925 if le>=6 then e1=50:e2=25
5926 if le>=9 then e1=60:e2=30
5927 if le>=12 then e1=80:e2=40
5928 if le>=15 then e1=100:e2=50
5929 if le>=19 then e1=120:e2=60
5930 wa=du-bw:if wa<0 then wa=0
5940 pt(0)=7:pt(1)=20:pt(2)=7:pt(3)=20:pt(4)=5:pt(5)=20:pt(6)=5:pt(7)=9999
5950 if le>=2 then pt(5)=1033:pt(6)=1
5960 if le>=5 then pt(0)=5:pt(2)=5:pt(5)=1037
5970 return
6000 rem item character definitions and sprite shapes
6010 chardef 92,12,18,4,26,60,90,36,0:rem cherry
6020 chardef 93,36,126,60,126,60,24,24,0:rem strawberry
6030 chardef 94,8,4,60,126,126,126,60,0:rem orange
6040 chardef 95,8,4,52,126,126,126,60,0:rem apple
6050 chardef 96,24,60,90,126,90,126,60,24:rem melon
6060 chardef 97,24,90,126,60,126,90,24,0:rem galaxian
6070 chardef 98,24,60,60,126,126,126,24,0:rem bell
6080 chardef 99,60,66,60,24,24,30,24,0:rem key
6100 rem cherry sprite
6101 s$(0)="       ###  ###"
6102 s$(1)="      ##  ###"
6103 s$(2)="     ##  ##"
6104 s$(3)="    ##  ##"
6105 s$(4)="   ### ###"
6106 s$(5)="  ##### #####"
6107 s$(6)=" ###### ######"
6108 s$(7)=" ###### ######"
6109 s$(8)="  ####   ####"
6110 s$(9)=""
6111 sn=18:gosub 3180
6120 rem strawberry sprite
6121 s$(0)="    ##  ##  ##"
6122 s$(1)="     ########"
6123 s$(2)="   ############"
6124 s$(3)="  ##############"
6125 s$(4)="   ############"
6126 s$(5)="    ##########"
6127 s$(6)="     ########"
6128 s$(7)="      ######"
6129 s$(8)="       ####"
6130 s$(9)="        ##"
6131 sn=19:gosub 3180
6140 rem orange sprite
6141 s$(0)="         ####"
6142 s$(1)="       ####"
6143 s$(2)="    ##########"
6144 s$(3)="  ##############"
6145 s$(4)=" ################"
6146 s$(5)=" ################"
6147 s$(6)="  ##############"
6148 s$(7)="   ############"
6149 s$(8)="     ########"
6150 s$(9)=""
6151 sn=20:gosub 3180
6160 rem apple sprite
6161 s$(0)="        ###"
6162 s$(1)="       ##   ###"
6163 s$(2)="   ###### ####"
6164 s$(3)="  ##############"
6165 s$(4)=" ################"
6166 s$(5)=" ################"
6167 s$(6)="  ##############"
6168 s$(7)="   ############"
6169 s$(8)="     ########"
6170 s$(9)=""
6171 sn=21:gosub 3180
6180 rem melon sprite
6181 s$(0)="      ######"
6182 s$(1)="    ##########"
6183 s$(2)="   ### ## ## ###"
6184 s$(3)="  ### ## ## ## ###"
6185 s$(4)="  ## ## ## ## ## ##"
6186 s$(5)="  ### ## ## ## ###"
6187 s$(6)="   ### ## ## ###"
6188 s$(7)="    ##########"
6189 s$(8)="      ######"
6190 s$(9)=""
6191 sn=22:gosub 3180
6200 rem galaxian flagship sprite
6201 s$(0)="        ##"
6202 s$(1)="   ##   ##   ##"
6203 s$(2)="    ## #### ##"
6204 s$(3)="  ##############"
6205 s$(4)=" ################"
6206 s$(5)=" ####  ####  ####"
6207 s$(6)="  ##   ####   ##"
6208 s$(7)="       ####"
6209 s$(8)="        ##"
6210 s$(9)=""
6211 sn=23:gosub 3180
6220 rem bell sprite
6221 s$(0)="       ####"
6222 s$(1)="     ########"
6223 s$(2)="    ##########"
6224 s$(3)="   ############"
6225 s$(4)="   ############"
6226 s$(5)="  ##############"
6227 s$(6)=" ################"
6228 s$(7)="       ####"
6229 s$(8)="      ######"
6230 s$(9)=""
6231 sn=24:gosub 3180
6240 rem key sprite
6241 s$(0)="   ######"
6242 s$(1)="  ##    ##"
6243 s$(2)="  ##    ##"
6244 s$(3)="   ######"
6245 s$(4)="     ##"
6246 s$(5)="     ##########"
6247 s$(6)="     ##  ##  ##"
6248 s$(7)="     ##########"
6249 s$(8)=""
6250 s$(9)=""
6251 sn=25:gosub 3180
6260 rem bonus item point popup sprites
6270 rem 100 point sprite
6271 s$(1)="       #  ### ###"
6272 s$(2)="      ##  # # # #"
6273 s$(3)="       #  # # # #"
6274 s$(4)="       #  # # # #"
6275 s$(5)="       #  # # # #"
6276 s$(6)="       #  # # # #"
6277 s$(7)="      ### ### ###"
6278 s$(0)="":s$(8)="":s$(9)=""
6279 sn=26:gosub 3180
6280 rem 300 point sprite
6281 s$(1)="      ### ### ###"
6282 s$(2)="        # # # # #"
6283 s$(3)="        # # # # #"
6284 s$(4)="      ### # # # #"
6285 s$(5)="        # # # # #"
6286 s$(6)="        # # # # #"
6287 s$(7)="      ### ### ###"
6288 s$(0)="":s$(8)="":s$(9)=""
6289 sn=27:gosub 3180
6290 rem 500 point sprite
6291 s$(1)="      ### ### ###"
6292 s$(2)="      #   # # # #"
6293 s$(3)="      #   # # # #"
6294 s$(4)="      ### # # # #"
6295 s$(5)="        # # # # #"
6296 s$(6)="        # # # # #"
6297 s$(7)="      ### ### ###"
6298 s$(0)="":s$(8)="":s$(9)=""
6299 sn=28:gosub 3180
6300 rem 700 point sprite
6301 s$(1)="      ### ### ###"
6302 s$(2)="        # # # # #"
6303 s$(3)="        # # # # #"
6304 s$(4)="        # # # # #"
6305 s$(5)="        # # # # #"
6306 s$(6)="        # # # # #"
6307 s$(7)="        # ### ###"
6308 s$(0)="":s$(8)="":s$(9)=""
6309 sn=29:gosub 3180
6310 rem 1000 point sprite
6311 s$(1)="     #  ### ### ###"
6312 s$(2)="    ##  # # # # # #"
6313 s$(3)="     #  # # # # # #"
6314 s$(4)="     #  # # # # # #"
6315 s$(5)="     #  # # # # # #"
6316 s$(6)="     #  # # # # # #"
6317 s$(7)="    ### ### ### ###"
6318 s$(0)="":s$(8)="":s$(9)=""
6319 sn=30:gosub 3180
6320 rem 2000 point sprite
6321 s$(1)="    ### ### ### ###"
6322 s$(2)="      # # # # # # #"
6323 s$(3)="      # # # # # # #"
6324 s$(4)="    ### # # # # # #"
6325 s$(5)="    #   # # # # # #"
6326 s$(6)="    #   # # # # # #"
6327 s$(7)="    ### ### ### ###"
6328 s$(0)="":s$(8)="":s$(9)=""
6329 sn=31:gosub 3180
6330 rem 3000 point sprite
6331 s$(1)="    ### ### ### ###"
6332 s$(2)="      # # # # # # #"
6333 s$(3)="      # # # # # # #"
6334 s$(4)="    ### # # # # # #"
6335 s$(5)="      # # # # # # #"
6336 s$(6)="      # # # # # # #"
6337 s$(7)="    ### ### ### ###"
6338 s$(0)="":s$(8)="":s$(9)=""
6339 sn=32:gosub 3180
6340 rem 5000 point sprite
6341 s$(1)="    ### ### ### ###"
6342 s$(2)="    #   # # # # # #"
6343 s$(3)="    #   # # # # # #"
6344 s$(4)="    ### # # # # # #"
6345 s$(5)="      # # # # # # #"
6346 s$(6)="      # # # # # # #"
6347 s$(7)="    ### ### ### ###"
6348 s$(0)="":s$(8)="":s$(9)=""
6349 sn=33:gosub 3180
6350 return
