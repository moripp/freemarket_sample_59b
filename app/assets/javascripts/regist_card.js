$(function() {
  var form = $("#charge-form"),
      number = form.find('#card-number'),
      cvc = form.find('#card-cvc'),
      exp_month = form.find('select[name="card[month]"]'),
      exp_year = form.find('select[name="card[year]"]');

      $("#charge-form").submit(function() {
    form.find("input[type=submit]").prop("disabled", true); // prop("disabled", true); はボタンを無効にする

    var card = {
        number: number.val(),
        cvc: cvc.val(),
        exp_month: exp_month.val(),
        exp_year: exp_year.val()
    };
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        form.find('.payment-errors').text(response.error.message);
        form.find('button').prop('disabled', false);
      }
      else {
        $(".number").removeAttr("name");
        $(".cvc").removeAttr("name");
        $(".exp_month").removeAttr("name");
        $(".exp_year").removeAttr("name");

        var token = response.id;

        form.append($('<input type="hidden" name="payjp-token" />').val(token));
        form.get(0).submit();
      }
    });
    return false;
  });
});