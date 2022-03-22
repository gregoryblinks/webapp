from flask_wtf import FlaskForm
from wtforms import SubmitField

class SearchToursForm(FlaskForm):
    submit = SubmitField('Suchen')
