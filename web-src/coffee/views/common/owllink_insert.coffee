# owllink_insert.coffee --
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


##
# A view for inserting and editing OWLlink text.
OWLlinkInsertView = Backbone.View.extend(
    initialize: () ->
        this.render()
        @textarea = this.$el.find("#insert_owllink_input")
        
    render: () ->
        template = _.template( $("#template_insertowllink").html() )
        this.$el.html( template() )

    events:
        "click a#insert_owlclass" : "insert_class"

    get_owllink: () ->
        return @textarea[0].value
        
    set_owllink: (str) ->
        @textarea[0].value = str

    append_owllink: (str) ->
        @textarea[0].value = @textarea[0].value + str

    insert_class: () ->
        this.append_owllink("<owl:Class IRI=\"CLASSNAME\" />")
)

        

exports.views.OWLlinkInsertView = OWLlinkInsertView
