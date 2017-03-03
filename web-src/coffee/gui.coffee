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
		gui.set_current_instance(this)
		gui.set_current_gui(this.current_gui)

	to_erd: () ->

	to_metamodel: () ->

	update_metamodel: () ->

	translate_owllink: () ->

	update_translation: () ->

	add_object_type: () ->

exports = exports ? this
if exports.gui == undefined
		exports.gui = {}
		
exports.gui.gui_instance = null
exports.gui.set_current_instance = (gui_instance) ->
		exports.gui.gui_instance = gui_instance

exports.gui.set_current_gui = (gui_instance) ->
		exports.gui.current_gui = gui_instance.current_gui 

exports.gui.GUI = GUI
	
