SIGN_IN = "/auth/signin";

window.signIn = function () {
  const token = document.querySelector('meta[name="csrf-token"]').content;
  var username = $("#usernameInput").val(),
    password = $("#passwordInput").val();
  if (!username || !password) {
    return alert("Todos los campos son obligatorios");
  }
  $.ajax(SIGN_IN, {
    type: "POST",
    headers: {
      "X-CSRF-Token": token,
      "Content-Type": "application/json",
    },
    data: JSON.stringify({
      username: username,
      password: password,
    }),
  }).done(function (data) {
    alert(data.msg);
    if (data.status) {
      window.location.replace("/");
    }
  });
};
