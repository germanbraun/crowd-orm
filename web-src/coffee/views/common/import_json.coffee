# import_json.coffee --
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
exports.views = exports.views ? this
exports.views.common = exports.views.common ? this


# View widget for the "Import JSON".
ImportJSONView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.find(".importjson-popup").popup()
        # For some reason, backboneJS doesn't process the given event.
        # Maybe a bug or some incompatibility with JQueryMobile?
        $("#importjson_importbtn").on('click', this.do_import)
    render: () ->
        template = _.template( $("#template_importjson").html() )
        this.$el.html( template() )
    show: () ->
        $(".importjson-popup").popup("open")
        # this.delegateEvents()
    events:
        "click a#importjson_importbtn" : "do_import"
    do_import: () ->
        console.log("Doing import now!")
        $(".importjson-popup").popup("close")
        jsonstr = $("#importjson_input").val()
        guiinst.import_jsonstr(jsonstr)
)



exports.views.common.ImportJSONView = ImportJSONView
