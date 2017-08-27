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
exports.views = exports.views ? this


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

    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y + viewpos.height * 2,
            left: viewpos.x + viewpos.width/2,
            position: 'absolute',
            'z-index': 1
            )

    # Show this widget.
    #
    # @param callback_fnc [function] Optional. A callback function without parameters. If not setted, then use the default.
    show: (classid, callback_fnc = null) ->
        this.set_classid(classid)
        this.set_callback(callback_fnc)
        this.$el.show()
)


exports.views.DoneWidget = DoneWidget
