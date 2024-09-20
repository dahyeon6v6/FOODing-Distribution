<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/pick.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<c:import url="/top.jsp" />
<section class="content">
<h1>찜 폴더 관리</h1>
<div class="pick-container">
    <div class="pickList-container">
        <h4 id="allPickList">전체 찜 목록</h4>
            <table class="pick-table">
                <c:forEach var="pick" items="${pickList}">
                <tr>
                    <td>
                        <input type="checkbox" name="selectedStore" value="${pick.store.sno}" />
                        <button class="storeName" onclick="location.href='${pageContext.request.contextPath}/storeDetail?sno=${pick.store.sno}'">${pick.store.sname}</button>
                    </td>
                </tr>
                </c:forEach>
            </table>
        <div class="removeButton-container">
            <button type="submit" id="removePick" class="removePick">삭제</button>
        </div>
    </div>
    <div class="addToFolder-container">
        <button type="button" class="add-button"><img src="${pageContext.request.contextPath}/resources/images/addToFolder.png"></button>
    </div>
    <div class="pickFolders-container">
        <h4 id="allFolderList">나의 찜 폴더</h4>
        <div class="addFolder-container">
            <form method="post" action="${pageContext.request.contextPath}/createFolder">
                <input type="hidden" name="pfname" value="새 폴더" />
                <button type="submit" class="createFolder">+새 폴더</button>
            </form>
        </div>
        <form id="deleteFolderForm" method="post" action="${pageContext.request.contextPath}/deleteFolder">
            <table class="folder-table">
                <c:forEach var="pfolder" items="${pfolderList}">
                    <tr>
                        <td>
                            <div class="folder-items">
                                <div class="folder-items folder-items-left">
                                    <input type="checkbox" name="selectedFolders" value="${pfolder.pfno}" class="folder-checkbox"/>
                                    <button type="button" class="pfolderName" id="pfname_${pfolder.pfno}" data-pfname="${pfolder.pfname}" onclick="loadFolderContent('${pfolder.pfno}')">${pfolder.pfname}</button>
                                    <input type="text" class="edit-input" id="edit_${pfolder.pfno}" value="${pfolder.pfname}" style="display: none" />
                                    <button type="button" class="save-pfname" id="save_${pfolder.pfno}" style="display: none" onclick="savePfname('${pfolder.pfno}')">저장</button>
                                    <button type="button" class="cancel-pfname" id="cancel_${pfolder.pfno}" style="display: none" onclick="cancelEdit('${pfolder.pfno}')">취소</button>
                                </div>
                                <div class="folder-items folder-items-right">
                                    <button type="button" class="edit-button" id="editButton" onclick="editPfname('${pfolder.pfno}')">
                                        <img src="${pageContext.request.contextPath}/resources/images/edit_icon.png">
                                    </button>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr id="folder-content-${pfolder.pfno}" style="display:none;"></tr>
                </c:forEach>
            </table>
            <div class="removeButton-container">
                <button type="submit" id="deleteFolder" class="deleteFolder">삭제</button>
            </div>
        </form>
    </div>
