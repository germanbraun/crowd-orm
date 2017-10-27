# selectionstate.coffee --
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


# Selection state, the user can select some classes.
#
# @namespace gui
class SelectionState extends gui.State
    constructor: () ->

    on_cell_clicked: (cellView, event, x, y, gui_instance) ->
        if (cellView.highlighted == undefined or cellView.highlighted == false)
            cellView.highlight()
            cellView.highlighted = true

            # classoptions = new ClassOptionsView({el: $("#classoptions")})
            gui_instance.set_options_classid(cellView.model.id)

        else
            cellView.unhighlight()
            cellView.highlighted = false
            gui_instance.hide_options()


exports.gui.SelectionState = SelectionState
