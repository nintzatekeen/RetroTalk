window.onload = () => {
    let buttons = document.getElementsByClassName("editBtn");
    for (let i = 0; i < buttons.length; i++) {
        buttons[i].addEventListener("click", e => {
            alert(e);
        })
    }
}