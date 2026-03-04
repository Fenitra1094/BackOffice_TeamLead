<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.cousin.model.Assignation" %>
<%@ page import="com.cousin.model.Reservation" %>
<%@ page import="com.cousin.model.Vehicule" %>
<%@ page import="com.cousin.model.Hotel" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Assignation Vehicules</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        h2 { color: #333; }
        table { border-collapse: collapse; width: 100%; margin-top: 15px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f0f0f0; }
        .error { color: red; font-weight: bold; padding: 10px; background: #ffe0e0; border: 1px solid red; margin: 10px 0; }
        .success { color: green; font-weight: bold; padding: 10px; background: #e0ffe0; border: 1px solid green; margin: 10px 0; }
        .warning { color: #b36b00; font-weight: bold; padding: 10px; background: #fff3e0; border: 1px solid #b36b00; margin: 10px 0; }
        form { margin-bottom: 30px; }
        input[type="date"] { padding: 5px; font-size: 14px; }
        button { padding: 8px 16px; font-size: 14px; cursor: pointer; }
    </style>
</head>
<body>

<h2>Assignation des vehicules aux reservations</h2>

<!-- Formulaire de choix de date -->
<form method="get" action="<%= request.getContextPath() %>/assignation/assigner">
    <label>Choisir une date :</label><br><br>
    <input type="date" name="date" required>
    <button type="submit">Assigner</button>
</form>

<%
    // Messages d'erreur
    Object error = request.getAttribute("error");
    if (error != null) {
%>
    <div class="error"><%= error %></div>
<%
    }

    // Message de succes
    Object message = request.getAttribute("message");
    if (message != null) {
%>
    <div class="success"><%= message %></div>
<%
    }

    // Tableau des assignations reussies
    List<Assignation> assignations = (List<Assignation>) request.getAttribute("assignations");
    if (assignations != null && !assignations.isEmpty()) {
%>
    <h3>Assignations effectuees (<%= assignations.size() %>)</h3>
    <table>
        <thead>
            <tr>
                <th>Reservation</th>
                <th>Client</th>
                <th>Nb Passagers</th>
                <th>Hotel</th>
                <th>Heure Arrivee</th>
                <th>Vehicule</th>
                <th>Nb Places</th>
                <th>Type</th>
                <th>Depart</th>
                <th>Retour</th>
            </tr>
        </thead>
        <tbody>
<%
        for (Assignation a : assignations) {
            Reservation r = a.getReservation();
            Vehicule v = a.getVehicule();
%>
            <tr>
                <td><%= r.getIdReservation() %></td>
                <td><%= r.getIdClient() %></td>
                <td><%= r.getNbPassager() %></td>
                <td><%= r.getHotel() != null ? r.getHotel().getNom() : "-" %></td>
                <td><%= r.getDateHeureArrive() %></td>
                <td><%= v.getReference() %></td>
                <td><%= v.getNbPlace() %></td>
                <td><%= v.getTypeVehicule() %></td>
                <td><%= a.getDateHeureDepart() %></td>
                <td><%= a.getDateHeureRetour() %></td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
<%
    }

    // Tableau des reservations non assignees
    List<Reservation> nonAssignees = (List<Reservation>) request.getAttribute("reservationsNonAssignees");
    if (nonAssignees != null && !nonAssignees.isEmpty()) {
%>
    <div class="warning">
        <%= nonAssignees.size() %> reservation(s) non assignee(s) (pas de vehicule disponible)
    </div>
    <table>
        <thead>
            <tr>
                <th>Reservation</th>
                <th>Client</th>
                <th>Nb Passagers</th>
                <th>Hotel</th>
                <th>Heure Arrivee</th>
            </tr>
        </thead>
        <tbody>
<%
        for (Reservation r : nonAssignees) {
%>
            <tr>
                <td><%= r.getIdReservation() %></td>
                <td><%= r.getIdClient() %></td>
                <td><%= r.getNbPassager() %></td>
                <td><%= r.getHotel() != null ? r.getHotel().getNom() : "-" %></td>
                <td><%= r.getDateHeureArrive() %></td>
            </tr>
<%
        }
%>
        </tbody>
    </table>
<%
    }

    // Si aucune reservation pour cette date
    if (assignations != null && assignations.isEmpty() && (nonAssignees == null || nonAssignees.isEmpty())) {
%>
    <div class="warning">Aucune reservation trouvee pour cette date.</div>
<%
    }
%>

</body>
</html>