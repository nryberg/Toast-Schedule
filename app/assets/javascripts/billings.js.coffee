jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  billing.setupForm()
  alert("hello world")

billing =
  setupForm: ->
    $('#new_billing').submit ->
      $('input[type=submit]').attr('disabled', true)
      billing.processCard()
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, billing.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      alert(response.id)
    else
         alert(response.error.message)
