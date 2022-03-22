from flask import render_template, request, Blueprint
from flask.helpers import flash
from app import cursor
from app.main.forms import SearchToursForm
from app.main.utils import from_list_to_string, get_tours

main = Blueprint('main', __name__)

@main.route('/', defaults={'page': 1, 'info': {}}, methods=['GET', 'POST'])
@main.route('/<info>/<page>', methods=['GET', 'POST'])
@main.route('/home', defaults={'page': 1, 'info': {}}, methods=['GET', 'POST'])
@main.route('/home/<info>/<page>', methods=['GET', 'POST'])
def home(page, info):
    # stellt sicher, dass Info als Dictionary geladen wird
    string = str(info)
    info = eval(string)

    # alle Elemente, die gesucht werden können
    searchElements = []

    # Liste, der ausgewählten Suchelemente
    list_all = []

    # allgemeine Informationen für die Auswahl mit PostgresSql
    selection = """
        SELECT DISTINCT fact_tour.tou_tourname, dim_languages.lan_long_deutsch, fact_tour.tou_price, dim_category.cat_name, fact_tour_languages.tlg_pk, fact_tour_languages.tlg_tour_fk_pk, fact_tour.tou_img_website
        FROM fact_tour_languages
        INNER JOIN fact_tour ON fact_tour_languages.tlg_tour_fk_pk = fact_tour.tou_pk
        INNER JOIN dim_languages ON fact_tour_languages.tlg_language_fk = dim_languages.lan_short_pk
        INNER JOIN dim_category ON fact_tour.tou_category_fk = dim_category.cat_pk"""
    orderBy = "ORDER BY fact_tour.tou_tourname, dim_languages.lan_long_deutsch"

    # Kategorien
    cursor.execute("SELECT cat_pk, cat_name FROM dim_category ORDER BY cat_name")
    rowsCat = cursor.fetchall()
    searchElements.append(rowsCat)

    # Sehenswürdigkeiten
    cursor.execute("SELECT sg_pk, sg_name FROM dim_sightseeings ORDER BY sg_name")
    rowsSights = cursor.fetchall()
    searchElements.append(rowsSights)

    # Sprachen
    cursor.execute("SELECT lan_short_pk, lan_long_deutsch FROM dim_languages ORDER BY lan_long_deutsch")
    rowsLang = cursor.fetchall()
    searchElements.append(rowsLang)

    # Wenn 'Suchen' angeklickt wurde
    formAct = SearchToursForm()
    if formAct.validate_on_submit():
        page = 1

        # Welche Art/en von Tour?
        values = request.form.getlist('category', type=int)
        if values:
            info['category'] = values
            category = []
            for value in values:
                category.append('dim_category.cat_pk=' + str(value))
            list_all.append((from_list_to_string(category, ' OR ')))
        elif 'category' in info:
            info.pop('category')

            
        # Welche Sehenswürdigkeit/en?
        values = request.form.getlist('sights', type=int)
        if values:
            info['sights'] = values
            sights = []
            for value in values:
                sights.append('fact_tour_highlights.th_sightseeing_fk=' + str(value))
            list_all.append((from_list_to_string(sights, ' OR ')))

        elif 'sights' in info:
            info.pop('sights')

        # In welcher/welchen Sprache/n?
        values = request.form.getlist('lang')
        if values:
            info['lang'] = values
            languages = []
            for value in values:
                languages.append('dim_languages.lan_short_pk=\'' + value + '\'')
            list_all.append((from_list_to_string(languages, ' OR ')))
        elif 'lang' in info:
            info.pop('lang')
            
        # In welchem/n Preisbereich/en?
        values = request.form.getlist('price')
        if values:
            info['price'] = values
            price = []
            for value in values:
                if value == 'until_15':
                    price.append('fact_tour.tou_price < 15.00')
                if value == '15to25':
                     price.append('fact_tour.tou_price BETWEEN 15.00 AND 25.00')
                if value == 'more_than_25':
                     price.append('fact_tour.tou_price > 25.00')
            list_all.append(from_list_to_string(price, ' OR '))
        elif 'price' in info:
            info.pop('price')

        # Welche Dauer?
        values = request.form.getlist('duration')
        if values:
            info['duration'] = values
            duration = []
            for value in values:
                if value == 'less_2point5':
                    duration.append('fact_tour.tou_duration < 2.5')
                if value == '2point5_4':
                    duration.append('fact_tour.tou_duration BETWEEN 2.5 AND 4.0')
                if value == 'whole':
                    duration.append('fact_tour.tou_duration = 24.0')
            list_all.append(from_list_to_string(duration, ' OR '))
        elif 'duration' in info:
            info.pop('duration')

        info['searching'] = list_all

    if 'sights' in info:
        selection = selection + """
            INNER JOIN fact_tour_highlights ON fact_tour.tou_pk=fact_tour_highlights.th_tour_fk_pk
            INNER JOIN dim_sightseeings ON fact_tour_highlights.th_sightseeing_fk=dim_sightseeings.sg_pk"""
    
    # Suche anhand der ausgewählten Parameter
    search = 'WHERE '
    if 'searching' in info:
        search = 'WHERE ' + from_list_to_string(info.get('searching'), ' AND ')
    if search == 'WHERE ' :
        result = get_tours(selection, None, orderBy, page)
    else:
        result = get_tours(selection, search, orderBy, page)
        if result[1] == []:
            flash('Es konnten keine Touren zu Ihrer Anfrage gefunden werden', 'warning')
        else:
            flash('Die folgenden Touren wurden zu Ihrer Anfrage gefunden', 'success')
    
    # stellt sicher, dass Info als Dictionary übergeben wird
    string = str(info)
    info = eval(string)

    return render_template('home.html', is_home=True, info=info, page=page, pages=result[0], formAct=formAct, searchElements=searchElements, tours=result[1])
