$('#cart').html("<%=j render @cart, store: @store %>")
$('#current_item a').css({'background-color':'#DD4814', 'color':'#ffffff'})
<% if @framework == "jquery-ui" %>
$('.dish_dialog').dialog 'close'
<% elsif @framework == "foundation" %>
$('.close-reveal-modal').trigger 'click'
<% end %>
