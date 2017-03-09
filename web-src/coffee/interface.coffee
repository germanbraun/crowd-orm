# interface.coffee --
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


# {Diagram} = require './diagram'
# {Class} = require './mymodel'

# ---------------------------------------------------------------------- 

window.onload = () ->
    # Un poco de aliasing para acortar el código.
#    uml = joint.shapes.uml;

    graph = new joint.dia.Graph
    paper = new joint.dia.Paper(
        el: $('#container')
        width: 2000
        height: 1000
        model: graph
        gridSize: 1
    )

    guiinst = new gui.GUI(graph, paper)
    gui.set_current_instance(guiinst)
    
 
    # Interface
    
    # Events for the Paper

    # A Cell was clicked: select it.
    paper.on("cell:pointerclick",
        (cellView, evt, x, y) ->
            guiinst.on_cell_clicked(cellView, evt, x, y)
    )

    # paper.on("cell:pointerdblclick",
    #     (cellView, evt, x, y) ->
    #         if classoptions != null then classoptions.hide()
    #         editclass = new EditClassView({el: $("#editclass")})
    #         editclass.set_classid(cellView.model.id)
    
    # )
        
    # CreateClassView instance
    exports = exports ? this
    
    exports.graph = graph
    exports.paper = paper
    exports.guiinst = guiinst

    # Create a first example class
    newclass = new Class("Classssssss", ["attribute":"STRING"], ["method"])
    console.log(newclass)
    guiinst.add_object_type(newclass)


