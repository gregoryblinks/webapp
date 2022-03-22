import getpass

passwd = getpass.getpass(prompt='Passwort für die Datenbank: ')
DB_URL = 'postgresql+psycopg2://{user}:{pw}@{url}:{port}/{db}'.format(user='postgres',pw=passwd,url='127.0.0.1', port='5432', db='tourguide')


class Config:
    SECRET_KEY = '37ab324m65p34q99'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
    SQLALCHEMY_DATABASE_URI = DB_URL
