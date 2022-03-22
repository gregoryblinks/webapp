from datetime import date
from dateutil.relativedelta import relativedelta
from flask import render_template, Blueprint
from flask.helpers import flash
from app import cursor


tours = Blueprint('tours', __name__)


@tours.route('/tour/<string:tourPK>-<string:tourID>')
def bookTour(tourPK, tourID):
    # Tourname, Gruppengröße, Dauer, Name für die Bilder
    cursor.execute("""
        SELECT DISTINCT tou_tourname, tou_img_website, tou_duration, tou_groupsize, tou_pk
        FROM fact_tour
        WHERE tou_pk=%s
    """ % (tourID))
    tour = cursor.fetchone()

    # Kategorie
    cursor.execute("""
        SELECT DISTINCT cat_pk
        FROM fact_tour
        INNER JOIN dim_category ON fact_tour.tou_category_fk=dim_category.cat_pk
        WHERE tou_pk=%s
    """ % (tourID))
    tourcat = cursor.fetchone()

    # Verfügbare Sprachen
    cursor.execute("""
        SELECT DISTINCT dim_languages.lan_long_deutsch
        FROM fact_tour_languages
        INNER JOIN dim_languages ON fact_tour_languages.tlg_language_fk = dim_languages.lan_short_pk
        WHERE tlg_tour_fk_pk=%s
        ORDER BY dim_languages.lan_long_deutsch
    """ % (tourID))
    langs = cursor.fetchall()
    tourlang = ''
    tourlangs = []
    for lang in langs:
        tourlangs.append(lang[0])
        if tourlang == '':
            tourlang = lang[0]
        else:
            tourlang = tourlang + ', ' + lang[0]

    # Ausgwählte Sprache
    cursor.execute("""
        SELECT dim_languages.lan_long_deutsch
        FROM fact_tour_languages
        INNER JOIN dim_languages ON fact_tour_languages.tlg_language_fk = dim_languages.lan_short_pk   
        WHERE tlg_pk=%s
    """ % (tourPK))
    selectLang = cursor.fetchone()

    # Datum
    today = date.today()
    tomorrow_in_one_year = today + relativedelta(years=1)
    dates = []
    dates.append(today)
    dates.append(tomorrow_in_one_year)

    # Sehenswürdigkeiten
    cursor.execute("""
        SELECT DISTINCT dim_sightseeings.sg_name
        FROM fact_tour_highlights
        INNER JOIN fact_tour ON fact_tour_highlights.th_tour_fk_pk=fact_tour.tou_pk
        INNER JOIN dim_sightseeings ON fact_tour_highlights.th_sightseeing_fk=dim_sightseeings.sg_pk
        WHERE th_tour_fk_pk=%s
    """ % (tourID))
    toursights = cursor.fetchall()

    # Treffpunkt
    cursor.execute("""
        SELECT DISTINCT
            CASE
                WHEN tou_meetingpoint_fk IS NULL
                    THEN 'different'
                ELSE dim_places.pl_plz || ' ' || dim_places.pl_street || ' ' || dim_places.pl_number
            END
        FROM fact_tour
        LEFT JOIN dim_places ON dim_places.pl_pk=fact_tour.tou_meetingpoint_fk
        WHERE tou_pk=%s
    """ % (tourID))
    tourpoint = cursor.fetchone()    

    html = 'tours/%s.html' % (tourID)
    return render_template(html, title=tour[0], dates=dates, tour=tour, tourcat=tourcat, tourlangs=tourlangs, tourlang=tourlang, selectLang=selectLang, toursights=toursights, tourpoint=tourpoint)
