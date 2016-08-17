# diagram.coffee --
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

#
# A diagram representation.
# 
class Diagram
    #
    # @param [joint.Graph] graph
    # 
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

    # Find a generalization that contains the given parent
    #
    # @param parentclass {Class} A Class instance that is the parent of the
    #     generalization.
    # @return null if nothing founded, a Generalization instance otherwise.
    find_IsA_with_parent: (parentclass) ->
        return @links.find( (elt, index, arr) ->
            elt.has_parent(parentclass)
        )

    # Add a Generalization link.
    #
    # If a generalziation already exists for the same parent, just add the class
    # into the same Generalizatino instance.
    #
    # @param class_parent_id {string} The parent class Id.
    # @param class_child_id {string} The child class Id.
    #
    # @todo Support various children on parameter class_child_id.
    add_generalization: (class_parent_id, class_child_id) ->
        class_parent = this.find_class_by_classid(class_parent_id)
        class_child = this.find_class_by_classid(class_child_id)

        gen = this.find_IsA_with_parent(class_parent)
        if (gen is undefined) || (gen is null)
            gen = new Generalization(class_parent, [class_child])
            this.agregar_link(gen)
        else
            gen.add_child(class_child)
    
    # @param class_a_id {string} the ID of the first class.
    # @param class_b_id {string} the ID of the second class.
    # @param name {string} optional. The name of the association.
    # @param mult {array} optional. An array of two strings with the cardinality from class a and to class b.
    add_association: (class_a_id, class_b_id, name = null, mult = null) ->
        class_a = this.find_class_by_classid(class_a_id)
        class_b = this.find_class_by_classid(class_b_id)
        
        newassoc = new Link([class_a, class_b])
        if (mult != null)
            newassoc.set_mult(mult)
        
        this.agregar_link(newassoc)

    #
    # # Hash Data
    # 
    # * `name`    (mandatory)
    # * `attribs` (optional)
    # * `methods` (optional)
    #
    # @example Adding a class
    #   diagram_instance.add_class({name: "class A"})
    #   diagram_instance.add_class({name: "class B", ["attrib1", "attrib2"], ["method1", "method2"]})
    # 
    #   
    # @param hash_data {Hash} data information for creating the new {Class} instance.
    # @see Class
    # @see GUI#add_class
    add_class: (hash_data) ->
        if hash_data.attribs == undefined
            hash_data.attribs = []
        if hash_data.methods == undefined
            hash_data.methods = []
        
        newclass = new Class(hash_data.name, hash_data.attribs, hash_data.methods)
        this.agregar_clase(newclass)

    agregar_clase: (clase) ->
        @clases.push(clase)
        @cells_nuevas.push(clase.get_joint(@factory, csstheme))
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

    
    # Update the view associated to the given class's classid if it
    # have already created its joint object. The view to be updated
    # must be of the given paper
    update_view: (class_id, paper) ->
        class_obj = this.find_class_by_classid(class_id)
        if class_obj != null
            class_obj.update_view(paper)

    
    # Remove the class from the diagram.
    delete_class_by_name: (name) ->
        c = this.find_class_by_name(name)
        if c != undefined then this.delete_class(c)

    
    # Delete a class selecting by using its Joint Model
    # 
    # @param [classid] string. 
    delete_class_by_classid: (classid) ->
        c = this.find_class_by_classid(classid)
        if c != undefined then this.delete_class(c)

    # # Limitations
    # If the link is a generalization it adds as a new generalization,
    # not as part of another one.
    #
    # For example, if you want to add another child into an already existent
    # generalization, use add_generalization(same_parent, new_child) message.
    agregar_link: (link) ->
        @links.push(link)       
        @cells_nuevas.push(link.get_joint(@factory, csstheme));
        this.actualizar_graph()

    # Update a joint.Graph instance with the new cells.
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

exports.Diagram = Diagram



