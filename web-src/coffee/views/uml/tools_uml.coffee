# tools_uml.coffee --
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
exports.views.uml = exports.views.uml ? this


# UML Toolbar.
#
# Acoplable toolbar for the most common primitives creation.
ToolsUMLView = Backbone.View.extend(
    initialize: () ->
        @render()
        @classnum = 0

    render: () ->
        template = _.template( $("#template_tools_uml").html(), {} )
        this.$el.html(template)

    events:
        'click a#umlclass_button': 'umlclass_pressed'
        'click a#umlassoc_button': 'umlassoc_pressed'
        'click a#umlisa_button': 'umlisa_pressed'

    umlclass_pressed: () ->
        @classnum += 1
        gui.gui_instance.add_object_type(
            name: "Class" + @classnum
        )

    umlassoc_pressed: () ->
        console.log('umlassoc')

    umlisa_pressed: () ->
        console.log('umlisa')
)

exports.views.uml.ToolsUML = ToolsUMLView
