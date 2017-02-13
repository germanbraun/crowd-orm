# GUIState.coffee --
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


# Abstract class that helps determine how the interface
# should respond to a user action depending on the current
# state.
#
# @abstract
class State
    constructor: () ->
        @selectionstate_inst = new SelectionState()
        @associationstate_inst = new AssociationState()
        @isastate_inst = new IsAState()

    # What to do when the user clicked on a cell.
    #
    # @abstract
    on_cell_clicked: (cellView, event, x, y, gui) ->

    selection_state: () ->
        return @selectionstate_inst
        
    association_state: () ->
        return @associationstate_inst

    isa_state: () ->
        return @isastate_inst

# Selection state, the user can select some classes.
class SelectionState extends State
    constructor: () ->
        
    on_cell_clicked: (cellView, event, x, y, gui) ->
        if (cellView.highlighted == undefined or cellView.highlighted == false) 
            cellView.highlight()
            cellView.highlighted = true

            # classoptions = new ClassOptionsView({el: $("#classoptions")})
            gui.set_options_classid(cellView.model.id)

        else
            cellView.unhighlight()
            cellView.highlighted = false
            gui.hide_options()
            


# Association state, the user can select another class for
# create an association between them.
class AssociationState extends State
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
    on_cell_clicked: (cell_view, event, x, y, gui) ->
        if @with_class
            gui.add_association_class(@cell_starter, cell_view.model.id, @name, @mult, @roles)
        else
            gui.add_association(@cell_starter, cell_view.model.id, @name, @mult, @roles)

        this.reset()


# IsA state, the user can select another class for
# create a generalization between them.
class IsAState extends State
    constructor: () ->
        this.reset()

    # Reset the state information to the default values.
    reset: () ->
        @disjoint = false
        @covering = false
        @cell_starter = null

    # Set the parent Cell Id.
    #
    # @param cell_starter {string} the parent Cell Id. 
    set_cellStarter: (@cell_starter) ->

    # Set the constrints of the generalization.
    #
    # @param disjoint {Boolean} If childrens are disjoint instances.
    # @param covering {Boolean} If the parent has no instances and are represented as the children ones.
    set_constraint: (@disjoint, @covering) ->
    set_disjoint: (@disjoint) ->
    set_covering: (@covering) ->

    on_cell_clicked: (cell_view, event, x, y, gui) ->
        gui.add_generalization(@cell_starter, cell_view.model.id, @disjoint, @covering)
        this.reset()

                  
        
exports = exports ? this
if exports.gui == undefined
    exports.gui = {}
exports.gui.state_inst = new State()
exports.gui.SelectionState = SelectionState
exports.gui.AssociationState = AssociationState
exports.gui.IsAState = IsAState
