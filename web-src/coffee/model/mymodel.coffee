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


# A Class from our model UML diagram.
class Class extends MyModel 
    # @param name {String}
    # @param attrs {Array<String>} Array representing the attributes names.
    # @param methods {Array<Strings>} Array representing the methods names.
    constructor : (name, @attrs = [] , @methods = []) ->
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

    get_methods: () ->
        return @methods

    # Set if this class is unsatisfiable. Changing its appearance if `csstheme`
    # is given.
    #
    # @param bool {Boolean} If it is unsatisfiable or not.
    # @param csstheme {CSSTheme} optional. A csstheme object that if given,
    #   will set the appearance of this class depending if it is unsatisfiable.
    #   It must have two elements: `css_class` and `css_class_unsatisfiable`. Both are CSS templates.
    # @see set_theme()
    set_unsatisfiable: (bool, csstheme=null) ->
        @unsatisfiable = bool
        if csstheme?
            this.set_theme(csstheme)
            

    # Set the csstheme to the joint class.
    #
    # @param csstheme {Hash} The theme with two keys: `css_class` and `css_class_unsatisfiale`. Both are CSS templates to apply on the SVG elements of the final JointJS attributes.
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
                    
                    @joint.push(factory.create_class(@name, @attrs, @methods, cssclass))
            else
                @joint.push(factory.create_class(@name, @attrs, @methods))


    to_json: () ->
        json = super()
        array = []
        if @attrs?
        	@attrs.forEach( (cv,index,@attrs) -> 
        		dots = @attrs[index].split ":"
        		name_attr = dots[0].trim()
        		datatype_attr = dots[1].trim()
        		array.push({name : name_attr, datatype : datatype_attr})
        		return array
        		)
        json.attrs = array
        json.methods = @methods #.toSource() if @methods != null
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
               


# An Entity from our model ERD diagram.
class Entity extends MyModel 
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


class Attribute extends Class
	
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
                   
# A Link between two classes or more classes.
#
# This give support for two (using from() or to()) or
# more classes.
class Link extends MyModel 
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

# A generalization link.
class Generalization extends Link

    # @param parent_class {Class} The parent class.
    # @param classes {Array<Class>} An array of child classes.
    constructor: (@parent_class, @classes) ->
        super(@classes)
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


# A link with association class.
#
# Also manage the association link, wich is the link that goes through the
# middle of the link with to the association class; the association class, which
# represent the association and is at the middle of the association link.
#
class LinkWithClass extends Link
   
    constructor: (@classes, name) ->
        super(@classes, name)
        @mult = [null,null]

        @assoc_class = new Class(name)
        @j_assoc_link = null
        # Easy access to the assoc_class.get_joint().
        @j_assoc_class = null

    # As {Link#create_joint}, but it also creates the association link and class.
    #
    # Also, inherit the same parameters.
    #
    # @return [Array] A list of joint objects created by the factory given.
    # @see MyModel#create_joint
    create_joint: (factory, csstheme = null) ->
        super(factory, csstheme)

        # Easy access to the Joint of associated class.
        #
        # A better approach has to be used instead of this, but for now it should work.
        # 
        # @todo craete a Class subclass "AssociateClass" and delegate some methods instead of asking for the joint.
        @j_assoc_class = @assoc_class.get_joint(factory, csstheme)[0]
        
        @j_assoc_link = factory.create_association_link(csstheme.css_assoc_links)
        # @j_assoc_class = factory.create_association_class(@name, csstheme.css_class)

        @joint.push(@j_assoc_link)
        @joint.push(@j_assoc_class)

        # It doesn't work. It is the scope of "this" or maybe another problem.
        # @joint[0].on('change:attrs', this.update_position)
        # @classes[0].get_joint()[0].on('change:position', this.update_position)
        # @classes[1].get_joint()[0].on('change:position', this.update_position)
        @classes[0].attach_on_change_position(this)
        @classes[1].attach_on_change_position(this)

    # Update position of the association link and association class
    # according tot he target and source classes (it must be half a way).
    update_position: () ->
        if (@j_assoc_link?) and (@j_assoc_class?)
            # For some misterious reason, you have to add some joint elements ids
            # on source and target. If not it will not associate the link with the
            # Element provided, instead it will still points to (10,10) coordinates.
            #
            # For this reason, we have to initialize with some ids that already
            # has been loaded into the graph object.
            @j_assoc_link.set('source',
                id: @classes[0].get_joint()[0].id
            )
            @j_assoc_link.set('target',
                id: @classes[1].get_joint()[0].id
            )

            # Now we can proceed asigning the source and target accordingly
            # Calculate the middle of the association's line, translate the
            # association class to that middle and a bit down.
            # Finally, set it to the source of the dashed line. Its target is
            # the association class.
            target_pos = @classes[1].get_joint()[0].position()            
            source_pos = @classes[0].get_joint()[0].position()
            target_size = @classes[1].get_joint()[0].attributes.size
            source_size = @classes[0].get_joint()[0].attributes.size
            middlex = Math.abs(target_pos.x + source_pos.x + target_size.width/2 + source_size.width/2  ) / 2
            middley = Math.abs(target_pos.y + source_pos.y + target_size.height/2 + source_size.height/2) / 2

            @j_assoc_class.position(middlex, middley + 100)
            @j_assoc_link.set('source',
                x: middlex,
                y: middley
            )
            @j_assoc_link.set('target',
                id: @j_assoc_class.id
            )

    # Exports to JSON
    #
    # Also adds the key "associated_class" and add the JSON of the associated class.
    # 
    # @return [object] The JSON object.
    # 
    # @see MyModel#to_json
    # @see Link#to_json
    to_json: () ->
        json = super()
        json.associated_class = @assoc_class.to_json()

        return json

# linking attributes to entities. Warning: @classes is defined as [class,attr]. We should consider
# also [attr,entity]

class LinkAttrToEntity extends Link
	
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

        
class LinkISAToEntity extends LinkAttrToEntity
	
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
                
exports = exports ? this
       
exports.MyModel = MyModel
exports.Class = Class
exports.Link = Link
exports.Generalization = Generalization
exports.LinkWithClass = LinkWithClass
exports.LinkAttrToEntity = LinkAttrToEntity
exports.LinkISAToEntity = LinkISAToEntity



