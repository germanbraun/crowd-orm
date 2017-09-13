# umlimporter.coffee --
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
exports.model = exports.model ? {}
exports.model.uml = exports.model.uml ? {}

# UMLImporter
#
# @namespace model.uml
class UMLImporter 

    # @param diagram {UMLDiagram} The diagram where to import the objects.
    # @param json {string} The JSON string.
    # @param json {object} The parsed JSON string.
    constructor: (@diagram, json) ->
        if typeof(json) == "string"
            @_json = JSON.parse(json)
        else
            @_json = json
        @_normalize()
    
    # Import all classes and links without clearing the diagram
    do_import: () ->
        @import_classes()
        @import_links()

    # Normalize the JSON into a more usable format.
    # 
    # Change attributes format for each classes:
    # From `{name: Namestr, datatype: Typestr}` into  a string "Name:Typestr"
    _normalize: () ->
        @_json.classes.forEach( (elt, index, arr) ->
            array = []
            if elt.attrs?
                attr = elt.attrs
                attr.forEach( (cv,index,attr) -> 
                    att = "#{attr[index].name}:#{attr[index].datatype}"
                    array.push(att)
                    return array
                )
            elt.attrs = array
        )

    # Normalize the JSON provided and import all its classes.
    import_classes: () ->
        @_json.classes.forEach(
            (elt, index, arr) ->                
                console.log("class " + elt.name)
                @diagram.add_class(elt)
            this)

    import_links: () ->
        @_json.links.forEach(
            (elt, index, arr) ->
                if elt.type is "association"
                    console.log("association " + elt.classes[0] + " - " + elt.classes[1])
                    class_a = @diagram.find_class_by_name(elt.classes[0])
                    class_b = @diagram.find_class_by_name(elt.classes[1])
                    if elt.associated_class?
                        @diagram.add_association_class(
                            class_a.get_classid(),
                            class_b.get_classid(),
                            elt.name,
                            elt.multiplicity,
                            elt.roles)
                    else
                        @diagram.add_association(
                            class_a.get_classid(),
                            class_b.get_classid(),
                            elt.name,
                            elt.multiplicity,
                            elt.roles)
                if elt.type is "generalization"
                    console.log("generalization " + elt.parent + " childs:")
                    console.log(elt.classes)
                    class_parent = @diagram.find_class_by_name(elt.parent)
                    classes_children = elt.classes.map(
                        (childname) ->
                            @diagram.find_class_by_name(childname)
                    this)
                    disjoint = elt.constraint.includes("disjoint")
                    covering = elt.constraint.includes("covering")
                    @diagram.add_generalization(
                        class_parent,
                        classes_children,
                        disjoint, covering,
                        elt.name)
                                
        this)


exports.model.uml.UMLImporter = UMLImporter
