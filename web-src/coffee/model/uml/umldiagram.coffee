# umldiagram.coffee --
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

exports = exports ? this
exports.model = exports.model ? {}
exports.model.uml = exports.model.uml ? {}

#
# A UML diagram representation.
#
# @namespace model.uml
class UMLDiagram extends model.Diagram
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
        
        @factory = new model.uml.UMLFactory()

        # Add events to the graph
        if @graph?
            this._add_events()

    get_factory: () ->
        return @factory

    set_factory: (@factory) ->
        
    get_graph: () ->
        return @graph

    set_graph: (@graph) ->
        this._add_events()

    # Add events to the joint.Graph instance assigned to @graph
    _add_events: () =>
        @graph.on('remove', (event) =>
            if event.attributes.type == 'link'
                link = this.delete_link_by_id(event.id)
        )

    get_clases: () ->
        return @clases

    get_links: () ->
        return @links

    get_clase: (nombre) ->

    # # Find Primitive Messages
    # ---
    #
    # @param name {String}
    # @return {Class} The first class founded that have the given name.
    find_class_by_name: (name) ->
        return @clases.find( (elt, index, arr) ->
            elt.get_name() == name
        )

    # @param classid {String}
    # @return {Class} The class with the provided ClassID
    find_class_by_classid: (classid) ->
        return @clases.find( (elt,index,arr) ->
            elt.has_classid(classid)
        )

    # @param linkid {String}
    # @return {Link} The MyModel's link.
    find_link_by_id: (linkid) ->
        @links.find( (elt, index, arr) ->
            elt.has_classid(linkid)
        )

    # Find a generalization that contains the given parent
    #
    # @param parentclass {Class} A Class instance that is the parent of the
    #     generalization.
    # @return {Generalization} null if nothing founded, a Generalization instance otherwise.
    find_IsA_with_parent: (parentclass) ->
        return @links.find( (elt, index, arr) ->
            elt.has_parent(parentclass)
        )

    # Find the Link instances with the given name.
    # 
    # @param name {string}
    # @return {Array}
    find_links_by_name: (name) ->
        return @links.filter( (elt) ->
            elt.name == name
        )

    # Add a Generalization link.
    #
    # If a generalziation already exists for the same parent, just add the class
    # into the same Generalization instance. Constraints are ignored in this case.
    #
    # This methods try to normalize all parameters  and then call add_generalization_objs().
    #
    # @param class_parent {string, object} The parent class Id string or the class_parent Class object.
    # @param class_child_id {string, array of strings, array of objects, object} The child class string, an array of class Ids strings, an array of Class objects or the child object.
    #
    add_generalization: (class_parent, class_childs, disjoint=false, covering=false) ->
        class_parent_obj = null
        class_child_obj = null

        # Normalize class_parent
        if typeof(class_parent) == "string"
            # class_parent is an Id string
            class_parent_obj = this.find_class_by_classid(class_parent)
        else if typeof(class_parent) == "object"
            # class_parent is the Class instance
            class_parent_obj = class_parent

        # Normalize class_childs        
        if class_childs instanceof Array
            # class_child is an Array, add one by one...
            class_childs.forEach( (child) ->
                # child could be a string or obj, it doesn't matter! :-)
                this.add_generalization(class_parent, child, disjoint, covering)
            this)
        else if typeof(class_childs) == "string"
            # class_child is an Id string
            class_child_obj = this.find_class_by_classid(class_childs)
        else if typeof(class_childs) == "object"
            # class_child is the Class instance
            class_child_obj = class_childs

        if class_child_obj? and class_parent_obj?
            this.add_generalization_objs(class_parent_obj, class_child_obj, disjoint, covering)

    # Add a Generalization link.
    #
    # If a generalziation already exists for the same parent, just add the class
    # into the same Generalizatino instance. Constraints are ignored in this case.
    #
    # @param class_parent {Class instance} A Class object.
    # @param class_child {Class instance} A Class object.
    #
    add_generalization_objs: (class_parent, class_child, disjoint=false, covering=false) ->
        gen = this.find_IsA_with_parent(class_parent)
        if (gen is undefined) || (gen is null)
            gen = new model.uml.Generalization(class_parent, [class_child])
            gen.set_disjoint(disjoint)
            gen.set_covering(covering)
            this.agregar_link(gen)
        else
            gen.add_child(class_child)
            gen.create_joint(@factory, csstheme)
            @cells_nuevas.push(gen.get_joint_for_child(class_child))
            this.actualizar_graph()
    
    # @param class_a_id {string} the ID of the first class.
    # @param class_b_id {string} the ID of the second class.
    # @param name {string} optional. The name of the association.
    # @param mult {array} optional. An array of two strings with the cardinality from class a and to class b.
    # @param roles {array} optional. An array of two strings with the from and to roles.
    add_association: (class_a_id, class_b_id, name = null, mult = null, roles = null) ->
        class_a = this.find_class_by_classid(class_a_id)
        class_b = this.find_class_by_classid(class_b_id)
        
        newassoc = new model.uml.Link([class_a, class_b], name)
        if (mult isnt null)
            newassoc.set_mult(mult)
        if (roles isnt null)
            newassoc.set_roles(roles)
        
        this.agregar_link(newassoc)

    add_association_class: (class_a_id, class_b_id, name, mult = null, roles= null) ->
        class_a = this.find_class_by_classid(class_a_id)
        class_b = this.find_class_by_classid(class_b_id)
        
        newassoc = new model.uml.LinkWithClass([class_a, class_b], name)
        if (mult isnt null)
            newassoc.set_mult(mult)
        if (roles isnt null)
            newassoc.set_roles(roles)
        
        this.agregar_link(newassoc)
        newassoc.update_position()

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
    # @return {Class} The new class
    # @see Class
    # @see GUI#add_class
    add_class: (hash_data) ->
        if ! hash_data.attrs?
            hash_data.attrs = []
        if ! hash_data.methods?
            hash_data.methods = []
        
        newclass = new model.uml.Class(hash_data.name, hash_data.attrs, hash_data.methods)
        this.agregar_clase(newclass)
        return newclass

    agregar_clase: (clase) ->
        @clases.push(clase)
        @cells_nuevas.push(clase.get_joint(@factory, csstheme))
        this.actualizar_graph()

    # @param c {Class instance}. 
    delete_class: (c) ->
        @clases = @clases.filter( (elt, index, arr) ->
            elt != c
        )

        this.remove_associated_links(c)
        
        @cells_deleted = @cells_deleted.concat(c.get_joint())
        this.actualizar_graph()

    # Search for all links associated to the given class.
    #
    # @param c {Class instance} The class.
    # 
    # @return Array of Links instances.
    find_associated_links: (c) ->
        @links.filter( (link, indx, arr) ->
            link.is_associated(c)
        this)
    
    # Remove all links associated to the given class.
    #
    # @param c {Class instance} The class.
    remove_associated_links: (c) ->
        lst = this.find_associated_links(c)
        lst.forEach( (link, indx, arr) ->
            this.delete_link(link)
        this)

    rename_class: (classid, name) ->
        c = this.find_class_by_classid(classid)
        if c != null
            c.set_name(name)

    # Remove the link by its Joint CellID from the diagram.
    #
    # @param linkid [string] the Joint CellID.
    delete_link_by_id: (linkid) ->
        link = this.find_link_by_id(linkid)
        if link?
            this.delete_link(link)

    # Remove the given link from the diagram.
    # 
    # @param link {Link instance} The link to remove.
    delete_link: (link) ->
        @links = @links.filter( (elt, index, arr) ->
            elt != link
        )
       
        @cells_deleted = @cells_deleted.concat(link.get_joint())
        this.actualizar_graph()

    
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

    # Reset the current diagram to start over empty.
    #
    # Remove all classes and associations.
    reset: () ->
        # Associations is supposed to be deleted after each classes has
        @clases.forEach( (c, i, arr) ->
            this.delete_class(c)
        this)
        this.actualizar_graph()
        

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

    # Show these classes as satisifiable.
    #
    # @see set_class_satisfiable
    #
    # @param classes_list {Array<String>} a list of classes names.
    set_satisfiable: (classes_list) ->
        classes_list.forEach( (class_name, i, arr) ->
            this.set_class_satisfiable(class_name)
        this)

    # # Satisfiability
    # Satifiability objects managent messages.
    # ---
    #  
    # Show this class as satisfiable.
    #
    # @param class_name {String} The class name.
    set_class_satisfiable: (class_name) ->
        c = this.find_class_by_name(class_name)
        if c?
            c.set_unsatisfiable(false, csstheme)

    # Show these classes as unsatisifiable.
    #
    # @see set_class_unsatisfiable
    #
    # @param classes_list {Array<String>} a list of classes names.
    set_unsatisfiable: (classes_list) ->
        classes_list.forEach( (class_name, i, arr) ->
            this.set_class_unsatisfiable(class_name)
        this)

    # Show this class as unsatisfiable.
    #
    # @param class_name {String} The class name.
    set_class_unsatisfiable: (class_name) ->
        c = this.find_class_by_name(class_name)
        if c?
            c.set_unsatisfiable(true, csstheme)

    # # JSON Import/Export
    # Messages for supporting JSON translation.
    # ---
    # 
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
                
    # Import all classes and associations from a JSON object.
    #
    # Make sure to reset() this diagram if you don't want the classes already
    # on this model.
    # 
    # @param json {JSON object} a JSON object. Use json = JSON.parse(jsonstr) to retrieve from a string.
    # 
    # @todo Better programmed it would be if we pass a JSON part to the constructor of each model class. Leaving the responsability of each MyModel class to create itself.
    import_json: (json) ->
        json.classes.forEach(
            (elt, index, arr) ->
            	if elt.attrs?
            		array = []
            		attr = elt.attrs
            		attr.forEach( (cv,index,attr) -> 
            			att = "#{attr[index].name}:#{attr[index].datatype}"
            			array.push(att)
            			return array
            			)
            	elt.attrs = []
            	elt.attrs = array
            	c = this.add_class(elt)
            	c.get_joint()[0].position(
                    elt.position.x,
                    elt.position.y)
        this)
        # associations
        json.links.forEach(
            (elt, index, arr) ->
                if elt.type is "association"
                    class_a = this.find_class_by_name(elt.classes[0])
                    class_b = this.find_class_by_name(elt.classes[1])
                    if elt.associated_class?
                        this.add_association_class(
                            class_a.get_classid(),
                            class_b.get_classid(),
                            elt.name,
                            elt.multiplicity,
                            elt.roles)
                    else
                        this.add_association(
                            class_a.get_classid(),
                            class_b.get_classid(),
                            elt.name,
                            elt.multiplicity,
                            elt.roles)
                if elt.type is "generalization"
                    class_parent = this.find_class_by_name(elt.parent)
                    classes_children = elt.classes.map(
                        (childname) ->
                            this.find_class_by_name(childname)
                    this)
                    disjoint = elt.constraint.includes("disjoint")
                    covering = elt.constraint.includes("covering")
                    this.add_generalization(
                        class_parent,
                        classes_children,
                        disjoint, covering)
                                
        this)

    # # Joint Graph Management
    # ---
    # 
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

    # # Comparing Diagrams
    # ---
    #
    # Two diagram are equivalents if has the same classes and links with
    # the same names and attributes.
    #
    # @return {boolean} 
    same_elts: (diag) ->
        if @clases.length != diag.clases.length
            return false
        if @links.length != diag.links.length
            return false

        # Check if all classes are the same
        all_same = true
        @clases.forEach( (c) ->
            c2 = diag.find_class_by_name(c.name)
            if c2?
                all_same = all_same && c2.same_elts(c)
            else
                all_same = false
        )
        if !all_same
            return false

        # Check if all the links are the same
        # all_same = true # not needed
        @links.forEach( (l) ->
            l2 = diag.find_links_by_name(l.name)
            # At least one of the links must be the same.
            one_same = false
            l2.forEach( (l2b) ->
                one_same = one_same || l.same_elts(l2b)
            )
            all_same = all_same && one_same
        )
        
        return all_same
        

        
exports.model.uml.UMLDiagram = UMLDiagram
