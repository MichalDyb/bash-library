#!/bin/sh
#Tworzy foldery do obsługi biblioteki w przypadku ich braku
test -d mylibrary 
if [ $? -eq 1 ]
then 
	mkdir mylibrary
	mkdir mylibrary/users mylibrary/books mylibrary/userbooks
	
fi
chmod 777 mylibrary


#Sekcja danych, wykorzystywanych w programie
autor='**************************\n*^^^^^^^^^^^^^^^^^^^^^^^^*\n*< Michał Dybaś\t\t>*\n*< Informatyka I\t>*\n*< Grupa: L1\t\t>*\n*------------------------*\n**************************'
menu_glowne=' _________________________________________________________\n| Menu programu:\t\t\t\t\t|\n| 1.Dodaj nowego użytkownika.\t\t\t\t|\n| 2.Dodaj nową książke.\t\t\t\t\t|\n| 3.Usuń użytkownika.\t\t\t\t\t|\n| 4.Usuń książke.\t\t\t\t\t|\n| 5.Wyświetl informacje o użytkowniku.\t\t\t|\n| 6.Wyświetl informacje o książce.\t\t\t|\n| 7.Aktualizuj dane użytkownika.\t\t\t|\n| 8.Aktualizuj dane książki.\t\t\t\t|\n| 9.Wypożycz książke z biblioteki.\t\t\t|\n| 10.Oddaj książke do biblioteki.\t\t\t|\n| 11.Wypisz liste użytkowników.\t\t\t\t|\n| 12.Wypisz liste książek.\t\t\t\t|\n| 13.Wypisz informację o autorze skryptu.\t\t|\n| 0.Zakończ program.\t\t\t\t\t|\n|_______________________________________________________|\n'
menu_uzytkownik_aktualizacja='_________________________________________________________\n| Aktualizowana informacja:\t\t\t\t|\n| 1.Imię.\t\t\t\t\t\t|\n| 2.Nazwisko.\t\t\t\t\t\t|\n| 3.Płeć.\t\t\t\t\t\t|\n| 4.Data urodzenia.\t\t\t\t\t|\n| 5.Miasto.\t\t\t\t\t\t|\n| 6.Adres.\t\t\t\t\t\t|\n| 0.Powrót do menu głównego\t\t\t\t|\n|_______________________________________________________|\n'
menu_uzytkownik_lista='_________________________________________________________\n| Sortuj według:\t\t\t\t\t|\n| 1.Nazwy użytkownika.\t\t\t\t\t|\n| 2.Imienia.\t\t\t\t\t\t|\n| 3.Nazwiska.\t\t\t\t\t\t|\n| 4.Płci.\t\t\t\t\t\t|\n| 5.Daty urodzenia.\t\t\t\t\t|\n| 6.Miasta.\t\t\t\t\t\t|\n| 7.Adresu.\t\t\t\t\t\t|\n| 0.Powrót do menu głównego\t\t\t\t|\n|_______________________________________________________|\n'
menu_ksiazka_aktualizacja='_________________________________________________________\n| Aktualizowana informacja:\t\t\t\t|\n| 1.Tytuł.\t\t\t\t\t\t|\n| 2.Imię autora.\t\t\t\t\t|\n| 3.Nazwisko autora.\t\t\t\t\t|\n| 4.Data wydania.\t\t\t\t\t|\n| 5.Wydawnictwo.\t\t\t\t\t|\n| 6.Liczba stron.\t\t\t\t\t|\n| 0.Powrót do menu głównego\t\t\t\t|\n|_______________________________________________________|\n'
menu_ksiazka_lista='_________________________________________________________\n| Sortuj według:\t\t\t\t\t|\n| 1.Tytułu.\t\t\t\t\t\t|\n| 2.Imienia autora.\t\t\t\t\t|\n| 3.Nazwiska autora.\t\t\t\t\t|\n| 4.Daty wydania.\t\t\t\t\t|\n| 5.Wydawnictwa.\t\t\t\t\t|\n| 6.Liczby stron.\t\t\t\t\t|\n| 0.Powrót do menu głównego\t\t\t\t|\n|_______________________________________________________|\n'
sortowanie='_________________________________________________________\n| Sortuj:\t\t\t\t\t\t|\n| 1.Rosnąca.\t\t\t\t\t\t|\n| 2.Malejąco.\t\t\t\t\t\t|\n|_______________________________________________________|\n'
wybierz='$Wybierz opcję (potwierdź klawiszem Enter): '
uzytkownik='$Wpisz nazwę użytkownika (potwierdź klawiszem Enter): '
ksiazka='$Wpisz tytuł książki (potwierdź klawiszem Enter): '


