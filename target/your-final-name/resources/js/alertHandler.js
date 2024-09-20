// alertHandler.js
function  groupForm() {
    var fields = ["gname"];
    var fieldLabels = {
        "gname" : "모임명"
    };
    var valid = true;

    fields.forEach(function (field) {
        var value = document.forms["group-createForm"][field].value;
        if (value === null || value === "") {
            alert(fieldLabels[field] + "을 입력해 주세요.");
            valid = false;
        }
    });
    return valid;
}

function  memberInviteForm() {
    var fields = ["member.mid"];
    var fieldLabel = {
        "member.mid" : "초대할 회원ID"
    };
    var valid = true;

    fields.forEach(function (field) {
        var value = document.forms["member-inviteForm"][field].value;
        if (value === null || value === "") {
            alert(fieldLabel[field] + "를 입력해 주세요.");
            valid = false;
        }
    });
    return valid;
}

function hideText() {
    var element = document.getElementById('temporaryText');
    if (element) {
        element.style.display = 'none';
    }
}

window.onload = function() {
    setTimeout(hideText, 2000); // 3000 milliseconds = 3 seconds
};