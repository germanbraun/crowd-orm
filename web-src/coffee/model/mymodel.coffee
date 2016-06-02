# mymodel.coffee --
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


# This *abstract* superclass represent the common behaviour
# of all of our model's diagram elements.
# 
# Each element from our diagram should be represented
# extending this class.

# {Factory} = require './factories'


#
# 
# # On subclass
# 
# Re-implement this functions:
# - constructor
# - create_joint
# - others?
class MyModel
    # @param name {String}
    constructor: (@name) ->
        @joint = null

    # Return the joint model. Create it if it is null and a factory
    # is provided.
    #
    # @param factory {Factory subclass} Concrete Factory like UMLFactory or ERDFactory instance.
    get_joint: (factory = null, csstheme = null) ->
        if factory != null then this.create_joint(factory, csstheme)
        return @joint

    # Create a JointJS view class and assign it to @joint variable.
    # 
    # @note Please redefine this method in the subclass.
    # @param factory {Factory subclass} A concrete Factory for creating the
    #   view instance.
    create_joint: (factory, csstheme = null) ->
        console.warn(this.toString() + " : Redefine create_joint() method on the subclass.");
        return null

    # Update the view if the @joint is already created and
    # associated to this class.
    update_view: (paper) ->
        if @joint != null
            v = @joint.findView(paper)
            v.update()
       
    #
    # @return {boolean} true if this Joint Model has the given classid string.
    has_classid: (classid) ->
        this.get_classid() == classid

    # Return the classid value of the associated JointJS View object.
    # Use {MyModel#create_joint} for creating a JointJS object.
    # 
    # @return {string} A string for the JointJS object or false if it wasn't initialized.
    get_classid: () ->
        if @joint == null
            return false
        else
            return @joint.id

    #
    # Return a JSON object representation with only the information.
    #
    # @note Redefine this method in the subclass.
    to_json: () ->
        name: @name


# A Class from our model diagram.
class Class extends MyModel 
    # @param name {String}
    # @param attrs {Array<String>} Array representing the attributes names.
    # @param methods {Array<Strings>} Array representing the methods names.
    constructor : (name, @attrs = null , @methods = null) ->
        super(name)
        @joint = null

    get_name: () ->
        return @name

    set_name: (@name) ->
        if @joint != null
             @joint.set("name", name)
        
        
    get_attrs: () ->
        return @attrs

    get_methods: () ->
        return @methods

    #
    # If the joint model wasn't created, make it.
    #
    # @param factory a Factory subclass instance.
    create_joint: (factory, csstheme = null) ->
        if @joint == null 
            if csstheme != null
                @joint = factory.create_class(@name, csstheme.css_class)
            else
                @joint = factory.create_class(@name)

    to_json: () ->
        json = super()
        json.attrs = @attrs.toSource() if @attrs != null     
        json.methods = @methods.toSource() if @methods != null
        return json
               

# A Link between two classes or more classes.
#
# This give support for two (using from() or to()) or
# more classes.
class Link extends MyModel 
    # @param classes {Array<Class>} An array of Class objects,
    #   the first class is the "from" and the second is the "to" class
    #   in a two-linked relation.
    constructor: (@classes) ->
        super("")

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

    to_json: () ->
        json = super()
        json.classes = $.map(@classes, (myclass) ->
            myclass.get_name()
        )
        json.multiplicity = ["0..*", "0..*"]
        json.type = "association"

        return json

    create_joint: (factory, csstheme = null) ->        
        if @joint == null
            if csstheme != null
                @joint = factory.create_association(
                    @classes[0].get_classid(),
                    @classes[1].get_classid(),
                    null,
                    csstheme.css_links)
            else
                @joint = factory.create_association(
                    @classes[0].get_classid(),
                    @classes[1].get_classid())

# A generalization link.
class Generalization extends Link

    # @param parent_class {Class} The parent class.
    # @param classes {Array<Class>} An array of child classes.
    constructor: (@parent_class, @classes) ->
        super(@classes)

    create_joint: (factory, csstheme = null) ->
        if @joint == null
            if csstheme != null
                @joint = factory.create_generalization(
                    @parent_class.get_classid(),
                    @classes[0].get_classid(),
                    csstheme.css_links)
            else
                @joint = factory.create_generalization(
                    @parent_class.get_classid(),
                    @classes[0].get_classid())

    to_json: () ->
        json = super()
        json.parent = @parent_class.get_name()
        json.type = "generalization"
        
        return json


exports = exports ? this
       
exports.MyModel = MyModel
exports.Class = Class
exports.Link = Link
exports.Generalization = Generalization



