$('#cart').html("<%=j render @cart %>")
$('#current_item a').css({'background-color':'#DD4814', 'color':'#ffffff'})
<% if @framework == "jquery-ui" %>
$('.dish_dialog').dialog 'close'
<% elsif @framework == "foundation" %>
$('.reveal-modal').foundation 'reveal', 'close'
<% end %>
