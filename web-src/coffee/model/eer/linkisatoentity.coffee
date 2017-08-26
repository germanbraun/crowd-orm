# linkisatoentity.coffee --
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
class LinkISAToEntity extends model.eer.LinkAttrToEntity
	
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



exports.model.eer.LinkISAToEntity = LinkISAToEntity
