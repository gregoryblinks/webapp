from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy.engine import create_engine
from app.config import Config


db = SQLAlchemy()

engine = create_engine(Config.SQLALCHEMY_DATABASE_URI)
connection = engine.raw_connection()
cursor = connection.cursor()


def create_app(config_class=Config):
    app = Flask(__name__)
    app.config.from_object(config_class)

    print("Database opened successfully\n")

    db.init_app(app)

    from app.tours.routes import tours
    from app.main.routes import main
    from app.errors.handlers import errors

    app.register_blueprint(tours)
    app.register_blueprint(main)
    app.register_blueprint(errors)

    return app
