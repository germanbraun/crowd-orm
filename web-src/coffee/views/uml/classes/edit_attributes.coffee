# edit_attributes.coffee --
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
exports.views.uml = exports.views.uml ? this
exports.views.uml.classes = exports.views.uml.classes ? this

EditAttributes = Backbone.View.extend(
    initialize: () ->
        this.render()

    render: () ->
        template = _.template( $("#template_edit_attributes").html(), {} )
        this.$el.html(template)

    events:
        "click a#umladd_attr_button": "add_attr"
        "click a#umlback_attr_button": "back"

    set_classid: (@classid) ->

    show: () ->
        this.$el.show()

    hide: () ->
        this.$el.hide()

    add_attr: () ->
        $("input#umlattr_input").val()
    back: () ->
        
)

exports.views.uml.classes.EditAttributes = EditAttributes