#Sekcja funkcji, wykorzystywanych w programie
get_user()	#funkcja pobiera nazwę użytkownika
{
	while [ 1 ]	
	do
		read -p "$uzytkownik" user 
		if [ "$user" ]
		then
			break
		else
			echo 'To pole nie może być puste. Wpisz nazwę nowego użytkownika!'
		fi
	done
}
check_user()	#funkcja sprawdza, czy użytkownik o takiej nazwie istnieje
{
	if [ -e mylibrary/users/"$user.txt" ]	
	then
		return 1
	else
		return 2
	fi
}
get_name()	#funkcja pobiera imię użytkownika
{
	while [ 1 ]	
	do
		read -p "Podaj imię: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj imię użytkownika!'
		fi
	done
}
get_surname()	#funkcja pobiera nazwisko użytkownika
{
	while [ 1 ]	
	do
		read -p "Podaj nazwisko: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj nazwisko użytkownika!'
		fi
	done
}
get_gender()	#funkcja pobiera płeć użytkownika
{
	while [ 1 ]	
	do	
		read -p "Podaj płeć: " pomoc
		if [ "$pomoc" ]
		then
			if [ "$pomoc" = "mężczyzna" -o "$pomoc" = "kobieta" ]
			then
				break
			else 
				echo 'Nie ma takiej płci. Wpisz "mężczyzna" lub "kobieta!'
				continue
			fi
		else
			echo 'Nie ma takiej płci. Wpisz "mężczyzna" lub "kobieta!'
		fi	
	done
}
get_town()	#funkcja pobiera miasto
{
	while [ 1 ]	
	do
		read -p "Podaj miasto: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj miejsce zamieszkania użytkownika!'
		fi
	done
}
get_address()	#funkcja pobiera adres
{
	while [ 1 ]	
	do	
		read -p "Podaj adres: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj adres zamieszkania użytkownika!'
		fi
	done
}
get_book()	#funkcja pobiera tytuł książki
{
	while [ 1 ]	
	do
		read -p "$ksiazka" tytul
		if [ "$tytul" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj tytuł książki!'
		fi
	done
}
check_book() #funkcja sprawdza, czy książka o takim tytule istnieje
{
	if [ -e mylibrary/books/"$tytul.txt" ]	
	then
		return 1
	else
		return 2
	fi
}
get_author_name()	#funkcja pobiera imię autora książki
{
	while [ 1 ]	
	do
		read -p "Podaj imię autora: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj imię autora książki!'
		fi
	done
}
get_author_surname()	#funkcja pobiera nazwisko autora książki
{
	while [ 1 ]	
	do
		read -p "Podaj nazwisko autora: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj nazwisko autora książki!'
		fi
	done
}
get_publishing_house()	#funkcja pobiera nazwe wydawnictwa książki
{
	while [ 1 ]	
	do
		read -p "Podaj wydawnictwo: " pomoc
		if [ "$pomoc" ]
		then
			break
		else
			echo 'To pole nie może być puste. Podaj nazwe wydawnictwa książki!'
		fi
	done
}
get_book_pages()	#funkcja pobiera liczbę stron książki
{
	while [ 1 ]	
	do	
		read -p "Podaj liczbę stron: " pomoc
		test $pomoc -eq $pomoc 2> /dev/null
		if [ $pomoc ]
		then
			if [ $? ]
			then
				if [ $pomoc -gt 0 ] 2> /dev/null
				then
					break
				else
					echo 'Liczba stron musi być większa od 0. Podaj liczbę stron!'
				fi
			else
				echo 'To nie jest liczba. Podaj liczbę stron!'
			fi
		else
			echo 'To pole nie może być puste. Podaj liczbę stron!'
		fi
	done
}
get_day()	#funkcja pobiera dzień miesiąca
{
	while [ 1 ]	
	do
		read -p "Podaj dzień (liczba): " pomoc
		test $pomoc -eq $pomoc 2> /dev/null
		if [ $pomoc ]
		then
			if [ $? ]
			then
				if [ $pomoc -ge 1 -a $pomoc -le 31 ] 2> /dev/null
				then
					break
				else
					echo 'Nie ma takiego dnia miesiąca. Podaj liczbę z przedziału 1-31!'
				fi
			else
				echo 'To nie jest liczba. Podaj dzień miesiąca!'
			fi
		else
			echo 'To pole nie może być puste. Podaj dzień miesiąca!'
		fi
	done
}
get_month()	#funkcja pobiera miesiąc
{
	while [ 1 ]	 
	do	
		read -p "Podaj miesiąc (liczba): " pomoc
		test $pomoc -eq $pomoc 2> /dev/null
		if [ $pomoc ]
		then
			if [ $? ]
			then
				if [ $pomoc -ge 1 -a $pomoc -le 12 ] 2> /dev/null
				then
					break
				else
					echo 'Nie ma takiego miesiąca. Podaj liczbę z przedziału 1-12!'
				fi
			else
				echo 'To nie jest liczba. Podaj miesiąc!'
			fi
		else
			echo 'To pole nie może być puste. Podaj miesiąc!'
		fi
	done
}
get_year()	#funkcja pobiera rok
{
	while [ 1 ]	
	do		
		read -p "Podaj rok (liczba): " pomoc
		test $pomoc -eq $pomoc 2> /dev/null
		if [ $pomoc ]
		then
			if [ $? ]
			then
				if [ $pomoc -gt 999 -a $pomoc -lt 10000 ] 2> /dev/null
				then
					break
				else
					echo 'Rok musi być liczbą z przedziału 1000-9999. Podaj rok!'
				fi
			else
				echo 'To nie jest liczba. Podaj rok!'
			fi
		else
			echo 'To pole nie może być puste. Podaj rok!'
		fi
	done
}
data_user()	#funkcja pobiera dane użytkownika 
{
	pomoc0=`tail +1 mylibrary/users/"$user.txt" | head -n1`		
	pomoc1=`tail +2 mylibrary/users/"$user.txt" | head -n1`
	pomoc2=`tail +3 mylibrary/users/"$user.txt" | head -n1`
	pomoc3=`tail +4 mylibrary/users/"$user.txt" | head -n1`
	pomoc4=`tail +5 mylibrary/users/"$user.txt" | head -n1`
	pomoc5=`tail +6 mylibrary/users/"$user.txt" | head -n1`
	pomoc6=`tail +7 mylibrary/users/"$user.txt" | head -n1`
	pomoc7=`tail +8 mylibrary/users/"$user.txt" | head -n1`
	pomoc8=`tail +9 mylibrary/users/"$user.txt" | head -n1`
}
update_user()	#funkcja aktualizuje dane użytkownika
{
	echo "$pomoc0" > mylibrary/users/"$user.txt"	
	echo "$pomoc1" >> mylibrary/users/"$user.txt"	
	echo "$pomoc2" >> mylibrary/users/"$user.txt"
	echo "$pomoc3" >> mylibrary/users/"$user.txt"
	echo "$pomoc4" >> mylibrary/users/"$user.txt"
	echo "$pomoc5" >> mylibrary/users/"$user.txt"
	echo "$pomoc6" >> mylibrary/users/"$user.txt"
	echo "$pomoc7" >> mylibrary/users/"$user.txt"
	echo "$pomoc8" >> mylibrary/users/"$user.txt"
	sync	#synchronizuje dane na dysku z pamięcią
}
book_user()	#funkcja pobiera dane książki	
{
	pomoc0=`tail +1 mylibrary/books/"$tytul.txt" | head -n1`		
	pomoc1=`tail +2 mylibrary/books/"$tytul.txt" | head -n1`
	pomoc2=`tail +3 mylibrary/books/"$tytul.txt" | head -n1`
	pomoc3=`tail +4 mylibrary/books/"$tytul.txt" | head -n1`
	pomoc4=`tail +5 mylibrary/books/"$tytul.txt" | head -n1`
	pomoc5=`tail +6 mylibrary/books/"$tytul.txt" | head -n1`
	pomoc6=`tail +7 mylibrary/books/"$tytul.txt" | head -n1`
	pomoc7=`tail +8 mylibrary/books/"$tytul.txt" | head -n1`
}
update_book()	#funkcja aktualizuje dane książki
{
	echo "$pomoc0" > mylibrary/books/"$tytul.txt"
	echo "$pomoc1" >> mylibrary/books/"$tytul.txt"
	echo "$pomoc2" >> mylibrary/books/"$tytul.txt"
	echo "$pomoc3" >> mylibrary/books/"$tytul.txt"
	echo "$pomoc4" >> mylibrary/books/"$tytul.txt"
	echo "$pomoc5" >> mylibrary/books/"$tytul.txt"
	echo "$pomoc6" >> mylibrary/books/"$tytul.txt"
	echo "$pomoc7" >> mylibrary/books/"$tytul.txt"
	sync	#synchronizuje dane na dysku z pamięcią
}

#Główny kod programu
clear
echo $menu_glowne
read -p "$wybierz" program
sync	#synchronizuje dane na dysku z pamięcią

while [ 1 ]
do
case "$program" in
"1")	#dodaje użytkownika
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Dodaj nowego użytkownika!**'

	get_user	#funkcja pobiera nazwę użytkownika	
	check_user	#funkcja sprawdza, czy użytkownik o takiej nazwie istnieje	

	if [ $? -eq 2 ]	#tworzy pliki nowego uzytkownika jeśli, nazwa nie jest zajęta 
	then
		touch mylibrary/users/"$user.txt"
		touch mylibrary/userbooks/"$user.txt"
		chmod 777 mylibrary/users/"$user.txt"
		chmod 777 mylibrary/userbooks/"$user.txt"
		echo "$user" >> mylibrary/users/"$user.txt"
		sync	#synchronizuje dane na dysku z pamięcią

		get_name	#funkcja pobiera imię użytkownika
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje imię użytkownika do pliku użytkownika
		get_surname	#funkcja pobiera nazwisko użytkownika
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje nazwisko użytkownika do pliku użytkownika
		get_gender	#funkcja pobiera płeć użytkownika
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje płeć użytkownika do pliku użytkownika

		echo ""
		echo "Podaj datę urodzenia!"
		get_day		#funkcja pobiera dzień miesiąca
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje dzień urodzenia do pliku użytkownika
		get_month	#funkcja pobiera miesiąc		
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje miesiąc urodzenia do pliku użytkownika
		get_year	#funkcja pobiera rok
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje rok urodzenia do pliku użytkownika

		echo ""
		get_town	#funkcja pobiera miasto
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje miasto do pliku użytkownika
		get_address	#funkcja pobiera adres
		echo "$pomoc" >> mylibrary/users/"$user.txt"	#dopisuje adres do pliku użytkownika

		sync	#synchronizuje dane na dysku z pamięcią
		echo "Użytkownik o nazwie $user został utworzony."
	else
		echo 'Ta nazwa użytkownika jest już zajęta. Spróbuj użyć innej nazwy!'	
	fi
	echo " "
	read -p "$wybierz" program ;;
