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

# If exports doesn't exists, use "this".
exports ? this

{Factory} = require './factories'

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


# A Class from our model diagram.
class Class extends MyModel 
        # Params.: 
        #
        # * name : A string.
        # * attrs : An array of strings representing the attributes names.
        # * methods : An array of strings representing the methods names.
        constructor : (@name, @attrs, @methods) ->
                super.constructor(name)
        	@joint = null
    

        get_name: () ->
                return @name    
        
        get_attrs: () ->
        	return @attrs

        get_methods: () ->
        	return @methods

        # Params.:
        # 
        # * factory: A Factory instance
        get_joint: (factory) ->
                if @joint == null then @joint = factory.create_class()	
        	return @joint

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

class Generalization extends Link     
    constructor: (@parent_class, @classes) ->


exports.MyModel = MyModel
exports.Class = Class
exports.Link = Link
exports.Generalization = Generalization
