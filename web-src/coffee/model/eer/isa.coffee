# generalization.coffee --
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
exports.model.eer = exports.model.eer ? {}

# A generalization link.
#
# @namespace model.uml
class Isa extends model.uml.Link

    # @param parent_class {Class} The parent class.
    # @param classes {Array<Class>} An array of child classes.
    constructor: (@parent_class, @classes, name = null) ->
        super(@classes, name)
        @disjoint = false
        @covering = false

    get_joint: (factory=null, csstheme=null) ->
        super(factory, csstheme)

        if @joint.length < @classes.length
            # If it was created before but now we have a new child.
            if factory != null then this.create_joint(factory, csstheme);
        return @joint

    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->
        if csstheme == null
            csstheme =
                css_links: null
        if (@joint == null) || (@joint.length < @classes.length)
            @joint = []
            @classes.forEach( (elt, index, arr) ->
                if (!this.has_joint_instance(elt))
                    if index == 0
                        # Only draw the "disjoint-covering" label at the first line.
                        disjoint = @disjoint
                        covering = @covering
                    else
                        disjoint = covering = false
                    @joint.push(factory.create_generalization(
                        @parent_class.get_classid(),
                        elt.get_classid(),
                        csstheme.css_links
                        disjoint, covering))
            this)


    # Has the given elt a JointJS::Cell insance already created?
    #
    # @param elt {Class} a Class instance.
    # @return true if elt has a joint instance at the @joint variable. false otherwise.
    has_joint_instance: (elt) ->
        classid = elt.get_classid()
        founded = @joint.find( (elt, index, arr) ->
            # elt is a JointJS::Cell instance, a UML::Generalization if the UMLFactory is used.
            elt.get('source').id == classid
        )
        return founded?

    # Search for a child JointJS::Cell inside this relation.
    #
    # @return undefined or null if not founded.
    get_joint_for_child: (classchild) ->
        classid = classchild.get_classid()
        founded = @joint.find( (elt, index, arr) ->
            # elt is a JointJS::Cell instance, a UML::Generalization if the UMLFactory is used.
            elt.get('source').id == classid
        )
        return founded


    has_parent: (parentclass) ->
        return @parent_class == parentclass

    # Add a child into the generalization.
    #
    # @param childclass {Class} a Class instance to add.
    add_child: (childclass) ->
        @classes.push(childclass)

    set_disjoint: (@disjoint) ->
    set_covering: (@covering) ->

    get_disjoint: () ->
        return @disjoint
    get_covering: () ->
        return @covering

    to_json: () ->
        json = super()
        json.parent = @parent_class.get_name()
        json.multiplicity = null
        json.type = "generalization"

        constraint = []
        if @disjoint then constraint.push("disjoint")
        if @covering then constraint.push("covering")
        json.constraint = constraint

        return json



exports.model.eer.Isa = Isa