"2")	#dodaje książke
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Dodaj nową książke!**'
	
	get_book	#funkcja pobiera tytuł książki
	check_book	#funkcja sprawdza, czy książka o takim tytule istnieje

	if [ $? -eq 2 ]	#tworzy plik ksiązki, jeśli tytuł nie jest zajęty 
	then
		touch mylibrary/books/"$tytul.txt"
		chmod 777 mylibrary/books/"$tytul.txt"
		echo "$tytul" > mylibrary/books/"$tytul.txt"
		sync	#synchronizuje dane na dysku z pamięcią

		get_author_name	#funkcja pobiera imię autora książki
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje imię autora do pliku książki
		get_author_surname	#funkcja pobiera nazwisko autora książki
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje nazwisko autora do pliku książki

		echo ""
		echo "Podaj datę wydania!"
		get_day		#funkcja pobiera dzień miesiąca
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje dzień	wydania do pliku książki
		get_month	#funkcja pobiera miesiąc
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje miesiąc wydania do pliku książki
		get_year	#funkcja pobiera rok
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje rok wydania do pliku książki

		echo ""
		get_publishing_house	#funkcja pobiera nazwe wydawnictwa książki
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje nazwe wydawnictwa do pliku książki
		get_book_pages	#funkcja pobiera liczbę stron książki
		echo "$pomoc" >> mylibrary/books/"$tytul.txt"	#dopisuje liczbe stron książki do pliku książki
	
		sync	#synchronizuje dane na dysku z pamięcią
		echo "Książka o tytule $tytul została utworzona."
	else
		echo 'Ten tytuł książki jest już zajęty. Spróbuj użyć innej nazwy!'	
	fi
	echo " "
	read -p "$wybierz" program ;;
