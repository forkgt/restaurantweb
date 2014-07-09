<% if @result == "not_complete" %>
$('#cart_message').html("Address is not complete!").show()
<% elsif @result == "not_valid" %>
$('#cart_message').html("Address is not valid!").show()
<% elsif @result == "good" %>
$('#cart').html("<%=j render @cart, store: @store %>")
  <% if @cart.delivery_fee == 0 %>
$('#cart_message').html("Your delivery is free!").show()
  <% else %>
$('#cart_message').html("<%= number_to_currency @cart.delivery_fee %> Delivery Fee Applies").show()
  <% end %>
<% elsif @result == "too_far" %>
$('#cart_message').html("Too far, contact restaurant!").show()
<% end %>
