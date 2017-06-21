# login.coffee --
# Copyright (C) 2017 Giménez, Christian

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.

# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# @namespace login
# 
# Class to manage the login and widgets.
#
# Main class for the login and save-load features and its widgets.
class LoginManager

    # The current Login instance.
    @current = null

    # The LoginRequests instance used for sending requests to the server.
    @loginconn = null

    # Create a LoginWidget
    # 
    # @param widget_id The login widget id. Example: "#loginwidget_placer"
    constructor: (loginwidget_id = "#loginwidget_placer", saveloadwidget_id = "#saveloadjson_placer") ->
        @current = null
        @loginwidget = new login.LoginWidgetView({el: $(loginwidget_id)})
        @saveloadjsonwidget = new login.SaveLoadJson({el: $(saveloadwidget_id)})
        @loginconn = new login.LoginRequests()

    # Create a new login and make it current.
    #
    # @param current [boolean] Optional. Make it current? By default is true.
    # @param username [string] The username of the login.
    new_login: (username, current = true) ->
        if current
            @current = new Login(username, @loginconn)
        else
            new Login(username, @loginconn)

    #
    # Show the login popup.
    #
    show_login: () ->
        @loginwidget.show()

    #
    # Hide the login popup.
    #
    hide_login: () ->
        @loginwidget.hide()

    change_to_user_page: () ->
        $.mobile.changePage("#user-page", transition: "slide")

    # Callback for the LoginRequests
    #
    # Update the interface according to a succesful login.
    #
    # @param data {String} The information about the login answer in JSON format.
    update_login: (data) ->
        console.log("update_login:")
        console.log(data)
        @current.set_json(data)
        if @current.logged
            this.set_logged_in()
        else
            @current = null
            # For some reason it won't show the error message if not wait for
            # one second.
            setTimeout(() ->
                console.log("Problems When Logging In", data)
            ,1000)

    # According to the information about @current, update the interface.
    set_logged_in: () ->
        if @current?
            @loginwidget.set_doing_login(false)
            # Update the model list
            this.show_load_json()
        else
            @loginwidget.set_doing_login(true)
            # Remove all models in the model list
            this.show_load_json_with_list([]);

    # Callback for the Loginrequests.
    #
    # Update the interface and JS as if the user has recently logged out.
    #
    # @param data {String} The information returned from the server.
    update_logout: (data) ->
        console.log(data)
        @current = null
        this.set_logged_in()

    # Display the saveloadjson Popup in the save state.
    show_save_json: () ->
        $.mobile.loading("show",
            text: "Retrieving models list...",
            textVisible: true,
            textonly: false
        )
        @loginconn.request_model_list(
            (data) ->
                login.lm_instance.update_saveloadjsonwidget(data))

    # Display the saveloadjson Popup in the load state.
    #
    # But first, we must retrieve the model list.
    show_load_json: () ->
        $.mobile.loading("show",
            text: "Retrieving models list...",
            textVisible: true,
            textonly: false
        )
        @loginconn.request_model_list(
            (data) ->
                login.lm_instance.update_saveloadjsonwidget(data))

    # Display the loadjson but without retrieving the model list.
    #
    # @param list {Array} A list of Strings with the names of the models.
    show_load_json_with_list: (list) ->
        $.mobile.loading("hide")
        @saveloadjsonwidget.set_jsonlist(list)
        login.lm_instance.change_to_user_page()

    # Hide the saveloadjson Popup.
    #
    # Maybe the user canceled?
    hide_saveloadjson: () ->
        @saveloadjsonwidget.hide()

    # Callback for LoginRequests.request_model_list().
    #
    # Retrive the JSON string data and update the load model list.
    # 
    # @param data [string] The JSON string.
    update_saveloadjsonwidget: (data) ->
        try
            list = JSON.parse(data)
        catch error
            $.mobile.loading("hide")
            console.log(error)
            console.log("Couldn't parse and retrieve models list.", data)
        this.show_load_json_with_list(list)

    model_sended: (data) ->
        $.mobile.loading("hide")
        console.log("Model sended...")
        console.log(data)


