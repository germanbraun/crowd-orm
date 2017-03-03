# meta_to_ERD.coffee --
# Copyright (C) 2017 GILIA

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


# Provides elements and events needed for displaying the interface for ERD.
CreateERDView = Backbone.View.extend(    
	initialize: () ->
        	this.render()
    
        render: () ->
            template = _.template( $("#template_tools_navbar_erd").html(), {} )
            this.$el.html(template)

        events:
        	"click a#meta_erd_button" :
        		"meta_to_erd"
			"click a#crearclase_button" :
                "create_class"
	
	 	get_gui: () -> 
 			$("#gui_select")[0].value
 
 	
 		meta_to_erd: (event) ->
 			console.log(event)
 			gui.current_gui.to_erd()
			
		create_class: (event) ->
            # alert("Creando: " + $("#crearclase_input").val() + "...")
            gui.current_gui.add_object_type(
                name: $("#crearclase_input").val()
            )

        # Event handler for translate diagram to OWLlink using Ajax
        # and the api/translate/berardi.php translator URL.
        translate_owllink: (event) ->
            gui.current_gui.translate_owllink()

        # Which is the current translation format selected by the
        # user?
        #
        # @return [String] "html", "owllink", etc.
        get_translation_format: () ->
            $("#format_select")[0].value

        insert_owllink: () ->
            gui.gui_instance.show_insert_owllink()
        reset_all: () ->
            gui.gui_instance.reset_all()
        import_json: () ->
            gui.gui_instance.show_import_json()
        export_json: () ->
            gui.gui_instance.show_export_json()

);

        

exports = exports ? this
exports.CreateERDView = CreateERDView
