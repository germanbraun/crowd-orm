# login_widget.coffee --
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


LoginWidgetView = Backbone.View.extend(
    initialize: () ->
        this.render()
        # We need to initialize the login-popup div because
        # jquery-mobile.js script is loaded before this script.
        this.$el.find(".login-popup").popup()
        #this.$el.hide()
        $("a#login_cancel_btn").on("click", this.hide)
        $("a#login_login_btn").on("click", this.do_login)
    render: () ->
        template = _.template( $("#template_loginwidget").html() )
        this.$el.html( template() )
    show: () ->
        $(".login-popup").popup("open")
    # events:
        # "click a#login_cancel_btn" : this.hide
        # "click a#login_login_btn" : "do_login"
    hide: (event) ->
        $(".login-popup").popup("close")
    do_login: (event) ->
        console.log("do_login")
        gui.gui_instance.hide_login()
        gui.gui_instance.do_login(
            $("#login_username").val(),
            $("#login_password").val())
        

)

        

exports = exports ? this
exports.LoginWidgetView = LoginWidgetView