</div>
</section>
<c:import url="/bottom.jsp" />
<script>
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.pfolderName').forEach(function(folder) {
            folder.addEventListener('click', function() {
                // 다른 모든 폴더에서 selected 클래스 제거
                document.querySelectorAll('.pfolderName').forEach(function(f) {
                    f.classList.remove('selected');
                });

                // 현재 클릭된 폴더에만 selected 클래스 추가
                this.classList.add('selected');
            });
        });

        document.getElementById("deleteFolder").addEventListener("click", function() {
            event.preventDefault();
            console.log("삭제 버튼이 클릭됨");

            var folderContentContainer = document.getElementById('folder-content-container');

            if (folderContentContainer) {
                // 찜 폴더 내부에서 가게 삭제
                var selectedStores = document.querySelectorAll('.store-checkbox:checked');
                if (selectedStores.length === 0) {
                    alert("삭제할 가게를 선택하세요.");
                    return;
                }

                var snos = [];
                selectedStores.forEach(function(store) {
                    snos.push(store.value);
                });

                var pfnoElement = document.querySelector('.pfolderName.selected');

                if (pfnoElement) {
                    var pfno = pfnoElement.getAttribute('id').replace('pfname_', '');

                    $.ajax({
                        type: 'POST',
                        url: '${pageContext.request.contextPath}/deletePickFromFolder',
                        data: {
                            snos: snos.join(','),
                            pfno: pfno
                        },
                        success: function(response) {
                            if (response === "success") {
                                alert('선택된 가게가 삭제되었습니다.');
                                loadFolderContent(pfno);
                            } else {
                                alert('삭제 중 오류가 발생했습니다.');
                            }
                        },
                        error: function() {
                            alert('가게를 삭제하는 중 오류가 발생했습니다.');
                        }
                    });
                }
            } else {
                // '찜 폴더 관리' 에서 폴더 삭제
                var checkboxes = document.querySelectorAll(".folder-checkbox:checked");
                if (checkboxes.length === 0) {
                    alert("삭제할 폴더를 선택하세요.");
                } else {
                    document.getElementById("deleteFolderForm").submit();
                }
            }
        });
    });


    document.getElementById("removePick").addEventListener("click", function() {
        var selectedStores = document.querySelectorAll('.pickList-container input[name="selectedStore"]:checked');

        if (selectedStores.length === 0) {
            alert("삭제할 가게를 선택하세요.");
            return;
        }

        var snos = [];
        selectedStores.forEach(function(store) {
            snos.push(store.value);
        });

        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/removePick',
            data: {
                snos: snos.join(',')
            },
            success: function(response) {
                if (response === "success") {
                    alert('선택된 가게들이 삭제되었습니다.');
                    location.reload();
                } else {
                    alert('삭제 중 오류가 발생했습니다.');
                }
            },
            error: function() {
                alert('삭제 중 오류가 발생했습니다.');
            }
        });
    });

    function editPfname(pfno) {
        document.getElementById('pfname_' + pfno).style.display = 'none';
        document.getElementById('edit_' + pfno).style.display = 'inline';
        document.getElementById('edit_' + pfno).focus();
        document.getElementById('save_' + pfno).style.display = 'inline';
        document.getElementById('cancel_' + pfno).style.display = 'inline';
        document.getElementById('editButton').style.display = 'none';
    }

    function savePfname(pfno) {
        var newName = document.getElementById('edit_' + pfno).value;
        $.ajax({
            type: 'POST',
            url: '${pageContext.request.contextPath}/updateFolderName',
            data: {
                pfno: pfno,
                pfname: newName
            },
            success: function(response) {
                if (response === 'success') {
                    document.getElementById('pfname_' + pfno).innerText = newName;
                    document.getElementById('pfname_' + pfno).style.display = 'inline';
                    document.getElementById('edit_' + pfno).style.display = 'none';
                    document.getElementById('save_' + pfno).style.display = 'none';
                    document.getElementById('cancel_' + pfno).style.display = 'none';
                    document.getElementById('editButton').style.display = 'inline';
                } else {
                    alert('폴더 이름 변경 중 오류가 발생했습니다.');
                }
            }
        });
    }

    function cancelEdit(pfno) {
        document.getElementById('edit_' + pfno).style.display = 'none';
        document.getElementById('save_' + pfno).style.display = 'none';
        document.getElementById('cancel_' + pfno).style.display = 'none';
        document.getElementById('pfname_' + pfno).style.display = 'inline';
        document.getElementById('editButton').style.display = 'inline';
    }

    function loadFolderContent(pfno) {
        // 기존의 폴더 내용 삭제 (reload 시 내용 중복 방지)
        var folderContentContainer = document.getElementById('folder-content-container');
        if (folderContentContainer) {
            folderContentContainer.remove();
        }

        document.querySelector('.addFolder-container').style.display = 'none';
        document.querySelector('.folder-table').style.display = 'none';

        var pfname = document.getElementById('pfname_' + pfno).getAttribute('data-pfname');
        document.querySelector('#allFolderList').innerText = pfname;

        $.ajax({
            type: 'GET',
            url: '${pageContext.request.contextPath}/getFolderContent',
            data: { pfno: pfno },
            success: function(response) {
                var contentHtml = '';
                if (response.length === 0) {
                    contentHtml += '<p class="isEmpty">폴더가 비어있습니다.</p>';
                } else {
                    contentHtml += '<ul class="folder-list">';
                    response.forEach(function(pick) {
                        contentHtml += '<li class="folder-item">';
                        contentHtml += '<input type="checkbox" name="selectedStores" value="' + pick.store.sno + '" class="store-checkbox"/>';
                        contentHtml += '<span class="store-label">' + pick.store.sname + '</span>';
                        contentHtml += '</li>';
                    });
                    contentHtml += '</ul>';
                }
                contentHtml += '<img id="backButton" src="${pageContext.request.contextPath}/resources/images/back.png" style="cursor:pointer;">';

                var folderContentContainer = document.createElement('div');
                folderContentContainer.id = 'folder-content-container';  // ID 추가
                folderContentContainer.innerHTML = contentHtml;
                document.querySelector('.pickFolders-container').appendChild(folderContentContainer);
                document.getElementById('backButton').addEventListener('click', function() {
                    goBackToFolderList();
                });
            },
            error: function() {
                alert('폴더 내용을 불러오는 중 오류가 발생했습니다.');
            }
        });
    }

    function goBackToFolderList() {
        var folderContentContainer = document.getElementById('folder-content-container');
        if (folderContentContainer) {
            folderContentContainer.remove();
        }
        var addFolderContainer = document.querySelector('.addFolder-container');
        addFolderContainer.style.display = 'block';
        addFolderContainer.style.justifyContent = 'flex-end';

        document.querySelector('.addFolder-container').style.display = 'block';
        document.querySelector('.folder-table').style.display = 'block';
        document.querySelector('#allFolderList').innerText = '찜 폴더 관리';
        document.querySelector('.createFolder').style.marginLeft = 'auto';
    }


    document.addEventListener('DOMContentLoaded', function() {
        let currentPfno = null;
        document.querySelectorAll('.pfolderName').forEach(function(folder) {
            folder.addEventListener('click', function() {
                // 다른 모든 폴더에서 selected 클래스 제거
                document.querySelectorAll('.pfolderName').forEach(function(f) {
                    f.classList.remove('selected');
                });

                // 현재 클릭된 폴더에만 selected 클래스 추가
                this.classList.add('selected');
                currentPfno = this.getAttribute('id').replace('pfname_', '');  // currentPfno 업데이트
            });
        });

        document.querySelector('.add-button').addEventListener('click', function() {
            addPickToFolder();
        });

        function addPickToFolder() {
            var selectedStores = document.querySelectorAll('.pickList-container input[name="selectedStore"]:checked');
            var selectedFolders = document.querySelectorAll('.pickFolders-container input[name="selectedFolders"]:checked');

            if (selectedStores.length === 0) {
                alert('추가할 가게를 선택하세요.');
                return;
            }
            if (selectedFolders.length === 0) {
                if (currentPfno !== null) {
                    selectedFolders = [currentPfno]; // currentPfno 값을 배열로 변환하여 사용
                } else {
                    alert('추가할 찜 폴더를 선택하세요.');
                    return;
                }
            } else {
                // 선택된 폴더가 있으면 currentPfno 값을 업데이트
                currentPfno = selectedFolders[0].value;
            }

            var pfnos = [];
            selectedFolders.forEach(function(folder) {
                pfnos.push(folder.value || folder);
            });

            var snos = [];
            selectedStores.forEach(function(store) {
                snos.push(store.value);
            });

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/addPickToFolder',
                data: {
                    pfnos: pfnos.join(','),
                    snos: snos.join(',')
                },
                success: function(response) {
                    if (response === "success") {
                        alert('선택한 폴더에 찜이 추가되었습니다.');
                        loadFolderContent(currentPfno);
                    } else if (response === "error") {
                        alert('한 번에 하나의 폴더에만 추가할 수 있습니다. 폴더를 하나만 선택해주세요.')
                    }
                },
                error: function() {
                    alert('가게를 폴더에 추가하는 중 오류가 발생했습니다.');
                }
            });
        }
    });
</script>
</body>
</html>
