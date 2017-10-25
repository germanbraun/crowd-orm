# isastate.coffee --
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


# IsA state, the user can select another class for
# create a generalization between them.
#
# @namespace gui
class IsAState extends gui.State
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

    # Set the constraints of the generalization.
    #
    # @param disjoint {Boolean} If childrens are disjoint instances.
    # @param covering {Boolean} If the parent has no instances and are represented as the children ones.
    set_constraint: (@disjoint, @covering) ->
    set_disjoint: (@disjoint) ->
    set_covering: (@covering) ->

    on_cell_clicked: (cellView, event, x, y, gui_instance) ->
        gui_instance.add_subsumption(@cell_starter, cellView.model.id, @disjoint, @covering)

exports.gui.IsAState = IsAState
