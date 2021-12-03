"use strict";

function newtask(event) {
    // Clearing all fields in the form
    document.querySelector("[name='title']").value = "";
    document.querySelector("[name='due']").value = "";
    document.querySelector("[name='reminder']").value = "";
    document.querySelector("[name='created']").value = "";
    document.querySelector("[name='category']").value = "Homework";
    document.querySelector("[name='priority']").value = "1";
    document.querySelector("[name='status']").value = "Unstarted";
    document.querySelector("[name='notes']").value = "";
    document.querySelector("[name='id']").value = "";
}

function newfolder(event) {
    let name = prompt("New folder:");
    let userid = document.querySelector("[name='userid']").value;
    if (name.length > 0) {
        let f = new FormData;
        f.append("userid", userid);
        f.append("name", name);
        fetch("/new_folder", {
            "method": "POST",
            "body": f,
        }).then(response => response.text()).then(data => {
            console.log("newFolder replied:", data);
            location.reload();
        });
    }
}

document.querySelector("#new-task-button").addEventListener("click", newtask)
document.querySelector("#new-folder-button").addEventListener("click", newfolder)
