# isa.coffee --
# Copyright (C) 2016 GILIA

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
exports.views.uml = exports.views.uml ? this
exports.views.uml.generalisation = exports.views.uml.generalisation ? this

GeneralisationOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_generalisationoptions").html() )
        this.$el.html(template({classid: @classid}))

    events:
        'click a#umlisa_button' : 'new_isa'

    new_isa: () ->
        disjoint = $("#chk-disjoint").prop("checked")
        covering = $("#chk-covering").prop("checked")
        guiinst.set_isa_state(@classid, disjoint, covering)

    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y + 150,
            left: viewpos.x,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()

    get_classid: () ->
        return @classid

    hide: () ->
        this.$el.hide()
)




exports.views.uml.generalisation.GeneralisationOptionsView = GeneralisationOptionsView
