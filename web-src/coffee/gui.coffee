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
class GUI
    constructor: (@graph, @paper) ->
        @current_gui = new GUIUML(@graph,@paper)
        @prev_gui = new GUIEER(@graph,@paper)
        @aux_gui = []
        gui.set_current_instance(this)

        # Widgets that are the same for all type of GUIImpl.
        # Login
        @loginwidget = new LoginWidgetView({el: $("#loginwidget_placer")})
        # Save-Load
        # Error reporting widget
        @errorwidget = new ErrorWidgetView({el: $("#errorwidget_placer")})

    to_erd: () ->
        @current_gui.to_erd(this)

    to_metamodel: () ->

    switch_to_erd: () -> 
#        @current_gui.hide_umldiagram_page()
        @aux_gui = @current_gui
        @current_gui = @prev_gui
        @prev_gui = @aux_gui
#        @current_gui.show_eerdiagram_page()
    
    update_metamodel: (data) ->
        @current_gui.update_metamodel(data)

    translate_owllink: () ->
        @current_gui.translate_owllink(this)

    update_translation: (data) -> @current_gui.update_translation(data)

    add_object_type: (name) -> 
        @current_gui.add_object_type(name)

    add_attribute: (name) ->
        @current_gui.add_attribute(name)
        
    add_relationship: (class_a_id, class_b_id, name, mult) -> 
        @current_gui.add_relationship(class_a_id, class_b_id, name, mult)

    add_relationship_attr: (class_id, attribute_id, name) ->
        @current_gui.add_relationship_attr(class_id, attribute_id, name)

    add_relationship_isa: (class_id, isa_id, name)-> 
        @current_gui.add_relationship_isa(class_id, isa_id, name)

    add_relationship_isa_inverse: (class_id, isa_id, name)-> 
        @current_gui.add_relationship_isa_inverse(class_id, isa_id, name)
                
    add_subsumption: (class_parent_id, class_child_id, disjoint, covering) -> 
        @current_gui.add_subsumption(class_parent_id, class_child_id, disjoint, covering)
    
    edit_class_name: (class_id, name) -> @current_gui.edit_class_name(class_id, name)
    
    delete_class: (class_id) -> @current_gui.delete_class(class_id)

    set_isa_state: (class_id, disjoint, covering) -> 
        @current_gui.set_isa_state(class_id, disjoint, covering)        

    set_options_classid: (model_id) ->
        @current_gui.set_options_classid(model_id)

    set_association_state: (class_id, mult) -> @current_gui.set_association_state(class_id, mult)
                
    hide_options: () ->
        @current_gui.hide_options()

    hide_toolbar: () -> @current_gui.hide_toolbar()

    hide_umldiagram_page: () -> @current_gui.hide_umldiagram_page()
    
    show_umldiagram_page: () -> @current_gui.show_umldiagram_page()

    hide_eerdiagram_page: () -> @current_gui.eerdiagram_page()
    
    show_eerdiagram_page: () -> @current_gui.eerdiagram_page()
        
    set_editclass_classid: (model_id) ->
        @current_gui.set_editclass_classid(model_id)
        
    set_selection_state: () ->
        @current_gui.set_selection_state()
            
    # Update and show the "Export JSON String" section.
    show_export_json: () ->
         @current_gui.show_export_json()

    # Refresh the content of the "Export JSON String" section.
    #
    # No need to show it.
    refresh_export_json: () ->
        @current_gui.refresh_export_json()
        

    on_cell_clicked: (cellview, event, x, y) -> @current_gui.on_cell_clicked(cellview,event,x,y)
    
    import_json: (json_obj) -> @current_gui.import_json(json_obj)

    import_jsonstr: (data) -> @current_gui.import_jsonstr(data)
    
    show_import_json: () -> @current_gui.show_import_json()
    
    reset_all: () -> @current_gui.reset_all()

    # Check if the model is satisfiable sending a POST to the server.
    check_satisfiable: () ->
        @current_gui.check_satisfiable()

    # Update the diagram displaying unsatisfiable primitives in red.
    #
    # @param data [String] The JSON answer.
    update_satisfiable: (data) ->
        @current_gui.update_satisfiable(data)

    # Report an error to the user.
    #
    # @param status {String} the status text.
    # @param error {String} error message
    show_error: (status, error) ->
        $.mobile.loading("hide")
        @errorwidget.show(status, error)



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
# We need to set a global gui instance variable with one GUI.gui instance.
exports.gui.switch_to_erd = () -> 
    gui_instance.aux_gui = gui_instance.current_gui
    gui_instance.current_gui = gui_instance.prev_gui
    gui_instance.prev_gui = gui_instance.aux_gui

exports.gui.GUI = GUI
