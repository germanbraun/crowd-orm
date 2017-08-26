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

exports = exports ? this
exports.model = exports.model ? {}

#
# 
# # On subclass
# 
# Re-implement this functions:
# - constructor
# - create_joint
# - others?
#
# @namespace model
class MyModel
    # @param name {String}
    constructor: (@name) ->
        @joint = null

    # Return the joint model. Create it if it is null and a factory
    # is provided.
    #
    # @param factory {Factory subclass} Concrete Factory like UMLFactory or ERDFactory instance.
    # @return {Array<JointJS::Cells> An array of Cells elements.
    get_joint: (factory = null, csstheme = null) ->
        if factory != null then this.create_joint(factory, csstheme)
        return @joint

    # Create a JointJS view class and assign it to @joint variable.
    #
    # # Caution
    # The first element is used for get_classid, representing it as the JointJS
    # visual element of this instance. If this instance has more than one
    # JointJS cells, the first one is the most important.
    # 
    # @note Please redefine this method in the subclass.
    # @param factory {Factory subclass} A concrete Factory for creating the
    #   view instance.
    # @return {Array<JointJS::Cells>} An array of Cells elements.
    create_joint: (factory, csstheme = null) ->
        console.warn(this.toString() + " : Redefine create_joint() method on the subclass.");
        return null

    # Update the view if the @joint is already created and
    # associated to this class.
    update_view: (paper) ->
        if @joint != null
            @joint.forEach( (elt, index, arr) ->
                v = elt.findView(paper)
                v.update()
            this)
       
    #
    # @return {boolean} true if this Joint Model has the given classid string.
    has_classid: (classid) ->
        this.get_classid() == classid

    # @return {boolean} true if this Joint Model has the given attrid string.
    has_attrid: (attrid) ->
        this.get_attributeid() == attrid

    # @return {boolean} true if this Joint Model has the given isaid string.
    has_isaid: (isaid) ->
        this.get_isaid() == isaid
        
    # Return the classid value of the associated JointJS View object.
    # Use {MyModel#create_joint} for creating a JointJS object.
    # 
    # @return {string} A string for the JointJS object or false if it wasn't initialized.
    get_classid: () ->
        if @joint == null
            return false
        else
            return @joint[0].id


    get_attributeid: () ->
    	if @joint == null
    		return false
    	else
    		return @joint[0].id

    get_isaid: () ->
    	if @joint == null
    		return false
    	else
    		return @joint[0].id

    #
    # Return a JSON object representation with only the information.
    #
    # @note Redefine this method in the subclass.
    to_json: () ->
        name: @name

    # Simply update the coordinates of this object to its proper position.
    # Useful when the object has other dependants, that should move accordingly
    # to one or another.
    #
    # Consider it could be called when the user change the position of the
    # JointJS Object or any associated MyModel/Joint object to update the
    # position of this object accordingly to them. So, this is also an
    # **event handler** .
    # 
    # Redefine this function if necessary.
    update_position: () ->        


       
exports.model.MyModel = MyModel





