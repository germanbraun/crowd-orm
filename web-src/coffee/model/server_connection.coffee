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

    # Send to the server a "is satisfiable" request
    #
    # @param [String] json String with the JSON data.
    # @param [function] callback_function a function to execute when
    #     the POST is done.
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
        url = @urlprefix + "api/translate/calvanesse.php"
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
