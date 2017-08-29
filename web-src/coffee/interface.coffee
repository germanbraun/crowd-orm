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

    # We add available GUIs. The last will be the current one.
    guiinst.add_gui('eer', new gui.GUIEER())
    gui.gui_instance.add_gui('uml', new gui.GUIUML())
    
 
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

    # Export the graph for debugging.
    exports.graph = graph
    # Export the paper for debugging.    
    exports.paper = paper
    # Export the guiinst for easy debugging.
    exports.guiinst = guiinst

    # Create a first example class

    #UML mode
    newclass = new model.uml.Class('Person',["dni : String","firstname : String", "surname : String", "birthdate : Date"],[])
    newclass1 = new model.uml.Class('Student',["id : String", "enrolldate : Date"],[])
    console.log(newclass)
    gui.gui_instance.add_object_type(newclass)
    gui.gui_instance.add_object_type(newclass1)
 #ERD mode

#    newattribute = new Attribute('dni','normal')
#    newattribute2 = new Attribute('firstname','normal')
#    newattribute3 = new Attribute('surname','normal')   
#    newattribute4 = new Attribute('birthdate','normal')
#    newattribute5 = new Attribute('id','normal')
#    newattribute6 = new Attribute('enrolldate','normal')
        
#    newclass = new Entity('Person',[newattribute,newattribute2,newattribute3,newattribute4])
#    newclass2 = new Entity('Student',[newattribute5,newattribute6])
#    newlink = new LinkAttrToEntity(['Person', 'dni'])
#    newlink2 = new LinkAttrToEntity(['Person', 'firstname'])
#    newlink3 = new LinkAttrToEntity(['Person', 'surname'])
#    newlink4 = new LinkAttrToEntity(['Person', 'birthdate'])
#    newlink5 = new LinkAttrToEntity(['Student', 'id'])
#    newlink6 = new LinkAttrToEntity(['Student', 'enrolldate']) 
#    newISA = new Generalization(newclass2,newclass)
#    console.log(newISA)       
#    newlinkISA =  new LinkISAToEntity(['Person', 'r1'])
#    newlinkISA1 =  new LinkISAToEntity(['r1', 'Student'])
#    console.log(newlinkISA)
#    console.log(newlinkISA1)
#    console.log(newclass)
#    console.log(newattribute)
#    console.log(newattribute2)
#    console.log(newlink)
#    console.log(newlink2)
#    guiinst.add_object_type(newclass)
#    guiinst.add_object_type(newclass2)
#    guiinst.add_attribute(newattribute)
#    guiinst.add_attribute(newattribute2)
#    guiinst.add_attribute(newattribute3)
#    guiinst.add_attribute(newattribute4)    
#    guiinst.add_attribute(newattribute5)
#    guiinst.add_attribute(newattribute6)
      
#    entity = graph.attributes.cells.models[0].id
#    entity2 = graph.attributes.cells.models[1].id    
#    attri = graph.attributes.cells.models[2].id
#    attri2 = graph.attributes.cells.models[3].id
#    attri3 = graph.attributes.cells.models[4].id
#    attri4 = graph.attributes.cells.models[5].id
#    attri5 = graph.attributes.cells.models[6].id
#    attri6 = graph.attributes.cells.models[7].id                
#    guiinst.add_relationship_attr(entity,attri)
#    guiinst.add_relationship_attr(entity,attri2)
#    guiinst.add_relationship_attr(entity,attri3)
#    guiinst.add_relationship_attr(entity,attri4)
#    guiinst.add_relationship_attr(entity2,attri5)
#    guiinst.add_relationship_attr(entity2,attri6)    
#ISA 
#    guiinst.add_subsumption(newclass2,newclass)
#    isa = graph.attributes.cells.models[14].id
#    guiinst.add_relationship_isa(entity,isa)
#    guiinst.add_relationship_isa_inverse(entity2,isa)


    
    
    
