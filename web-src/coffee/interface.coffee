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

#UML mode
#    newclass = new Class('Person',["name : String", "birthdate : Date"],[])
#    newclass1 = new Class('Student',["id_leg : String", "enrollment : Date"],[])
#    console.log(newclass)
#    guiinst.add_object_type(newclass)
#    guiinst.add_object_type(newclass1)
#ERD mode
    newattribute = new Attribute('name','key')
    newattribute2 = new Attribute('birthdate','normal')
    newclass = new Entity('Person',[newattribute,newattribute2])
    newclass2 = new Entity('Student',[])    
    newISA = new Generalization(newclass,newclass)
    console.log(newISA)
    newlink = new LinkAttrToEntity(['Person', 'name'])
    newlink2 = new LinkAttrToEntity(['Person', 'birthdate'])  
    newlinkISA =  new LinkAttrToEntity(['Person', 'r1'])
    newlinkISA1 =  new LinkEntityToAttr(['r1', 'Student'])
    console.log(newlinkISA)
    console.log(newlinkISA1)
    console.log(newclass)
    console.log(newattribute)
    console.log(newattribute2)
    console.log(newlink)
    console.log(newlink2)
    guiinst.add_object_type(newclass)
    guiinst.add_object_type(newclass2)
    guiinst.add_attribute(newattribute)
    guiinst.add_attribute(newattribute2)
    entity = graph.attributes.cells.models[0].id
    entity2 = graph.attributes.cells.models[1].id    
    attri = graph.attributes.cells.models[2].id
    attri2 = graph.attributes.cells.models[3].id

    guiinst.add_relationship_attr(entity,attri)
    guiinst.add_relationship_attr(entity,attri2)
#ISA    
    guiinst.add_subsumption(newclass,newclass2)
    isa = graph.attributes.cells.models[6].id
    guiinst.add_relationship_attr(entity,isa)
    guiinst.add_relationship_attr_inverse(entity2,isa)


    
    
    