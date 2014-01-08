$('#cart').html("<%=j render @cart %>")
$('#current_item a').css({'background-color':'#DD4814', 'color':'#ffffff'})
<% if @template == 'yumasianbistro' || @template == 'joyluckdelivery' %>
$('.dish_dialog').dialog 'close'
<% elsif %>
$('.reveal-modal').foundation 'reveal', 'close'
<% end %>
