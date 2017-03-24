# save_load_json.coffee --
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


# Provides elements and events needed for displaying the interface for
# loading or saving the model.
SaveLoadJson = Backbone.View.extend(    
        initialize: () ->
            @is_loading = true
            @jsonlist = []
            this.render()
            this.$el.find(".saveloadjsonwidget-popup").popup()
            $("a#saveloadjson_cancel_btn").on("click", this.hide)

        render: () ->
            template = _.template( $("#template_saveloadjsonwidget").html(), {} )
            this.$el.html(template)

        events: 
        	"click a#saveloadjson_cancel_btn" :
                "hide"
            "click a#savejson_save_btn" :
                "save"

        set_jsonlist: (list) ->
            @jsonlist = list
            $("#modelList").html(this.retrieve_html_list())

        show: () ->
            $(".saveloadjsonwidget-popup").popup("open")
            this.set_load_save()

        hide: (event) ->
            $(".saveloadjsonwidget-popup").popup("close")

        retrieve_html_list: () ->
            lst_str = @jsonlist.map( (value, index, arr) ->
                '<li><a href="#">' + value + '</a></li>'
            )
            lst_str.join(' ')

        # Set to load or save depending on @is_loading hiding the needed
        # widgets.
        set_load_save: () ->
            if @is_loading
                $("#savejson-header").hide()
                $("#savejson-form").hide()
                $("#loadjson-header").show()
                $("#loadjson-form").show()
            else
                $("#savejson-header").show()
                $("#savejson-form").show()
                $("#loadjson-header").hide()
                $("#loadjson-form").hide()

        save: () ->
            gui.gui_instance.save_model()
);

exports = exports ? this
exports.SaveLoadJson = SaveLoadJson

