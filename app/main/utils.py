from app import cursor

# forme aus den einzelnen Werten einer Liste einen String mit OR bzw. AND zwischen den Werten
# OR für Werte einzelner Auswahlmöglichkeiten
# AND für alle ausgewählten Optionen
def from_list_to_string(liste, or_and):
    index = 0
    final_str = ''
    for item in liste:
        if index == 0:
            final_str = '(' + item + ')'
        else:
            final_str = final_str + or_and + '(' + item + ')'
        index += 1
    return final_str


# immer nur 5 Ergebnisse pro Seite
def limit_results_per_page(tours):
    six = 0
    pages = 1
    limit = []
    while six < len(tours):
        limit.append("LIMIT 6 OFFSET " + str(six))
        pages = pages + 1
        six = six + 6
    return pages, limit


# Touren, die angezeigt werden sollen
def get_tours(selection, search, orderBy, page):
    # alle Touren um die Anzahl der Pages und die limit-Bereiche zu erhalten
    if search:
        cursor.execute("%s %s %s" % (selection, search, orderBy))
    else:
        cursor.execute("%s %s" % (selection, orderBy))
    tour = cursor.fetchall()
    result = limit_results_per_page(tour)
    pages = result[0]
    limit = result[1]

    # Touren für die aktuelle Seite
    # wenn es kein limit gibt, dann gibt es keine Ergebnisse
    if limit:
        if search:
            cursor.execute("%s %s %s %s" % (selection, search, orderBy, limit[int(page)-1]))
        else:
            cursor.execute("%s %s %s" % (selection, orderBy, limit[int(page)-1]))
        tours = cursor.fetchall()
    else:
        tours = []

    return pages, tours
