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

# @namespace login
# Widget for login.
LoginWidgetView = Backbone.View.extend(
    initialize: () ->
        @doing_login = true
        this.render()
        # We need to initialize the login-popup div because
        # jquery-mobile.js script is loaded before this script.
        #this.$el.hide()
        $("a#login_login_btn").on("click", this.do_login)
        $("a#logout_logout_btn").on("click", this.do_logout)
    render: () ->
        template = _.template( $("#template_loginwidget").html() )
        this.$el.html( template() )
        this.set_doing_login(@doing_login)

    hide: () ->
        # $("#login-header").
        $("#login-header").collapsible("collapse")

    show: () ->
        this.set_doing_login(@doing_login)
        $("#{login-header}").collapsible("expand")

    # events:
        # "click a#login_cancel_btn" : this.hide
        # "click a#login_login_btn" : "do_login"
    do_login: (event) ->
        console.log("do_login")
        gui.gui_instance.hide_login()
        gui.gui_instance.do_login(
            $("#login_username").val(),
            $("#login_password").val())

    do_logout: (event) ->
        console.log("do_logout")
        gui.gui_instance.hide_login()
        gui.gui_instance.do_logout()

    # Is this widget doing login or logout?
    #
    # Affects the next time it is called the show().
    #
    # @param doing_login {boolean} If true, the next time the dialog is shown it will display the login widgets.
    set_doing_login: (@doing_login) ->
        if @doing_login
            $("#logoutForm").hide()
            $("#loginForm").show()
        else
            $("#loginForm").hide()
            $("#logoutForm").show()

)


exports = exports ? this
exports.login = exports.login ? {}

# @namespace login
#
exports.login.LoginWidgetView = LoginWidgetView
