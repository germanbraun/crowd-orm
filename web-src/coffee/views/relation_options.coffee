# relation_options.coffee --
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




RelationOptionsView = Backbone.View.extend(
    initialize: () ->
        this.render()
        this.$el.hide()

    render: () ->
        template = _.template( $("#template_relationoptions").html() )
        this.$el.html(template({classid: @classid}))

    events:
        'click a#association_button' : 'new_relation',
        'click a#isa_button' : 'new_isa'

    new_relation: () ->
        mult = []
        mult[0] = this.map_to_mult($('#cardfrom').val())
        mult[1] = this.map_to_mult($('#cardto').val())
        gui.gui_instance.set_association_state(@classid, mult)

    # Map the Option value to multiplicity string.
    #
    # @param str {string} The value string.
    # @return {String} A string that represent the multiplicity as in UML.
    map_to_mult : (str) ->
        switch str
            when "zeromany" then "0..*"
            when "onemany" then "1..*"
            when "zeroone" then "0..1"
            when "oneone" then "1..1"

    new_isa: () ->
        disjoint = $("#chk-disjoint").prop("checked")
        covering = $("#chk-covering").prop("checked")
        gui.gui_instance.set_isa_state(@classid, disjoint, covering)

    set_classid: (@classid) ->
        viewpos = graph.getCell(@classid).findView(paper).getBBox()

        this.$el.css(
            top: viewpos.y,
            left: viewpos.x + viewpos.width,
            position: 'absolute',
            'z-index': 1
            )
        this.$el.show()
        
    get_classid: () ->
        return @classid

    hide: () ->
        this.$el.hide()
)


        

exports = exports ? this
exports.RelationOptionsView = RelationOptionsView
