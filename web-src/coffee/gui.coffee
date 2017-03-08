# gui.coffee --
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

# @namespace gui
## Central GUI *do-it-all* class...
class GUI
	constructor: (@graph, @paper) ->
		@current_gui = new GUIUML(@graph,@paper)
		@prev_gui = new GUIEER(@graph,@paper)
		@aux_gui = []
		gui.set_current_instance(this)

	to_erd: () ->
		@current_gui.to_erd(this)
				

	to_metamodel: () ->

	switch_to_erd: () ->
	    @aux_gui = @current_gui
	    @current_gui = @prev_gui
	    @prev_gui = @aux_gui
	
	update_metamodel: (data) ->
		@current_gui.update_metamodel(data)

	translate_owllink: () ->
		@current_gui.translate_owllink(this)

	update_translation: () ->

	add_object_type: (name) ->
		@current_gui.add_object_type(name)

exports = exports ? this
if exports.gui == undefined
		exports.gui = {}
		
exports.gui.gui_instance = null
exports.gui.set_current_instance = (gui_instance) ->
		exports.gui.gui_instance = gui_instance


exports.gui.switch_to_erd = () -> 
	gui_instance.aux_gui = gui_instance.current_gui
	gui_instance.current_gui = gui_instance.prev_gui
	gui_instance.prev_gui = gui_instance.aux_gui
 
exports.gui.GUI = GUI
	
