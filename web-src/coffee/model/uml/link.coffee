# link.coffee --
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

# A Link between two classes or more classes.
#
# This give support for two (using from() or to()) or
# more classes.
#
# @namespace model
class Link extends model.MyModel 
    # @param classes {Array<Class>} An array of Class objects,
    #   the first class is the "from" and the second is the "to" class
    #   in a two-linked relation.
    constructor: (@classes, name=null) ->
        if name?
            super(name)
        else
            super(Link.get_new_name())
        @mult = [null, null]
        @roles = [null, null]

    # Set the multiplicity.
    #
    # For example:
    # `[null, null]` or `["0..*", "0..*"]` means from 0..* to 0..*.
    # `[1..*, null]` means from 1..* to 0..*.
    # 
    # @param [array] mult An array that describes the multiplicity in strings.
    set_mult : (@mult) ->
        this.change_to_null(m,i) for m,i in @mult

    # Change the from and to roles.
    #
    # @param [array] roles An array with two strings, the from and to roles.
    set_roles: (@roles) ->

    change_to_null : (mult, index) ->
        if (mult == "0..*") or (mult == "0..n")
            @mult[index] = null
    #
    # @param class_from an instance of Class.
    set_from : (class_from) ->
        @classes[0] = class_from
        
    get_from : () ->
        return @classes[0]

    set_to : (class_to) ->
        @classes[1] = class_to
        
    get_to: () ->
        return @classes[1]
    
    get_classes: () ->
        return @classes

    # True if a two-linked relation. False otherwise.
    is_two_linked: () ->
        return @classes.length == 2

    # *Implement in the subclass if necesary.*
    #
    # @param parentclass {Class} The Class instance to check.
    # @return `true` if this is a generalization class and has the given parent instance. `false` otherwise.
    has_parent: (parentclass) ->
        return false

    # Is this link associated to the given class?
    #
    # @param c {Class instance} The class to test with.
    #
    # @return {Boolean}
    is_associated: (c) ->
        this.has_parent(c) or @classes.includes(c)

    to_json: () ->
        json = super()
        json.classes = $.map(@classes, (myclass) ->
            myclass.get_name()
        )
        json.multiplicity = @mult
        json.roles = @roles
        json.type = "association"

        return json

    #
    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->        
        if @joint == null
            @joint = []
            if csstheme != null
                @joint.push(factory.create_association(
                    @classes[0].get_classid(),
                    @classes[1].get_classid(),
                    @name,
                    csstheme.css_links,
                    @mult,
                    @roles))
            else
                @joint.push(factory.create_association(
                    @classes[0].get_classid(),
                    @classes[1].get_classid(),
                    @name
                    null,
                    @mult,
                    @roles))

Link.get_new_name = () ->
    if Link.name_number == undefined
        Link.name_number = 0
    Link.name_number = Link.name_number + 1
    return "r" + Link.name_number


exports.model.Link = Link
