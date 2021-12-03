from flask import Blueprint, render_template, request, flash

auth = Blueprint("auth", __name__)


@auth.route("/login/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form.get("Username")
        password = request.form.get("Password")
    return render_template("login.html")


@auth.route("/register/", methods=["GET", "POST"])
def register():
    if request.method == "POST":
        username = request.form.get("Username")
        password = request.form.get("Password")

        if username != None and password != None:
            if len(username) < 3 and len(password) < 8:
                flash("Account details too short!", category="error")
            elif len(username) < 3:
                flash("Username too short!", category="error")
            elif len(password) < 8:
                flash("Password too short!", category="error")
            else:
                flash("Account created!", category="success")
        else:
            flash("Invalid input")
    return render_template("register.html")
