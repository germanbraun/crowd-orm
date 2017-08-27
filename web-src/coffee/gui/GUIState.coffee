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


exports = exports ? this
exports.gui = exports.gui ? {}

# Abstract class that helps determine how the interface
# should respond to a user action depending on the current
# state.

# @abstract
# @namespace gui
class State
    constructor: () ->
        @selectionstate_inst = new gui.SelectionState()
        @associationstate_inst = new gui.AssociationState()
        @isastate_inst = new gui.IsAState()

    # What to do when the user clicked on a cell.
    #
    # @abstract
    on_cell_clicked: (cellView, event, x, y, gui_instance) ->

    selection_state: () ->
        return @selectionstate_inst
        
    association_state: () ->
        return @associationstate_inst

    isa_state: () ->
        return @isastate_inst



exports.gui.State = State

# The gui.State instance currently running.
#
# **Don't access this property!*** use gui.get_state().
#
# @see gui.get_state()
# @namespace gui
exports.gui.gui_inst = null

# The current gui.State instance.
#
# @namespace gui
exports.gui.get_state = () ->
    if ! gui.gui_inst?
       gui.gui_inst = new gui.State()
    gui.gui_inst

