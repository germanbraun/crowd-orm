# edit_class.coffee --
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

exports = exports ? this
exports.views = exports.views ? this
exports.views.eer = exports.views.eer ? this


EditEntityView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_editclass").html())
        this.$el.html(template({classid: @classid}))

    events:
        "click a#editclass_button" : "edit_class"
        "click a#close_button" : "hide"

    # Set this class ID and position the form onto the
    #
    # Class diagram.
    set_classid : (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y + 50,
            left: viewpos.x,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    get_classid : () ->
        return @classid

    edit_class: (event) ->
        name = $("#editclass_input").val()
        gui.gui_instance.edit_class_name(@classid, name)
        # Hide the form.
        gui.gui_instance.hide_options()

    hide: () ->
        this.$el.hide()

)


exports.views.eer.EditEntityView = EditEntityView