"3")	#usuwa użytkownika
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Usuń użytkownika!**'

	get_user	#funkcja pobiera nazwę użytkownika	
	check_user	#funkcja sprawdza, czy użytkownik o takiej nazwie istnieje		

	if [ $? -eq 1 ]	#usuwa pliki użytkownika, jeśli taki użytkownik istnieje
	then
		rm mylibrary/users/"$user.txt"
		rm mylibrary/userbooks/"$user.txt"
		echo "Użytkownik o nazwie $user został usunięty."
		sync	#synchronizuje dane na dysku z pamięcią
	else
		echo 'Nie można usunąć użytkownika. Nie ma użytkownika o takiej nazwie!'	
	fi
	echo ""
	read -p "$wybierz" program ;;
"4")	#usuwa książkę
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Usuń książke!**'
	
	get_book	#funkcja pobiera tytuł książki
	check_book	#funkcja sprawdza, czy książka o takim tytule istnieje	
	
	if [ $? -eq 1 ]	#usuwa plik książki, jeśli taka książka istnieje
	then
		rm mylibrary/books/"$tytul.txt"
		
		for file in `ls mylibrary/userbooks`	#usuwa książke z wypożyczonych książek
		do
		sed -i "/$tytul/d" mylibrary/userbooks/"$file" 2> /dev/null
		done

		sync	#synchronizuje dane na dysku z pamięcią
		echo "Książka o tytule $tytul została usunięta."
	else
		echo 'Nie można usunąć książki. Nie ma książki o takim tytule!'	
	fi
	echo " "
	read -p "$wybierz" program ;;
"5")	#wyświetla informację o użytkowniku
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Wyświetl informacje o użytkowniku!**'

	get_user	#funkcja pobiera nazwę użytkownika	
	check_user	#sprawdza, czy użytkownik o takiej nazwie istnieje		
	
	if [ $? -eq 1 ]	#wyświetla informację o użytkowniku, jeśli użytkownik istnieje
	then
		pomoc=`cat mylibrary/userbooks/"$user.txt"`
		data_user	#funkcja pobiera dane użytkownika 
		echo "Nazwa użytkownika: $pomoc0\nImię: $pomoc1\nNazwisko: $pomoc2\nPleć: $pomoc3\nData urodzenia: $pomoc4-$pomoc5-$pomoc6\nMiasto: $pomoc7\nAdres: $pomoc8"

		echo ""
		echo 'Wypożyczone książki:'	#wyświetla informację o książkach wypożyczonych przez użytkownika	
		if [ "$pomoc" ]
		then
			echo ""
			echo "$pomoc"
		else
			echo 'Aktualnie brak wyporzyczonych książek!'
		fi
	else
		echo 'Nie można wyświetlić informacji. Nie ma użytkownika o takiej nazwie!'
	fi

	read -p "$wybierz" program ;;
"6")	#wyświetla informację o książce
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Wyświetl informacje o książce!**'
	
	get_book	#funkcja pobiera tytuł książki
	check_book	#funkcja sprawdza, czy książka o takim tytule istnieje
	
	if [ $? -eq 1 ]	#wyświetla informacje o książce, jeśli książka istnieje
	then
		book_user	#funkcja pobiera dane książki	
		echo "Tytuł książki: $pomoc0\nImię autora: $pomoc1\nNazwisko autora: $pomoc2\nData wydania książki: $pomoc3-$pomoc4-$pomoc5\nWydawnictwo: $pomoc6\nLiczba stron: $pomoc7"
	else
		echo 'Nie można wyświetlić informacji. Nie ma książki o takim tytule!'	
	fi
	read -p "$wybierz" program ;;
