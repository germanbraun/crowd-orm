# gui.coffee --
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


class GUI
    constructor: (@graph, @paper) ->
        @diag = new Diagrama(@graph)
        @state = gui.State.selectionstate
        @crearclase = new CrearClaseView({el: $("#crearclase")});
        @editclass = new EditClassView({el: $("#editclass")})
        @classoptions = new ClassOptionsView({el: $("#classoptions")})
        @relationoptions = new RelationOptionsView({el: $("#relationoptions")})
        @trafficlight = new TrafficLightsView({el: $("#trafficlight")})

    ##
    # What to do when the user clicked on a cellView.
    on_cell_clicked: (cellview, event, x, y) ->
        @state.on_cell_clicked(cellview, event, x, y, this)

    ##
    # Set the class Id of the class options GUI.
    set_options_classid: (model_id) ->
        @relationoptions.set_classid(model_id)
        @classoptions.set_classid(model_id)

    ##
    # Hide the class options GUI.
    hide_options: () ->
        @classoptions.hide()
        @relationoptions.hide()

    ##
    # Add a class to the diagram.
    #
    # Params.:
    #  class_inst = A Class instance.
    add_class: (class_inst) ->
        @diag.agregar_clase(class_inst)

exports = exports ? this
if exports.gui == undefined
    exports.gui = {}
exports.gui.GUI = GUI

