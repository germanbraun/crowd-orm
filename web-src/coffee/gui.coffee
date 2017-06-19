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
		# Login
		@loginwidget = new LoginWidgetView({el: $("#loginwidget_placer")})
		@login = null
		@serverconn = new ServerConnection( (jqXHR, status, text) ->
            exports.gui.gui_instance.show_error(status + ": " + text , jqXHR.responseText)
        )
		# Save-Load
		@saveloadjsonwidget = new SaveLoadJson({el: $("#saveloadjson_placer")})

	to_erd: () ->
		@current_gui.to_erd(this)
				

	to_metamodel: () ->

	switch_to_erd: () -> 
#	    @current_gui.hide_umldiagram_page()
	    @aux_gui = @current_gui
	    @current_gui = @prev_gui
	    @prev_gui = @aux_gui
#	    @current_gui.show_eerdiagram_page()
	
	update_metamodel: (data) ->
		@current_gui.update_metamodel(data)

	translate_owllink: () ->
		@current_gui.translate_owllink()

	update_translation: () ->

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

   #
    # Show the login popup.
    #
    show_login: () ->
        @loginwidget.show()

    #
    # Hide the login popup.
    #
    hide_login: () ->
        @loginwidget.hide()

    # Do the login steps connecting to the server and verifying the username
    # and password.
    #
    # @param username {String} The username.
    # @param pass {String} The password.
    do_login: (username, pass) ->
        @serverconn.request_login(
            username,
            pass,
            gui.update_login)

    # Callback for the ServerConnection
    #
    # Update the interface according to a succesful login.
    #
    # @param data {String} The information about the login answer in JSON format.
    update_login: (data) ->
        console.log(data)
        @login = JSON.parse(data)
        if @login.logged
            this.set_logged_in()
        else
            @login = null
            # For some reason it won't show the error message if not wait for
            # one second.
            setTimeout(() ->
                gui.gui_instance.show_error("Problems When Logging In", data)
            ,1000)

    # According to the information about @login, update the interface.
    set_logged_in: () ->
        if @login?
            @loginwidget.set_doing_login(false)
            # Update the model list
            this.show_load_json()
        else
            @loginwidget.set_doing_login(true)
            # Remove all models in the model list
            this.show_load_json_with_list([]);


    # Clear the login and reset the interface. Send information to the server.
    do_logout: () ->
        @serverconn.request_logout(gui.update_logout)

    # Callback for the ServerConnection.
    #
    # Update the interface and JS as if the user has recently logged out.
    #
    # @param data {String} The information returned from the server.
    update_logout: (data) ->
        console.log(data)
        @login = null
        this.set_logged_in()

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

    change_to_user_page: () ->
        $.mobile.changePage("#user-page",
            transition: "slide")

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
        

    # Display the saveloadjson Popup in the save state.
    show_save_json: () ->
        $.mobile.loading("show",
            text: "Retrieving models list...",
            textVisible: true,
            textonly: false
        )
        @serverconn.request_model_list(gui.update_saveloadjsonwidget)

    # Display the saveloadjson Popup in the load state.
    #
    # But first, we must retrieve the model list.
    show_load_json: () ->
        $.mobile.loading("show",
            text: "Retrieving models list...",
            textVisible: true,
            textonly: false
        )
        @serverconn.request_model_list(gui.update_saveloadjsonwidget)

    # Display the loadjson but without retrieving the model list.
    #
    # @param list {Array} A list of Strings with the names of the models.
    show_load_json_with_list: (list) ->
        $.mobile.loading("hide")
        @saveloadjsonwidget.set_jsonlist(list)
        this.change_to_user_page()

    # Hide the saveloadjson Popup.
    #
    # Maybe the user canceled?
    hide_saveloadjson: () ->
        @saveloadjsonwidget.hide()

    save_model: (modelname) ->
        $.mobile.loading("show",
            text: "Sending to the server..."
            textVisible: true
            textonly: false
        )
        jsonstr = this.diag_to_json()
        @serverconn.send_model(modelname, jsonstr, gui.model_sended)
        this.change_to_diagram_page()


    # Retrieve the model from the server and import it.
    #
    # @param modelname {String} The modelname to import.
    load_model: (modelname) ->
        $.mobile.loading("show",
            text: "Retrieving model..."
            textVisible: true,
            textonly: false
        )
        @serverconn.request_model(modelname, gui.update_model)


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
	
