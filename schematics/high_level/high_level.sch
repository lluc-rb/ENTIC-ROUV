EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 3
Title "General view"
Date "2020-12-29"
Rev "1"
Comp "RBSM"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Motor:Motor_DC M1
U 1 1 5FEBA328
P 3500 2200
F 0 "M1" H 3658 2150 50  0000 L CNN
F 1 "Motor_DC" H 3658 2105 50  0001 L CNN
F 2 "" H 3500 2110 50  0001 C CNN
F 3 "~" H 3500 2110 50  0001 C CNN
	1    3500 2200
	-1   0    0    -1  
$EndComp
$Comp
L Motor:Motor_DC M2
U 1 1 5FEBA614
P 3500 3000
F 0 "M2" H 3658 2950 50  0000 L CNN
F 1 "Motor_DC" H 3658 2905 50  0001 L CNN
F 2 "" H 3500 2910 50  0001 C CNN
F 3 "~" H 3500 2910 50  0001 C CNN
	1    3500 3000
	-1   0    0    -1  
$EndComp
$Comp
L Motor:Motor_DC M3
U 1 1 5FEBAE2E
P 3500 3800
F 0 "M3" H 3658 3750 50  0000 L CNN
F 1 "Motor_DC" H 3658 3705 50  0001 L CNN
F 2 "" H 3500 3710 50  0001 C CNN
F 3 "~" H 3500 3710 50  0001 C CNN
	1    3500 3800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	3500 2000 4000 2000
Wire Wire Line
	3500 2500 4000 2500
Wire Wire Line
	3500 2800 4000 2800
Wire Wire Line
	3500 3300 4000 3300
Wire Wire Line
	3500 3600 4000 3600
Wire Wire Line
	3500 4100 4000 4100
Entry Wire Line
	4000 2000 4100 2100
Entry Wire Line
	4000 2500 4100 2600
Entry Wire Line
	4000 2800 4100 2900
Entry Wire Line
	4000 3300 4100 3400
Entry Wire Line
	4000 3600 4100 3700
Entry Wire Line
	4000 4100 4100 4200
$Sheet
S 2650 4850 850  500 
U 5FEB700A
F0 "Data circuit" 50
F1 "data-circuit.sch" 50
F2 "TxD" O R 3500 5050 50 
F3 "RxD" I R 3500 5150 50 
F4 "GND" I R 3500 5250 50 
F5 "Vin" I R 3500 4950 50 
$EndSheet
Wire Wire Line
	3500 4950 4000 4950
Wire Wire Line
	4000 5050 3500 5050
Wire Wire Line
	3500 5150 4000 5150
Wire Wire Line
	4000 5250 3500 5250
Entry Wire Line
	4100 5150 4000 5250
Entry Wire Line
	4100 5050 4000 5150
Entry Wire Line
	4100 4950 4000 5050
Entry Wire Line
	4100 4850 4000 4950
Text Label 4000 2000 2    50   ~ 0
M1p
Text Label 4000 2500 2    50   ~ 0
M1n
Text Label 4000 2800 2    50   ~ 0
M2p
Text Label 4000 3300 2    50   ~ 0
M2n
Text Label 4000 3600 2    50   ~ 0
M3p
Text Label 4000 4100 2    50   ~ 0
M3n
Text Label 4000 4950 2    50   ~ 0
Vin
Text Label 4000 5050 2    50   ~ 0
TxD
Text Label 4000 5150 2    50   ~ 0
RxD
Text Label 4000 5250 2    50   ~ 0
GND
$Sheet
S 7900 3000 1100 1200
U 5FED8D3C
F0 "Controller" 50
F1 "controller.sch" 50
F2 "M1p" O L 7900 3100 50 
F3 "M1n" O L 7900 3200 50 
F4 "M2p" O L 7900 3300 50 
F5 "M3p" O L 7900 3500 50 
F6 "M3n" O L 7900 3600 50 
F7 "M2n" O L 7900 3400 50 
F8 "RxD" I L 7900 4000 50 
F9 "TxD" O L 7900 3900 50 
F10 "Vout" O L 7900 3800 50 
F11 "GND" O L 7900 4100 50 
$EndSheet
Wire Wire Line
	7500 3100 7900 3100
Wire Wire Line
	7500 3200 7900 3200
Wire Wire Line
	7500 3300 7900 3300
Wire Wire Line
	7500 3400 7900 3400
Wire Wire Line
	7500 3500 7900 3500
Wire Wire Line
	7500 3600 7900 3600
Entry Wire Line
	7400 4200 7500 4100
Entry Wire Line
	7400 4100 7500 4000
Entry Wire Line
	7400 4000 7500 3900
Entry Wire Line
	7400 3600 7500 3500
Entry Wire Line
	7400 3700 7500 3600
Wire Wire Line
	7500 3800 7900 3800
Wire Wire Line
	7500 3900 7900 3900
Wire Wire Line
	7500 4000 7900 4000
Wire Wire Line
	7500 4100 7900 4100
Entry Wire Line
	7400 3500 7500 3400
Entry Wire Line
	7400 3400 7500 3300
Entry Wire Line
	7400 3300 7500 3200
Entry Wire Line
	7400 3200 7500 3100
Wire Notes Line
	2500 5500 2500 1850
Wire Notes Line
	2500 1850 4300 1850
Wire Notes Line
	2500 5500 4300 5500
Wire Notes Line
	4300 1850 4300 5500
Entry Wire Line
	7400 3900 7500 3800
Wire Notes Line
	7250 4600 9150 4600
Wire Notes Line
	7250 2850 9150 2850
Text Notes 2500 1850 0    50   ~ 0
ROUV
Text Notes 7250 2850 0    50   ~ 0
Controller
Wire Bus Line
	4100 4500 7400 4500
Connection ~ 4100 4500
Wire Notes Line
	7250 2850 7250 4600
Wire Notes Line
	9150 2850 9150 4600
Wire Notes Line
	4500 4400 4500 4600
Wire Notes Line
	7050 4400 7050 4600
Wire Notes Line
	4500 4600 7050 4600
Wire Notes Line
	4500 4400 7050 4400
Text Notes 4500 4400 0    50   ~ 0
Link Cable
Text Label 7500 3100 0    50   ~ 0
M1p
Text Label 7500 3200 0    50   ~ 0
M1n
Text Label 7500 3300 0    50   ~ 0
M2p
Text Label 7500 3400 0    50   ~ 0
M2n
Text Label 7500 3500 0    50   ~ 0
M3p
Text Label 7500 3600 0    50   ~ 0
M3n
Text Label 7500 3800 0    50   ~ 0
Vin
Text Label 7500 3900 0    50   ~ 0
TxD
Text Label 7500 4000 0    50   ~ 0
RxD
Text Label 7500 4100 0    50   ~ 0
GND
Wire Bus Line
	4100 4500 4100 5150
Wire Bus Line
	4100 2100 4100 4500
Wire Bus Line
	7400 3200 7400 4500
$EndSCHEMATC
