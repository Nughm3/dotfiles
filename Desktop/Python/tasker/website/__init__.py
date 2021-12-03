from flask import Flask
import sqlite3

# Database
database_filename = "tasker.db"


def db_read(sql, data=None):
    connection = sqlite3.connect(database_filename)
    connection.row_factory = sqlite3.Row
    db = connection.cursor()

    # If the data exists, read it, if not, don't
    if data:
        db.execute(sql, data)
    else:
        db.execute(sql)

    records = db.fetchall()
    rows = [dict(record) for record in records]

    # Close the connections
    connection.commit()
    db.close()
    connection.close()

    return rows


def db_write(sql, data=None):
    connection = sqlite3.connect(database_filename)
    connection.row_factory = sqlite3.Row
    db = connection.cursor()

    # If the data exists, write it, if not, don't
    if data:
        rows_affected = db.execute(sql, data).rowcount
    else:
        rows_affected = db.execute(sql).rowcount

    # Close the connections
    connection.commit()
    db.close()
    connection.close()

    return rows_affected


app = Flask(__name__)
app.config["SECRET_KEY"] = "asdfghjkl;'"

from .views import views
from .auth import auth

app.register_blueprint(views, url_prefix="/")
app.register_blueprint(auth, url_prefix="/account")
