# class_options.coffee --
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
exports.views.eer.attributes = exports.views.eer.attributes ? this

# @namespace views
AttrOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_attroptions").html() )
        this.$el.html(template({attrid: @attrid}))

    events:
        "click a#deleteattr_button" : "delete_attr",
        "click a#editattr_button" : "edit_attr"

    ##
    # Set the classid of the Joint Model associated to this EditClass
    # instance, then set the position of the template to where is the
    # class Joint Model.
    set_attrid: (@attrid) ->
        viewpos = graph.getCell(@attrid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y + 50,
            left: viewpos.x - 30,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    ##
    # Return the ClassID of the Joint.Model element associated to
    # this EditClass instance.
    get_attrid: () ->
        return @attrid

    delete_attr: (event) ->
        gui.gui_instance.hide_options()
        gui.gui_instance.delete_attr(@attrid)

    edit_attr: (event) ->
        gui.gui_instance.hide_options()
        gui.gui_instance.set_editclass_classid(@attrid)
        this.hide()

    hide: () ->
        this.$el.hide()
)


exports.views.eer.attributes.AttrOptionsView = AttrOptionsView
