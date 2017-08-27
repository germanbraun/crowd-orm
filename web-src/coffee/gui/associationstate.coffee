# associationstate.coffee --
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
exports.gui = exports.gui ? {}


# Association state, the user can select another class for
# create an association between them.
#
# @namespace gui
class AssociationState extends gui.State
    constructor: () ->
        @cell_starter = null
        @mult = null
        @with_class = false
        @name = null
        @roles = null

    # Reset the state restoring its default values.
    reset: () ->
        @cell_starter = null
        @with_class = false
        @name = null

    set_cellStarter: (@cell_starter) ->

    # Set the association's multiplicity that the user gave.
    # 
    # @param mult [Array] An array with two strings. 
    set_mult: (@mult) ->
        
    # Set the association's roles that the user gave.
    # 
    # @param roles [Array] An array with two strings.
    set_roles: (@roles) ->
    set_cardinality: (@mult) ->
    set_name: (@name) ->

    # Create an association with class? 
    #
    # By default is false. Set to true if you have setted the name before.
    #
    # @param with_class [boolean] True if an association with class is needed.
    # @see #enable_with_class
    set_with_class: (with_class) ->
        if @name?
            @with_class = with_class
        else
            @with_class = false
    # Ensure to create an association with class.
    #
    # `associationstate.enable_with_class("a name")` is the same as:
    # 
    # @example Same as
    #   associationstate.set_name("a name")
    #   associationstate.set_with_class(true)
    #
    # @param name [String] The name for the association class.
    # @see #set_with_class
    enable_with_class: (@name) ->
        @with_class = true

    # What to do when the user clicks on another cell.
    #
    # @param cell_view [joint.dia.CellView] The cell view that recieves the click event.
    # @param event [Event] The event object representation. {https://developer.mozilla.org/en-US/docs/Web/API/Event/Event}
    # @param x [int] Where's the X coordinate position where the mouse has clicked.
    # @param y [int] Where's the Y coordinate position where the mouse has clicked.
    # @param gui [GUI] A the current GUI instance.
    on_cell_clicked: (cell_view, event, x, y, gui_instance) ->
        if @with_class
            gui_instance.add_association_class(@cell_starter, cell_view.model.id, @name, @mult, @roles)
        else
            gui_instance.add_relationship(@cell_starter, cell_view.model.id, @name, @mult, @roles)

        this.reset()


exports.gui.AssociationState = AssociationState
