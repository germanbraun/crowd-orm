# attribute.coffee --
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


# @namespace model 
class Attribute extends model.MyModel
	
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


exports.model.eer.Attribute = Attribute
