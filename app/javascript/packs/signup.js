SIGN_UP = "/auth/signup";

window.sendSignUp = function () {
  $("#feedbackError").hide();
  const username = $("#usernameRegister").val(),
    password = $("#passwordRegister").val(),
    email = $("#emailRegister").val(),
    terms = $("#terms").is(":checked"),
    token = document.querySelector('meta[name="csrf-token"]').content;

  if (!username || !password || !email) {
    $("#feedbackError").show();
    $("#feedbackError").text("Todos los campos son obligatorios");
    return;
  }
  if (!terms) {
    $("#feedbackError").show();
    $("#feedbackError").text(
      "Debes aceptar los terminos y condiciones para continuar."
    );
    return;
  }
  if (
    $("#passwordRegister").val() != $("#passwordRegisterConfirmation").val()
  ) {
    $("#feedbackError").show();
    $("#feedbackError").text("Las contraseñas no coinciden.");
    return;
  }
  if (!/^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test($("#emailRegister").val())) {
    $("#feedbackError").show();
    $("#feedbackError").text("Debes ingresar un correo valido.");
    return;
  }
  $("#feedbackError").hide();
  $.ajax(SIGN_UP, {
    type: "POST",
    headers: {
      "X-CSRF-Token": token,
      "Content-Type": "application/json",
    },
    data: JSON.stringify({
      user: {
        username: username,
        password: password,
        email: email,
        terms: terms,
      },
    }),
  })
    .done(function (data) {
      alert(data.msg);
      if (data.status) {
        window.location.replace("/");
      }
    })
    .fail(function (xhr) {
      $("#feedbackError").show();
      $("#feedbackError").text(JSON.parse(xhr.responseText).msj);
    });
  $("#passwordRegisterConfirmation").focusout(() => {
    if (
      $("#passwordRegister").val() != $("#passwordRegisterConfirmation").val()
    ) {
      $("#feedbackError").show();
      $("#feedbackError").text("Las contraseñas no coinciden.");
      return;
    }
    $("#feedbackError").hide();
  });
};
