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

exports = exports ? this
exports.gui = exports.gui ? {}


# @namespace gui
#
# Central GUI *do-it-all* class...
#
class GUI
    constructor: (@graph, @paper) ->
        # Current and active GUIIMP.
        @current_gui = null
        # When changing GUI, this will be the "return" GUI.
        @prev_gui = null
        # List of GUIIMP instance available.
        @lst_guis = []
        @aux_gui = []

        # Widgets that are the same for all type of GUIImpl.
        # Login
        @loginwidget = new login.LoginWidgetView({el: $("#loginwidget_placer")})
        # Save-Load
        # Error reporting widget
        @errorwidget = new views.ErrorWidgetView({el: $("#errorwidget_placer")})

    # # GUIIMP management.
    # Messages for manage GUIIMP instances.
    # ---
    #
    # Add the GUIIMP instance as availables GUIs.
    #
    # If the GUIIMP provided is the first, then make it the current.
    # Works as a stack: if there are already one, make the last added the current.
    #
    # @param guiimp {GUIIMP} An instance of a GUIIMP subclass.
    add_gui: (guiimp) ->
        @lst_guis.push guiimp
        guiimp.set_graph(@graph)
        guiimp.set_paper(@paper)
        this.set_current(0)
        this.set_previous(1)

    # Make the nth GUIIMP in the @lst_guis the current GUI.
    #
    # Change the current GUI the previous one.
    # 
    # @param nth {number} The index of the @lst_guis.
    set_current: (nth) ->
        if @lst_guis[nth]?
            @prev_gui = @current_gui
            @current_gui = @lst_guis[nth]

    # Make the nth GUIIMP in the @lst_guis the previous GUI.
    #
    # @param nth {number} The index of the @lst_guis.
    set_previous: (nth) ->
        if @lst_guis[nth]?
            @prev_gui = @lst_guis[nth]

    # Set the previous GUIIMP instance.
    #
    # @param guiimp {GUIIMP} A GUIIMP subclass.
    set_prev_gui: (guiimp) ->
        # @prev_gui = new gui.GUIEER(@graph,@paper)
        @prev_gui = guiimp
        guiimp.graph = @graph
        guiimp.paper = @paper

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

    # Translate the current model into a formalization.
    # 
    # Show the user a "wait" message while the server process the model.
    # 
    # @param strategy {String} The strategy name to use for formalize the model.
    # @param syntax {String} The output sintax format.
    translate_formal: (strategy, syntax) ->
        @current_gui.translate_formal(strategy, syntax)

    # @deprecated Use translate_formal() instead.
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



# Current GUI instance.
# 
# An instance must be running!
# 
# Better use gui.set_current_instance()
#
# @see set_current_instance()
# @namespace gui
exports.gui.gui_instance = null

# Set the current instance of the GUI class.
#
# This has nothing to do with the current language interface (GUIUML, GUIEER,
# etc.).
#
# @param gui_instance {GUI} The running instance.
# @namespace gui
exports.gui.set_current_instance = (gui_instance) ->
    exports.gui.gui_instance = gui_instance


# @namespace gui
#
# Switch to the ERD interface and diagram.
# 
# This is sooo bad, but the context of a $.post callback function
# differs from the source caller class.
#
# We need to set a global gui instance variable with one GUI.gui instance.
exports.gui.switch_to_erd = () -> 
    gui_instance.aux_gui = gui_instance.current_gui
    gui_instance.current_gui = gui_instance.prev_gui
    gui_instance.prev_gui = gui_instance.aux_gui

# @namespace gui
#
# This is sooo bad, but the context of a $.post callback function
# differs from the source caller class.
#
# We need to set a global guiinst variable with one GUI.gui instance.
exports.gui.update_satisfiable = (data) ->
    exports.gui.gui_instance.update_satisfiable(data)

# @namespace gui
exports.gui.update_translation = (data) ->
    exports.gui.gui_instance.update_translation(data)

# @namespace gui
exports.gui.show_error = (jqXHR, status, text) ->
    exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)

exports.gui.GUI = GUI
