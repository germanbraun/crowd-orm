# diagrama.coffee --
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

# {UMLFactory} = require './factories'

class Diagrama
    ##
    # Params.:
    # * graph: Una instancia de joint.Graph.
    constructor: (@graph = null) ->
        @clases = []
        @links = []
        
        @cells_nuevas = []
        # Cells that are listed for deletion, you have to update
        # diagram for apply.
        @cells_deleted = []
        
        @factory = new UMLFactory()

    get_factory: () ->
        return @factory

    set_factory: (@factory) ->
        
    get_graph: () ->
        return @graph

    set_graph: (@graph) ->

    get_clases: () ->
        return @clases

    get_links: () ->
        return @links

    get_clase: (nombre) ->

    find_class_by_name: (name) ->
        return @clases.find( (elt, index, arr) ->
            elt.get_name() == name
        )
        

    find_class_by_classid: (classid) ->
        return @clases.find( (elt,index,arr) ->
            elt.has_classid(classid)
        )
        
    agregar_clase: (clase) ->
        @clases.push(clase)
        @cells_nuevas.push(clase.get_joint(@factory))
        this.actualizar_graph()

    delete_class: (c) ->
        @clases = @clases.filter( (elt, index, arr) ->
            elt != c
        )
        @cells_deleted.push(c.get_joint())
        this.actualizar_graph()

    rename_class: (classid, name) ->
        c = this.find_class_by_classid(classid)
        if c != null
            c.set_name(name)

    ##
    # Update the view associated to the given class's classid if it
    # have already created its joint object. The view to be updated
    # must be of the given paper
    update_view: (class_id, paper) ->
        class_obj = this.find_class_by_classid(class_id)
        if class_obj != null
            class_obj.update_view(paper)

    ##
    # Remove the class from the diagram.
    delete_class_by_name: (name) ->
        c = this.find_class_by_name(name)
        if c != undefined then this.delete_class(c)

    ##
    # Delete a class selecting by using its Joint Model
    # classid string. 
    delete_class_by_classid: (classid) ->
        c = this.find_class_by_classid(classid)
        if c != undefined then this.delete_class(c)

    agregar_link: (link) ->
        @links.push(link)
        @cells_nuevas.push(link.get_joint(@factory));
        this.actualizar_graph()

    # Actualizar una instancia de joint.Graph con las nuevas celdas.
    actualizar_graph: () ->
        if @graph != null
            @graph.addCell(@cells_nuevas)
            # remove the removed cells
            @cells_deleted.forEach(
                (elt,index,arr) ->
                    elt.remove()
            )                    
        @cells_deleted = []
        @cells_nuevas = []
        

    ##
    # Return a JSON representing the Diagram.
    #
    # We want to send only some things not all the JSON the object
    # has. So, we drop some things, like JointJS graph objects.
    #
    # Use JSON.stringify(json_object) to translate a JSON object to
    # string.
    to_json : () ->
        classes_json = $.map @clases, (myclass) ->
            myclass.to_json()

        links_json = $.map @links, (mylink) ->
            mylink.to_json()

        classes: classes_json
        links: links_json
                
        
exports = exports ? this

exports.Diagrama = Diagrama