"7")	#aktualizacja danych użytkownika
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Aktualizuj dane użytkownika!**'

	get_user	#funkcja pobiera nazwę użytkownika	
	check_user	#sprawdza, czy użytkownik o takiej nazwie istnieje		
	
	if [ $? -eq 1 ]	#umożliwia aktualizacje danych użytkownika, jeśli taki użytkownik isnieje
	then
		clear
		echo "$menu_uzytkownik_aktualizacja"
		read -p "$wybierz" aktualizacja
		while [ 1 ]
		do
		data_user	#funkcja pobiera dane użytkownika 

		case "$aktualizacja" in		#menu aktualizacji danych użytkownika
		"1")	#aktualizuje imię użytkownika 
			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo '**Aktualizuj imię użytkownika!**'
					
			get_name	#funkcja pobiera imię użytkownika
			pomoc1="$pomoc"
			update_user	#funkcja aktualizuje dane użytkownika

			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Imię użytkownika zostało zaktualizowane.'
			read -p "$wybierz" aktualizacja ;;
		"2")	#aktualizuję nazwisko użytkownika
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo '**Aktualizuj nazwisko użytkownika!**'

			get_surname	#funkcja pobiera nazwisko użytkownika
			pomoc2="$pomoc"
			update_user	#funkcja aktualizuje dane użytkownika

			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Nazwisko użytkownika zostało zaktualizowane.'
			read -p "$wybierz" aktualizacja ;;
		"3")	#aktualizuje płeć użytkownika
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo '**Aktualizuj płeć użytkownika!**'

			get_gender	#funkcja pobiera płeć użytkownika
			pomoc3="$pomoc"
			update_user	#funkcja aktualizuje dane użytkownika

			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Płeć użytkownika została zaktualizowana.'
			read -p "$wybierz" aktualizacja ;;
		"4") 	#aktualizuje datę urodzenia użytkownika
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo '**Aktualizuj date urodzenia użytkownika!**'

			echo "Podaj datę urodzenia!"
			get_day		#funkcja pobiera dzień miesiąca
			pomoc4="$pomoc"	#przechowuje dzień 
			get_month	#funkcja pobiera miesiąc
			pomoc5="$pomoc"	#przechowuje miesiąc
			get_year	#funkcja pobiera rok
			pomoc6="$pomoc"	#przechowuje rok
			update_user	#funkcja aktualizuje dane użytkownika

			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Data urodzenia użytkownika została zaktualizowana.'
			read -p "$wybierz" aktualizacja ;;
		"5") 	#aktualizuje miasto użytkownika
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo '**Aktualizuj miasto użytkownika!**'

			get_town	#funkcja pobiera miasto
			pomoc7="$pomoc"
			update_user	#funkcja aktualizuje dane użytkownika

			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Miasto użytkownika zostało zaktualizowane.'
			read -p "$wybierz" aktualizacja ;;
		"6") 	#aktualizuje adres użytkownika
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo '**Aktualizuj adres użytkownika!**'

			get_address	#funkcja pobiera adres
			pomoc8="$pomoc"
			update_user	#funkcja aktualizuje dane użytkownika

			clear
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Adres użytkownika zostało zaktualizowany.'
			read -p "$wybierz" aktualizacja ;;
		"0") 	#wraca do menu
			clear
			break ;;
		*)	#wyświetla komunikat w przypadku wybrania nieprawidłowej opcji menu
			clear 
			echo "$menu_uzytkownik_aktualizacja"
			echo 'Nie ma takiej opcji. Wybierz inną opcję lub wróć do menu głównego!'
			read -p "$wybierz" aktualizacja ;;
		esac
		done
	else
		clear
		echo $menu_glowne
		echo 'Nie można aktualizować informacji. Nie ma użytkownika o takiej nazwie!'
		read -p "$wybierz" program 
	fi 
	clear 
	echo $menu_glowne
	read -p "$wybierz" program ;;
