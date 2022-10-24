1000 REM Snake Game
1010 REM Basic
1020 REM ***************************
2000 REM Array fuer die Snakeelemente
2010 REM die Koordinaten vom Kopf der Snake sind x(sh)/y(sh)
2020 REM die Koordinaten vom Ende der Snake sind x(se)/y(se) 
2025 REM Initialisieren der Arrays
2030 dim x%(1000)
2035 dim y%(1000)
2040 REM Initialisieren von dem Index der Snake
2042 REM die Koordinaten sind links oben
2045 sh%=0
2050 se%=0
2060 REM speichern der Richtung in der Variable d
2070 REM d Initialisieren
2080 d%=1
2090 REM Punkt bzw. Futter der Snake
2095 REM px ist x Wert des Punktes
2098 REM py ist y Wert des Punktes
2099 REM Initalisieren des Punktes
2100 px%=-1
2110 py%=-1
2120 REM Spielstartbildschirm
2121 PRINT CHR$(147)
2122 PRINT "*****snake game*****" 
2123 REM Erklaeuterung der steuerung
2124 PRINT "steuerung der snake"
2125 PRINT "hoch: w"
2126 PRINT "links: a"
2127 PRINT "rechts: s"
2128 PRINT "runter: d" 
2129 PRINT "beenden: q"
2134 GOSUB 10000
2140 REM Snake aufrufen
2150 GOSUB 5000
2160 REM Punkt aufrufen
2170 GOSUB 9000
2180 REM Snake zeichnen
2190 GOSUB 6000
2200 REM warten von einer Sek 
2210 g%=60
3000 REM Spiel
3010 REM warten auf Steuerungseingabe
3020 GOSUB 8000
3030 REM Snake bewegt sich ueber das Spielfeld
3040 GOSUB 7000
3050 GOSUB 3020
3060 END
4000 REM Musik
4010 S= 54272
4020 RESTORE
4030 REM Sound Chip loeschen
4040 FOR L=STOS+24: POKE L,0: NEXT
4050 POKE S+5,9 :POKE+6,127
4060 REM Lautstaerke setzen auf max
4070 POKE s+24,15
4080 READ HF,LF,DR
4090 IF HF<0 THEN RETURN
4100 POKE S+1,HF:POKE S,LF
4110 POKE S+4,17
4120 FOR T=1 TO DR/1.8: NEXT
4130 POKE S+4,4
4140 GOTO 4080
4200 REM Toene
4210 DATA 31,165,512
4220 DATA 42,62,768
4230 DATA 50,60,256
4240 DATA 47,107,512
4250 DATA 42,62,1024
4260 DATA 63,75,512
4270 DATA 56,99,1536
4280 DATA 47,107,1536
4290 DATA 42,62,768
4300 DATA 50,60,256
4310 DATA 47,107,384
4320 DATA 39,223,1024
4330 DATA 44,193,512
4340 DATA 31,165,1536
4350 DATA -1,-1,-1
5000 REM Snake initialisieren
5010 x%(0)=20
5020 y%(0)=10
5030 d%=1
5040 sh%=0
5050 se%=0
5060 RETURN
6000 REM Snake zeichnen
6010 REM pruefen ob Snakeende = Snakehead ist
6020 IF sh%=se% THEN 6060
6030 REM Snakeende loeschen
6040 POKE 1024+y%(se%)*40+x%(se%),32
6050 REM Snakehead malen
6060 POKE 1024+y%(sh%)*04+x%(sh%), 128+32
6070 RETURN
7000 REM Snake bewegen ueber das Spielfeld
7010 REM Snakehead erhoehen
7020 REM sz% speichert das erste Element der Snake
7030 sz%=sh%
7040 REM erhoeht den Wert von sh%
7050 sh%=sh%+1
7060 REM prueft ob sh groesser 1000 und wenn ja setz es sh auf 0
7070 IF sh%>=1000 THEN sh%=0
7080 REM Koordinaten fuer die Richtung d ermitteln
7085 REM 0 heisst Snake Richtung hoch
7090 IF d% = 0 THEN y%(sh%)=y%(sz%)-1 : x%(sh%)=x%(sz%)
7095 REM 1 heisst Snake Richtung links
7100 IF d% = 1 THEN x%(sh%)=x%(sz%)-1 : y%(sh%)=y%(sz%)
7105 REM 2 heisst Snake Richtung rechts
7110 IF d% = 2 THEN x%(sh%)=x%(sz%)+1 : y%(sh%)=y%(sz%)
7115 REM 3 heisst Snake Richtung unten
7120 IF d% = 3 THEN y%(sh%)=y%(sz%)+1 : x%(sh%)=x%(sz%)
7200 REM Kollissionen pruefen
7210 REM pruefen mit dem Rand
7220 IF y%(sh%)>= 0 AND y%(sh%)<= 24 AND x%(sh%)>=0 AND x%(sh%)<=39 THEN 7260
7230 PRINT "game over, kollision mit wand"
7240 END
7250 REM  pruefen, ob selbst gefressen
7260 IF PEEK(1024+x%(sh%)+y%(sh%)*40)<> 128+32 THEN 7290
7270 PRINT "game over, selbst gefressen"
7280 END
7290 REM pruefe, ob mit Punkt kollidiert ist
7300 IF  x%(sh%) <> px% OR y%(sh%)<> py% THEN 7410
7310 REM Kopf Snake wenn Punkt gefressen
7320 POKE 1024+y%(sh%)*40+x%(sh%),128+32
7330 REM Musik
7340 GOSUB 4000
7350 REM Neuer Punkt bzw Futter
7360 GOSUB 9000
7370 REM Snake schneller werden
7380 g% = g%/2
7390 IF g% < 2 THEN t%=1
7400 RETURN
7410 REM Nicht gefressen
7420 REM Snake zeichnen
7430 GOSUB 6000
7440 REM Index Ende erhoehen
7450 se% = se%+1
7460 if se% >= 1000 THEN se%=0
7470 RETURN
8000 REM Warte t und pruefe Tasteneingae
8010 IF g%<= 1 THEN 8040
8020 t% = time
8030 IF (time -t%) >= g% THEN 8110
8040 GET e$
8050 IF e$ = "w" THEN d% =0
8060 IF e$ = "a" THEN d% =1
8070 IF e$ = "s" THEN d% =2
8080 IF e$ = "d" THEN d% =3
8090 IF e$ = "q" THEN END
8100 GOTO 8030
8110 RETURN
9000 REM Punkt/Futter generieren
9010 i%=RND(0)
9020 px% = int(rnd(1)*39)
9030 py% = int(rnd(1)*24)
9040 k% =1024+py%*40+px%
9050 REM schau ob Kooordinaten auf Snake sind
9060 sz% =sh%
9070 IF sh% < se% THEN sz% =999
9080 FOR i=se% TO sz%
9090 IF x%(i) = px% AND y%(i) =py% THEN 9020
9100 NEXT
9110 IF sh% > se% THEN 9160
9120 FOR i=0 TO sz%
9130 IF x%(i) = px% AND y%(i) =py% THEN 9020
9140 NEXT
9150 POKE k%, 42
9160 RETURN
10000 REM mehrere Farben anmachen
10010 POKE 53276,255
10020 POKE 53285,85
10030 POKE 53286,86
10040 POKE 53287,98
10050 REM x vergroessern
10060 POKE 53277,1
10070 REM y vergroessern
10080 POKE 53271,1
10090 REM Musik
10100 GOSUB 4000
10110 REM Sprite
10120 GOSUB 10300
10130 FOR i=0 TO 9: PRINT : NEXT
10140 PRINT "irgendeine taste druecken"
10150 PRINT "*************************"
10160 PRINT " melodie: harry potter"
10170 PRINT "*************************"
10180 PRINT "von hme"
10200 REM Warten auf Tastendruck
10210 GET v$
10220 if v$ ="" THEN 
10230 PRINT CHR$(147)
10240 REM Sprite weg
10250 POKE 53248,255
10260 POKE 53249,255
10270 RETURN
10300 REM Sprite nach Melodie
10310 s = 832
10320 FOR x=0 TO 40: READ y : POKE s+x,y: NEXT x
10330 POKE 2040,13
10340 POKE 53269,1
10350 POKE 53248,240
10360 POKE 53249,80
10370 RETURN
10400 REM Sprite Data
10410 DATA 0,0,0
10420 DATA 4,0,0
10430 DATA 20,0,0
10435 DATA 20,0,0
10440 DATA 164,0,0
10445 DATA 164,0,0
10450 DATA 20,0,0
10455 DATA 20,0,0
10458 DATA 20,0,0
10459 DATA 20,0,0
10460 DATA 5,0,16
10470 DATA 5,0,85
10480 DATA 5,64,85
10490 DATA 5,65,85
10500 DATA 5,85,81
10510 DATA 1,85,65
10520 DATA 1,85,64
10530 DATA 0,85,0
