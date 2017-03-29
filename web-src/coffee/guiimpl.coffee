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
#
# Central GUI *do-it-all* class...
#
class GUIIMPL
    constructor: (@graph,@paper) ->
    	gui.set_current_instance(this);

    set_urlprefix : (str) ->
	
    to_metamodel: () ->

    switch_to_erd: () ->

    to_erd: () ->
		
    update_metamodel: (data) ->
	
		
	# What to do when the user clicked on a cellView.
    on_cell_clicked: (cellview, event, x, y) ->
	
		
	##
    # Set the class Id of the class options GUI.
    set_options_classid: (model_id) ->


    ##
    # Hide the class options GUI.
    hide_options: () ->
   

    set_editclass_classid: (model_id) ->
        
    #
    # Add a class to the diagram.
    #
    # @param hash_data {Hash} data information for creating the Class. Use `name`, `attribs` and `methods` keys.
    # @see Class
    # @see Diagram#add_class
    
    add_object_type: (hash_data) ->
      
    add_attribute: (hash_data, class_id) ->

    add_relationship_attr: (class_id, attribute_id, name) ->

    #
    # Delete a class from the diagram.
    #
    # @param class_id {string} a String with the class Id.
    delete_class: (class_id) ->
       

    # Change a class name identified by its classid.
    # 
    # @example Getting a classid
    #   < graph.getCells()[0].id
    #   > "5777cd89-45b6-407e-9994-5d681c0717c1"
    #
    # @param class_id {string}
    # @param name {string}
    edit_class_name: (class_id, name) ->


    #
    # Add a simple association from A to B.
    # Then, set the selection state for restoring the interface.
    # 
    # @example Getting a classid
    #   < graph.getCells()[0].id
    #   > "5777cd89-45b6-407e-9994-5d681c0717c1"
    #
    # @param class_a_id {string} 
    # @param class_b_id {string}
    # @param name {string} optional. The association name.
    # @param mult {array} optional. An array of two string with the cardinality from class and to class b.
    add_relationship: (class_a_id, class_b_id, name, mult) ->
       

    # Add a Generalization link and then set the selection state.
    #
    # @param class_parent_id {string} The parent class Id.
    # @param class_child_id {string} The child class Id.
    # 
    # @todo Support various children on parameter class_child_id.
    add_subsumption: (class_parent_id, class_child_id, disjoint, covering) ->
        

    #
    # Report an error to the user.
    #
    # @param status {String} the status text.
    # @param error {String} error message
    show_error: (status, error) ->
        

    #
    # Put the traffic light on green.
    traffic_light_green: () ->
        

    #
    # Put the traffic light on red.
    traffic_light_red: () ->
        

    # Update the interface with satisfiable information.
    #
    # @param data {string} is a JSON string with the server response.
    update_satisfiable: (data) ->
        

    # Set the traffic-light according to the JSON object recived by the server.
    #
    # @param obj {JSON} The JSON object parsed from the recieved data.
    set_trafficlight: (obj) ->
 

    # Show these classes as unsatisifable.
    #
    # @param classes_list {Array<String>} a list of classes names.
    set_unsatisfiable: (classes_list) ->


    # Show these classes as satisifable.
    #
    # @param classes_list {Array<String>} a list of classes names.
    set_satisfiable: (classes_list) ->
 
        
    #
    # Send a POST to the server for checking if the diagram is
    # satisfiable.
    check_satisfiable: () ->


    # Update the translation information on the GUI and show it to the
    # user.
    #
    # Depending on the format selected by the user show it as HTML or
    # inside a textarea tag.
    #
    # @param data {string} The HTML, OWLlink or the translation
    # string.
    # @see CreateClassView#get_translation_format
    update_translation: (data) ->


    ##
    # Event handler for translate diagram to OWLlink using Ajax
    # and the api/translate/berardi.php translator URL.
    translate_owllink: () ->

    change_to_details_page: () ->

    change_to_diagram_page: () ->

 
    #
    # Hide the left side "Tools" toolbar
    # 
    
    hide_toolbar: () ->

    hide_umldiagram_page: () ->
    
    show_umldiagram_page: () ->

    hide_eerdiagram_page: () ->
    
    show_eerdiagram_page: () ->


    # Change the interface into a "new association" state.
    #
    # @param class_id {string} The id of the class that triggered it and thus,
    #   the starting class of the association.
    # @param mult {array} An array of two strings representing the cardinality from and to.
    set_association_state: (class_id, mult) ->

    # Change to the IsA GUI State so the user can select the child for the parent.
    #
    # @param class_id {String} The JointJS::Cell id for the parent class.
    # @param disjoint {Boolean} optional. If the relation has the disjoint constraint.
    # @param covering {Boolean} optional. If the relation has the disjoint constraint.
    set_isa_state: (class_id, disjoint=false, covering=false) ->


    # Change the interface into a "selection" state.
    set_selection_state: () ->


    # Update and show the "Export JSON String" section.
    show_export_json: () ->


    # Refresh the content of the "Export JSON String" section.
    #
    # No need to show it.
    refresh_export_json: () ->
 

    #
    # Show the "Import JSON" modal dialog.
    #
    show_import_json: () ->
 
    ##
    # Show the "Insert OWLlink" section.
    show_insert_owllink: () ->
 
    ##
    # Set the OWLlink addon at the "Insert OWLlink" section.
    set_insert_owllink: (str) ->


    diag_to_json: () ->
 

    # Import a JSON string.
    #
    # This will not reset the current diagram, just add more elements.
    #
    # @param jsonstr {String} a JSON string, like the one returned by diag_to_json().
    import_jsonstr: (jsonstr) ->


    # Import a JSON object.
    #
    # This will not reset the current diagram, just add more elements.
    #
    # Same as import_jsonstr, but it accept a JSON object as parameter.
    #
    # @param json_obj {JSON object} A JSON object.
    import_json: (json_obj) ->


    # Reset all the diagram and the input forms.
    #
    # Reset the diagram and the "OWLlink Insert" input field.
    reset_all: () ->



exports = exports ? this

if exports.gui == undefined
    exports.gui = {}

exports.gui.gui_instance = null
exports.gui.set_current_instance = (gui_instance) ->
    exports.gui.gui_instance = gui_instance

    

# @namespace gui
#
# This is sooo bad, but the context of a $.post callback function
# differs from the source caller class.
#
# We need to set a global guiinst variable with one GUI.gui instance.
exports.gui.update_satisfiable = (data) ->
    exports.gui.gui_instance.update_satisfiable(data)

exports.gui.update_translation = (data) ->
    exports.gui.gui_instance.update_translation(data)

exports.gui.show_error = (jqXHR, status, text) ->
    exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)

exports = exports ? this
exports.gui.GUIIMPL = GUIIMPL
#exports.gui.guiuml.GUIUML = GUIUML
#exports.gui.guieer.GUIEER = GUIEER

