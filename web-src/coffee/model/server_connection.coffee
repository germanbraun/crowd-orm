# server_connection.coffee --
# Copyright (C) 2016 Giménez, Christian

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


class ServerConnection
    # @param error_callback {function} which error callback function to use.
    constructor: (@error_callback) ->
        @urlprefix = ""

    set_urlprefix : (str) ->
        @urlprefix = str

    # Send to the server e request for retrieving the model list.
    #
    # @param callback_function {function} A function to execute when the server answer successfully
    request_model_list: (callback_function) ->
        url = @urlprefix + "api/profiles/list_models.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "GET",
            url: url,
            success: callback_function,
            error: @error_callback
            )

    # Send to the server the JSON representatino of the model.
    #
    # @param modelname {string} The model to load
    # @param json {string} The JSON representation.
    # @param callback_function {function} A function to execute when the server answer successfully
    send_model: (modelname, json, callback_function) ->
        url = @urlprefix + "api/profiles/save_model.php"
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
        url = @urlprefix + "api/profiles/retrieve_model.php"
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
    # @param [Stirng] username The username.
    # @param [String] pass The password.
    # @param [function] callback_function A function to execute when the POST is successful.
    request_login: (username, pass, callback_function) ->
        postdata = "username=" + username + "&password=" + pass
        url = @urlprefix + "api/profiles/login.php"
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
        url = @urlprefix + "api/profiles/logout.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "GET",
            url: url,
            success: callback_function,
            error: @error_callback
            )

    # Send to the server a "is satisfiable" request
    #
    # @param [String] json String with the JSON data.
    # @param [function] callback_function a function to execute when the POST is done.
    request_satisfiable: (json, callback_function) ->
        postdata = "json=" + json
        url = @urlprefix + "api/querying/satisfiable.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "POST",
            url: url,
            data: postdata,
            success: callback_function,
            error: @error_callback
            )
        
    # Send to the server a translation Request.
    #
    # @param json {string} 
    # @param format {string} "owllink", "html" or any supported
    #   translation format by the server.
    # @param callback_function A functino to use as a callback when
    #   the response is recieved.
    request_translation: (json, format, callback_function) ->
        url = @urlprefix + "api/translate/crowd.php"
        console.log("Requesting at " + url)
        $.ajax(
            type: "POST",
            url: url,
            data:            
                "format":
                    format
                "json":
                    json
            success:
                callback_function
            error:
                @error_callback
        )

exports = exports ? this
exports.ServerConnection = ServerConnection
