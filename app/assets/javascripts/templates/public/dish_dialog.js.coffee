$ ->

  $('.dish_dialog').each ->
    dish_dialog = $(this)
    dish_id = dish_dialog.attr 'dish_id'

    # Hide all dish dialogs when the page is loaded
    dish_dialog.dialog { autoOpen: false, width: 500 }

    # Add customer choices and prices changes into note and price_ajustment, and then submit the form
    dish_dialog.find(".dish_dialog_submit").click ->
      flag = true

      dish_dialog.find('.dish_choice').each ->
        if $.trim($(this).attr("must")) == "true"
          if $.trim($(this).attr("type")) == "radio" || $.trim($(this).attr("type")) == "checkbox"
            if $(this).find("input:checked").length == 0
              flag = false

      if flag
        note = dish_dialog.find('input[name=note]')
        price_adjustment = dish_dialog.find('input[name=price_adjustment]')
        note_val = ''
        price_adjustment_val = 0

        dish_dialog.find('input:checked, input:text').each ->
          if $(this).val()
            note_val += ($(this).val() + ',')
            price_adjustment_val += Number($(this).attr("add"))

        if note_val.charAt(note_val.length-1) == ','
          note_val = note_val.substring(0, note_val.length-1)

        note.val note_val
        price_adjustment.val price_adjustment_val

        dish_dialog.find('form').submit()


