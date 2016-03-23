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

class MyModel
    # Params.:
    #
    # name : A String.
    constructor: (@name) ->

    # Return the joint model associated to this object.
    #
    # Params.:
    #
    # * joint_factory : A Concrete Factory like UMLFactory or ERDFactory instance.
    get_joint: (joint_factory) ->

    ##
    # Return true if this Joint Model has the given classid string.
    has_classid: (classid) ->
        return false

    to_json: () ->
        name: @name


# A Class from our model diagram.
class Class extends MyModel 
    # Params.: 
    #
    # * name : A string.
    # * attrs : An array of strings representing the attributes names.
    # * methods : An array of strings representing the methods names.
    constructor : (name, @attrs = null , @methods = null) ->
        super(name)
        @joint = null

    get_name: () ->
        return @name    
        
    get_attrs: () ->
        return @attrs

    get_methods: () ->
        return @methods

    ##
    # Return the joint model. Create it if it is null and a factory
    # is provided.
    # 
    # Params.:
    # * factory: A Factory subclass instance.
    get_joint: (factory = null) ->
        if factory != null then this.create_joint(factory)
        return @joint

    ##
    # If the joint model wasn't created, make it.
    #
    # Parameters:
    # * factory : a Factory subclass instance.
    create_joint: (factory) ->
        if @joint == null then @joint = factory.create_class(@name)

    has_classid: (classid) ->
        this.get_classid() == classid

    get_classid: () ->
        if @joint == null
            return false
        else
            return @joint.id

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
    # Params.:
    #
    # * classes: An array of Class objects, the first class is the "from"
    # and the second is the "to" class in a two-linked relation.
    constructor: (@classes) ->
        super.constructor "" 

    get_from : () ->
        return @classes[0]
            
    get_to: () ->
        return @classes[1]
    
    get_classes: () ->
        return @classes

    # True if a two-linked relation. False otherwise.
    is_two_linked: () ->
        return @classes.length == 2

    to_json: () ->
        json = super()        
        json.classes = $.map @classes, (myclass) ->
            myclass.to_json()
        return json

class Generalization extends Link     
    constructor: (@parent_class, @classes) ->


exports = exports ? this
       
exports.MyModel = MyModel
exports.Class = Class
exports.Link = Link
exports.Generalization = Generalization



