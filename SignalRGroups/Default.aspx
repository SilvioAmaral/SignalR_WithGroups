<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SignalRGroups.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <input type="text" id="room" />
            <input type="button" id="connect" value="connect" />


            <input type="text" id="msg" />
            <input type="button" id="broadcast" value="broadcast" />

            <ul id="messages">
            </ul>
        </div>
    </form>
</body>
</html>
 
<script src="Scripts/jquery-1.6.4.js" type="text/javascript"></script>
<script src="Scripts/jquery.signalR-1.1.4.min.js" type="text/javascript"></script>
<script src="signalr/hubs" type="text/javascript"></script>
<script type="text/javascript">
    $('#connect').click(function () {
        // proxy created on the fly          
        var chat = $.connection.chat;

        // declare a function on the chat hub so the server can invoke it          
        chat.client.addmessage = function (message) {
            $('#messages').append('<li>' + message + '</li>');
        };

        $.connection.hub.start(function () {
            chat.server.join($('#room').val());
        });

        // start the connection
        $.connection.hub.start().done(function () {

            $("#broadcast").click(function () {
                // call the chat method on the server
                //chat.server.send($('#msg').val());
                chat.server.send({ msg: $('#msg').val(), group: $('#room').val() });
            });
        });
    });


    //$(function () {
    //    // proxy created on the fly          
    //    var chat = $.connection.chat;

    //    // declare a function on the chat hub so the server can invoke it          
    //    chat.client.addmessage = function (message) {
    //        $('#messages').append('<li>' + message + '</li>');
    //    };

    //    $.connection.hub.start(function () {
    //        chat.server.join($('#msg').val());
    //    });

    //    // start the connection
    //    $.connection.hub.start().done(function () {

    //        $("#broadcast").click(function () {
    //            // call the chat method on the server
    //            //chat.server.send($('#msg').val());
    //            chat.server.send({ msg: $('#msg').val(), group: "rooma" });
    //        });
    //    });
    //});
</script>

