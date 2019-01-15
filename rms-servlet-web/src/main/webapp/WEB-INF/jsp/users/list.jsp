<%@ page language="java" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix = "rms" uri = "/WEB-INF/tags/link.tld"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">

  <title>RMS</title>
  <meta name="description" content="Index">
  <meta name="author" content="Mitrais">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
  <link rel="stylesheet" href="https://code.getmdl.io/1.3.0/material.indigo-pink.min.css">
  <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
  <rms:link type="stylesheet" href="css/styles.css?v=1.0"/>

  <!--[if lt IE 9]>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
  <![endif]-->
</head>

<body>
    <div class="mdl-layout mdl-js-layout mdl-color--grey-100 box-center">
    	<main class="mdl-layout__content">
    		<table class="mdl-data-table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp">
              <thead>
                <tr>
                  <th class="mdl-data-table__cell--non-numeric">User Name</th>
                  <th>Password</th>
                  <th><a class="mdl-navigation__link" href="insert"><button class="mdl-button mdl-js-button mdl-button--icon mdl-button--primary"><i class="material-icons icon-hover">add_circle_outline</i></button></a></th>
                </tr>
              </thead>
              <tbody>
              <c:forEach items = "${users}" var="user">
                  <tr>
                    <td class="mdl-data-table__cell--non-numeric"><c:out value = "${user.userName}"/></td>
                    <td><c:out value = "${user.password}"/></td>
                    <td><a href="${pageContext.request.contextPath}/users/update?id=${user.id}" role="button">
                    <button type="button" class="mdl-button mdl-js-button mdl-button--icon mdl-button--primary" value="${user.id}">
                        <i class="material-icons icon-hover">edit</i>
                        </button> </a>
                    </td>
                    <td><a href="${pageContext.request.contextPath}/users/delete?id=${user.id}" role="button">
                        <button class="mdl-button mdl-js-button mdl-button--icon mdl-button--primary" value="${user.id}">
                        <i class="material-icons icon-hover">delete</i></button></a>
                    </td>
                  </tr>
              </c:forEach>

              </tbody>
            </table>
    	</main>
    </div>

  <dialog class="mdl-dialog">
    <h5 class="mdl-dialog__title">Edit Data</h5>
    <form action="${pageContext.request.contextPath}/users" method="post">
        <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type="hidden" id="id" name="id" value=""/>
        </div>
        <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type="text" id="username" name="username" value=""/>
            <label class="mdl-textfield__label" for="username">Username</label>
        </div>
        <div class="mdl-textfield mdl-js-textfield">
            <input class="mdl-textfield__input" type="password" id="userpass" name="password" value=""/>
            <label class="mdl-textfield__label" for="userpass">Password</label>
        </div>
        <div class="mdl-dialog__actions">
          <button type="button" class="mdl-button">Edit</button>
          <button type="button" class="mdl-button close">Cancel</button>
        </div>
    </form>
  </dialog>

  <script src="js/scripts.js"></script>
  <script>
      var dialog = document.querySelector('dialog');
      var showDialogButton = document.querySelector('#show-dialog');
      if (! dialog.showModal) {
        dialogPolyfill.registerDialog(dialog);
      }
      showDialogButton.addEventListener('click', function() {
        dialog.showModal();
      });
      dialog.querySelector('.close').addEventListener('click', function() {
        dialog.close();
      });
    </script>
</body>

</html>
