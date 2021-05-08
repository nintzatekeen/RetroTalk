<%-- 
    Document   : newProduct
    Created on : 30-abr-2021, 17:17:47
    Author     : IKER
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="header.jsp" />


<h1>Nuevo Producto</h1>

<form method="post" action="InsertProductServlet" enctype="multipart/form-data">
    Título: <input type="text" name="title"/>
    <br/>
    Descripción: <textarea name="description"></textarea>
    <br/>
    Precio: <input type="number" name="price" min="0" step=".01"/>
    <br/>
    Imagen: <input type="file" name="img" value="Subir imagen" accept="image/*"/>
    <br/>
    <input type="submit" name="submit" value="SUBIR"/>
</form>

<c:if test="${requestScope.error != null}">
    <p style="color:red">${requestScope.error}</p>
</c:if>

<!--IMPORTACIÓN DEL HEADER-->
<jsp:include page="footer.jsp" />
