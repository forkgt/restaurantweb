$('#cart').html("<%=j render @cart %>")
$('#current_item a').css({'background-color':'#DD4814', 'color':'#ffffff'})
<% if @template.desc == "jquery-ui" %>
$('.dish_dialog').dialog 'close'
<% elsif @template.desc == "foundation" %>
$('.reveal-modal').foundation 'reveal', 'close'
<% end %>
