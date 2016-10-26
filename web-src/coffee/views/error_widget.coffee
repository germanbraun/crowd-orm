# error_widget.coffee --
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



ErrorWidgetView = Backbone.View.extend(
    initialize: () ->
        this.render()
        # We need to initialize the error-popup div because
        # jquery-mobile.js script is loaded before this script.
        this.$el.find(".error-popup").popup()
        #this.$el.hide()
    render: () ->
        template = _.template( $("#template_errorwidget").html() )
        this.$el.html( template() )
    show: (status, message) ->
        $(".error-popup").popup("open")
        $("#errorstatus_text").html(status)
        $("#errormsg_text").html(message)
        console.log(status + " - " + message)
    events:
        "click a#errorwidget_hide_btn" : "hide"
    hide: () ->
        $(".error-popup").popup("close")
)

        

exports = exports ? this
exports.ErrorWidgetView = ErrorWidgetView
