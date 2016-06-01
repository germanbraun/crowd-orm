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
class State
    constructor: () ->
        @selection_state = new SelectionState()
        @association_state = new AssociationState()

    ## 
    # What to do when the user clicked on a cell.
    on_cell_clicked: (cellView, event, x, y, gui) ->

    selectionstate: () ->
        return @selection_state
        
    associationstate: () ->
        return @association_state

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

    set_cellStarter: (@cell_starter) ->

    on_cell_clicked: (cell_view, event, x, y, gui) ->
        gui.add_association(@cell_starter, cell_view.model.id)
        @cell_starter = null;
        
exports = exports ? this
if exports.gui == undefined
    exports.gui = {}
exports.gui.State = new State()
exports.gui.SelectionState = SelectionState
exports.gui.AssociationState = AssociationState
