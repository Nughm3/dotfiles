from flask import Blueprint, render_template, request, redirect
from . import db_read, db_write
from uuid import uuid1 as uuid

views = Blueprint("views", __name__)


@views.route("/")
def home():
    return render_template("home.html")


@views.route("/tasks/")
def tasks():
    if "folderid" in request.values:
        folderid = int(request.values["folderid"])
    else:
        folderid = 0
    if "id" in request.values:
        id = request.values["id"]
    else:
        id = 0

    user = {
        "name": "Aaden",
        "username": "Nughm",
    }
    print(db_read("SELECT * FROM accounts;"))
    # users can't be implemented here yet until login system is done

    folders = db_read("SELECT * FROM folders ORDER BY name;")
    tasks = db_read(
        f"SELECT * FROM tasks WHERE folderid='{folderid}' AND status != 'Completed' ORDER BY title;"
    )
    try:
        maintask = db_read(f"SELECT * FROM tasks WHERE id='{id}';")[0]
    except IndexError:
        maintask = None

    folders = [{"id": folders.index(name), "name": name["name"]} for name in folders]

    return render_template(
        "tasks.html",
        user=user,
        folders=folders,
        folderid=folderid,
        tasks=tasks,
        maintask=maintask,
    )


@views.route("/error")
def error():
    return "<head><title>Error</title></head><body><h1>Sorry!</h1><p>There was an error</p><a href='/tasks/'>Back to tasks page</a></body>"


@views.route("/save_task", methods=["POST"])
def save_task():
    form = dict(request.values)
    id = form["id"]
    folderid = form["folderid"]
    if "submit-close" in form:
        form["status"] = "Completed"
        return redirect(f"/tasks/?folderid={folderid}")
    elif "submit-delete" in form:
        db_write(f"DELETE FROM tasks WHERE id='{id}';")
        return redirect(f"/tasks/?folderid={folderid}")

    form["link"] = ""
    if id == "":
        id = str(uuid())
        write = db_write(
            "INSERT INTO tasks (title, due, reminder, category, priority, status, notes, link) VALUES (:title, :due, :reminder, :category, :priority, :status, :notes, :link);",
            form,
        )
    else:
        write = db_write(
            "UPDATE tasks SET title=:title, due=:due, reminder=:reminder, category=:category, priority=:priority, status=:status, notes=:notes, link=:link",
            form,
        )

    if write == 0:
        return redirect(f"/tasks/?folderid={folderid}&id={id}")
    else:
        return redirect("/error")


@views.route("/new_folder", methods=["POST"])
def new_folder():
    form = dict(request.values)
    id = str(uuid())
    form["id"] = id
    write = db_write(
        "INSERT INTO folders (userid, id, name) VALUES (:userid, :id, :name);", form
    )
    if write == 0:
        return "Ok"
    else:
        return "Err"

@views.route("/archive/")
def archive():
    archived_tasks = db_read("SELECT * FROM tasks WHERE status == 'Completed' ORDER BY title;")
    return "WIP"