"8")	#aktualizacja danych książki
	sync	#synchronizuje dane na dysku z pamięcią
	clear 
	echo $menu_glowne
	echo '**Aktualizuj dane książki!**'

	get_book	#funkcja pobiera tytuł książki
	check_book	#funkcja sprawdza, czy książka o takim tytule istnieje
	
	if [ $? -eq 1 ]	#umożliwia aktualizacje książki, jeśli taka książka istnieje
	then
		clear
		echo "$menu_ksiazka_aktualizacja"
		read -p "$wybierz" aktualizacja

		while [ 1 ]
		do
		book_user	#funkcja pobiera dane książki	
		
		case "$aktualizacja" in #menu aktualizacji książki
		"1")	#aktualizuje tytuł książki
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo '**Aktualizuj tytułu książki!**'
			pomoc="$tytul"
			get_book	#funkcja pobiera tytuł książki
			check_book	#funkcja sprawdza, czy książka o takim tytule istnieje
			if [ $? -eq 2 ]	#aktualizuje tytuł, gdy tytuł nie jest zajęty
			then
				rm mylibrary/books/"$pomoc.txt"	#usuwa stary plik książki

				for file in `ls mylibrary/userbooks`	#aktualizuje tytuł, w wypożyczonych książkach użytkowników
				do
				sed -i "s/$pomoc/$tytul/" mylibrary/userbooks/"$file" 2> /dev/null
				done

				touch mylibrary/books/"$tytul.txt"
				chmod 777 mylibrary/books/"$tytul.txt"
				update_book	#funkcja aktualizuje dane książki

				clear
				echo "$menu_ksiazka_aktualizacja" 
				echo 'Tytuł książki został zaktualizowany.'
				read -p "$wybierz" aktualizacja 
			else
				clear
				echo "$menu_ksiazka_aktualizacja" 
				echo 'Nie można zmienić tytułu książki. Tytuł jest zajęty przez inną książke!'
				read -p "$wybierz" aktualizacja 
			fi ;;
		"2")	#aktualizuje imię autora
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo '**Aktualizuj imię autora!**'

			
			get_author_name	#funkcja pobiera imię autora książki
			pomoc1="$pomoc"
			update_book	#funkcja aktualizuje dane książki

			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo 'Imię autora książki zostało zaktualizowane.'
			read -p "$wybierz" aktualizacja ;;
		"3")	#aktualizuje nazwisko autora
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo '**Aktualizuj nazwisko autora!**'
			
			get_author_surname	#funkcja pobiera nazwisko autora książki
			pomoc2="$pomoc"
			update_book	#funkcja aktualizuje dane książki

			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo 'Nazwisko autora książki zostało zaktualizowane.'
			read -p "$wybierz" aktualizacja ;;
		"4")	#aktualizuje date wydania ksiązki
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo '**Aktualizuj date wydania książki!**'

			echo "Podaj datę wydania!"
			get_day		#funkcja pobiera dzień miesiąca
			pomoc3="$pomoc"	#przechowuje dzień	
			get_month	#funkcja pobiera miesiąc
			pomoc4="$pomoc"	#przechowuje miesiąc
			get_year	#funkcja pobiera rok
			pomoc5="$pomoc" #przechowuje rok
			update_book	#funkcja aktualizuje dane książki

			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo 'Data wydania książki została zaktualizowana.'
			read -p "$wybierz" aktualizacja ;;
		"5")	#aktualizuje wydawnictwo autora
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo '**Aktualizuj wydawnictwo książki!**'

			get_publishing_house	#funkcja pobiera nazwe wydawnictwa książki
			pomoc6="$pomoc"
			update_book	#funkcja aktualizuje dane książki

			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo 'Wydawnictwo książki zostało zaktualizowane.'
			read -p "$wybierz" aktualizacja ;;
		"6")	#aktualizuje liczbę stron 
			sync	#synchronizuje dane na dysku z pamięcią
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo '**Aktualizuj liczbe stron książki!**'

			get_book_pages	#funkcja pobiera liczbę stron książki
			pomoc8="pomoc"
			update_book	#funkcja aktualizuje dane książki

			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo 'Liczba stron książki została zaktualizowana.'
			read -p "$wybierz" aktualizacja ;;
		"0")	#wraca do menu
			clear
			break ;;
		*)	#wyświetla komunikat w przypadku wybrania nieprawidłowej opcji menu
			clear
			echo "$menu_ksiazka_aktualizacja" 
			echo 'Nie ma takiej opcji. Wybierz inną opcję lub wróć do menu głównego!'
			read -p "$wybierz" aktualizacja ;;
		esac
		done
	else
		clear
		echo $menu_glowne
		echo 'Nie można aktualizować informacji. Nie ma książki o takim tytule!'
		read -p "$wybierz" program 
	fi 
	clear 
	echo $menu_glowne
	read -p "$wybierz" program ;;
"9")	#wypożyczenie
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Wypożycz książke!**'

	get_user	#funkcja pobiera nazwę użytkownika	
	check_user	#funkcja sprawdza, czy użytkownik o takiej nazwie istnieje		
	
	if [ $? -eq 1 ]	#jeśli użytkownik o takiej nazwie istnieje, sprawdzany jest następnie tytuł książki
	then

		get_book	#funkcja pobiera tytuł książki
		check_book	#funkcja sprawdza, czy książka o takim tytule istnieje

		if [ $? -eq 1 ]	#wypożycza książke użytkownikowi, jeśli taka książka istnieje
		then
			pomoc=`grep "$tytul" mylibrary/userbooks/"$user.txt"`
			if [ "$pomoc" ]		#sprawdza, czy użytkownik wypożyczył już taką książke, jeśli nie wypożycza ją
			then
				clear
				echo $menu_glowne
				echo 'Nie można wypożyczyć 2 takich samych książek!'
				read -p "$wybierz" program 
			else
				echo "$tytul" >> mylibrary/userbooks/"$user.txt"

				sync	#synchronizuje dane na dysku z pamięcią
				clear
				echo $menu_glowne
				echo 'Książka została wypożyczona.'
				read -p "$wybierz" program 
				fi
		else
			clear
			echo $menu_glowne
			echo 'Nie można wypożyczyć książki. Nie ma książki o takim tytule!'
			read -p "$wybierz" program 
		fi
	else
		clear
		echo $menu_glowne
		echo 'Nie można wypożyczyć książki. Nie ma użytkownika o takiej nazwie!'
		read -p "$wybierz" program 
	fi ;;
