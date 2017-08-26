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


# An Entity from our model ERD diagram.
#
# @namespace model
class Entity extends model.MyModel 
    # @param name {String}
    # @param attrs {Array<String>} Array representing the attributes names.
    # @param methods {Array<Strings>} Array representing the methods names.
    constructor : (name, @attrs = null) ->
        super(name)
        @joint = null
        @unsatisfiable = false
        @on_change_objs = []

    get_name: () ->
        return @name

    set_name: (@name) ->
        if @joint != null
             @joint[0].set("name", @name)
       
    get_attrs: () ->
        return @attrs

    # Set if this class is unsatisfiable. Changing its appearance if `csstheme`
    # is given.
    #
    # @param bool {Boolean} If it is unsatisfiable or not.
    # @param csstheme {CSSTheme} optional. A csstheme object that if given,
    #   will set the appearance of this class depending if it is unsatisfiable.
    set_unsatisfiable: (bool, csstheme=null) ->
        @unsatisfiable = bool
        if csstheme?
            this.set_theme(csstheme)
            

    # Set the csstheme to the joint class.
    set_theme: (csstheme) ->
        if (@joint?) && (@joint.length > 0)
            # Joint instance exists.
            if @unsatisfiable
                @joint[0].set('attrs', csstheme.css_class_unsatisfiable)
            else
                @joint[0].set('attrs', csstheme.css_class)

    # If the joint model wasn't created, make it.
    # 
    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->
        unless @joint?
            @joint = []
            if csstheme?
                if @unsatisfiable
                    cssclass = csstheme.css_class_unsatisfiable
                else
                    cssclass = csstheme.css_class
                    
                    @joint.push(factory.create_class(@name, @attrs, cssclass))
            else
                @joint.push(factory.create_class(@name, @attrs))


    to_json: () ->
        json = super()
        if @joint?
            json.position = @joint[0].position()
        return json

    # I attach myself and my event handlers into the joint model
    # for answering myself whenever some important changes happens.
    #
    # If I have already attached, I don't attach again.
    #
    # This will attach for:
    #
    # - change:position : {Class#notify_change_position}
    #
    attach_my_event_handlers: () ->
        if @joint?
            unless @joint[0].mymodel_class?
                @joint[0].mymodel_class = this
                @joint[0].on('change:position', () ->
                    @mymodel_class.notify_change_position(this);
                )

    # Attach an object for notifying whenever the class changes position.
    #
    # @param [MyModel] object has to answer to {MyModel#update_position}.
    # @see #notify_change_position
    # @see MyModel#update_position
    attach_on_change_position: (object) ->
        this.attach_my_event_handlers()

        @on_change_objs.push(object)

    # **Event handler** for notifying all objects attached that the position has been changed.
    #
    # It will call update_position() to all objects attached. 
    #
    # @param [joint.dia.Element] model The Joint element that has recieved the event.
    # @see MyModel#update_position
    notify_change_position: (model) ->
        @on_change_objs.forEach( (obj, indx, arr) ->
            obj.update_position()
        )   

# @namespace model 
class Attribute extends model.Class
	
	constructor: (name, @type=null) ->
		super(name)
		@joint = null
		@unsatisfiable = false
		@on_change_objs = []

	get_name: () ->
        return @name

    set_name: (@name) ->
        if @joint != null
             @joint[0].set("name", @name)

    get_attr_type: () ->
    	return @type
            
    create_joint: (factory, csstheme = null) ->
        unless @joint?
            @joint = []
            if csstheme?
                if @unsatisfiable
                    cssclass = csstheme.css_class_unsatisfiable
                else
                    cssclass = csstheme.css_class
                    
                    @joint.push(factory.create_attribute(@name, @type, cssclass))
            else
                @joint.push(factory.create_attribute(@name, @type))         


    to_json: () ->
        json = super()
        json.type = @type
        delete json.attrs
        delete json.methods
        return json
                   
# linking attributes to entities. Warning: @classes is defined as [class,attr]. We should consider
# also [attr,entity]
#
# @namespace model
class LinkAttrToEntity extends model.Link
	
    constructor: (@classes, name=null) ->
        super(@classes, name)
            
    get_name: () ->
    	return @name
    	            
    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->        
        if @joint == null
            @joint = []
            if csstheme != null
                @joint.push(factory.create_link_attribute(
                    @classes[0].get_classid(),
                    @classes[1].get_attributeid(),
                    @name,
                    csstheme.css_links,
                    ))
            else
                @joint.push(factory.create_link_attribute(
                    @classes[0].get_classid(),
                    @classes[1].get_attributeid(),
                    @name
                    null
                    ))    


    to_json: () ->
        json = super()
        delete json.multiplicity
        delete json.roles
        json.type = "attribute"

        return json

# @namespace model        
class LinkISAToEntity extends model.LinkAttrToEntity
	
    constructor: (@classes, name=null) ->
        super(@classes, name)
            
    get_name: () ->
    	return @name
    	            
    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->        
        if @joint == null
            @joint = []
            if csstheme != null
                @joint.push(factory.create_link_attribute(
                	@classes[0].get_classid(),
                	@classes[1].get_isaid()
                    @name,
                    csstheme.css_links,
                    ))
            else
                @joint.push(factory.create_link_attribute(
                	@classes[0].get_classid(),
                	@classes[1].get_isaid()
                    @name
                    null
                    ))    


    to_json: () ->
        json = super()
        json.type = "isa"

        return json
                
       
exports.model.MyModel = MyModel
exports.model.LinkAttrToEntity = LinkAttrToEntity
exports.model.LinkISAToEntity = LinkISAToEntity



