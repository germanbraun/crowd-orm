// Generated by CoffeeScript 1.12.5
(function() {
  var Login, LoginManager, LoginRequests, exports, ref;

  LoginManager = (function() {
    LoginManager.current = null;

    LoginManager.loginconn = null;

    function LoginManager(loginwidget_id, saveloadwidget_id) {
      if (loginwidget_id == null) {
        loginwidget_id = "#loginwidget_placer";
      }
      if (saveloadwidget_id == null) {
        saveloadwidget_id = "#saveloadjson_placer";
      }
      this.current = null;
      this.loginwidget = new login.LoginWidgetView({
        el: $(loginwidget_id)
      });
      this.saveloadjsonwidget = new login.SaveLoadJson({
        el: $(saveloadwidget_id)
      });
      this.loginconn = new login.LoginRequests();
    }

    LoginManager.prototype.new_login = function(username, current) {
      if (current == null) {
        current = true;
      }
      if (current) {
        return this.current = new Login(username, this.loginconn);
      } else {
        return new Login(username, this.loginconn);
      }
    };

    LoginManager.prototype.show_login = function() {
      return this.loginwidget.show();
    };

    LoginManager.prototype.hide_login = function() {
      return this.loginwidget.hide();
    };

    LoginManager.prototype.change_to_user_page = function() {
      return $.mobile.changePage("#user-page", {
        transition: "slide"
      });
    };

    LoginManager.prototype.update_login = function(data) {
      console.log("update_login:");
      console.log(data);
      this.current.set_json(data);
      if (this.current.logged) {
        return this.set_logged_in();
      } else {
        this.current = null;
        return setTimeout(function() {
          return console.log("Problems When Logging In", data);
        }, 1000);
      }
    };

    LoginManager.prototype.set_logged_in = function() {
      if (this.current != null) {
        this.loginwidget.set_doing_login(false);
        return this.show_load_json();
      } else {
        this.loginwidget.set_doing_login(true);
        return this.show_load_json_with_list([]);
      }
    };

    LoginManager.prototype.update_logout = function(data) {
      console.log(data);
      this.current = null;
      return this.set_logged_in();
    };

    LoginManager.prototype.show_save_json = function() {
      $.mobile.loading("show", {
        text: "Retrieving models list...",
        textVisible: true,
        textonly: false
      });
      return this.loginconn.request_model_list(function(data) {
        return login.lm_instance.update_saveloadjsonwidget(data);
      });
    };

    LoginManager.prototype.show_load_json = function() {
      $.mobile.loading("show", {
        text: "Retrieving models list...",
        textVisible: true,
        textonly: false
      });
      return this.loginconn.request_model_list(function(data) {
        return login.lm_instance.update_saveloadjsonwidget(data);
      });
    };

    LoginManager.prototype.show_load_json_with_list = function(list) {
      $.mobile.loading("hide");
      this.saveloadjsonwidget.set_jsonlist(list);
      return login.lm_instance.change_to_user_page();
    };

    LoginManager.prototype.hide_saveloadjson = function() {
      return this.saveloadjsonwidget.hide();
    };

    LoginManager.prototype.update_saveloadjsonwidget = function(data) {
      var error, list;
      try {
        list = JSON.parse(data);
      } catch (error1) {
        error = error1;
        $.mobile.loading("hide");
        console.log(error);
        console.log("Couldn't parse and retrieve models list.", data);
      }
      return this.show_load_json_with_list(list);
    };

    LoginManager.prototype.model_sended = function(data) {
      $.mobile.loading("hide");
      console.log("Model sended...");
      return console.log(data);
    };

    return LoginManager;

  })();

  Login = (function() {
    function Login(username1, loginconn) {
      this.username = username1;
      this.loginconn = loginconn != null ? loginconn : null;
      this.json = null;
    }

    Login.prototype.set_json = function(jsonstr) {
      return this.json = JSON.parse(jsonstr);
    };

    Login.prototype.logged = function() {
      return this.json.logged;
    };

    Login.prototype.do_login = function(pass) {
      return this.loginconn.request_login(this.username, pass, function(data) {
        return login.lm_instance.update_login(data);
      });
    };

    Login.prototype.do_logout = function() {
      return this.loginconn.request_logout(function(data) {
        return login.lm_instance.update_logout(data);
      });
    };

    Login.prototype.save_model = function(jsonstr, modelname) {
      $.mobile.loading("show", {
        text: "Sending to the server...",
        textVisible: true,
        textonly: false
      });
      this.loginconn.send_model(modelname, jsonstr, function(data) {
        return login.lm_instance.model_sended(data);
      });
      return gui.gui_instance.change_to_diagram_page();
    };

    Login.prototype.load_model = function(modelname) {
      $.mobile.loading("show", {
        text: "Retrieving model...",
        textVisible: true,
        textonly: false
      });
      return this.loginconn.request_model(modelname, function(data) {
        return gui.gui_instance.update_metamodel(data);
      });
    };

    return Login;

  })();

  LoginRequests = (function() {
    function LoginRequests() {
      this.default_error_callback = function(jqxhr, status, error) {
        console.log("Login error:");
        console.log(status);
        return console.log(error);
      };
      this.error_callback = this.default_error_callback;
    }

    LoginRequests.prototype.set_error_callback = function(fnc) {
      if (fnc != null) {
        return this.error_callback = fnc;
      } else {
        return this.error_callback = this.default_error_callback;
      }
    };

    LoginRequests.prototype.send_model = function(modelname, json, callback_function) {
      var postdata, url;
      url = "api/profiles/save_model.php";
      postdata = "model_name=" + modelname + "&json=" + json;
      console.log("Requesting at " + url);
      return $.ajax({
        type: "POST",
        url: url,
        data: postdata,
        success: callback_function,
        error: this.error_callback
      });
    };

    LoginRequests.prototype.request_model = function(modelname, callback_function) {
      var postdata, url;
      url = "api/profiles/retrieve_model.php";
      postdata = "model_name=" + modelname;
      console.log("Requesting at " + url);
      return $.ajax({
        type: "POST",
        url: url,
        data: postdata,
        success: callback_function,
        error: this.error_callback
      });
    };

    LoginRequests.prototype.request_login = function(username, pass, callback_function) {
      var postdata, url;
      postdata = "username=" + username + "&password=" + pass;
      url = "api/profiles/login.php";
      console.log("Requesting at " + url);
      return $.ajax({
        type: "POST",
        url: url,
        data: postdata,
        success: callback_function,
        error: this.error_callback
      });
    };

    LoginRequests.prototype.request_logout = function(callback_function) {
      var url;
      url = "api/profiles/logout.php";
      console.log("Requesting at " + url);
      return $.ajax({
        type: "GET",
        url: url,
        success: callback_function,
        error: this.error_callback
      });
    };

    LoginRequests.prototype.request_model_list = function(callback_function) {
      var url;
      url = "api/profiles/list_models.php";
      console.log("Requesting at " + url);
      return $.ajax({
        type: "GET",
        url: url,
        success: callback_function,
        error: this.error_callback
      });
    };

    return LoginRequests;

  })();

  exports = exports != null ? exports : this;

  exports.login = (ref = exports.login) != null ? ref : {};

  exports.login.LoginManager = LoginManager;

  exports.login.LoginRequests = LoginRequests;

  exports.login.Login = Login;

  $.when($.ready).then(function() {
    exports = exports != null ? exports : this;
    return exports.login.lm_instance = new LoginManager();
  });

}).call(this);