"10")	#użytkownik oddaje książke
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Oddaj książke!**'

	get_user	#funkcja pobiera nazwę użytkownika	
	check_user	#funkcja sprawdza, czy użytkownik o takiej nazwie istnieje	
	
	if [ $? -eq 1 ]	#jeśli użytkownik o takiej nazwie istnieje, sprawdzany jest tytuł książki
	then

		get_book	#funkcja pobiera tytuł książki
		check_book	#funkcja sprawdza, czy książka o takim tytule istnieje
	
		if [ $? -eq 1 ]	#sprawdza czy użytkownik wypożyczył taką książke, jeśli tak oddaje ją
		then
			pomoc=`grep "$tytul" mylibrary/userbooks/"$user.txt"`
			if [ "$pomoc" ]		
			then
				sed -i "/$tytul/d" "mylibrary/userbooks/$user.txt" 2> /dev/null

				sync	#synchronizuje dane na dysku z pamięcią
				clear
				echo $menu_glowne
				echo 'Książka została oddana.'
				read -p "$wybierz" program 
			else
				clear
				echo $menu_glowne
				echo 'Nie można oddać książki. Użytkownik nie wypożyczył takiej książki!'
				read -p "$wybierz" program 
				fi
		else
			clear
			echo $menu_glowne
			echo 'Nie można oddać książki. Nie ma książki o takim tytule!'
			read -p "$wybierz" program 
		fi
	else
		clear
		echo $menu_glowne
		echo 'Nie można oddać książki. Nie ma użytkownika o takiej nazwie!'
		read -p "$wybierz" program 
	fi ;;
