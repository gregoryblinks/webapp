########################
##### Instructions #####
########################

Damit die GUI funktioniert, muss zunächst die Datenbank "tourguide" erstellt werden.
Dazu einfach die Datenbank "tourguide" in Postgres erstellen und anschließend mit rechtsklick "Restore" auswählen.
Als File muss dann ".../tourguide.tar" ausgewählt werden.

Bevor die Anwendung gestartet werden kann, muss wahrscheinlich das ein oder andere Paket installiert werden.
Dazu jeweils ein 'pip install ...' für
- flask
- flask-wtf
- wtforms
- flask-sqlalchemy
- datetime
- python-dateutil

Ist die Datenbank erst einmal korrekt und vollständig installiert, kann der Ordner "/GUI/" in einem Bearbeitungsprogramm wie Visual Studio Code aufgerufen werden.
Dort kann die Applikation aus dem File "/app.py" heraus mit "Str+F5" gestartet werden.

Anschließend muss noch das Passwort für die Datenbank angegeben werden, da diese direkt angebunden ist.
Es sollte keine Probleme geben, sofern die Datenbank mit "tourguide" benannt wurde und über den Port "5432" läuft.
Sollte es Ihrerseits Abweichungen geben, müssen diese in "/app/config.py" entsprechend angepasst werden.
Auch kann dort das Passwort eingetragen werden, wenn Sie es nicht bei jedem Start neu eingeben möchten.

Abschließend sollte alles korrekt funktionieren, sodass die Oberfläche über den angegebenen Link aufgerufen werden kann (am besten über Chrome).

########################
###### Viel Spaß! ######
########################