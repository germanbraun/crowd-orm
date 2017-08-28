# class.coffee --
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

# A Class from our model UML diagram.
#
# @namespace model.uml
class Class extends model.MyModel 
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

    same_elts: (other) ->
        all_same = super(other) && @unsatisfiable == other.unsatisfiable
        if @attrs.length != other.attrs.length
            return false
        @attrs.forEach( (s) ->
            all_same = all_same && other.attrs.includes(s)
        )

        if @methods.length != other.methods.length
            return false
        @methods.forEach( (s) ->
            all_same = all_same && other.methods.includes(s)
        )

        return all_same


exports.model.uml.Class = Class