"11")	#wyświetla listę użytkowników
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_uzytkownik_lista
	echo '**Wyświetl liste użytkowników!**'
	read -p "$wybierz" lista

	while [ 1 ]	#sprawdza, według czego sortować użytkowników
	do
		case $lista in
		"1") 
			break ;;
		"2") 
			break ;;
		"3") 
			break ;;
		"4") 
			break ;;
		"5") 
			break ;;
		"6") 
			break ;;
		"7") 
			break ;;
		"0") 
			break ;;
		*)
			clear
			echo $menu_uzytkownik_lista
			echo '**Wyświetl liste użytkowników!**'
			echo 'Nie ma takiej opcji. Wybierz inną opcję lub zakończ program!'
			read -p "$wybierz" lista
		esac
	done
	
	clear
	echo $sortowanie
	echo '**Wyświetl liste użytkowników!**'

	while [ $lista -ge 1 -a $lista -le 7 ]	#sprawdza, w jaki sposób sortować użytkowników
	do
		read -p "$wybierz" sortuj
		case $sortuj in
		"1") 
			break ;;
		"2") 
			break ;;
		*)
			clear
			echo $sortowanie
			echo '**Wyświetl liste użytkowników!**'
			echo 'Nie ma takiej opcji. Wybierz inną opcję lub zakończ program!'
			esac
		done

	if [ $lista -ge 1 -a $lista -le 7 ] #realizuje wybraną opcje sortowania
	then
		for file in mylibrary/users/*.txt	#pobiera dane użytkowników,	gdzie ^ oznacza separator kolumn
		do	
			pomoc0=`tail +1 "$file" | head -n1` 2> /dev/null
			pomoc1=`tail +2 "$file" | head -n1` 2> /dev/null
			pomoc2=`tail +3 "$file" | head -n1` 2> /dev/null
			pomoc3=`tail +4 "$file" | head -n1` 2> /dev/null
			pomoc4=`tail +5 "$file" | head -n1` 2> /dev/null
			pomoc5=`tail +6 "$file" | head -n1` 2> /dev/null
			pomoc6=`tail +7 "$file" | head -n1` 2> /dev/null
			pomoc7=`tail +8 "$file" | head -n1` 2> /dev/null
			pomoc8=`tail +9 "$file" | head -n1` 2> /dev/null

			echo "$pomoc0^$pomoc1^$pomoc2^$pomoc3^$pomoc4^$pomoc5^$pomoc6^$pomoc7^$pomoc8" >> unsort.txt	#dopisuje dane użytkowników do pliku
			
		done
		
		case $lista in	#sortuje i wyświetla użytkowników według wybranej opcji
		"1")	#sortuje według nazwy użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k1 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1}' sort.txt	
			else
				sort -t '^' -rk1 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1}' sort.txt	
			fi ;;
		"2")	#sortuje według imienia użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k2 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tImię: "$2}' sort.txt
			else
				sort -t '^' -rk2 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tImię: "$2}' sort.txt
			fi ;;
		"3") 	#sortuje według nazwiska użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k3 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tNazwisko: "$3}' sort.txt
			else
				sort -t '^' -rk3 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tNazwisko: "$3}' sort.txt
			fi ;;
		"4")	#sortuje według płci użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k4 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tPłeć: "$4}' sort.txt
			else
				sort -t '^' -rk4 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tPłeć: "$4}' sort.txt
			fi ;;
		"5") 	#sortuje według daty urodzenia użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -nk7 -nk6 -nk5 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tData urodzenia: "$5"-"$6"-"$7}' sort.txt
			else
				sort -t '^' -rnk7 -rnk6 -rnk5  unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tData urodzenia: "$5"-"$6"-"$7}' sort.txt
			fi ;;
		"6") 	#sortuje według miasta użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k8 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tMiasto: "$8}' sort.txt
			else
				sort -t '^' -rk8 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tMiasto: "$8}' sort.txt
			fi ;;
		"7") 	#sortuje według adresu użytkownika
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k9 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tAdres: "$9}' sort.txt
			else
				sort -t '^' -rk9 unsort.txt >> sort.txt 
				echo '\nLista użytkowników:'
				awk -F "^" '{print "Użytkownik: "$1"\tAdres: "$9}' sort.txt
			fi ;;
		esac
		rm unsort.txt
		rm sort.txt
	
		sync	#synchronizuje dane na dysku z pamięcią
		read -p '$Podaj dowolny klawisz, aby kontynuować: ' pomoc
		clear
		echo $menu_glowne
		read -p "$wybierz" program 
	else
		clear
		echo $menu_glowne
		read -p "$wybierz" program 
	fi ;;
"12")	#wyświetla listę książek
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_ksiazka_lista
	echo '**Wyświetl liste książek!**'
	read -p "$wybierz" lista

	while [ 1 ]	#sprawdza, według czego sortować książki
	do
		case $lista in
		"1") 
			break ;;
		"2") 
			break ;;
		"3") 
			break ;;
		"4") 
			break ;;
		"5") 
			break ;;
		"6") 
			break ;;
		"0") 
			break ;;
		*)
			clear
			echo $menu_ksiazka_lista
			echo '**Wyświetl liste książek!**'
			echo 'Nie ma takiej opcji. Wybierz inną opcję lub zakończ program!'
			read -p "$wybierz" lista
		esac
	done
	
	clear
	echo $sortowanie
	echo '**Wyświetl liste książek!**'

	while [ $lista -ge 1 -a $lista -le 6 ]	#sprawdza, w jaki sposób sortować książki
	do
		read -p "$wybierz" sortuj
		case $sortuj in
		"1") 
			break ;;
		"2") 
			break ;;
		*)
			clear
			echo $sortowanie
			echo '**Wyświetl liste książek!**'
			echo 'Nie ma takiej opcji. Wybierz inną opcję lub zakończ program!'
			esac
		done

	if [ $lista -ge 1 -a $lista -le 6 ] #realizuje wybraną opcje sortowania
	then
		for file in mylibrary/books/*.txt #pobiera dane książek,	gdzie ^ oznacza separator kolumn
		do	
			pomoc0=`tail +1 "$file" | head -n1` 2> /dev/null	
			pomoc1=`tail +2 "$file" | head -n1` 2> /dev/null
			pomoc2=`tail +3 "$file" | head -n1` 2> /dev/null
			pomoc3=`tail +4 "$file" | head -n1` 2> /dev/null
			pomoc4=`tail +5 "$file" | head -n1` 2> /dev/null
			pomoc5=`tail +6 "$file" | head -n1` 2> /dev/null
			pomoc6=`tail +7 "$file" | head -n1` 2> /dev/null
			pomoc7=`tail +8 "$file" | head -n1` 2> /dev/null

			echo "$pomoc0^$pomoc1^$pomoc2^$pomoc3^$pomoc4^$pomoc5^$pomoc6^$pomoc7" >> unsort.txt	#dopisuje dane książek do pliku
		done

		case $lista in	#sortuje i wyświetla książki według wybranej opcji
		"1") 	#sortuje według tytułu książki
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k1 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1}' sort.txt	
			else
				sort -t '^' -rk1 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1}' sort.txt	
			fi ;;
		"2") 	#sortuje według imienia autora książki
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k2 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tImię autora: "$2}' sort.txt
			else
				sort -t '^' -rk2 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tImię autora: "$2}' sort.txt
			fi ;;
		"3") 	#sortuje według nazwiska autora książki
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k3 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tNazwisko autora: "$3}' sort.txt
			else
				sort -t '^' -rk3 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tNazwisko autora: "$3}' sort.txt
			fi ;;
		"4") 	#sortuje według daty wydania książki
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -nk6 -nk5 -nk4 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tData wydania: "$4"-"$5"-"$6}' sort.txt
			else
				sort -t '^' -rnk6 -rnk5 -rnk4 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tData wydania: "$4"-"$5"-"$6}' sort.txt
			fi ;;
		"5") 	#sortuje według nazwy wydawnictwa książki
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -k7 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tWydawnictwo: "$7}' sort.txt
			else
				sort -t '^' -rk7 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tWydawnictwo: "$7}' sort.txt
			fi ;;
		"6") 	#sortuje według liczby stron książki
			if [ $sortuj -eq 1 ]	#sprawdza, czy sortować rosnąco czy malejąco
			then
				sort -t '^' -n -k8 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tLiczba stron: "$8}' sort.txt
			else
				sort -t '^' -n -rk8 unsort.txt >> sort.txt 
				echo '\nLista książek:'
				awk -F "^" '{print "Tytuł: "$1"\tLiczba stron: "$8}' sort.txt
			fi ;;
		esac
		rm unsort.txt
		rm sort.txt
	
		sync	#synchronizuje dane na dysku z pamięcią
		read -p '$Podaj dowolny klawisz, aby kontynuować: ' pomoc
		clear
		echo $menu_glowne
		read -p "$wybierz" program 
	else
		clear
		echo $menu_glowne
		read -p "$wybierz" program 
	fi ;;
"13")	#wyświetla informację o autorze skryptu
	sync	#synchronizuje dane na dysku z pamięcią
	clear
	echo $menu_glowne
	echo '**Informacje o autorze skryptu!**'
	echo "$autor"	
	read -p "$wybierz" program ;;
"0")	#kończy program
	clear
	echo 'Do widzenia, dziękuje za skorzystanie z mojego programu :)'
	return 0 ;;

*)	#wyświetla komunikat w przypadku wybrania nieprawidłowej opcji menu
	clear
	echo $menu_glowne
	echo 'Nie ma takiej opcji. Wybierz inną opcję lub zakończ program!'
	read -p "$wybierz" program
esac
done
