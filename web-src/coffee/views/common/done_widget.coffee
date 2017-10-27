# done_widget.coffee --
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

exports = exports ? this
exports.views = exports.views ? {}


# Widget with a "done" button.
DoneWidget = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()
        @classid = null
        @callback = () ->
            console.log "Done clicked"

    render: () ->
        template = _.template( $("#template_done_widget").html() )
        this.$el.html(template({classid: @classid}))

    events:
        "click a#done_button" : "done_clicked"

    # What to do when the user clicks on the "Done" button.
    #
    # This is a callback function.
    done_clicked: (event) ->
        @callback()
        @hide()

    # Change the callback function that will be called when the user clicked on
    # the button.
    #
    # @param fnc [function] A callback function without parameters.
    set_callback: (fnc) ->
        if fnc?
            @callback = fnc
        else
            @callback = () ->
                console.log "Done clicked"

    # Hide this widget.
    hide: () ->
        this.$el.hide()

    # Set the position of the widget.
    #
    # @param x {number} The CSS X (alias "left") coordinate.
    # @param y {number} The CSS Y (alias "top") coordinate.
    set_pos: (@x, @y) ->
        this.$el.css(
            top: @y
            left: @x
            position: 'absolute',
            'z-index': 1
            )

    # Show this widget.
    #
    # @param pos {object} Optional. The position, for example: `{x: 10, y: 20}`
    # @param callback_fnc [function] Optional. A callback function without parameters. If not setted, then use the default.
    show: (pos = null, callback_fnc = null) ->
        if pos?
            this.set_pos(pos.x, pos.y)
        this.set_callback(callback_fnc)
        this.$el.show()
)


exports.views.DoneWidget = DoneWidget