# @namespace login
# 
# Login representation.
class Login
    # @param json [string]
    # @param loginrequests a LoginRequests instance.
    constructor: (@username, @loginconn = null) ->
        @json = null

    # @param jsonstr [string] The JSON string.
    set_json: (jsonstr) ->
        @json = JSON.parse(jsonstr)

    logged: () ->
        @json.logged

    # Do the login steps connecting to the server and verifying the username
    # and password.
    #
    # @param username {String} The username.
    # @param pass {String} The password.
    do_login: (pass) ->
        @loginconn.request_login(@username, pass,
            (data) ->
                login.lm_instance.update_login(data))
        
    # Clear the login and reset the interface. Send information to the server.
    do_logout: () ->
        @loginconn.request_logout(
            (data) ->
                login.lm_instance.update_logout(data))
        
    # Save the JSON model with the provided name.
    #
    # @param jsonstr [string] The JSON string to save.
    # @param modelname [string] The name of the model.
    save_model: (jsonstr, modelname) ->
        $.mobile.loading("show",
            text: "Sending to the server..."
            textVisible: true
            textonly: false
        )
        @loginconn.send_model(modelname, jsonstr,
            (data) ->
                login.lm_instance.model_sended(data))
        gui.gui_instance.change_to_diagram_page()


    # Retrieve the model from the server and import it.
    #
    # @param modelname {String} The modelname to import.
    load_model: (modelname) ->
        $.mobile.loading("show",
            text: "Retrieving model..."
            textVisible: true,
            textonly: false
        )
        @loginconn.request_model(modelname, gui.update_model)


# @namespace login
# 
# AJAX requet for implementing the login and save-load feature.
#
# # Error Callback
# 
# The default error callback just print in the console the login error.
class LoginRequests
    constructor: () ->
        @default_error_callback = (jqxhr, status, error) ->
            console.log("Login error:")            
            console.log(status)
            console.log(error)
        @error_callback = @default_error_callback

    # Change the error callback.
    #
    # If the function provided is null, then use the default one.
    # 
    # @param fnc [function] a function with three parameters: jqXHR object, text status and the error thrown.
    set_error_callback: (fnc) ->
        if fnc? 
            @error_callback = fnc
        else
            @error_callback = @default_error_callback

    # Send to the server the JSON representatino of the model.
    #
    # @param modelname {string} The model to load
    # @param json {string} The JSON representation.
    # @param callback_function {function} A function to execute when the server answer successfully
    send_model: (modelname, json, callback_function) ->
        url = "api/profiles/save_model.php"
        postdata = "model_name=" + modelname + "&json=" + json
        console.log("Requesting at " + url)
        $.ajax(
            type: "POST",
            url: url,
            data: postdata,
            success: callback_function,
            error: @error_callback
            )
            
    # Send to the server e request for retrieving the model list.
    #
    # @param modelname {string} The model to load
    # @param callback_function {function} A function to execute when the server answer successfully
    request_model: (modelname, callback_function) ->
        url = "api/profiles/retrieve_model.php"
        postdata = "model_name=" + modelname
        console.log("Requesting at " + url)
        $.ajax(
            type: "POST",
            url: url,
            data: postdata,
            success: callback_function,
            error: @error_callback
            )

    # Send to the server a login request.
    #
    # @param [String] username The username.
    # @param [String] pass The password.
    # @param [function] callback_function A function to execute when the POST is successful.
    request_login: (username, pass, callback_function) ->
        postdata = "username=" + username + "&password=" + pass
        url = "api/profiles/login.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "POST",
            url: url,
            data: postdata,
            success: callback_function,
            error: @error_callback
            )

    # Send to the server a logout request.
    #
    # @param [function] callback_function A function to execute when the POST is successful.
    request_logout: (callback_function) ->
        url = "api/profiles/logout.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "GET",
            url: url,
            success: callback_function,
            error: @error_callback
            )

    # Send to the server e request for retrieving the model list.
    #
    # @param callback_function {function} A function to execute when the server answer successfully
    request_model_list: (callback_function) ->
        url = "api/profiles/list_models.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "GET",
            url: url,
            success: callback_function,
            error: @error_callback
            )





exports = exports ? this
exports.login = exports.login ? {}

# @namespace login
#
# Login and Save-Load feature for *crowd*.
exports.login.LoginManager = LoginManager
exports.login.LoginRequests = LoginRequests
exports.login.Login = Login

# Create instance when the document is ready.
$.when($.ready).then(() ->
    exports = exports ? this
    exports.login.lm_instance = new LoginManager()
)
