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
exports.views.eer = exports.views.eer ? {}


# EER Toolbar.
#
# Acoplable toolbar for the most common primitives creation.
ToolsEERView = Backbone.View.extend(
    initialize: () ->
        @render()
        @classnum = 0

    render: () ->
        template = _.template( $("#template_tools_eer").html(), {} )
        this.$el.html(template)

    events:
        'click a#eerclass_button': 'umlclass_pressed'
        'click a#eerassoc_button': 'umlassoc_pressed'
        'click a#eerisa_button': 'umlisa_pressed'
        'click a#eerattr_button': 'eerattr_pressed'

    umlclass_pressed: () ->
        @classnum += 1
        gui.gui_instance.add_object_type(
            name: "Class" + @classnum
        )

    eerattr_pressed: () ->
        @classnum += 1
        gui.gui_instance.add_attribute(
            name: "Attr" + @classnum
        )

    umlassoc_pressed: () ->
        console.log('umlassoc')

    umlisa_pressed: () ->
        console.log('umlisa')


)

exports.views.eer.ToolsEERView = ToolsEERView
